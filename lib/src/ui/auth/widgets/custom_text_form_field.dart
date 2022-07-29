import 'package:flutter/material.dart';

Widget customTextFormField(
        TextEditingController controller,
        String label,
        String hint,
        IconData icon,
        String? Function(String?)? validator,
        bool value) =>
    TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controller,
      cursorColor: Colors.red,
      obscureText: value,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: Icon(
          icon,
          color: Colors.red,
        ),
      ),
    );
