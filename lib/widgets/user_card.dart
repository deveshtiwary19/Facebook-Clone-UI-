import 'package:flutter/material.dart';
import 'package:flutter_facebook_responsive_ui/models/models.dart';
import 'package:flutter_facebook_responsive_ui/widgets/profile_avatar.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProfileAvatar(imageUrl: user.imageUrl),
        const SizedBox(
          width: 6.0,
        ),
        Text(
          user.name,
          style: TextStyle(fontSize: 16.0),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
