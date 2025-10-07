import os
import sys

def get_all_files_with_extensions(base_dir, extensions):
    result = []
    for root, dirs, files in os.walk(base_dir):
        # ignore hidden directories
        dirs[:] = [d for d in dirs if not d.startswith('.')]
        # only include 'en.lua' in lang/ directories
        if os.path.relpath(root, base_dir).replace('\\', '/').startswith('lang'):
            files = [f for f in files if f == 'en.lua']
        for f in files:
            if any(f.endswith(ext) for ext in extensions):
                rel_path = os.path.relpath(os.path.join(root, f), base_dir)
                # don't check the .addon file itself
                if not rel_path.endswith('.addon'):
                    result.append(rel_path.replace('\\', '/'))
    return sorted(result)

def get_listed_files_from_addon(addon_path):
    listed_files = []
    with open(addon_path, encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            # ignore lines with special variables
            if '$(language)' in line:
                continue
            if (line.endswith('.lua') or line.endswith('.xml')) and not line.startswith(';'):
                listed_files.append(line)
    return sorted(listed_files)

def find_addon_file(base_dir):
    for f in os.listdir(base_dir):
        if f.endswith('.addon') and os.path.isfile(os.path.join(base_dir, f)):
            return os.path.join(base_dir, f)
    return None

def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <base_dir>")
        sys.exit(2)
    base_dir = sys.argv[1]
    addon_file = find_addon_file(base_dir)
    if not addon_file:
        print("::error:: ❌ No .addon file found in base directory.")
        sys.exit(2)

    local_files = get_all_files_with_extensions(base_dir, ['.lua', '.xml'])
    listed_files = get_listed_files_from_addon(addon_file)

    missing_in_addon = sorted(set(local_files) - set(listed_files))
    extra_in_addon = sorted(set(listed_files) - set(local_files))

    if not missing_in_addon and not extra_in_addon:
        print("::notice:: ✅ All .lua and .xml files are included in the .addon file")
        sys.exit(0)
    else:
        if missing_in_addon:
            print("::error:: ❌ Missing in .addon file:")
            for name in missing_in_addon:
                print(f"  {name}")
        if extra_in_addon:
            print("::warning:: ❌ Listed in .addon file but missing on disk:")
            for name in extra_in_addon:
                print(f"  {name}")
        sys.exit(1)

if __name__ == "__main__":
    main()