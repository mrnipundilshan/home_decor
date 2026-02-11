import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class SelectionBottomSheet {
  static void show<T>(
    BuildContext context, {
    required String title,
    required List<SelectionItem<T>> items,
    required T selectedValue,
    required Function(T) onSelected,
  }) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 12),

            // drag handle
            // Container(
            //   width: 40,
            //   height: 4,
            //   decoration: BoxDecoration(
            //     color: Colors.grey.shade400,
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            // ),
            const SizedBox(height: 16),

            Text(title, style: Theme.of(context).textTheme.titleMedium),

            const SizedBox(height: 12),

            ...items.map(
              (item) => ListTile(
                title: Text(item.label),
                trailing: selectedValue == item.value
                    ? const Icon(Icons.check, color: AppColors.commonPrimary)
                    : null,
                onTap: () {
                  onSelected(item.value);
                  Navigator.pop(context);
                },
              ),
            ),

            const SizedBox(height: 60),
          ],
        );
      },
    );
  }
}

class SelectionItem<T> {
  final T value;
  final String label;

  SelectionItem({required this.value, required this.label});
}
