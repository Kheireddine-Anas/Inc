import os

def list_directory(path, prefix=""):
    """
    Recursively list the contents of a directory in a tree-like structure.
    """
    if not os.path.exists(path):
        print(f"Path '{path}' does not exist.")
        return

    items = os.listdir(path)
    items.sort()  # Sort to ensure consistent order

    for i, item in enumerate(items):
        full_path = os.path.join(path, item)
        is_last = (i == len(items) - 1)

        # Print the current item
        print(f"{prefix}{'└── ' if is_last else '├── '}{item}")

        # If it's a directory, recurse into it
        if os.path.isdir(full_path):
            extension = "    " if is_last else "│   "
            list_directory(full_path, prefix + extension)

if __name__ == "__main__":
    # Set the working directory (change this to your desired directory)
    working_directory = "."

    # List the directory structure
    print(f"{working_directory}/")
    list_directory(working_directory)
