import 'package:flutter/Material.dart';

Widget defaultTextFormField(
        {required BuildContext context,
        TextEditingController? controller,
        required String hintText,
        BorderRadius radius = const BorderRadius.all(Radius.circular(50)),
        Icon? prefixIcon,
        Widget? suffixIcon,
        required TextInputAction inputAction,
        bool? isVisiblePassword = false,
        Function? validator}) =>
    TextFormField(
      controller: controller,
      textInputAction: inputAction,
      obscureText: isVisiblePassword!,
      decoration: InputDecoration(
          hintText: hintText,
          errorBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.error),
              borderRadius: radius),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: prefixIcon,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: suffixIcon,
          ),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: radius),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: radius),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: radius),
          fillColor: Colors.white,
          filled: true),
    );
