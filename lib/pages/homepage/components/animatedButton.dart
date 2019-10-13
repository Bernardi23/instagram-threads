import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  AnimatedButton({
    Key key,
    @required this.scroll,
    @required this.isScrolling,
    @required this.activated,
    @required this.icon,
  }) : super(key: key);

  final double scroll;
  final bool isScrolling;
  final bool activated;
  final IconData icon;

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> with TickerProviderStateMixin {
  AnimationController _ac;
  Animation _buttonColor;
  Animation _iconColor;

  @override
  void initState() {
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
  void didUpdateWidget(AnimatedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activated && !oldWidget.activated) {
      _ac.forward();
    } else if (!widget.activated && oldWidget.activated) {
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
                width: 55,
                height: 55,
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
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _buttonColor.value,
              ),
            ),
            Container(
              width: 50,
              height: 50,
              child: Icon(
                widget.icon,
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
      Rect.fromCircle(center: Offset(0, 0), radius: 55 / 2),
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
