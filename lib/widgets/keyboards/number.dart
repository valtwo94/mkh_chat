import 'package:flutter/material.dart';

class NumberKeyboard extends StatelessWidget {
  const NumberKeyboard({super.key, required this.onKeyPressed, required this.onKeyLongPressed});

  final void Function(String) onKeyPressed;
  final VoidCallback onKeyLongPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 52),
      height: 308,
      color: Theme.of(context).canvasColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('1', context),
                _buildNumberButton('2', context),
                _buildNumberButton('3', context),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('4', context),
                _buildNumberButton('5', context),
                _buildNumberButton('6', context),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('7', context),
                _buildNumberButton('8', context),
                _buildNumberButton('9', context),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberButton('', context, isSpecial: true, isButton: false), // Clear button
                _buildNumberButton('0', context),
                _buildNumberButton('back', context, isSpecial: true), // Confirm button
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String text, BuildContext context, {bool isSpecial = false, bool isButton = true}) {
    return Expanded(
      child: !isButton? Container():TextButton(
        onPressed: ()=> onKeyPressed(text),
        onLongPress: isSpecial?onKeyLongPressed:null,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: isSpecial? Icon(Icons.backspace_outlined, color: Theme.of(context).iconTheme.color,):Text(
              text,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ),
      ),
    );
  }
}