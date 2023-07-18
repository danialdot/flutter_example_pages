import os
import shutil

def copy_template_files():
    template_dir = "public/template"
    target_dir = "public"

    for file_name in os.listdir(template_dir):
        if file_name.endswith("-template.html"):
            template_file_path = os.path.join(template_dir, file_name)
            target_file_path = os.path.join(target_dir, file_name.replace("-template", ""))
            shutil.copy(template_file_path, target_file_path)

def replace_placeholders_in_file(file_path, placeholders_dict):
    with open(file_path, 'r') as file:
        content = file.read()

    for key, value in placeholders_dict.items():
        placeholder = f'[{key}]'
        content = content.replace(placeholder, value)

    with open(file_path, 'w') as file:
        file.write(content)

if __name__ == "__main__":
    # Get user input
    email = input("Enter your email address: ")
    city = input("Enter your city: ")

    # Define the placeholders and their corresponding values
    placeholders = {
        'Your Email Address': email,
        'Your City': city
    }

    # Make a copy of the template files into the public directory
    copy_template_files()

    # Replace placeholders in the terms-and-conditions.html file
    replace_placeholders_in_file("public/terms-and-conditions.html", placeholders)

    # Replace placeholders in the contact-us.html file
    replace_placeholders_in_file("public/contact-us.html", placeholders)

    print("Placeholder replacement completed successfully.")
