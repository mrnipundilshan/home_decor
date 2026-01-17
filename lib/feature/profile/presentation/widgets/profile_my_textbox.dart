import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileMyTextbox extends StatefulWidget {
  final String textFieldName;
  final TextEditingController controller;

  const ProfileMyTextbox({
    super.key,
    required this.textFieldName,
    required this.controller,
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
