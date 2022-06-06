import 'package:flutter/material.dart';
import 'package:psc_quiz/src/constant/constant.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    Key? key,
    required this.title,
    required this.onTap,
    required this.width,
    required this.height,
    required this.textStyle,
    this.isPrimary = true,
  }) : super(key: key);

  final String title;
  final Function onTap;
  final bool isPrimary;
  final double height;
  final double width;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: isPrimary
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.r100)),
                  side: const BorderSide(color: AppColor.white)),
              onPressed: () => onTap(),
              child: Text(title, style: textStyle),
            )
          : InkWell(
              onTap: () => onTap(),
              child: Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      AppColor.resultButtonColor1,
                      AppColor.resultButtonColor2
                    ]),
                    borderRadius: BorderRadius.circular(AppRadius.r100)),
                child: Center(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ),
              ),
            ),
    );
  }
}
