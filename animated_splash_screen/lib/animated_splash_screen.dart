library animated_splash_screen;

import 'package:flutter/material.dart';

enum SplashType { simpleSplash, backgroundScreenReturn }

enum SplashTransition {
  slideTransition,
  scaleTransition,
  rotationTransition,
  sizeTransition,
  fadeTransition,
  decoratedBoxTransition
}

class AnimatedSplashScreen extends StatefulWidget {
  /// Type of splash transition
  final SplashTransition splashTransition;

  /// Only required while using [AnimatedSplashScreen.withScreenFunction]
  /// here you pass your function that needs to be called before jumping
  /// on to the next screen
  final Future Function()? function;

  /// Custom animation to icon of splash
  final Animatable? customAnimation;

  /// Background color
  final Color backgroundColor;

  /// Background image
  final ImageProvider? backgroundImage;

  /// Compulsory in default constructor.
  /// Here you pass your widget that will be browsed
  final Widget? nextScreen;

  /// Type of AnimatedSplashScreen
  final SplashType type;

  /// to make the icon in [Center] of splash
  final bool centered;

  /// If you want to implement the navigation to the next page yourself.
  /// By default this is [false], the widget will call Navigator.of(_context).pushReplacement()
  /// using PageTransition with [transitionType] after [duration] to [nextScreen]
  final bool disableNavigation;

  /// It can be string for [Image.asserts], normal [Widget] or you can user tags
  /// to choose which one you image type, for example:
  /// * '[n]www.my-site.com/my-image.png' to [Image.network]
  final dynamic splash;

  /// Time in milliseconds after splash animation to jump to next screen
  /// Default is [milliseconds: 2500], minimum is [milliseconds: 100]
  final int duration;

  /// Curve of splash animation
  final Curve curve;

  /// Splash animation duration, default is [milliseconds: 800]
  final Duration? animationDuration;

  /// Size of an icon in splash screen
  final double? splashIconSize;

  /// Here you pass your route that will be browsed
  final String? nextRoute;

  factory AnimatedSplashScreen({
    Curve curve = Curves.easeInCirc,
    Future Function()? function,
    int duration = 2500,
    required dynamic splash,
    required Widget nextScreen,
    Color backgroundColor = Colors.white,
    ImageProvider? backgroundImage,
    Animatable? customTween,
    bool centered = false,
    bool disableNavigation = false,
    SplashTransition? splashTransition,
    Duration? animationDuration,
    double? splashIconSize,
    String? nextRoute,
  }) {
    return AnimatedSplashScreen._internal(
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      animationDuration: animationDuration,
      splashTransition: splashTransition ?? SplashTransition.fadeTransition,
      splashIconSize: splashIconSize,
      customAnimation: customTween,
      function: function,
      nextRoute: nextRoute,
      duration: duration,
      centered: centered,
      disableNavigation: disableNavigation,
      splash: splash,
      type: SplashType.simpleSplash,
      nextScreen: nextScreen,
      curve: curve,
    );
  }

  factory AnimatedSplashScreen.withScreenFunction({
    Curve curve = Curves.easeInCirc,
    bool centered = true,
    bool disableNavigation = false,
    int duration = 2500,
    required dynamic splash,
    required Future<Widget> Function() screenFunction,
    Animatable? customTween,
    Color backgroundColor = Colors.white,
    ImageProvider? backgroundImage,
    SplashTransition? splashTransition,
    Duration? animationDuration,
    double? splashIconSize,
  }) {
    return AnimatedSplashScreen._internal(
      type: SplashType.backgroundScreenReturn,
      animationDuration: animationDuration,
      splashTransition: splashTransition ?? SplashTransition.fadeTransition,
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      splashIconSize: splashIconSize,
      customAnimation: customTween,
      function: screenFunction,
      duration: duration,
      centered: centered,
      disableNavigation: disableNavigation,
      nextRoute: null,
      nextScreen: null,
      splash: splash,
      curve: curve,
    );
  }

  factory AnimatedSplashScreen.withScreenRouteFunction({
    Curve curve = Curves.easeInCirc,
    bool centered = true,
    bool disableNavigation = false,
    int duration = 2500,
    required dynamic splash,
    required Future<String> Function() screenRouteFunction,
    Animatable? customTween,
    Color backgroundColor = Colors.white,
    ImageProvider? backgroundImage,
    SplashTransition? splashTransition,
    Duration? animationDuration,
    double? splashIconSize,
  }) {
    return AnimatedSplashScreen._internal(
      type: SplashType.backgroundScreenReturn,
      animationDuration: animationDuration,
      splashTransition: splashTransition ?? SplashTransition.fadeTransition,
      backgroundColor: backgroundColor,
      backgroundImage: backgroundImage,
      splashIconSize: splashIconSize,
      customAnimation: customTween,
      function: screenRouteFunction,
      duration: duration,
      centered: centered,
      disableNavigation: disableNavigation,
      nextRoute: null,
      nextScreen: null,
      splash: splash,
      curve: curve,
    );
  }

