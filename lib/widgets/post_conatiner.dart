import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/profile_avatar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/responsive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PostContainer extends StatelessWidget {
  final Post post;

  PostContainer({@required this.post});

  @override
  Widget build(BuildContext context) {
    
final bool isDeskTop = Responsive.isDesktop(context);
    return Card(
        margin: EdgeInsets.all(isDeskTop?5.0:0.0),
      elevation: isDeskTop?1.0:0.0,
      shape: isDeskTop? RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)):null,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        padding: EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //Now, we will place the requirements one by one
                  _PostHeader(post: post),
                  SizedBox(
                    height: 4.0,
                  ),
                  //Setting the post caption
                  Text(post.caption),
                  //Now providig some spacing  according to the image present or not
                  post.imageUrl != null
                      ? const SizedBox.shrink()
                      : const SizedBox(
                          height: 6.0,
                        ),
                ],
              ),
            ),
            //The post image. only of avilable
            post.imageUrl != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.network(
                      post.imageUrl,
                    ),
                  )
                : const SizedBox.shrink(),
    
            //The bottom widgetsa below the post image
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: _PostStats(post: post),
            ),
          ],
        ),
      ),
    );
  }
}

//Following is the widget to create a header for the post
class _PostHeader extends StatelessWidget {
  final Post post;
  _PostHeader({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: post.user.imageUrl),
        const SizedBox(
          width: 8.0,
        ),
        //Tye column for name and tiome stamp
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    '${post.timeAgo}  ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  ),
                ],
              )
            ],
          ),
        ),
        //The menu button in right
        IconButton(
          onPressed: () => print('Option on post clicked'),
          icon: Icon(Icons.more_horiz),
        )
      ],
    );
  }
}

//Following is the widget to create the post stats under the image
class _PostStats extends StatelessWidget {
  final Post post;

  _PostStats({@required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Palette.facebookBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 4.0,
            ),
            //The likes
            Expanded(
              child: Text(
                '${post.likes}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            //The comments
            Text(
              '${post.comments} Comments',
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(
              width: 8.0,
            ),
            //The shares
            Text(
              '${post.shares} Shares',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        const Divider(),
        //The row for like, comment and share button
        Row(
          children: [
            //Like operation button
            _PostOpeartionButton(
              icon: Icon(
                MdiIcons.thumbUpOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Like',
              onTap: () => ('Like Pressed'),
            ),
            //Comment operation button
            _PostOpeartionButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Comment',
              onTap: () => ('Comment Pressed'),
            ),
            //Share operation button
            _PostOpeartionButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'Share',
              onTap: () => ('Share Pressed'),
            ),
          ],
        ),
      ],
    );
  }
}

//Following is the button, that creates the like, share and comment button
class _PostOpeartionButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  _PostOpeartionButton(
      {@required this.icon, @required this.label, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            onTap();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(
                  width: 4.0,
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
