import os

def generate_filtered_structure(root_dir, indent=0):
    """Recursively generate directory structure with only .py, .R, .ipynb and .txt files."""
    try:
        items = os.listdir(root_dir)
        has_valid_files = False

        # Check for valid files in the current directory
        for item in items:
            if item.endswith('.py') or item.endswith('.txt'):
                has_valid_files = True
                break

        # If valid files exist, print the current directory
        if has_valid_files or any(os.path.isdir(os.path.join(root_dir, item)) for item in items):
            print(" " * indent + f"├── {os.path.basename(root_dir)}")

        for item in items:
            item_path = os.path.join(root_dir, item)
            if os.path.isfile(item_path) and (item.endswith('.py') or item.endswith('.R') or item.endswith('.ipynb') or item.endswith('.txt')):
                print(" " * (indent + 4) + f"├── {item}")
            elif os.path.isdir(item_path):
                generate_filtered_structure(item_path, indent + 4)
    except PermissionError:
        print(" " * indent + "├── [Permission Denied]")

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Generate a filtered directory structure.")
    parser.add_argument("directory", type=str, help="The root directory to start generating the structure.")
    args = parser.parse_args()

    if os.path.exists(args.directory) and os.path.isdir(args.directory):
        print(f"Filtered structure of '{args.directory}':\n")
        generate_filtered_structure(args.directory)
    else:
        print(f"Error: '{args.directory}' is not a valid directory.")
