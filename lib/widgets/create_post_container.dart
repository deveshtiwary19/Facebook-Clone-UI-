import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/profile_avatar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/responsive.dart';

class CreatePostConatiner extends StatelessWidget {
  final User currentUser;

  const CreatePostConatiner({@required this.currentUser});

  @override
  Widget build(BuildContext context) {
    final bool isDeskTop = Responsive.isDesktop(context);

    return Card(
      margin: EdgeInsets.all(isDeskTop?5.0:0.0),
      elevation: isDeskTop?1.0:0.0,
      shape: isDeskTop? RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)):null,
      child: Container(
        padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        color: Colors.white,
        child: Column(
          children: [
            //The row for avatar and edit text
            Row(
              children: [
                ProfileAvatar(imageUrl: currentUser.imageUrl),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration.collapsed(
                        hintText: 'What\'s on your mind?'),
                  ),
                ),
              ],
            ),
            //The divider
            const Divider(
              height: 10.0,
              thickness: 0.5,
            ),
            //Row for the bottom three buttons
            Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //The live button
                  FlatButton.icon(
                    onPressed: () => print('Live Pressed'),
                    icon: const Icon(
                      Icons.videocam,
                      color: Colors.red,
                    ),
                    label: Text('Live'),
                  ),
                  const VerticalDivider(
                    width: 8.0,
                  ),
                  //
                  FlatButton.icon(
                    onPressed: () => print('Photo Pressed'),
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.green,
                    ),
                    label: Text('Photo'),
                  ),
                  const VerticalDivider(
                    width: 8.0,
                  ),
                  //
                  FlatButton.icon(
                    onPressed: () => print('Room Pressed'),
                    icon: const Icon(
                      Icons.video_call,
                      color: Colors.purple,
                    ),
                    label: Text('Room'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
