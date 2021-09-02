import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/circle_button.dart';
import 'package:flutter_facebook_responsive_ui/widgets/custom_tab_bar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/user_card.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomAppBar extends StatelessWidget {
  final User currentUser;
  final List<IconData> icon;
  final int selectedIndex;
  final Function(int) onTap;

  CustomAppBar(
      {@required this.currentUser,
      @required this.icon,
      @required this.onTap,
      @required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(color: Colors.white, boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 2),
          blurRadius: 4.0,
        ),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'facebook',
              style: TextStyle(
                color: Palette.facebookBlue,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.85,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: 600.0,
            child: CustomTabBar(icons: icon,selectedIndex: selectedIndex,onTap: onTap,isBottomIndicator: true),
          ),
          Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              UserCard(user: currentUser),
              const SizedBox(width: 12.0,),
              CircleButton(icon: Icons.search, iconSize: 30.0, onPressed: ()=> print('Search Pressed'),),
              CircleButton(icon: MdiIcons.facebookMessenger, iconSize: 30.0, onPressed: ()=> print('Messenger Pressed'),),
          ],),)
        ],
      ),
    );
  }
}
