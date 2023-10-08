
import 'dart:async';

import 'package:covidtrackingapp/View/WorldStatsScreen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
 
  // Animation
 late final AnimationController  controller = AnimationController(
  duration: Duration(seconds: 5),
  vsync: this)..repeat();


    @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  
    controller.dispose();
  }

  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (_)=> WorldStatsScreen()));
     
    SystemChannels.textInput.invokeMethod('TextInput.hide');

     
     });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: controller,
            child: Container(
              height: 200,
              width: 200,
              child: Center(
                child: Image(image: AssetImage('images/virus.png')),
              ),
            ),
           builder: (BuildContext context , Widget? child){
            return Transform.rotate(angle: controller.value * 2.0 * math.pi,
            child: child,);
           }),
           SizedBox(
            height: MediaQuery.of(context).size.height * .08,
           ),
           Align(
            alignment: Alignment.center,
             child: Text('Covid 19\nTracker App' ,textAlign: TextAlign.center , style: 
             TextStyle(fontSize: 35 , fontWeight: FontWeight.bold),),
           )

        ],
      ),
    );
  }
}