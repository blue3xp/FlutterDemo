import 'package:flutter/material.dart';
import 'circle_progress_bar.dart';
import 'dart:ui';
import 'util.dart';
class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProgressCard(),
      ),
    );
  }
}

class ProgressCard extends StatefulWidget {
  @override
  _ProgressCardState createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  double progressPercent = 0;

  void initState() {
    super.initState();
    _start();
  }

  @override
  Widget build(BuildContext context) {
    Color foreground = Colors.red;

    if (progressPercent >= 0.8) {
      foreground = Colors.green;
    } else if (progressPercent >= 0.4) {
      foreground = Colors.orange;
    }

    Color background = getColorFromHex("#D8D8D8");
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough, //未定位widget占满Stack整个空间
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
            child: Image.asset(
          'assets/login/Component_BG.png',
          fit: BoxFit.fill,
        )),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 15,
              sigmaY: 15,
            ),
            child: Container(
              color: Colors.white10,
            ),
          ),
        ),
        Container(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              child: CircleProgressBar(
                backgroundColor: background,
                foregroundColor: foreground,
                value: this.progressPercent,
              ),
              onTap: () {
                _updateValue1();
              },
              onDoubleTap: () {
                _updateValue2();
              },
            ),
          ),
        ),
        Positioned(
          left: 20.0,
          top: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new CircleAvatar(
                radius: 36.0,
                backgroundImage: AssetImage('assets/login/headicon.png'),
              ),
              SizedBox(
                width: 20,
              ),
              Text("Climber",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            ],
          ),
        )
      ],
    );
  }

  void _updateValue1() {
    final updated = ((this.progressPercent + 0.1).clamp(0.0, 1.0) * 100);
    setState(() {
      this.progressPercent = updated.round() / 100;
    });
  }

  void _updateValue2() {
    final updated = ((this.progressPercent - 0.1).clamp(0.0, 1.0) * 100);
    setState(() {
      this.progressPercent = updated.round() / 100;
    });
  }

  void _start() {
    Future.delayed(const Duration(milliseconds: 500), () {
      _updateValue1();
    });
  }
}
