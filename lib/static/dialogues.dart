import 'package:flutter/material.dart';

import '../helper/ui_helper.dart';
import '/extensions/app_extension.dart';

class MyAlerts {
  static void showAlert(BuildContext context) {
    String alert =
        'This application functions as a streaming platform and does not host, store, or own any of the content available within the app. All video, audio, images, and other media are the property of their respective copyright owners.';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextButton(
              style: TextButton.styleFrom(fixedSize: Size.fromWidth(80)),
              onPressed: () => context.popScreen(),
              child: UIHelper.text(
                'OK',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          title: Text(
            'Disclaimer',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10,
            children: [
              Text(
                alert,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
