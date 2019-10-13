import 'package:flutter/material.dart';
import '../../users.dart';
import 'components.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  double _scroll;
  bool _isScrolling;

  ScrollController _sc;
  AnimationController _ac;
  Animation _aPadding;
  double _padding;

  @override
  void initState() {
    // Animation Controller
    _ac = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    // Padding
    _padding = 40;
    // Animated padding
    _aPadding = Tween<double>(
      begin: _padding,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _ac,
      curve: Curves.easeOut,
    ));
    // Scroll Controller
    _sc = ScrollController();
    _sc.addListener(() {
      setState(() {
        // _scroll = 0;
        _isScrolling = true;
      });
      if (_sc.offset < 0) {
        setState(() {
          _scroll = _sc.offset;
          final padding = _sc.offset.abs() / 50 < 1 ? 40 + 10 * (_sc.offset.abs() / 50) : 50.0;
          _padding = padding;
        });
      }
    });
    // Scrolling state
    _scroll = _sc.initialScrollOffset;
    _isScrolling = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (n) => _handleNotification(n),
        child: ListView.builder(
          controller: _sc,
          physics: BouncingScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (ctx, i) {
            final user = users[i];
            return AnimatedBuilder(
              animation: _ac,
              child: (i == 0)
                  ? Header(
                      user: user,
                      scroll: _scroll,
                      isScrolling: _isScrolling,
                      cameraActivated: _sc.offset.abs() / 50 >= 1,
                    )
                  : Chat(user: user),
              builder: (context, child) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: (i == 0) ? 30 : 20,
                  ),
                  child: Column(
                    children: <Widget>[
                      child,
                      SizedBox(height: _isScrolling ? _padding : _aPadding.value),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  _handleNotification(n) {
    if (n is ScrollUpdateNotification) {
      try {} catch (e) {
        setState(() {
          _aPadding = Tween<double>(
            begin: _padding,
            end: 0,
          ).animate(CurvedAnimation(
            parent: _ac,
            curve: Curves.easeOut,
          ));
          _isScrolling = false;
          _scroll = 0.0;
        });
      }
    }
  }
}
