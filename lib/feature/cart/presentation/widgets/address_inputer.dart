import 'package:flutter/material.dart';
import 'package:home_decor/core/widgets/my_textbox.dart';

class AddressInputer extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController zipController;
  final TextEditingController addressController2;
  final TextEditingController addressController3;

  const AddressInputer({
    super.key,
    required this.nameController,
    required this.addressController,
    required this.cityController,
    required this.zipController,
    required this.addressController2,
    required this.addressController3,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeData.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: themeData.dividerColor.withAlpha(50)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: themeData.colorScheme.secondary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                "Shipping Address",
                style: themeData.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          MyTextbox(
            placeholder: "Receiver Name",
            prefixIcon: Icons.person_outline,
            obsecureText: false,
            controller: nameController,
          ),
          const SizedBox(height: 12),
          MyTextbox(
            placeholder: "Address Line 1",
            prefixIcon: Icons.home_outlined,
            obsecureText: false,
            maxLines: 1,
            controller: addressController,
          ),
          const SizedBox(height: 12),
          MyTextbox(
            placeholder: "Address Line 2",
            prefixIcon: Icons.home_outlined,
            obsecureText: false,
            maxLines: 1,
            controller: addressController2,
          ),
          const SizedBox(height: 12),
          MyTextbox(
            placeholder: "Address Line 3",
            prefixIcon: Icons.home_outlined,
            obsecureText: false,
            maxLines: 1,
            controller: addressController3,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: MyTextbox(
                  placeholder: "City",
                  prefixIcon: Icons.location_city_outlined,
                  obsecureText: false,
                  controller: cityController,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MyTextbox(
                  placeholder: "Zip Code",
                  prefixIcon: Icons.post_add_outlined,
                  obsecureText: false,
                  controller: zipController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
