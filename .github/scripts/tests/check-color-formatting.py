import os
import re
import sys

COLOR_LINE_PATTERN = re.compile(r'^n\["([^"]+)"\]\s*=\s*{[^,]+,\s*"(.+)"\s*}')
COLOR_CODE_PATTERN = re.compile(r'\|c([0-9a-fA-F]{6})(.*?)\|r')

errors = []

def check_color_string(color_str, path, lineno, at_name):
    matches = COLOR_CODE_PATTERN.finditer(color_str)

    for match in matches:
        hexcode = match.group(1)

        if len(hexcode) != 6 or not all(c in "0123456789abcdefABCDEF" for c in hexcode):
            errors.append(f"Invalid hex code '{hexcode}':\t\t{path}:{lineno}: {at_name}")

    # Check for malformed |c / |r balance
    c_open = color_str.count("|c")
    c_close = color_str.count("|r")
    if c_open != c_close:
        errors.append(f"Mismatched |c / |r pairs ({c_open} / {c_close}):\t{path}:{lineno}: {at_name}")

    # Check for invalid sequences (e.g., |c with too short hex)
    if re.search(r"\|c(?![0-9a-fA-F]{6})", color_str):
        errors.append(f"Malformed |c segment (not 6-digit hex):\t{path}:{lineno}: {at_name}")

def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <names_dir>")
        sys.exit(2)
    names_dir = sys.argv[1]
    for root, _, files in os.walk(names_dir):
        for file in files:
            if not file.endswith(".lua"):
                continue
            path = os.path.join(root, file)
            with open(path, encoding="utf-8") as f:
                for lineno, line in enumerate(f, start=1):
                    line = line.strip()
                    match = COLOR_LINE_PATTERN.match(line)
                    if not match:
                        continue

                    at_name, color_string = match.groups()
                    check_color_string(color_string, path, lineno, at_name)

    if errors:
        print("::error:: ❌ Color string format issues found:")
        for err in errors:
            print(err)
        sys.exit(1)
    else:
        print("::notice:: ✅ All color strings valid!")

if __name__ == "__main__":
    main()