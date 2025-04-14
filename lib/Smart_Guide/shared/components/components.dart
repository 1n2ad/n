import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_guide_to_medication/Smart_Guide/layout/shop_layout/cubit/cubit.dart';
import 'package:smart_guide_to_medication/Smart_Guide/shared/constant/constant.dart';
import '../../styles/fonts_style.dart';

Widget defaultOutlinedButton({
  required Function()? btnFunction,
  required String btnText,
  required dynamic backColor,
  double textSize = 16.0,
  double width = double.infinity,
  double height = 50.0,
  bool isUpperCase = true,
  double radius = 12.0,
  Widget? icon,
  bool enabled = true,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: enabled ? backColor : Colors.grey[600],
      borderRadius: BorderRadius.circular(radius),
    ),
    child: InkWell(
      onTap: enabled ? btnFunction : null,
      borderRadius: BorderRadius.circular(radius),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon,
            const SizedBox(width: 10.0),
          ],
          Text(
            isUpperCase ? btnText.toUpperCase() : btnText,
            style: getMediumStyle(
              color: Colors.white,
              fontSize: textSize,
            ),
          ),
        ],
      ),
    ),
  );
}
void navigateAndFinish(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false,
  );
}
Widget defaultTextField({
  TextEditingController? controller,
  required String labelText,
  required Color textColor,
  required TextInputType keyboardType,
  Function()? onTap,
  Function(String)? onChange,
  Function(String)? onSubmitted,
  String? Function(String?)? validator,
  bool readOnly = false,
  bool obscureText = false,
  String obscuringCharacter = '*',
  IconData? suffixIcon,
  Function()? suffixPressed,
  double radius = 12.0,
  String? initialValue,
}) {
  return TextFormField(
    controller: controller,
    initialValue: initialValue,
    style: getMediumStyle(color: textColor.withOpacity(0.9), fontSize: 13),
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: getMediumStyle(color: textColor.withOpacity(0.7)),
      suffixIcon: suffixIcon != null
          ? IconButton(
        onPressed: suffixPressed,
        icon: Icon(suffixIcon, color: textColor.withOpacity(0.6)),
      )
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: textColor.withOpacity(0.7)),
      ),
    ),
    keyboardType: keyboardType,
    onTap: onTap,
    onChanged: onChange,
    onFieldSubmitted: onSubmitted,
    readOnly: readOnly,
    validator: validator,
    obscureText: obscureText,
    obscuringCharacter: obscuringCharacter,
  );
}