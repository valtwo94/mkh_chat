import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key, required this.onPressed, required this.label,
  });
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      minWidth: MediaQuery.of(context).size.width /375 * 327,
      height: 52,
      color: Theme.of(context).primaryColor,
      child: Text(label, style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.white),),
    );
  }
}