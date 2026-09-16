import 'package:code_connect_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final String buttonTitle;
  final VoidCallback? onPressed;

  const CustomTextButton({
    super.key,
    required this.buttonTitle,
    this.onPressed,
  });

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        setState(() {
          _isActive = !_isActive;
        });

        widget.onPressed;
      },
      child: Text(
        widget.buttonTitle,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: _isActive ? AppTheme.verdeDestaque : AppTheme.cinzaMedio,
          decoration: _isActive
              ? TextDecoration.underline
              : TextDecoration.none,
          decorationColor: AppTheme.verdeDestaque,
        ),
      ),
    );
  }
}
