import 'package:flutter/material.dart';
import 'package:flutter_example_pages/core/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width * 1.5,
                MediaQuery.of(context).size.height * 0.8,
              ),
              painter: CirclePainter(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.04,
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_rounded,
                    size: MediaQuery.of(context).size.width * 0.08,
                    color: AppColor.customWhiteIcon,
                  ),
                ),
                Text(
                  AppText.navigatorPageTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                    color: AppColor.customWhiteText,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.08,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width * 0.5;
    double centerY = size.height * -0.2;
    Paint paint = Paint()..color = AppColor.darkCerulean;
    canvas.drawCircle(Offset(centerX, centerY), size.width * 0.6, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
