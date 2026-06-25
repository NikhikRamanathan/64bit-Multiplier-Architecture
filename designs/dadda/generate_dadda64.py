# Generates structural 64-bit unsigned Dadda multiplier design.sv

from collections import defaultdict

N = 64
OUT = "design.sv"

def dadda_sequence(n):
    seq = [2]
    while seq[-1] < n:
        seq.append((seq[-1] * 3) // 2)
    return [x for x in seq if x < n][::-1]

def wire_name(x):
    return x

columns = defaultdict(list)
lines = []

lines.append("`timescale 1ns/1ps\n")

lines.append("""
module half_adder (
    input  wire a,
    input  wire b,
    output wire sum,
    output wire carry
);
    assign sum   = a ^ b;
    assign carry = a & b;
endmodule

module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire carry
);
    assign sum   = a ^ b ^ cin;
    assign carry = (a & b) | (b & cin) | (a & cin);
endmodule

module dadda_multiplier_64bit (
    input  wire [63:0]  multiplicand,
    input  wire [63:0]  multiplier,
    output wire [127:0] final_product
);
""")

# Partial products
lines.append("    // Partial product generation\n")
for i in range(N):
    for j in range(N):
        name = f"pp_{i}_{j}"
        columns[i + j].append(name)
        lines.append(f"    wire {name};")
        lines.append(f"    assign {name} = multiplier[{i}] & multiplicand[{j}];")
    lines.append("")

thresholds = dadda_sequence(N)

wire_id = 0
fa_count = 0
ha_count = 0

for stage, target in enumerate(thresholds):
    new_columns = defaultdict(list)
    lines.append(f"\n    // Dadda reduction stage {stage}: target height {target}\n")

    max_col = max(max(columns.keys()), 127)

    for col in range(max_col + 2):
        available = list(columns.get(col, []))

        need = max(0, len(new_columns[col]) + len(available) - target)

        while need >= 2 and len(available) >= 3:
            a = available.pop(0)
            b = available.pop(0)
            c = available.pop(0)

            s = f"s_{stage}_{col}_{wire_id}"
            co = f"c_{stage}_{col}_{wire_id}"

            lines.append(f"    wire {s}, {co};")
            lines.append(
                f"    full_adder FA_{stage}_{col}_{wire_id} "
                f"(.a({a}), .b({b}), .cin({c}), .sum({s}), .carry({co}));"
            )

            new_columns[col].append(s)
            new_columns[col + 1].append(co)

            wire_id += 1
            fa_count += 1
            need -= 2

        while need >= 1 and len(available) >= 2:
            a = available.pop(0)
            b = available.pop(0)

            s = f"s_{stage}_{col}_{wire_id}"
            co = f"c_{stage}_{col}_{wire_id}"

            lines.append(f"    wire {s}, {co};")
            lines.append(
                f"    half_adder HA_{stage}_{col}_{wire_id} "
                f"(.a({a}), .b({b}), .sum({s}), .carry({co}));"
            )

            new_columns[col].append(s)
            new_columns[col + 1].append(co)

            wire_id += 1
            ha_count += 1
            need -= 1

        new_columns[col].extend(available)

        if len(new_columns[col]) > target:
            raise RuntimeError(
                f"Column {col} exceeds target height {target} at stage {stage}"
            )

    columns = new_columns

# Final two-row output
for col, bits in columns.items():
    if len(bits) > 2:
        raise RuntimeError(f"Final column {col} has more than 2 bits")

extra_cols = [col for col, bits in columns.items() if col >= 128 and len(bits) > 0]
if extra_cols:
    raise RuntimeError(f"Unexpected non-empty columns beyond 127: {extra_cols}")

lines.append("\n    // Final two-row carry-propagate addition\n")
lines.append("    wire [127:0] row0;")
lines.append("    wire [127:0] row1;\n")

for col in range(128):
    bits = columns.get(col, [])

    if len(bits) == 0:
        lines.append(f"    assign row0[{col}] = 1'b0;")
        lines.append(f"    assign row1[{col}] = 1'b0;")
    elif len(bits) == 1:
        lines.append(f"    assign row0[{col}] = {bits[0]};")
        lines.append(f"    assign row1[{col}] = 1'b0;")
    elif len(bits) == 2:
        lines.append(f"    assign row0[{col}] = {bits[0]};")
        lines.append(f"    assign row1[{col}] = {bits[1]};")

lines.append("\n    assign final_product = row0 + row1;\n")
lines.append("endmodule\n")

with open(OUT, "w") as f:
    f.write("\n".join(lines))

print(f"Generated {OUT}")
print(f"Full adders: {fa_count}")
print(f"Half adders: {ha_count}")
print(f"Dadda thresholds used: {thresholds}")