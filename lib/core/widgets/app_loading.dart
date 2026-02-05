import 'package:pixel_snap/material.dart';

import '/core/constants/app_padding.dart';
import '/core/constants/app_spaces.dart';
import '/core/extension/context_extension.dart';

class AppLoader extends StatelessWidget {
  final String? message;

  const AppLoader({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppPadding.a24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            if (message != null) ...[
              AppSpaces.v16,
              Text(
                message!,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
