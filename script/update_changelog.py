import datetime

def create_changelog():
    # Check if the CHANGELOG.md file exists
    try:
        with open('CHANGELOG.md', 'r') as file:
            changelog_content = file.read()
    except FileNotFoundError:
        # If the file doesn't exist, create it with initial content
        changelog_content = """# Change Log
All notable changes to this project will be documented in this file.

## [Unreleased]

### Added
- 

### Changed
- 

### Fixed
- 

---

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

#### Reference: [Sample CHANGELOG](https://gist.github.com/juampynr/4c18214a8eb554084e21d6e288a18a2c)
"""

    # Get version and date input from the user
    version = input("Enter the new version (e.g., 1.0.2): ")
    date = input("Enter the release date (leave empty for current date): ")

    # Use current date if the user didn't input a date
    if not date:
        date = datetime.date.today().strftime("%Y-%m-%d")

    # Get the added features input from the user and convert to multiline
    added_features_input = input("Enter the added features (comma-separated): ")
    added_features_list = added_features_input.split(',')
    added_features = "\n- ".join(added_features_list)

    # Get the changed features input from the user and convert to multiline
    changed_features_input = input("Enter the changed features (comma-separated): ")
    changed_features_list = changed_features_input.split(',')
    changed_features = "- ".join(changed_features_list) + "\n"

    # Get the fixed bugs input from the user and convert to multiline
    fixed_bugs_input = input("Enter the fixed bugs (comma-separated): ")
    fixed_bugs_list = fixed_bugs_input.split(',')
    fixed_bugs = "\n- ".join(fixed_bugs_list)

    # Update the changelog content with the user's input
    new_version_entry = f"""---
## [{version}] - {date}

### Added
- {added_features}

### Changed
- {changed_features}

### Fixed
- {fixed_bugs}
"""

    # Find the last occurrence of '---' in the changelog content
    last_separator_index = changelog_content.rfind('---')

    if last_separator_index == -1:
        # If '---' is not found, add the new version entry at the end of the file
        changelog_content += new_version_entry
    else:
        # Insert the new version entry before the last '---'
        changelog_content = (
            changelog_content[:last_separator_index] + new_version_entry + changelog_content[last_separator_index:]
        )

    # Write the updated content back to the CHANGELOG.md file
    with open('CHANGELOG.md', 'w') as file:
        file.write(changelog_content)

    print(f"Version {version} with release date {date} added to CHANGELOG.md")


if __name__ == "__main__":
    create_changelog()
