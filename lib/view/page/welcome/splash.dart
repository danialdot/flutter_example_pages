import 'package:flutter_example_pages/controller/app_config.dart';
import 'package:flutter_example_pages/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example_pages/view/page/home/navigator.dart';
import 'package:flutter_example_pages/view/page/welcome/update.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AppConfigController _appConfigontroller = AppConfigController();
  late bool _loadingStaus = false;
  late String _version = "Unknown";

  void _initPackageInfo() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;

    setState(() {
      _version = version;
    });
  }

  Future _verificationsWithcustomeDelay() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!_loadingStaus) await _checkVersion(version: _version);
    if (!_loadingStaus) await _navigateToNavigator();
  }

  Future _checkVersion({required String version}) async {
    var versionResponse = await _appConfigontroller.getVersion(version: version);
    if (!context.mounted) return;
    if (versionResponse != null) {
      if (versionResponse.result.updateIsNeeded) {
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdatePage(
              versionResult: versionResponse.result,
            ),
          ),
        );
        _loadingStaus = true;
      }
    }
  }

  Future _navigateToNavigator() async {
    if (!context.mounted) return;
    if (!_loadingStaus) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigatorPage(),
        ),
      );
      _loadingStaus = true;
    }
  }

  @override
  void initState() {
    _initPackageInfo();
    _verificationsWithcustomeDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.background),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 22,
                bottom: MediaQuery.of(context).size.height / 80,
                right: MediaQuery.of(context).size.width / 4,
                left: MediaQuery.of(context).size.width / 4,
              ),
              child: Image.asset(
                AppImage.welcomeVector,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 12),
            Text(
              maxLines: 1,
              textAlign: TextAlign.center,
              _version,
              style: const TextStyle(
                fontSize: 16,
                color: AppColor.customWhiteText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
