import 'dart:math';

import 'package:flutter/material.dart';

import '../../users.dart';

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
          width: 40,
          height: 40,
          child: Icon(Icons.dehaze),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).buttonColor,
          ),
        ),
        Avatar(user: user, owner: true),
        HeaderButton(
          scroll: scroll,
          isScrolling: isScrolling,
          cameraActivated: cameraActivated,
        ),
      ],
    );
  }
}

class Chat extends StatelessWidget {
  const Chat({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Avatar(user: user),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              user.username,
              style: Theme.of(context).textTheme.subhead,
            ),
            SizedBox(height: 8),
            Text(
              user.lastmsg,
              style: TextStyle(
                fontWeight: user.notification ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            SizedBox(height: 6),
            Text(user.status, style: Theme.of(context).textTheme.subtitle),
          ],
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 15,
              width: 15,
              decoration: user.notification
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).focusColor,
                    )
                  : BoxDecoration(),
            ),
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final bool owner;
  final User user;

  Avatar({this.owner = false, this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 70,
          height: 70,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: user.hasStory
                ? Border.all(
                    color: user.hasSeenStory ? Color(0xFF919191) : Theme.of(context).accentColor,
                    width: 1,
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

class HeaderButton extends StatefulWidget {
  HeaderButton({
    Key key,
    @required this.scroll,
    @required this.isScrolling,
    @required this.cameraActivated,
  }) : super(key: key);

  final double scroll;
  final bool isScrolling;
  final bool cameraActivated;

  @override
  _HeaderButtonState createState() => _HeaderButtonState();
}

class _HeaderButtonState extends State<HeaderButton> with TickerProviderStateMixin {
  AnimationController _ac;
  Animation _buttonColor;
  Animation _iconColor;

  @override
  void initState() {
    // Border Animation

    // Camera activate Animation
    _ac = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _iconColor = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(CurvedAnimation(curve: Curves.easeInOut, parent: _ac));
    _buttonColor = ColorTween(begin: Colors.black.withOpacity(0.0), end: Colors.black)
        .animate(CurvedAnimation(curve: Curves.easeInOut, parent: _ac));
    super.initState();
  }

  @override
  void didUpdateWidget(HeaderButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cameraActivated && !oldWidget.cameraActivated) {
      _ac.forward();
    } else if (!widget.cameraActivated && oldWidget.cameraActivated) {
      _ac.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final actualScroll = (widget.scroll.abs() / 50 < 1) ? (widget.scroll.abs() / 50) : 1.0;
    return AnimatedBuilder(
      animation: _ac,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Grey border
            Opacity(
              opacity: actualScroll,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[400],
                ),
              ),
            ),
            CustomPaint(
              painter: ButtonBorderPainter(
                actualScroll,
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _buttonColor.value,
              ),
            ),
            Container(
              width: 40,
              height: 40,
              child: Icon(
                Icons.camera_alt,
                color: _iconColor.value,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).buttonColor.withOpacity(1 * (1 - actualScroll)),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ButtonBorderPainter extends CustomPainter {
  double progression;

  ButtonBorderPainter(this.progression);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, 0), radius: 45 / 2),
      (progression < 1) ? (1.5 - progression) * pi : 0,
      (progression < 1) ? progression * 2 * pi : 2 * pi,
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(ButtonBorderPainter oldDelegate) {
    return progression != oldDelegate.progression;
  }
}
