import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  final Color color;
  final Size size;
  final String buttonTitle;
  final Widget? iconButton;
  final VoidCallback? onPressed;
  final Widget? sizedBox;

  const OutlinedButtonWidget({
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
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: size,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(12),
        ),
        side: BorderSide(color: color),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            buttonTitle,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: color),
          ),
          sizedBox ?? SizedBox.shrink(),
          iconButton ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
