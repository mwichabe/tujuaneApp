import 'package:flutter/material.dart';
import 'package:tujuane_app/SCREENS/onBoarding/onBoardingScreeens/picture_screen.dart';
import 'package:tujuane_app/SCREENS/onBoarding/onBoardingScreeens/start_screen.dart';

import '/widgets/widgets.dart';
import 'bio_screen.dart';
import 'demo_screen.dart';
import 'email_Screen.dart';
import 'location_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => OnboardingScreen(),
    );
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Start'),
    Tab(text: 'Email'),
    Tab(text: 'Demographics'),
    Tab(text: 'Pictures'),
    Tab(text: 'Biography'),
    Tab(text: 'Location')
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;

        return Scaffold(
          appBar: CustomAppBar(
            title: 'ARROW',
            hasActions: false,
          ),
          body: TabBarView(
            children: [
              Start(tabController: tabController),
              Email(tabController: tabController),
              Demo(tabController: tabController),
              Pictures(tabController: tabController),
              Bio(tabController: tabController),
              Location(tabController: tabController),
            ],
          ),
        );
      }),
    );
  }
}
