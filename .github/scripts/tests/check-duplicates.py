import os
import sys
import re
from collections import defaultdict

# Regex to match lines like: n["@m00nyONE"] = {...}
entry_pattern = re.compile(r'^(?P<table>[nsa])\s*\[\s*"(?P<user>@[^"]+)"\s*]')

# Store seen @names per table: { 'n': {'@name': [(file, line_number), ...]} }
seen_entries = defaultdict(lambda: defaultdict(list))


def check_file(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        for line_number, line in enumerate(f, start=1):
            match = entry_pattern.match(line.strip())
            if match:
                table = match.group("table")
                user = match.group("user")
                seen_entries[table][user].append((filepath, line_number))


def report_duplicates():
    found = False
    for table, users in seen_entries.items():
        for user, occurrences in users.items():
            if len(occurrences) > 1:
                if not found:
                    print("::error:: ❌ Duplicates found across files:")
                    found = True
                print(f" {table}[\"{user}\"] appears in:")
                for filepath, line_number in occurrences:
                    print(f"  - {filepath}, line {line_number}")
    if not found:
        print("::notice:: ✅ No duplicates found across files.")
    else:
        sys.exit(1)


def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <lua_dir>")
        sys.exit(2)
    lua_dir = sys.argv[1]
    for file in os.listdir(lua_dir):
        if file.endswith(".lua"):
            full_path = os.path.join(lua_dir, file)
            check_file(full_path)
    report_duplicates()


if __name__ == "__main__":
    main()