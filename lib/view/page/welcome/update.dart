import 'package:flutter/material.dart';
import 'package:flutter_example_pages/core/constants.dart';
import 'package:flutter_example_pages/model/remote/app_config/version/version.dart';
import 'package:flutter_example_pages/view/page/home/navigator.dart';
import 'package:flutter_example_pages/utils.dart';

class UpdatePage extends StatefulWidget {
  final VersionResponseResult versionResult;

  const UpdatePage({Key? key, required this.versionResult}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (widget.versionResult.versions.last.image != null)
              ? Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 22,
                    bottom: MediaQuery.of(context).size.height / 80,
                    right: MediaQuery.of(context).size.width / 4,
                    left: MediaQuery.of(context).size.width / 4,
                  ),
                  child: buildImage(widget.versionResult.versions.last.image!),
                )
              : Container(),
          SizedBox(height: MediaQuery.of(context).size.height / 12),
          Text(
            maxLines: 1,
            textAlign: TextAlign.center,
            widget.versionResult.versions.last.text,
            style: const TextStyle(
              fontSize: 16,
              color: AppColor.customBlackText,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (widget.versionResult.versions.first.forced)
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 20),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavigatorPage(),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: Text(
                            textAlign: TextAlign.end,
                            AppText.later,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColor.darkCerulean,
                            ),
                          ),
                        ),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 20),
                child: GestureDetector(
                  onTap: () {},
                  child: const Card(
                    color: AppColor.periwinkleBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(24),
                      ),
                    ),
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                      child: Text(
                        textAlign: TextAlign.end,
                        AppText.update,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColor.darkCerulean,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
