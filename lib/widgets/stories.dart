import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/config/palette.dart';
import 'package:flutter_facebook_responsive_ui/models/story_model.dart';
import 'package:flutter_facebook_responsive_ui/models/user_model.dart';
import 'package:flutter_facebook_responsive_ui/widgets/profile_avatar.dart';
import 'package:flutter_facebook_responsive_ui/widgets/responsive.dart';

class Stories extends StatelessWidget {
  final User currentUser;
  final List<Story> storiesList;

  Stories({@required this.currentUser, @required this.storiesList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      color: Responsive.isDesktop(context) ? Colors.transparent:Colors.white,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        scrollDirection: Axis.horizontal,
        itemCount: 1 + storiesList.length, //First one is the add story button
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              child: _StoryCard(
                isAddStory: true,
                currentUser: currentUser,
              ),
            );
          }

          //Grabing the stories from the list
          final Story story = storiesList[index - 1];

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.0,
            ),
            child: _StoryCard(story: story),
          );
        },
      ),
    );
  }
}

//Following is the private stateless widget for story card
class _StoryCard extends StatelessWidget {
  final bool isAddStory;
  final User currentUser;
  final Story story;

  _StoryCard({
    this.isAddStory = false,
    this.currentUser,
    this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //The image first
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.network(
            isAddStory ? currentUser.imageUrl : story.imageUrl,
            height: double.infinity,
            width: 110.0,
            fit: BoxFit.cover,
          ),
        ),
        //A conatiner to overlap the image and give gradient over image
        Container(
          height: double.infinity,
          width: 110.0,
          decoration: BoxDecoration(
            gradient: Palette.storyGradient,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: Responsive.isDesktop(context)? const [BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 4.0),]:null,
          ),
        ),
        //The image at the top left
        Positioned(
          top: 8.0,
          left: 8.0,
          child: isAddStory
              ? Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.add),
                    iconSize: 30.0,
                    color: Palette.facebookBlue,
                    onPressed: () => print('Add to story clicked'),
                  ),
                )
              : ProfileAvatar(
                  imageUrl: story.user.imageUrl,
                  hasBorder: !story.isViewed,
                ),
        ),
        //For the name of the user
        Positioned(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          child: Text(
            isAddStory ? 'Add to Story' : story.user.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
