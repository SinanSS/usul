import 'package:pixel_snap/material.dart';

import '/core/constants/app_padding.dart';
import '/core/constants/app_spaces.dart';
import '/core/extension/context_extension.dart';

class AppEmpty extends StatelessWidget {
  final String message;
  final IconData icon;

  const AppEmpty({
    super.key,
    this.message = 'Gösterilecek veri yok',
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppPadding.a24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 48,
              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
            AppSpaces.v16,
            Text(
              message,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
