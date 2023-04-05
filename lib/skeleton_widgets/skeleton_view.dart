import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SkeletonView extends StatefulWidget {
  final double? height;
  final double? width;

  SkeletonView({Key? key, this.height, this.width}) : super(key: key);

  createState() => SkeletonState();
}

class SkeletonState extends State<SkeletonView>
    with SingleTickerProviderStateMixin {
  // AnimationController _controller;
  //
  // Animation gradientPosition;

  @override
  void initState() {
    super.initState();
    // _controller = AnimationController(
    //     duration: Duration(milliseconds: 1500), vsync: this);
    //
    // gradientPosition = Tween<double>(
    //   begin: -3,
    //   end: 10,
    // ).animate(
    //   CurvedAnimation(parent: _controller, curve: Curves.linear),
    // )..addListener(() {
    //     setState(() {});
    //   });
    //
    // _controller.repeat();
  }

  @override
  void dispose() {
    //_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Center(
        child: Container(
          height: 60,
          width: 60,
          child: FlareActor(
            "images/loading.flr",

            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "Loading",
          ),
        ),
      ),
    );
  }
}
