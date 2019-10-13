import 'dart:math';

import 'package:flutter/gestures.dart';

import '../../../users.dart';
import 'package:flutter/material.dart';
import '_components.dart';

class Chat extends StatefulWidget {
  const Chat({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  double _drag;

  @override
  void initState() {
    _drag = 0;
    super.initState();
  }

  double _convertDrag() {
    return (pow(_drag.abs(), 0.5));
  }

  Future<void> getDragToZero() async {
    if (_drag.toInt() > 0.1) {
      setState(() => _drag -= 0.075);
      await Future.delayed(Duration(microseconds: (100)));
      getDragToZero();
    } else if (_drag.toInt() < -0.1) {
      setState(() => _drag += 0.075);
      await Future.delayed(Duration(microseconds: (100)));
      getDragToZero();
    } else {
      setState(() => _drag = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(left: 15 + _convertDrag(), top: 15, child: _buildButton(Icons.close)),
        Positioned(right: 15 + _convertDrag(), top: 15, child: _buildButton(Icons.camera_alt, right: true)),
        CustomDismissible(
          movementDuration: Duration(milliseconds: 1000),
          key: Key(''),
          dragginAction: (d) => setState(() => _drag += d.delta.dx * 0.4),
          dragginEnd: (d) => getDragToZero(),
          child: Container(
            color: Colors.white,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Row(
                children: <Widget>[
                  Avatar(user: widget.user),
                  SizedBox(width: 15),
                  _buildChatInfo(context),
                  _buildNotificationBubble(context)
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  if (_drag.abs() > 0)
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: _convertDrag().abs() < 10 ? _convertDrag().abs() : 10,
                      blurRadius: _convertDrag().abs() < 10 ? _convertDrag().abs() : 10,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(IconData icon, {right = false}) {
    return AnimatedButton(
      icon: icon,
      activated: _drag.abs() > 50,
      isScrolling: false,
      scroll: _drag,
    );
  }

  Widget _buildNotificationBubble(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          height: 15,
          width: 15,
          decoration: widget.user.notification
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).focusColor,
                )
              : BoxDecoration(),
        ),
      ),
    );
  }

  Widget _buildChatInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.user.username,
          style: Theme.of(context).textTheme.subhead,
        ),
        SizedBox(height: 4),
        Text(
          widget.user.lastmsg,
          style: TextStyle(
            fontWeight: widget.user.notification ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        SizedBox(height: 6),
        Text(widget.user.status, style: Theme.of(context).textTheme.subtitle),
      ],
    );
  }
}
