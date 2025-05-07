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

Widget Button({
  required String text,
  required VoidCallback onpressed,
  Color color = const Color.fromRGBO(0, 9, 69, 1),
  Color textcolor = Colors.white,
}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(style: BorderStyle.solid),
      borderRadius: BorderRadius.circular(8),
      color: color,
    ),
    height: 52,
    width: 327 / 375 * ScreenSize.width,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onpressed,
      child: TextCairo(text: text, color: textcolor),
    ),
  );
}

Widget CustomTextFeild({
  Widget? suffixicon,
  Widget? prefixicon,
  required String toptext,
  String? hinttext,
  required TextEditingController controller,
  TextInputType? inputType,
  bool enabled = true,
  bool obscureText = false,
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
            color: enabled == true ? Colors.white : disabled100,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  enabled == true
                      ? Color.fromRGBO(160, 169, 183, 1)
                      : disabled200,
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextFormField(
              controller: controller,
              enabled: enabled,
              style: TextStyle(
                fontFamily: 'Cairo',
                color: enabled == true ? brandColor200 : disabled200,
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
              obscureText: obscureText,
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
      child: TextCairo(
        text: sectors[index],
        color: index != 0 ? primary_blue : Colors.white,
      ),
    ),
  );
}

Widget sectorsListView() => Container(
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
  Navigator.push(context, MaterialPageRoute(builder: (context) => to));
}

Widget richTextCairoSteps() {
  return RichText(
    textDirection: TextDirection.rtl,
    text: TextSpan(
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Cairo'),
      children: [
        TextSpan(text: '1. '),
        TextSpan(
          text: 'تسجيل الدخول\n',
          style: TextStyle(
            color: primary_blue,
            fontFamily: 'Cairo',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: 'باستخدام بياناتك الجامعية\n',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Cairo',
            fontSize: 14.0,
          ),
        ),

        TextSpan(text: '2. '),
        TextSpan(
          text: 'اختيار نوع الشكوى\n',
          style: TextStyle(
            color: primary_blue,
            fontFamily: 'Cairo',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: 'من القائمة المتاحة\n',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Cairo',
            fontSize: 14.0,
          ),
        ),

        TextSpan(text: '3. '),
        TextSpan(
          text: 'كتابة تفاصيل الشكوى\n',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: primary_blue,
            fontFamily: 'Cairo',
            fontSize: 16.0,
          ),
        ),
        TextSpan(
          text: 'وإضافة مرفقات إن وجدت\n',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Cairo',
            fontSize: 14.0,
          ),
        ),

        TextSpan(text: '4. '),
        TextSpan(
          text: 'إرسال الشكوى\n',
          style: TextStyle(
            color: primary_blue,
            fontFamily: 'Cairo',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: 'للجهة المختصة\n',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Cairo',
            fontSize: 14.0,
          ),
        ),

        TextSpan(text: '5. '),
        TextSpan(
          text: 'متابعة حالة الشكوى\n',
          style: TextStyle(
            color: primary_blue,
            fontFamily: 'Cairo',
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextSpan(
          text: 'من خلال سجل الشكاوى',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Cairo',
            fontSize: 14.0,
          ),
        ),
      ],
    ),
  );
}

Widget supportRichTextCairo() {
  return RichText(
    textDirection: TextDirection.rtl,
    text: TextSpan(
      style: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Cairo'),
      children: [
        TextSpan(
          text: 'إذا واجهت أي مشكلة في استخدام التطبيق، يرجى التواصل معنا:\n',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.0),
        ),
        TextSpan(
          text: 'البريد الإلكتروني: ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: brandColor300,
          ),
        ),
        TextSpan(
          text: 'support@universitycomplaints.edu\n',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        TextSpan(
          text: 'ساعات العمل: من 9 ص إلى 5 م (أيام العمل الرسمية)',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: brandColor300,
          ),
        ),
      ],
    ),
  );
}

Widget dropdownlist({
  required String? selectedvalue,
  required String title,
  required String hinttext,
  required List<String> dropdownitems,
  required Function(String?) onchanged,
  required IconData dropIcon,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
    TextCairo(text: title, color: primary_blue, fontsize: 14),
    const SizedBox(height: 8),
    Container(
      width: 327 / 375 * ScreenSize.width - 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: brandColor25),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedvalue,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: Icon(dropIcon),
        ),
        hint: Align(
          alignment: Alignment.centerRight,
          child: Text(
            hinttext,
            style: TextStyle(fontFamily: 'Cairo', color: Colors.grey),
          ),
        ),
        items:
            dropdownitems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontFamily: 'Cairo'),
                  ),
                ),
              );
            }).toList(),
        onChanged: onchanged,
        isExpanded: true,
        alignment: Alignment.centerRight,
      ),
    ),
  ],
);