  AnimatedSplashScreen._internal({
    required this.animationDuration,
    required this.splashTransition,
    required this.customAnimation,
    required this.backgroundColor,
    required this.backgroundImage,
    required this.splashIconSize,
    required this.nextScreen,
    required this.function,
    required this.duration,
    required this.centered,
    required this.disableNavigation,
    required this.splash,
    required this.curve,
    required this.type,
    required this.nextRoute,
  });

  @override
  _AnimatedSplashScreenState createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  static late BuildContext _context;
  late Animation _animation;

  AnimatedSplashScreen get w => widget;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        duration: w.animationDuration ?? Duration(milliseconds: 800),
        vsync: this);

    Animatable animation = w.customAnimation ??
        () {
          switch (w.splashTransition) {
            case SplashTransition.slideTransition:
              return Tween<Offset>(end: Offset.zero, begin: Offset(1, 0));

            case SplashTransition.decoratedBoxTransition:
              return DecorationTween(
                  end: BoxDecoration(color: Colors.black87),
                  begin: BoxDecoration(color: Colors.redAccent));

            default:
              return Tween(begin: 0.0, end: 1.0);
          }
        }() as Animatable<dynamic>;

    _animation = animation
        .animate(CurvedAnimation(parent: _animationController, curve: w.curve));
    _animationController.forward().then((value) => doTransition());
  }

  /// call function case needed and then jump to next screen
  doTransition() async {
    if (w.type == SplashType.backgroundScreenReturn)
      navigator(await w.function!());
    else if (!w.disableNavigation) navigator(w.nextRoute ?? w.nextScreen);
  }

  @override
  void dispose() {
    _animationController.reset();
    _animationController.dispose();
    super.dispose();
  }

  navigator(screen) {
    Future.delayed(Duration(milliseconds: w.duration < 100 ? 100 : w.duration))
        .then((_) {
      try {
        if (screen is String) {
          Navigator.of(_context).pushReplacementNamed(screen);
        } else {
          Navigator.of(_context)
              .pushReplacement(MaterialPageRoute(builder: (context) => screen));
        }
      } catch (msg) {
        print('AnimatedSplashScreen -> '
            'error in jump to next screen, probably '
            'this run is in hot reload: $msg');
      }
    });
  }

  /// Return icon of splash screen
  Widget getSplash() {
    final size =
        w.splashIconSize ?? MediaQuery.of(context).size.shortestSide * 0.2;

    Widget main({required Widget child}) =>
        w.centered ? Center(child: child) : child;

    return getTransition(
      child: main(
        child: SizedBox(
          width: double.infinity, // تأخذ العرض الكامل
          height: double.infinity, // تأخذ الارتفاع الكامل
          child: w.splash is String
              ? <Widget>() {
                  if (w.splash.toString().contains('[n]'))
                    return Image.network(
                        w.splash.toString().replaceAll('[n]', ''));
                  else
                    return Image.asset(w.splash);
                }()
              : (w.splash is IconData ? Icon(w.splash, size: size) : w.splash),
        ),
      ),
    );
  }

  /// return transtion
  Widget getTransition({required Widget child}) {
    switch (w.splashTransition) {
      case SplashTransition.slideTransition:
        return SlideTransition(
            position: (_animation as Animation<Offset>), child: child);

      case SplashTransition.scaleTransition:
        return ScaleTransition(
            scale: (_animation as Animation<double>), child: child);

      case SplashTransition.rotationTransition:
        return RotationTransition(
            turns: (_animation as Animation<double>), child: child);

      case SplashTransition.sizeTransition:
        return SizeTransition(
            sizeFactor: (_animation as Animation<double>), child: child);

      case SplashTransition.fadeTransition:
        return FadeTransition(
            opacity: (_animation as Animation<double>), child: child);

      case SplashTransition.decoratedBoxTransition:
        return DecoratedBoxTransition(
            decoration: (_animation as Animation<Decoration>), child: child);

      default:
        return FadeTransition(
            opacity: (_animation as Animation<double>), child: child);
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      backgroundColor: w.backgroundColor,
      body: Container(
        width: double.infinity, // تأخذ العرض الكامل
        height: double.infinity, // تأخذ الارتفاع الكامل
        decoration: BoxDecoration(
          image: w.backgroundImage != null
              ? DecorationImage(
                  image: w.backgroundImage!,
                  fit: BoxFit.cover, // تغطي الصورة الشاشة بالكامل
                )
              : null,
        ),
        child: getSplash(),
      ),
    );
  }
}
