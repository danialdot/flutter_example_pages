import 'package:flutter/material.dart';
import 'package:flutter_example_pages/core/constants.dart';
import 'package:flutter_example_pages/utils.dart';

Widget basicCardListItem({
  required BuildContext context,
  required String title,
  String? description,
  Icon? icon,
  String? media,
}) {
  return Container(
    decoration: ShapeDecoration(
      color: AppColor.customWhiteBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadows: AppShadow.card,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 6,
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 60,
            vertical: MediaQuery.of(context).size.height / 240,
          ),
          child: (icon != null)
              ? icon
              : (media != null)
                  ? buildImage(media)
                  : null,
        ),
        Container(
          width: MediaQuery.of(context).size.width - MediaQuery.of(context).size.width / 3 - 12,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                style: const TextStyle(color: AppColor.customBlackText, fontWeight: FontWeight.w700),
              ),
              (description != null)
                  ? Text(
                      title,
                      maxLines: 1,
                      style: const TextStyle(color: AppColor.customBlackText, fontWeight: FontWeight.w700),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    ),
  );
}
