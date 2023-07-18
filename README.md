# 🚀 flutter_example_pages

This project showcases various pages implemented using Flutter, serving as a learning resource and a source of fun experimentation.

## 🏁 Getting Started

To get this Flutter app up and running, follow these simple steps:

### 1. 📱 Add the desired platform/s

```bash
flutter create --platforms=<platform/s> .
```

**_example_**:

```bash
flutter create --platforms=ios,macos,web,android .
```

### 2. 📚 Fetch the required libraries

```bash
flutter pub get
```

### 3. 🌐 Internet Connection Issue

Please note that this application requires an internet connection to function properly. To ensure seamless operation, make sure to configure the necessary settings for each platform as described below:

macos:
Add the following lines to the file/s `./macos/Runner/*.entitlements`:

```
    <key>com.apple.security.network.client</key>
	<true/>
```

android:
Add the following line to the file/s `./android/app/src/*/AndroidManifest.xml`

```
    <uses-permission android:name="android.permission.INTERNET" />
```

## 🔄 Scripts

### 1. 📄 Automated Placeholder Replacement Script

This repository contains a Python script that automates the process of replacing placeholders in the `terms-and-conditions.html` and `contact-us.html` files. It simplifies customization by asking for your email address and city, updating the HTML files accordingly.

Run with:

```python
python3 script/placeholder_replacement.py
```

> make sure to replace `AppUrl.contactUs` and `AppUrl.termsOfCondition` in `lib/core/constants.dart`

## 🖼️ Assets Credits

| Asset                       | Source                                                                                           |
| --------------------------- | ------------------------------------------------------------------------------------------------ |
| Splash Background           | [Pawel Czerwinski - Unsplash](https://unsplash.com/photos/6lQDFGOB1iw)                           |
| Icon Pack                   | [COCO (Community) - Figma](https://www.figma.com/community/file/1091314698854537052)             |
| Splash/Welcome Illustration | [MISCELLANY TEXTS AND BADGES - Freepik](https://www.flaticon.com/free-icon/welcome-back_5331946) |
| Avatars Illustration        | [Avatars stickers pack - Freepik](https://www.flaticon.com/stickers-pack/avatars-132)            |

## 📜 License

This script is distributed under the MIT License. Feel free to use, modify, and distribute it according to the terms specified in the LICENSE file.
