import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/rendering.dart';
import 'package:gh_app/view/pages/assets/listings_page.dart';
import 'package:gh_app/view/pages/assets/post_page.dart';
import 'package:gh_app/view/pages/assets/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final autoSizeGroup = AutoSizeGroup();
  var _bottomNavIndex = 0; //default index of a first screen

  // late AnimationController _fabAnimationController;
  // late AnimationController _borderRadiusAnimationController;
  // late Animation<double> fabAnimation;
  // late Animation<double> borderRadiusAnimation;
  // late CurvedAnimation fabCurve;
  // late CurvedAnimation borderRadiusCurve;
  // late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[Icons.home_rounded, Icons.account_circle_rounded];

  @override
  void initState() {
    super.initState();

    // _fabAnimationController = AnimationController(
    //   duration: Duration(milliseconds: 500),
    //   vsync: this,
    // );
    // _borderRadiusAnimationController = AnimationController(
    //   duration: Duration(milliseconds: 500),
    //   vsync: this,
    // );
    // fabCurve = CurvedAnimation(
    //   parent: _fabAnimationController,
    //   curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    // );
    // borderRadiusCurve = CurvedAnimation(
    //   parent: _borderRadiusAnimationController,
    //   curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    // );

    // fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    // borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
    //   borderRadiusCurve,
    // );

    // _hideBottomBarAnimationController = AnimationController(
    //   duration: Duration(milliseconds: 200),
    //   vsync: this,
    // );

    // Future.delayed(
    //   Duration(seconds: 1),
    //   () => _fabAnimationController.forward(),
    // );
    // Future.delayed(
    //   Duration(seconds: 1),
    //   () => _borderRadiusAnimationController.forward(),
    // );
  }

  // bool onScrollNotification(ScrollNotification notification) {
  //   if (notification is UserScrollNotification &&
  //       notification.metrics.axis == Axis.vertical) {
  //     switch (notification.direction) {
  //       case ScrollDirection.forward:
  //         _hideBottomBarAnimationController.reverse();
  //         _fabAnimationController.forward(from: 0);
  //         break;
  //       case ScrollDirection.reverse:
  //         _hideBottomBarAnimationController.forward();
  //         _fabAnimationController.reverse(from: 1);
  //         break;
  //       case ScrollDirection.idle:
  //         break;
  //     }
  //   }
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).extension<CustomColorsTheme>()!;
    return Scaffold(
      extendBody: true,
      // appBar: AppBar(
      //   title: Text(
      //     widget.title,
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body: NotificationListener<ScrollNotification>(
        // onNotification: onScrollNotification,
        child: NavigationScreen(_bottomNavIndex),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          size: 36,
        ),
        onPressed: () {
          // _fabAnimationController.reset();
          // _borderRadiusAnimationController.reset();
          // _borderRadiusAnimationController.forward();
          // _fabAnimationController.forward();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostPage()));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 30,
                color: color,
              ),
              // const SizedBox(height: 4),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8),
              //   child: AutoSizeText(
              //     "brightness $index",
              //     maxLines: 1,
              //     style: TextStyle(color: color),
              //     group: autoSizeGroup,
              //   ),
              // )
            ],
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        activeIndex: _bottomNavIndex,
        splashColor: Theme.of(context).colorScheme.primary,
        // notchAndCornersAnimation: borderRadiusAnimation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        // hideAnimationController: _hideBottomBarAnimationController,
        shadow: BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final int index;

  NavigationScreen(this.index) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  // late AnimationController _controller;
  // late Animation<double> animation;

  // @override
  // void didUpdateWidget(NavigationScreen oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.index != widget.index) {
  //     // _startAnimation();
  //   }
  // }

  // @override
  // void initState() {
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: Duration(milliseconds: 1000),
  //   );
  //   animation = CurvedAnimation(
  //     parent: _controller,
  //     curve: Curves.easeIn,
  //   );
  //   _controller.forward();
  //   super.initState();
  // }

  // _startAnimation() {
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: Duration(milliseconds: 1000),
  //   );
  //   animation = CurvedAnimation(
  //     parent: _controller,
  //     curve: Curves.easeIn,
  //   );
  //   _controller.forward();
  // }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).extension<CustomColorsTheme>()!;
    return Container(
      color: Theme.of(context).colorScheme.background,
      child:
          SafeArea(child: widget.index == 0 ? ListingsPage() : ProfilePage()),
      // child: ListView(
      //   children: [
      //     SizedBox(height: 64),
      //     Center(
      //       child: CircularRevealAnimation(
      //         animation: animation,
      //         centerOffset: Offset(80, 80),
      //         maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
      //         child: Icon(
      //           widget.iconData,
      //           color: Theme.of(context).colorScheme.primary,
      //           size: 160,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
