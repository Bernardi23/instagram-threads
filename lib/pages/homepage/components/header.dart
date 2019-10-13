import '../../../users.dart';
import 'package:flutter/material.dart';

import '_components.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.user,
    @required this.scroll,
    @required this.isScrolling,
    @required this.cameraActivated,
  }) : super(key: key);

  final User user;
  final double scroll;
  final bool isScrolling;
  final bool cameraActivated;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          child: Icon(Icons.dehaze),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).buttonColor,
          ),
        ),
        Avatar(user: user, owner: true),
        AnimatedButton(
          scroll: scroll,
          isScrolling: isScrolling,
          activated: cameraActivated,
          icon: Icons.camera_alt,
        ),
      ],
    );
  }
}
