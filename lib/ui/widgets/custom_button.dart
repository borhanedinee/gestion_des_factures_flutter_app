import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final ButtonStyle? style;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.icon,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Theme.of(context).scaffoldBackgroundColor),
      label: Text(
        label,
        style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
      ),
      style:
          style ??
          ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
    );
  }
}
