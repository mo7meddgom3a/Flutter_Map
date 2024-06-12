import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.text, required this.icon, required this.onTap});

  final String text, icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: SvgPicture.asset("assets/icon_images/Vector (Stroke).svg"),
          ),
          const Spacer(),
          Text(text),
          const SizedBox(
            width: 10,
          ),
          SvgPicture.asset(icon),
        ],
      ),
    );
  }
}
