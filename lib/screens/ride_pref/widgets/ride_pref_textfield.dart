import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class RidePrefTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final VoidCallback? onRightIconPressed;
  final IconData? rightIcon;
  final Color? labelColor;
  final Color? iconColor;
  const RidePrefTextField({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.rightIcon,
    this.onRightIconPressed, this.labelColor, this.iconColor,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(icon, size: 24, color: iconColor ?? BlaColors.iconLight),
      title: Text(
        label,
        style: BlaTextStyles.button.copyWith(
          fontSize: 14,
          color: labelColor ?? BlaColors.textLight
        ),
      ),
      trailing: rightIcon != null
          ? IconButton(icon: Icon(rightIcon), onPressed: onRightIconPressed)
          : null,
    );
  }
}
