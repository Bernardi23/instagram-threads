import '../../../users.dart';

import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final bool owner;
  final User user;

  Avatar({this.owner = false, this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 80,
          height: 80,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: user.hasStory
                ? Border.all(
                    color: user.hasSeenStory ? Color(0x77919191) : Theme.of(context).accentColor,
                    width: 2,
                  )
                : Border.all(color: Colors.transparent),
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.img),
          ),
        ),
        user.active
            ? Positioned(
                bottom: 3,
                right: 3,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(5.0),
                  child: !owner
                      ? Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).accentColor,
                          ),
                        )
                      : Icon(
                          Icons.add,
                          size: 15,
                          color: Colors.black,
                        ),
                ),
              )
            : Container()
      ],
    );
  }
}
