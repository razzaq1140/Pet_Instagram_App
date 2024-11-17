import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_project/src/common/constants/app_images.dart';
import 'package:pet_project/src/common/constants/global_variables.dart';
import 'package:pet_project/src/common/utils/custom_snackbar.dart';
import 'package:pet_project/src/common/utils/image_picker_helper.dart';
import 'package:pet_project/src/common/utils/validation.dart';
import 'package:pet_project/src/common/widget/custom_button.dart';
import 'package:pet_project/src/common/widget/custom_text_field.dart';

class CompleteYourProfilePage extends StatefulWidget {
  const CompleteYourProfilePage({super.key});

  @override
  State<CompleteYourProfilePage> createState() => _CompleteYourProfilePageState();
}

class _CompleteYourProfilePageState extends State<CompleteYourProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String selectedPetType = 'Dog';
  XFile? selectedImage;

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () {
                  pickImageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Capture from Camera'),
                onTap: () {
                  pickImageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to pick an image from the gallery
  Future<void> pickImageFromGallery() async {
    try {
      await ImagePickerHelper.pickImageFromGallery().then((image) {
        if (image != null) {
          setState(() {
            selectedImage = image;
          });
        }
      });
    } catch (e) {
      showSnackbar(
        message: 'Failed to pick images. Please try again.',
        isError: true,
      );
    }
  }

  // Function to capture an image from the camera
  Future<void> pickImageFromCamera() async {
    try {
      await ImagePickerHelper.pickImageFromCamera().then((image) {
        if (image != null) {
          setState(() {
            selectedImage = image;
          });
        }
      });
    } catch (e) {
      showSnackbar(
        message: 'Failed to capture image. Please try again.',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text("Account"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change Image',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                ),
              ),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor:
                        colorScheme(context).primary.withOpacity(0.2),
                        backgroundImage: selectedImage != null
                            ? FileImage(File(selectedImage!.path))
                            : null,
                        child: selectedImage == null
                            ? Icon(Icons.pets,
                            size: 50,
                            color: colorScheme(context)
                                .surface
                                .withOpacity(0.8))
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 9, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: colorScheme(context).surface,
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme(context)
                                    .outline
                                    .withOpacity(0.2),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(AppIcons.camera, height: 25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text('User Name', style: textTheme(context).titleSmall),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: nameController,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(0.5),
                hint: 'Whiskers Pet',
                inputAction: TextInputAction.next,
                validator: (value) =>
                    Validation.fieldValidation(value, "name"),
                focusBorderColor:
                colorScheme(context).onSurface.withOpacity(0.5),
              ),
              const SizedBox(height: 15),
              Text(
                'Select Pet Type',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedPetType,
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide(
                      color: colorScheme(context).onSurface.withOpacity(0.5),
                    ),
                  ),
                ),
                dropdownColor: colorScheme(context).surface,
                style: TextStyle(
                  color: colorScheme(context).onSurface.withOpacity(0.5),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPetType = newValue!;
                  });
                },
                items: <String>['Dog', 'Cat', 'Bird']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        color: colorScheme(context).onSurface.withOpacity(0.9),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
              Text(
                'Breed',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                controller: breedController,
                validator: (value) =>
                    Validation.fieldValidation(value, "breed"),
                fillColor: colorScheme(context).surface,
                inputAction: TextInputAction.next,
                borderColor: colorScheme(context).onSurface.withOpacity(0.5),
                hint: 'What breed is your pet?',
              ),
              const SizedBox(height: 15),
              Text(
                'Ages',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                inputAction: TextInputAction.next,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(0.5),
                hint: 'How old is your pet?',
                // validationType: ValidationType.number,
                validator: Validation.numberValidation,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 15),
              Text(
                'Weight',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                inputAction: TextInputAction.next,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(0.5),
                hint: 'Enter your pet\'s weight (lbs/kg)',
                // validationType: ValidationType.number,
                validator: Validation.numberValidation,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onTap: () {
                  if (selectedImage == null) {
                    showSnackbar(message: "Please upload an image before saving.",isError: true);
                  } if (_formKey.currentState!.validate()) {
                    // Proceed with saving if form is valid and image is uploaded
                    // Perform save operation here
                  }
                },
                text: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
