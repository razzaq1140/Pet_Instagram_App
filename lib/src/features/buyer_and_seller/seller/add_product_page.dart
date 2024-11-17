import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_project/src/common/constants/app_images.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';
import 'package:pet_project/src/common/utils/custom_snackbar.dart';
import 'package:pet_project/src/common/utils/validation.dart';
import 'package:pet_project/src/common/widget/custom_button.dart';
import 'package:pet_project/src/router/routes.dart';

import '../../../common/utils/image_picker_helper.dart';
import '../../../common/widget/custom_text_field.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController productName = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();
  String _descriptionJson = ''; // Holds the description JSON data
  final List<XFile> _pickedImages = [];

  // Method to pick images
  void _pickImage() {
    ImagePickerHelper.showImageSourceSelection(
      context,
      onTapCamera: () async {
        final XFile? image = await ImagePickerHelper.pickImageFromCamera();
        if (image != null) {
          setState(() {
            _pickedImages.add(image);
          });
        }
      },
      onTapGallery: () async {
        final List<XFile> images = await ImagePickerHelper.pickMultipleImages();
        if (images.isNotEmpty) {
          setState(() {
            _pickedImages.addAll(images);
          });
        }
      },
    );
  }

  // Method to edit the description using Quill editor
  Future<void> _editDescription() async {
    // Navigate to the QuillEditorPage and await the returned data
    final Object? editedData = await context.pushNamed(AppRoute.quillEditor);

    // Check if we received valid data
    if (editedData != null && editedData is String) {
      // Update the description JSON with the new data
      setState(() {
        _descriptionJson = editedData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar and Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'upload_product'.tr(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 20, color: colorScheme(context).onSurface),
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () => context.pushNamed(AppRoute.cartPage),
                        child: SvgPicture.asset(AppIcons.cartIcon)),
                    const SizedBox(width: 15),
                    GestureDetector(
                        onTap: () =>
                            context.pushNamed(AppRoute.notificationPage),
                        child: SvgPicture.asset(AppIcons.notiIcon)),
                  ],
                ),
                const SizedBox(height: 20),

                // Upload Picture Section
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme(context).onPrimary,
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    border: Border.all(
                        color: colorScheme(context).outlineVariant, width: 1),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Add Product Title
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "add_product".tr(),
                          style: textTheme(context)
                              .headlineMedium
                              ?.copyWith(fontSize: 24),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "upload_picture".tr(),
                          style: textTheme(context).titleSmall,
                        ),
                      ),
                      SizedBox(
                        height: 90,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              _pickedImages.length + 1, // +1 for the "add box"
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(6)),
                                    color: colorScheme(context).surface,
                                  ),
                                  child: Icon(
                                    Icons.add_box_outlined,
                                    color: colorScheme(context).outline,
                                    size: 18,
                                  ),
                                ),
                              );
                            } else {
                              final pickedImage = _pickedImages[
                                  index - 1]; // Adjust for the "add box"
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    color: colorScheme(context).surface,
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(pickedImage.path),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      // Product Name Field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "product_name".tr(),
                          style: textTheme(context).titleSmall,
                        ),
                      ),
                      CustomTextFormField(
                        controller: productName,
                        hint: "product_name_hint".tr(),
                        validator: (value) => Validation.fieldValidation(
                            value, "product_name_field".tr()),
                        fillColor: colorScheme(context).surface,
                      ),

                      // Price Field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "price".tr(),
                          style: textTheme(context).titleSmall,
                        ),
                      ),
                      CustomTextFormField(
                        controller: price,
                        hint: "150\$",
                        validator: Validation.numberValidation,
                        fillColor: colorScheme(context).surface,
                        keyboardType: const TextInputType.numberWithOptions(),
                      ),

                      // Quantity Field
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "quantity".tr(),
                          style: textTheme(context).titleSmall,
                        ),
                      ),
                      CustomTextFormField(
                        controller: quantity,
                        hint: "50",
                        validator: Validation.numberValidation,
                        fillColor: colorScheme(context).surface,
                        keyboardType: const TextInputType.numberWithOptions(),
                      ),

                      // Description Section
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "description".tr(),
                          style: textTheme(context).titleSmall,
                        ),
                      ),
                      GestureDetector(
                        onTap: _editDescription, // Trigger Quill editor on tap
                        child: Container(
                          width: double.infinity,
                          //  padding: const EdgeInsets.symmetric(vertical: 40),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: colorScheme(context).surface,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: colorScheme(context).outlineVariant),
                          ),
                          child: _descriptionJson.isEmpty
                              ? Text(
                                  'click_to_add_description'.tr(),
                                  style:
                                      textTheme(context).bodyMedium?.copyWith(
                                            color: colorScheme(context).outline,
                                          ),
                                )
                              : quill.QuillEditor(
                                  controller: quill.QuillController(
                                    document: quill.Document.fromJson(
                                        jsonDecode(_descriptionJson)),
                                    selection: const TextSelection.collapsed(
                                        offset: 0),
                                  ),
                                  scrollController: ScrollController(),
                                  //   scrollable: false,
                                  focusNode: FocusNode(),
                                  // autoFocus: false,
                                  //   readOnly: true,
                                  // expands: false,
                                  // padding: EdgeInsets.zero,
                                ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Upload Button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomButton(
                          onTap: () {
                            if (_pickedImages.isEmpty) {
                              showSnackbar(
                                  message: "upload_picture_snackbar".tr(),
                                  isError: true);
                            } else if (formKey.currentState!.validate()) {
                              // You can use _descriptionJson here if needed
                              context.pushNamed(AppRoute.navigationBar);
                            }
                          },
                          text: 'upload'.tr(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
