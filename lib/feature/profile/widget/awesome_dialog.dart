import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutrimind/core/constant/app_color.dart';

AwesomeDialog awesomDialog(
  BuildContext context, {
  required void Function()? btnOkOnPress,
}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.warning,
    animType: AnimType.scale,
    title: "profile.logout_dialog_title".tr(),
    desc: "profile.logout_dialog_desc".tr(),
    btnCancelText: "profile.cancel".tr(),
    btnCancelColor: AppColor.greyColor,
    btnCancelOnPress: () {},
    btnOkText: "profile.logout".tr(),
    btnOkColor: AppColor.redColor,
    btnOkOnPress: btnOkOnPress,
  );
}
