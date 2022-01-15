from pathlib import Path
def get_subfolders(folder):
    return [x for x in folder.iterdir() if x.is_dir()]

tag = 'BIKI'
file_dir = Path(__file__).parents[0]
mod_folder = file_dir.parents[0] # Assuming we are in the tools dir

all_addons = get_subfolders(mod_folder / "addons")
print("Enter number or name for which addon to generate CfgFunctions:")
for i, a in enumerate(all_addons):
    print(f"{i:>2} | {a.name}")
addon = input("Addon: ")
try:
    addon = all_addons[int(addon)]
except ValueError:
    pass

addon = mod_folder / "addons" / addon
if not addon.is_dir():
    raise FileNotFoundError(f"Addon {addon.name} does not exist!")

print(f"Building CfgFunctions for addon \"{addon.name}\"...")

file_cfg = addon / 'CfgFunctions.hpp'
content = [
        "class CfgFunctions",
        "{",
        f"\tclass {tag}",
        "\t{"
]
# Get all categories by looking at the folders
categories = get_subfolders(addon)
categories.sort(key=lambda x: x.name.upper())
for cat in categories:
   content.extend([f'\t\tclass {cat.name}', "\t\t{", f"\t\t\tfile = QPATHTOF({cat.name});"])
   # Get all functions from the files
   function_files = [f.stem.replace('fn_', '') for f in cat.iterdir() if f.is_file() and f.name.startswith('fn_')]
   function_files.sort(key=lambda x: x.upper())
   for f in function_files:
       content.append(f'\t\t\tclass {f};')
   content.append('\t\t};')
content.extend(["\t};","};"])
output = '\n'.join(content)
file_cfg.write_text(output)
print(f"CfgFunctions written to {file_cfg}")
