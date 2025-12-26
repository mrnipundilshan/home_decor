import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextbox extends StatefulWidget {
  final String placeholder;
  final IconData? prefixIcon;
  final bool obsecureText;
  final TextEditingController controller;

  const MyTextbox({
    super.key,
    required this.placeholder,
    this.prefixIcon,
    required this.obsecureText,
    required this.controller,
  });

  @override
  State<MyTextbox> createState() => _MyTextboxState();
}

class _MyTextboxState extends State<MyTextbox> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obsecureText;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: CupertinoTextField(
        controller: widget.controller,
        suffix: widget.obsecureText
            ? Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: _isObscure
                      ? Icon(Icons.remove_red_eye_outlined)
                      : Icon(Icons.remove_red_eye),
                ),
              )
            : null,
        obscureText: _isObscure,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.transparent,
          border: Border.all(color: themeData.colorScheme.inversePrimary),
        ),
        prefix: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Icon(widget.prefixIcon),
        ),
        placeholder: widget.placeholder,
        placeholderStyle: themeData.textTheme.bodyMedium?.copyWith(
          color: themeData.textTheme.bodyMedium?.color?.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
