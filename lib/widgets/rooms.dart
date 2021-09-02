import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/user_model.dart';
import 'package:flutter_facebook_responsive_ui/widgets/profile_avatar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/responsive.dart';

//Following is teh widget to show the online users (Along with create room button)
class Rooms extends StatelessWidget {
  final List<User> onlineUsers;

  Rooms({@required this.onlineUsers});

  @override
  Widget build(BuildContext context) {

final bool isDeskTop = Responsive.isDesktop(context);

    return Card(
        margin: EdgeInsets.all(isDeskTop?5.0:0.0),
      elevation: isDeskTop?1.0:0.0,
      shape: isDeskTop? RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)):null,
      child: Container(
        height: 60.0,
        color: Colors.white,
        //Following will be a list view, with first item as create Room button and then list of online users
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          scrollDirection: Axis.horizontal,
          itemCount: 1 + onlineUsers.length,
          itemBuilder: (BuildContext buildContext, int index) {
            //The button first
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _CreateRoomButton(),
              );
            }
    
            final User user =
                onlineUsers[index - 1]; //(As one added for create room button)
    
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ProfileAvatar(
                imageUrl: user.imageUrl,
                isActive: true,
              ),
            );
          },
        ),
      ),
    );
  }
}

//The create room widget
class _CreateRoomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {



    return OutlineButton(
      onPressed: () => print('Create Room Button prssed'),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      borderSide: BorderSide(
        width: 2.5,
        color: Colors.blueAccent[100],
      ),
      textColor: Palette.facebookBlue,
      child: Row(
        children: [
          // ShaderMask(
          //   //Shader Mask to give gradient to icon
          //   shaderCallback: (rect) =>
          //       Palette.createRoomGradient.createShader(rect),
          //   child: Icon(
          //     Icons.video_call,
          //     size: 35.0,
          //     color: Colors.white,
          //   ),
          // ),
          Icon(
            Icons.video_call,
            size: 35.0,
            color: Colors.purple,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            'Create\nRoom',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
