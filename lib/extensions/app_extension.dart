import 'package:flutter/material.dart';
import '/helper/ui_helper.dart';

extension ScreenNav on BuildContext {
  NavigatorState get state => Navigator.of(this);
  Size get screenResp => MediaQuery.of(this).size;
  buildRoute(Widget screen) {
    return MaterialPageRoute(builder: (_) => screen);
  }

  pushScreen(Widget screen) {
    return state.push(buildRoute(screen));
  }

  popScreen() {
    return state.pop();
  }

  pushReplaceScreen(Widget screen) {
    return state.pushReplacement(buildRoute(screen));
  }

  showAlert(BuildContext context, String title, String script) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: UIHelper.text(
              title,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [UIHelper.button(() => context.popScreen(), 'OK')],
          content: UIHelper.text(
            script,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        );
      },
    );
  }
}

extension Aligner on double {
  get getSize => SizedBox(height: this);
  get getWidth => SizedBox(width: this);
}
