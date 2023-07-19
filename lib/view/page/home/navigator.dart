import 'package:flutter/material.dart';
import 'package:flutter_example_pages/core/constants.dart';
import 'package:flutter_example_pages/view/page/profile/profile.dart';
import 'package:flutter_example_pages/view/widget/basic_card_list_item.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({Key? key}) : super(key: key);

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

enum SelectableTabs { profile }

List navigatorPages = const [ProfilePage()];

List<Icon> navigatorPageIcons = const [
  Icon(
    Icons.account_circle_rounded,
    size: 32,
  ),
];

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / (9.2 * 2),
            alignment: Alignment.center,
            child: const Text(
              AppText.navigatorPageTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColor.customBlackText,
              ),
              // textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height / 6,
            child: _navigatorWidget(context),
          ),
        ],
      ),
    );
  }

  Widget _navigatorWidget(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.zero,
      itemCount: navigatorPages.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => navigatorPages[index],
              ),
            );
          },
          child: Container(
            height: MediaQuery.of(context).size.height / 9.2,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 12,
              vertical: MediaQuery.of(context).size.height / 80,
            ),
            child: basicCardListItem(
              context: context,
              title: index.toString(),
              icon: navigatorPageIcons[index],
            ),
          ),
        );
      },
    );
  }
}
