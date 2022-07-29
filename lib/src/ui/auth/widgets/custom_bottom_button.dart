import 'package:flutter/material.dart';

Widget customBottomButton(String label, Function()? onPress) => Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        color: Colors.red,
      ),
      child: MaterialButton(
        color: Colors.red,
        onPressed: onPress,
        height: 50,
        minWidth: double.infinity,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
