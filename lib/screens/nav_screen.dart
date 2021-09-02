import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/screens/home_screen.dart';
import 'package:flutter_facebook_responsive_ui/widgets/custom_app_bar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/custom_tab_bar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/responsive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:io'
    show Platform; //Following will be used to detect android or iOs

//Following is the screen to create the Nav Bar

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
//List opf screens we want the app to have for bottomNav bar
  final List<Widget> _screens = [
    HomeScreen(),
    Scaffold(
      body: ScreenTester(
        text: 'I am the Videos\nscreen',
      ),
    ), //As No screen declared for it
    Scaffold(
      body: ScreenTester(
        text: 'I am the Account\nscreen',
      ),
    ),
    Scaffold(
      body: ScreenTester(
        text: 'I am the Groups\nscreen',
      ),
    ),
    Scaffold(
      body: ScreenTester(
        text: 'I am the Notifications\nscreen',
      ),
    ),
    Scaffold(
      body: ScreenTester(
        text: 'I am the Menu\nscreen',
      ),
    ),
  ];

  //Following is the list of icons that we need in our menu
  final List<IconData> _icons = [
    Icons.home, //Home button
    Icons.ondemand_video, //Videos button
    MdiIcons.accountCircleOutline, //Account Button
    MdiIcons.accountGroupOutline, //Groups Button
    MdiIcons.bellOutline, //Notification Button
    Icons.menu, //The menu button at last option
  ];

  //Following is the variable to maintain the selected state of Nav Bar
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //iOs has bottom bar, which may overlap the screen
    //double requiredBottomPadding = Platform.isIOS ? 12.0 : 0.0;

    final Size screenSize = MediaQuery.of(context).size;

    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        appBar: Responsive.isDesktop(context)
            ? PreferredSize(
                child: CustomAppBar(
                  currentUser: currentUser,
                  icon: _icons,
                  selectedIndex: _selectedIndex,
                   onTap: (index) {
                      setState(() {
                        _selectedIndex =
                            index; //Setting selected index to the new index and chnaging the state
                      });
                    },
                ), 
                preferredSize: Size(screenSize.width, 100.0))
            : null,
        //Following is used as prefered for Web Apps
        //Also the scroll position is maaintained
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        //Following might also work(Prefered for mobile devides)
        //TabBarView(
        //   children: _screens,
        //   physics: NeverScrollableScrollPhysics(),
        // ),
        bottomNavigationBar: !Responsive.isDesktop(context)
            ? Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: CustomTabBar(
                    icons: _icons,
                    selectedIndex: _selectedIndex,
                    onTap: (index) {
                      setState(() {
                        _selectedIndex =
                            index; //Setting selected index to the new index and chnaging the state
                      });
                    }),
              )
            : SizedBox.shrink(),
      ),
    );
  }
}

//Following is just the widget to test the screen chnage properly.
//Just remove it once, a real screenfor the option is created
class ScreenTester extends StatelessWidget {
  final String text;
  ScreenTester({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}
