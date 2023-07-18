import os

def create_flutter_project(platforms):
    if not platforms:
        print("No platforms selected. Exiting.")
        return

    platforms_arg = ",".join(platforms)
    os.system(f"flutter create --platforms={platforms_arg} .")

def edit_files_for_internet_permission(platforms):
    internet_permission_code_android = '''
    uses-permission android:name="android.permission.INTERNET"
    '''

    info_plist_path_ios = 'ios/Runner/Info.plist'
    info_plist_internet_permission_ios = '''
        <key>NSAppTransportSecurity</key>
        <dict>
            <key>NSAllowsArbitraryLoads</key>
            <true/>
        </dict>
    '''

    entitlements_path_macos = 'macos/Runner/DebugProfile.entitlements'
    entitlements_internet_permission_macos = '''
    <dict>
        <key>com.apple.security.network.client</key>
        <true/>
    </dict>
    '''

    for platform in platforms:
        if platform == 'android':
            manifest_path = 'android/app/src/main/AndroidManifest.xml'
            with open(manifest_path, 'r') as file:
                content = file.read()
                if 'INTERNET' not in content:
                    with open(manifest_path, 'a') as file:
                        file.write(internet_permission_code_android)
                    print("Internet permission added to AndroidManifest.xml")
                else:
                    print("Internet permission already exists in AndroidManifest.xml")

        elif platform == 'ios':
            with open(info_plist_path_ios, 'r') as file:
                content = file.read()
                if '<key>NSAppTransportSecurity</key>' not in content:
                    with open(info_plist_path_ios, 'a') as file:
                        file.write(info_plist_internet_permission_ios)
                    print("Internet permission added to Info.plist (iOS)")
                else:
                    print("Internet permission already exists in Info.plist (iOS)")

        elif platform == 'macos':
            with open(entitlements_path_macos, 'r') as file:
                content = file.read()
                if '<key>com.apple.security.network.client</key>' not in content:
                    with open(entitlements_path_macos, 'a') as file:
                        file.write(entitlements_internet_permission_macos)
                    print("Internet permission added to DebugProfile.entitlements (macOS)")
                else:
                    print("Internet permission already exists in DebugProfile.entitlements (macOS)")

if __name__ == "__main__":
    platforms = []

    print("Select platforms (separate each platform by a space):")
    print("1. Web")
    print("2. Android")
    print("3. iOS")
    print("4. macOS")

    platform_choices = input("Enter the platform numbers (e.g., '1 2 3'): ")
    platform_choices = platform_choices.split()

    for choice in platform_choices:
        if choice == '1':
            platforms.append('web')
        elif choice == '2':
            platforms.append('android')
        elif choice == '3':
            platforms.append('ios')
        elif choice == '4':
            platforms.append('macos')

    create_flutter_project(platforms)
    edit_files_for_internet_permission(platforms)
