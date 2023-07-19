import 'package:flutter/material.dart';

enum pageState { loading, loaded, error, initial }

enum MediaType { image, video, audio }

class AppText {
  static const String appName = "app name";
  static const String splashWelcome = "welcome to $appName";
  static const String navigatorPageTitle = "navigator title";
  static const String profilePageTitle = "profile title";
  static const String circularAppbarPageTitle = "circular appbar title";
  static const String update = "update";
  static const String later = "later";
}

class AppKey {}

class AppInputLength {
  static const int name = 100;
  static const int refcode = 20;
  static const int phoneNumber = 11;
}

class LocalKey {
  static const String refreshToken = 'REFRESHTOKEN';
  static const String accessToken = 'ACCESSTOKEN';
}

class AppUrl {
  static const String base = "https://raw.githubusercontent.com/danialdot/flutter_example_pages/main";
  static const String imagePrefix = "$base/public/image";
  static const String audioPrefix = "$base/public/audio";
  static const String videoPrefix = "$base/public/video";
  static const String apiVersion = "$base/api/v1";
  static const String baseUser = "$apiVersion/user";
  static const String baseAppConfig = "$apiVersion/app-config";
  static const String getVersion = "$baseAppConfig/app-update/get-version";
  static const String termsOfCondition =
      "https://raw.githubusercontent.com/danialdot/flutter_example_pages/main/public/template/terms-and-conditions-template.html";
  static const String contactUs = "https://raw.githubusercontent.com/danialdot/flutter_example_pages/main/public/template/contact-us-template.html";
}

class CloudflareWorkerUrl {
  static const String getVersion = "https://getversionapi.1998alirezam.workers.dev/api/v1/app-config/app-update/get-version";
}

class AppImage {
  static const String logoIcon = "assets/icon/icon-1024x1024.png";
  static const String background = "assets/image/pawel-czerwinski-6lQDFGOB1iw-unsplash.jpg";
  static const String welcomeVector = "assets/image/welcome-back.png";
}

class AppColor {
  // app theme colors
  // Burnt Sienna Orange + Bedazzled Blue Color Palette
  static const Color darkCerulean = Color(0xff3d5a80);
  static const Color periwinkleBlue = Color(0xff98c1d9);
  static const Color lightCyan = Color(0xffe0fbfc);
  static const Color salmonRed = Color(0xffee6c4d);
  static const Color darkGunmetalBlue = Color(0xff293241);

  // Common colors
  static const Color customWhiteBackground = Color(0xffffffff);
  static const Color customWhiteText = Color(0xffffffff);
  static const Color customWhiteIcon = Color(0xffffffff);
  static const Color customGreyText = Color(0xff494949);
  static const Color customGreyBorder = Color(0xff494949);
  static const Color customLightGreyText = Color(0xff79747E);
  static const Color customBlackText = Color(0xff000000);
  static const Color customBlackIcon = Color(0xff000000);
}

class AppShadow {
  static const List<BoxShadow> navigationBar = [
    BoxShadow(
      color: Color(0x3F000000),
      blurRadius: 4,
      offset: Offset(0, 4),
      spreadRadius: 0,
    )
  ];
  static const List<BoxShadow> navigationButton = [
    BoxShadow(
      color: Color(0x4C000000),
      blurRadius: 3,
      offset: Offset(0, 1),
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x26000000),
      blurRadius: 8,
      offset: Offset(0, 4),
      spreadRadius: 3,
    )
  ];
  static const List<BoxShadow> button = [
    BoxShadow(
      color: Color(0x26000000),
      blurRadius: 3,
      offset: Offset(0, 1),
      spreadRadius: 1,
    ),
    BoxShadow(
      color: Color(0x4C000000),
      blurRadius: 2,
      offset: Offset(0, 2),
      spreadRadius: 0,
    )
  ];
  static const List<BoxShadow> circularIcon = [
    BoxShadow(
      color: Color(0x26000000),
      blurRadius: 3,
      offset: Offset(0, 1),
      spreadRadius: 1,
    ),
    BoxShadow(
      color: Color(0x4C000000),
      blurRadius: 2,
      offset: Offset(0, 2),
      spreadRadius: 0,
    )
  ];
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x26000000),
      blurRadius: 3,
      offset: Offset(0, 1),
      spreadRadius: 1,
    ),
    BoxShadow(
      color: Color(0x4C000000),
      blurRadius: 2,
      offset: Offset(0, 1),
      spreadRadius: 0,
    )
  ];
}
