import 'package:flutter/material.dart';

import '../../theme/theme.dart';

enum ButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? rightIcon;
  final IconData? icon;
  final ButtonType type;
  const BlaButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.type = ButtonType.primary,
    this.rightIcon,
  });

  @override
  Widget build(BuildContext context) {
    bool isPrimary = type == ButtonType.primary;
    Color backgroundColor = isPrimary ? (onPressed != null ? BlaColors.primary : BlaColors.greyLight) : BlaColors.white;
    BorderSide borderSide = isPrimary
        ? BorderSide.none
        : BorderSide(color: BlaColors.greyLight);
    Color textColor = isPrimary ? BlaColors.white : BlaColors.primary;
    Color iconColor = isPrimary ? BlaColors.white : BlaColors.primary;
    return SizedBox(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radius),
          ),
          side: borderSide,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: iconColor),
              const SizedBox(width: BlaSpacings.s),
            ],
            Text(text, style: BlaTextStyles.button.copyWith(color: textColor)),
          ],
        ),
      ),
    );
  }
}
