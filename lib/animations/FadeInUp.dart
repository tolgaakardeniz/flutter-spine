/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'dart:async';

import 'package:spine/data/library.dart';
import 'package:flutter/material.dart';

class FadeInUp extends StatefulWidget {
  final Widget child;
  final Duration? startDuration;
  final Duration? animationDuration;
  final double? size;
  final dynamic parentObject;

  const FadeInUp({Key? key, required this.child, this.startDuration, this.animationDuration, this.size, this.parentObject}) : super(key: key);

  @override
  _FadeInUpState createState() => _FadeInUpState();
}

class _FadeInUpState extends State<FadeInUp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late String animationID;
  late int screenCount;

  Duration? get startDuration {
    return widget.startDuration == null ? Duration(milliseconds: 500) : widget.startDuration;
  }

  Duration? get animationDuration {
    return widget.animationDuration == null ? Duration(milliseconds: 500) : widget.animationDuration;
  }

  double get size {
    return widget.size == null ? 50 : widget.size!;
  }

  @override
  void initState() {
    super.initState();

    animationID = Library.globalData["animationCount"].toString();
    Library.globalData["animationCount"]++;

    ///Random().nextInt(99999).toString() + Random().nextInt(99999).toString() + Random().nextInt(99999).toString();

    Library.debugPrint(animationID + " " + "FadeInUp");

    _controller = AnimationController(
      duration: animationDuration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(curve: Curves.easeInOut, parent: _controller));

    try {
      screenCount = widget.parentObject.screenCount;

      /**
       * Global anmimation controller
       */
      Library.globalData["widgetList"][screenCount]["animations"][animationID] = <String, dynamic>{};

      /**
       * Animation Controller
       */
      Library.globalData["widgetList"][screenCount]["animations"][animationID]["animationController"] = _controller;
      /**
       * Start Duration
       */
      Library.globalData["widgetList"][screenCount]["animations"][animationID]["startDuration"] = startDuration;
    } catch (e) {
      Library.debugPrint(e);
    }

    Timer(startDuration!, () {
      if (_controller.status == AnimationStatus.dismissed || _controller.status == AnimationStatus.completed) {
        try {
          _controller.reset();
          _controller.forward();
        } catch (e) {
          Library.debugPrint(e);
        }
      }

      Library.debugPrint("FadeInDown status : " + _controller.status.toString());
    });
  }

/*  Future<void> _playAnimation() async {
    try {
      if (_controller.status == AnimationStatus.dismissed) {
        await _controller.forward().orCancel;
      }
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

  Future<void> reverseAnimation() async {
    try {
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }*/

  @override
  void dispose() {
    try {
      _controller.stop();
      _controller.dispose();
    } catch (e) {
      Library.debugPrint(e);
    }

    try {
      Library.globalData["widgetList"][widget.parentObject.screenCount]["animations"].remove(animationID);
    } catch (e) {
      Library.debugPrint(e);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: widget.child,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          child: Opacity(
            opacity: _animation.value,
            child: Opacity(
              opacity: _controller.value,
              child: Transform.translate(
                offset: Offset(0, size - (size * _controller.value)),
                child: child,
              ),
            ),
          ),
          offset: Offset(0, size - (size * _controller.value)),
        );
      },
    );
  }
}
