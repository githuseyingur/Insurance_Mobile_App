import 'package:crenno_huseyin_gur/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ErrorInfoWidget extends StatelessWidget {
  const ErrorInfoWidget({
    super.key,
    required this.errorMessage,
    required this.onPressed,
  });
  final String errorMessage;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 60, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text(
              'Something went wrong!',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.blueColor),
              onPressed: onPressed,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
