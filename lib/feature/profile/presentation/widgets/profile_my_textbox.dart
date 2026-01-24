import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileMyTextbox extends StatefulWidget {
  final String textFieldName;
  final TextEditingController controller;
  final TextInputType? keyboardInputType;
  final IconData? iconData;
  final bool enabled;
  final VoidCallback? onIconTap;
  final String label;
  final bool? readOnly;
  const ProfileMyTextbox({
    super.key,
    required this.textFieldName,
    this.iconData,
    required this.controller,
    this.keyboardInputType,
    this.onIconTap,
    this.readOnly = false,
    this.enabled = false,
    required this.label,
  });

  @override
  State<ProfileMyTextbox> createState() => _ProfileMyTextboxState();
}

class _ProfileMyTextboxState extends State<ProfileMyTextbox> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0, bottom: 4),
          child: Text(widget.label),
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: CupertinoTextField(
            readOnly: widget.readOnly!,
            keyboardType: widget.keyboardInputType,
            enabled: widget.enabled,
            suffix: widget.iconData == null
                ? null
                : IconButton(
                    onPressed: widget.onIconTap,
                    icon: Icon(widget.iconData),
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
        ),
      ],
    );
  }
}
