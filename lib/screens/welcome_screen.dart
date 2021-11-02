import 'screens.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/components.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  // To use curves and other animations
  Animation animation;

  @override
  void initState() {
    super.initState();
    //vsync > required ! This is where we provide the ticker provider > our state object the class <> inherits its parent > State object
    // The ticker provider inherits the state of the class for the state handling the animation <SingleTickerProviderMixin> for one animation or many
    //Mixin add many capabilities >> We enable the state object to act as the Tickerprovider... (State of progression)
    // Adding <this,> keyword refers to the class providing us with the SingleTickerProviderStateMixin <normally represented by the class extending the
    // stateful widget

    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
      upperBound: 1,
      //A form of iterator ,with a built in setstate
      //upperBound: 100 | No upperbound when working with animations can declare but must be in [0,1]
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    //Can reverse an animation > from big to small
    //controller.reverse(from: 1.0);
    controller.forward();

    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    controller.addListener(() {
      // setState to the controller, helps the build method keep track of the changing state
      setState(() {});
      //consider that the animation is thrown onto the controller as its child
      print(animation.value);
      //print(controller.value);
    });
  }

  // This method kills the animation as soon as the screen is closed | To avoid resource hogging
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: animation
      // .value, //withOpacity(controller.value), => color change with a delay
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/0.jpg"), fit: BoxFit.cover)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/salogo.png'),
                      height: 100, //animation.value * 100,
                    ),
                  ),
                  TypeWriter(['Mzansi Chat']),
                  // Text(
                  //   'Flash Chat', //'${controller.value.toInt()}%',
                  //   style: TextStyle()
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              RoundedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                Title: 'Login',
                color: Colors.blue,
              ),
              RoundedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                Title: 'Register',
                color: Colors.blueGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TypeWriter extends StatelessWidget {
  List<String> title;
  TypeWriter(@required this.title);

  @override
  Widget build(BuildContext context) {
    return TypewriterAnimatedTextKit(
      repeatForever: false,
      speed: const Duration(milliseconds: 250),
      totalRepeatCount: 3,
      displayFullTextOnTap: true,
      text: title,
      textStyle: TextStyle(
        fontSize: 30.0,
        color: Colors.white,
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
