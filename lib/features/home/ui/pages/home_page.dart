import 'package:flutter/material.dart';
import 'package:project66/core/widgets/app_bar/app_bar_widget.dart';

import '../../../natural_numbers/ui/pages/natural_numbers_screen.dart';
import '../widget/bottom_nav_widget.dart';
import '../../../scan/ui/pages/scan_view.dart';
import 'menu_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: pageIndex == 0,
      onPopInvoked: (didPop) {
        if (pageIndex != 0) {
          pageIndex = 0;
          setState(() => _pageController.jumpToPage(0));
        }
      },
      child: Scaffold(
        bottomNavigationBar: NewNav(
          onChange: (index) {
            pageIndex = index;
            setState(() => _pageController.jumpToPage(index));
          },
          controller: _pageController,
        ),
        appBar: pageIndex == 3 ? null : const AppBarWidget(zeroHeight: true),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              HomeScreen(),
              ScanPage(),
              MenuScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
