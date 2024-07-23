import os
import glob

# Define the old and new package names
old_package_name = 'package:flutterapp'
new_package_name = 'package:deaf_project'

# Specify the folder containing the Dart files
dart_folder = r'C:\Users\mavic\OneDrive\Desktop\deaf_project\deaf_project\lib\easy_20meetapp\generatedmeetingwidget\generated'

# Use the glob module to find all Dart files in the folder
dart_files = glob.glob(os.path.join(dart_folder, '*.dart'))

def replace_package_name(file_path, old_package, new_package):
    with open(file_path, 'r', encoding='utf-8') as file:
        file_data = file.read()

    new_data = file_data.replace(old_package, new_package)

    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(new_data)

# Process each Dart file
for dart_file in dart_files:
    replace_package_name(dart_file, old_package_name, new_package_name)
    print(f"Processed {dart_file}")