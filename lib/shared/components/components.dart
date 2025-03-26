import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';

Widget TextCairo({
  required String text,
  Color color = Colors.white,
  double fontsize = 16,
  FontWeight fontweight = FontWeight.w600,
  TextAlign? textalign,
}) {
  return Text(
    textAlign: textalign,
    "${text}",
    style: TextStyle(
      fontFamily: 'Cairo',
      color: color,
      fontSize: fontsize,
      fontWeight: fontweight,
    ),
  );
}

Widget Button({required String text, required VoidCallback onpressed}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: primary_blue,
    ),
    height: 52,
    width: 327 / 375 * ScreenSize.width,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: primary_blue),
      onPressed: onpressed,
      child: TextCairo(text: text),
    ),
  );
}

Widget CustomTextFeild({
  Widget? suffixicon,
  required Widget prefixicon,
  required String toptext,
  required String hinttext,
  required TextEditingController controller,
}) {
  return Container(
    padding: EdgeInsets.all(8),
    width: 327 / 375 * ScreenSize.width,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextCairo(text: toptext, color: primary_blue, fontsize: 14),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color.fromRGBO(160, 169, 183, 1)),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              controller: controller,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                suffixIcon: suffixicon,
                hintText: hinttext,
                hintStyle: TextStyle(color: Color.fromRGBO(89, 105, 130, 1)),
                prefixIcon: prefixicon,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget sharedSectors({required int index}) {
  List<String> sectors = [
    'الكل',
    'قطاع شئون التعليم',
    'قطاع إدارة الجامعة',
    'قطاع الدراسات العليا',
    'قطاع أمين عام الجامعة',
    'قطاع خدمة المجتمع',
  ];
  return Container(
    padding: EdgeInsetsDirectional.symmetric(horizontal: 11.0, vertical: 5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: primary_blue),
      color: index != 0 ? Colors.white : primary_blue,
    ),
    child: InkWell(
      onTap: () {},
      child: TextCairo(text: sectors[index], color: index != 0 ? primary_blue : Colors.white),
    ),
  );
}

Widget sectorsListView() =>  Container(
  height: 36.0,
  child: ListView.separated(
    physics: BouncingScrollPhysics(),
    scrollDirection: Axis.horizontal,
    reverse: true,
    itemBuilder: (context, index) => sharedSectors(index: index),
    separatorBuilder: (context, index) => SizedBox(width: 10.0),
    itemCount: 6,
  ),
);

void navigateTo({required Widget to, required context}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => to),
  );
}