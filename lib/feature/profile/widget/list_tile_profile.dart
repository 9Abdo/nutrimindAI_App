import 'package:flutter/material.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/core/constant/app_style.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.icon,
    required this.title,
    this.color,
    this.onTap,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final Color? color;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color ?? AppColor.primaryColor),
      title: Text(title, style: AppStyle.font16w500),
      trailing: trailing ?? Icon(Icons.arrow_forward_ios, size: 18),
    );
  }
}
