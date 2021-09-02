import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/data/data.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/circle_button.dart';
import 'package:flutter_facebook_responsive_ui/widgets/contacts_list.dart';
import 'package:flutter_facebook_responsive_ui/widgets/create_post_container.dart';
import 'package:flutter_facebook_responsive_ui/widgets/more_options_list.dart';
import 'package:flutter_facebook_responsive_ui/widgets/post_conatiner.dart';
import 'package:flutter_facebook_responsive_ui/widgets/responsive.dart';
import 'package:flutter_facebook_responsive_ui/widgets/rooms.dart';
import 'package:flutter_facebook_responsive_ui/widgets/stories.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context)
          .unfocus(), //For mobile==> Tap anywhere and the Open keyboard closes
      child: Scaffold(
        body: Responsive(
          mobile:
              _HomeScreenMobile(scrollController: _trackingScrollController),
          desktop:
              _HomeScreenDesktop(scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}

//Following will render the Home Screen for Mobile
class _HomeScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _HomeScreenMobile({ this.scrollController});



  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverAppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.white,
          title: Text(
            'facebook',
            style: TextStyle(
              color: Palette.facebookBlue,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.85,
            ),
          ),
          centerTitle: false,
          floating: true,
          actions: [
            //The search icon
            CircleButton(
              icon: Icons.search,
              iconSize: 30.0,
              onPressed: () => print('search pressed'),
            ),
            //The message icon
            CircleButton(
              icon: MdiIcons.facebookMessenger,
              iconSize: 30.0,
              onPressed: () => print('messenger pressed'),
            ),
          ],
        ),
        //The conatiner for new post
        SliverToBoxAdapter(
          child: CreatePostConatiner(currentUser: currentUser),
        ),
        //The conatiner for list of online users
        SliverPadding(
          padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 5.0),
          sliver: SliverToBoxAdapter(
            child: Rooms(onlineUsers: onlineUsers),
          ),
        ),
        //The stories
        SliverPadding(
          padding: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 5.0),
          sliver: SliverToBoxAdapter(
            child: Stories(currentUser: currentUser, storiesList: stories),
          ),
        ),

        //Thw Posts now
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final Post post = posts[index];
              return PostContainer(post: post);
            },
            childCount: posts.length,
          ),
        ),

        SliverToBoxAdapter(
            child: SizedBox(
          height: 10,
        )),
      ],
    );
  }
}

//Following will render the desktop sized Home Screen
class _HomeScreenDesktop extends StatelessWidget {

  final TrackingScrollController scrollController;

  const _HomeScreenDesktop({ this.scrollController});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Flexible(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: MoreOptionList(currentUser: currentUser),
              ),
            ),),
        const Spacer(),
        Container(
          width: 600.0,
          child: CustomScrollView(
              controller: scrollController,
            slivers: [
              //The stories
              SliverPadding(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
                sliver: SliverToBoxAdapter(
                  child:
                      Stories(currentUser: currentUser, storiesList: stories),
                ),
              ),
              //The conatiner for new post
              SliverToBoxAdapter(
                child: Container(
                    margin: EdgeInsets.only(top: 15.0),
                    child: CreatePostConatiner(currentUser: currentUser)),
              ),
              //The conatiner for list of online users
              SliverPadding(
                padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 5.0),
                sliver: SliverToBoxAdapter(
                  child: Rooms(onlineUsers: onlineUsers),
                ),
              ),

              //Thw Posts now
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final Post post = posts[index];
                    return PostContainer(post: post);
                  },
                  childCount: posts.length,
                ),
              ),

              SliverToBoxAdapter(
                  child: SizedBox(
                height: 10,
              )),
            ],
          ),
        ),
        const Spacer(),
        Flexible(
            flex: 2,
            child: Align(
            alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: ContactsList(users: onlineUsers),
              ),
            ),),
      ],
    );
  }
}
