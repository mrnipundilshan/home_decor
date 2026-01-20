import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileMyTextbox extends StatefulWidget {
  final String textFieldName;
  final TextEditingController controller;
  final TextInputType? keyboardInputType;
  final IconData? iconData;
  final bool enabled;
  const ProfileMyTextbox({
    super.key,
    required this.textFieldName,
    this.iconData,
    required this.controller,
    this.keyboardInputType,
    this.enabled = false,
  });

  @override
  State<ProfileMyTextbox> createState() => _ProfileMyTextboxState();
}

class _ProfileMyTextboxState extends State<ProfileMyTextbox> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: CupertinoTextField(
        keyboardType: widget.keyboardInputType,
        enabled: widget.enabled,
        suffix: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(widget.iconData),
        ),
        controller: widget.controller,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.transparent,
          border: Border.all(color: themeData.colorScheme.inversePrimary),
        ),
        textAlignVertical: TextAlignVertical.center,
        prefix: SizedBox(width: 10),
        style: themeData.textTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
