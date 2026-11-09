import 'package:code_connect_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomDefaultButton extends StatelessWidget {
  final Color color;
  final Size size;
  final String buttonTitle;
  final Widget? iconButton;
  final VoidCallback? onPressed;
  final Widget? sizedBox;

  const CustomDefaultButton({
    super.key,
    required this.color,
    required this.size,
    required this.buttonTitle,
    this.iconButton,
    this.onPressed,
    this.sizedBox,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        disabledBackgroundColor: color.withValues(alpha: 0.5),
        fixedSize: size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            buttonTitle,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppTheme.grafite),
          ),
          sizedBox ?? SizedBox.shrink(),
          iconButton ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
