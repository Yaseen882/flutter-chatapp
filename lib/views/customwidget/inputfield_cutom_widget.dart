import 'package:flutter/material.dart';
import 'package:mychatapp/controller/signup_controller.dart';

typedef ValidatorClosure = String? Function(String? value);

class CustomTextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool autoFocus;
  final double width;
  final double height;

  final TextEditingController controller;


  const CustomTextFieldWidget({
    Key? key,
    required this.icon,
    required this.height,
    required this.width,
    required this.hintText,
    required this.autoFocus,
    required this.controller,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width,


        child: TextFormField(
          onChanged: (value) {
            formKey.currentState!.validate();
          },
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter fields';
            }
            return null;
          },
          autofocus: autoFocus,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
                  const BorderSide(color: Colors.blue, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: Colors.lightBlueAccent, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blue, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            contentPadding: EdgeInsets.all(5),
            prefixIcon: Icon(icon),
            hintText: hintText,
          ),
        ),
      ),
    );
  }
}
