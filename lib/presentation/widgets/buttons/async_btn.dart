import 'package:flutter/material.dart';

class AsyncButton extends StatefulWidget {
  final Future<void> Function() onPressed; // Async operation to perform
  final Widget child; // Button content
  final Color? disabledColor; // Optional color when button is disabled

  const AsyncButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.disabledColor,
  });

  @override
  _AsyncButtonState createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  bool _isLoading = false;

  Future<void> _handlePress() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onPressed();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handlePress,
      style: ElevatedButton.styleFrom(
        backgroundColor: _isLoading && widget.disabledColor != null
            ? widget.disabledColor
            : null,
      ),
      child: _isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.white,
              ),
            )
          : widget.child,
    );
  }
}
