import 'package:assignment/src/constants/color_constants.dart';
import 'package:assignment/src/constants/image_constants.dart';
import 'package:assignment/src/extensions/gesture_extensions.dart';
import 'package:assignment/src/extensions/image_extensions.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

/// ToastUtils class is used for toast in app.
class ToastUtils {
  static late Function() cancel;

  static void cancelToast() {
    cancel();
  }

  /// Show success toast
  static void showSuccess({required String message}) {
    cancel = BotToast.showCustomNotification(
      duration: const Duration(seconds: 2),
      toastBuilder: (cancelFunc) {
        return toastView(
          message: message,
          image: ImageConstants.icCheck,
          cardColor: ColorConstants.toastSuccess,
        );
      },
    );
  }

  /// Show Failed toast
  static void showFailed({required String message}) {
    cancel = BotToast.showCustomNotification(
      duration: const Duration(seconds: 2),
      toastBuilder: (cancelFunc) {
        return toastView(
          message: message,
          image: ImageConstants.icError,
          cardColor: ColorConstants.toastFailure,
        );
      },
    );
  }

  ///toastView - Display Toast View
  static Widget toastView({
    required String message,
    required String image,
    required Color cardColor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Card(
        elevation: 5,
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image.getSVGImageHW(),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(fontSize: 12, color: ColorConstants.black),
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              (ImageConstants.icCancel)
                  .getSVGImageHW(height: 15, width: 15, color: ColorConstants.primary)
                  .onPressedWithoutHaptic(() {
                cancelToast();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
