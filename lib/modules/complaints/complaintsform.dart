// ignore_for_file: must_be_immutable

import 'package:damnhour_university/shared/components/components.dart';
import 'package:damnhour_university/shared/constants/constants.dart';
import 'package:damnhour_university/shared/cubit/cubit.dart';
import 'package:damnhour_university/shared/cubit/states.dart';
import 'package:damnhour_university/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintsForm extends StatelessWidget {
  ComplaintsForm({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var cubit = UniversityCubit.get(context);
    return BlocConsumer<UniversityCubit, UniversityStates>(
      listener: (context, state) {
        if (state is ComplaintsSubmitSuccessState) {
          showtoast(message: state.message, color: Colors.green);
          descriptionController.clear();
          cubit.resetpickedfile();
          cubit.resetSelectedSector();
          titleController.clear();
          cubit.resetbordercolor();
          print("register success");
          cubit.getUserComplaintsAndSuggestions();
        } else if (state is ComplaintsSubmitErrorState) {
          showtoast(message: state.error, color: Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: TextCairo(
              text: 'تسجيل شكوى',
              color: Colors.black,
              fontsize: 18,
              fontweight: FontWeight.w500,
            ),

            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title Field
                    SizedBox(height: 16),
                    Container(
                      width: 327 / 375 * ScreenSize.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: brandColor25),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'عنوان الشكوى مطلوب';
                          }
                          return null;
                        },
                        controller: titleController,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          hintTextDirection: TextDirection.rtl,
                          hintText: 'عنوان الشكوى',
                          hintStyle: TextStyle(
                            color: accent_orange,
                            fontFamily: 'Cairo',
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),

                    // Sector Dropdown
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Container(
                            height: 450,
                            width: 327 / 375 * ScreenSize.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(width: 1, color: brandColor25),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 330,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: cubit.sectorcolor),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: cubit.selectedSector,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  suffixIcon: Icon(Icons.business_outlined),
                                ),
                                hint: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'اختر القطاع المعني',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                items:
                                    [
                                      'قطاع شئون التعليم والطلاب',
                                      'قطاع شئون خدمة المجتمع وتنمية البيئة',
                                      'قطاع الدراسات العليا',
                                      'قطاع امين عام الجامعه',
                                      'قطاع ادارة الجامعه',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            value,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                onChanged: (newValue) {
                                  cubit.changeSelectedSector(newValue);
                                },
                                isExpanded: true,
                                alignment: Alignment.centerRight,
                              ),
                            ),
                            SizedBox(height: 30),

                            // Description Field
                            Container(
                              width: 330,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.white),
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'تفاصيل الشكوى مطلوبه';
                                  }
                                  return null;
                                },
                                controller: descriptionController,
                                textDirection: TextDirection.rtl,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.rtl,
                                  hintText: 'يرجى شرح الشكوى بالتفصيل.....',
                                  hintStyle: TextStyle(
                                    color: accent_orange,
                                    fontFamily: 'Cairo',
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(16),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            // Attachment Buttons
                            Container(
                              width: 330,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildAttachmentButton(
                                    icon: Icons.note_add_outlined,
                                    onTap: () => cubit.attachFile(),
                                  ),
                                  SizedBox(width: 16),
                                  _buildAttachmentButton(
                                    icon: Icons.add_photo_alternate_outlined,
                                    onTap: () => cubit.attachFile(),
                                  ),
                                  SizedBox(width: 16),
                                  _buildAttachmentButton(
                                    icon: Icons.attach_file,
                                    onTap: () => cubit.attachFile(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            cubit.pickedfile != null ||
                                    cubit.pickedimage != null
                                ? Column(
                                  children: [
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      cubit.pickedfile?.path.split('/').last ??
                                          '',
                                    ),
                                    Text(
                                      "uploaded",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                )
                                : SizedBox(),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 40),

                    // Submit Button
                    state is ComplaintsSubmitLoadingState
                        ? Center(child: CircularProgressIndicator())
                        : Button(
                          onpressed: () {
                            cubit.validatesectoronform(cubit.selectedSector);
                            if (_formkey.currentState!.validate() &&
                                cubit.isSectorValid) {
                              cubit.submitComplaint(
                                sector: cubit.selectedSector!,
                                sc_type: 'شكوى',
                                title: titleController.text,
                                description: descriptionController.text,
                              );
                            }
                          },
                          text: 'إرسال',
                        ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttachmentButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: accent_orange),
      ),
    );
  }
}
