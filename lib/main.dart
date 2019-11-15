import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Animations'),
        ),
        body: EasingAnimationWidget(),
      ),
    );
  }
}

class EasingAnimationWidget extends StatefulWidget {
  @override
  _EasingAnimationWidgetState createState() => _EasingAnimationWidgetState();
}

class _EasingAnimationWidgetState extends State<EasingAnimationWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    void handler(status){
      if(status == AnimationStatus.completed){
        _animation.removeStatusListener(handler);
        _controller.reset();
        _animation = Tween(begin: 0.0,end: 1.0).animate(
          CurvedAnimation(curve: Curves.fastOutSlowIn,parent: _controller)
        );
        _controller.forward();
      }
    }
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _animation = Tween(begin: -1, end: 0.0).animate(
        CurvedAnimation(curve: Curves.fastOutSlowIn, parent: _controller))..addStatusListener(handler);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    //Implemetation of app animation goes here
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget child){
        return Scaffold(
          body: Transform(
            transform: Matrix4.translationValues(_animation.value*width, 0, 0),
            child: new Center(
              child: Container(
                width: 200,
                height: 200,
                color: Colors.black12,
              ),
              ),
          ),
        );
      },
    );
  }
  
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
}