import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeAnimationHandler extends GetxController
    with GetTickerProviderStateMixin {
  late Animation<Offset> aiCardAnimation;
  late AnimationController _aiCardAnimationController;

  late Animation<double> dottedAnimation;
  late AnimationController _dottedAnimationController;

  late Animation<Offset> adsCardAnimation;
  late AnimationController _adsCardAnimationController;

  late Animation<Offset> catCardAnimation;
  late AnimationController _catCardAnimationController;

  @override
  void onInit() {
    super.onInit();

    _aiCardAnimationController = AnimationController(
      vsync: this,
      duration: 2000.milliseconds,
    );
    final curve1 = CurvedAnimation(
        parent: _aiCardAnimationController, curve: Curves.linearToEaseOut);
    aiCardAnimation =
        Tween<Offset>(begin: const Offset(0, -10), end: const Offset(0, 0))
            .animate(curve1);

    _dottedAnimationController = AnimationController(
      vsync: this,
      duration: 10000.milliseconds,
    );
    final curve4 = CurvedAnimation(
        parent: _dottedAnimationController, curve: Curves.linearToEaseOut);
    dottedAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curve4);

    _dottedAnimationController.forward();

    _aiCardAnimationController.forward();

    _adsCardAnimationController = AnimationController(
      vsync: this,
      duration: 2300.milliseconds,
    );
    final curve2 = CurvedAnimation(
        parent: _adsCardAnimationController, curve: Curves.linearToEaseOut);
    adsCardAnimation =
        Tween<Offset>(begin: const Offset(-10, 0), end: const Offset(0, 0))
            .animate(curve2);

    _adsCardAnimationController.forward();

    _catCardAnimationController = AnimationController(
      vsync: this,
      duration: 2300.milliseconds,
    );
    final curve3 = CurvedAnimation(
        parent: _catCardAnimationController, curve: Curves.linearToEaseOut);
    catCardAnimation =
        Tween<Offset>(begin: const Offset(0, 10), end: const Offset(0, 0))
            .animate(curve3);

    _catCardAnimationController.forward();

    /*   createAnimation(
        adsCardAnimation,
        _adsCardAnimationController,
        Curves.fastEaseInToSlowEaseOut,
        const Offset(-10, 0),
        3100.milliseconds);
    createAnimation(catCardAnimation, _catCardAnimationController,
        Curves.fastEaseInToSlowEaseOut, const Offset(0, 10), 3200.milliseconds);*/
  }

  // void createAnimation(Animation animation, AnimationController controller,
  //     Curve curve, Offset offset, Duration duration) {
  //   controller = AnimationController(
  //     vsync: this,
  //     duration: duration,
  //   );
  //   final curves = CurvedAnimation(parent: controller, curve: curve);
  //   animation =
  //       Tween<Offset>(begin: offset, end: const Offset(0, 0)).animate(curves);
  //
  //   controller.forward();
  // }
  //

  @override
  void onClose() {
    super.onClose();
    _catCardAnimationController.dispose();
    _adsCardAnimationController.dispose();
    _aiCardAnimationController.dispose();
  }
}
