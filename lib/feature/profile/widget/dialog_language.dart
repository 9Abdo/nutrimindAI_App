import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

StatefulBuilder dialogLanguage(String selected, BuildContext dialogContext) {
  return StatefulBuilder(
    builder: (context, setState) {
      return AlertDialog(
        title: Text("profile.language".tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioGroup(
              groupValue: selected,
              onChanged: (value) {
                setState(() {
                  selected = value!;
                });
              },
              child: RadioListTile<String>(
                value: "ar",

                title: const Text("العربية"),
              ),
            ),
            RadioGroup(
              onChanged: (value) {
                setState(() {
                  selected = value!;
                });
              },
              groupValue: selected,
              child: RadioListTile<String>(
                value: "en",

                title: const Text("English"),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext, selected);
            },
            child: Text("common.ok".tr()),
          ),
        ],
      );
    },
  );
}
