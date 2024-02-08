import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, '/homeScreen');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xffe07648),
            Color(0xfff3c677),
          ])),
        ),
        const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('images/splash.jpg')),
              Text("Recipe",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900),),
              SizedBox(height: 2,),
              SpinKitChasingDots(
                color: Colors.white,
                size: 50.0,
              )
            ],
          ),
        ),
       const Positioned(
          bottom: 2,
            left: 140,
            child: Text("Made by Abhay..",style: TextStyle(fontSize: 15,fontFamily: 'poppins')))
      ]),
    );
  }
}
