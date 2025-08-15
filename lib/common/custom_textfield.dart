import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final double wd;
  final double ht;
  final TextEditingController ctrl;
  final String name;
  final IconData icon;
  final bool obscure;
  const CustomTextfield({
    super.key,
    required this.wd,
    required this.ht,
    required this.ctrl,
    required this.name,
    required this.icon,
    this.obscure = true,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool isObscured;
  @override
  void initState() {
    isObscured = widget.obscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: widget.wd * 0.03,
        top: widget.ht * 0.03,
        right: widget.wd * 0.03,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          obscureText: isObscured,
          cursorColor: Colors.white,
          controller: widget.ctrl,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: Colors.white, size: 19),
            contentPadding: EdgeInsets.only(
              top: widget.ht * 0.022,
              bottom: widget.ht * 0.01,
              right: widget.wd * 0.01,
              left: widget.wd * 0.03,
            ),
            border: InputBorder.none,
            hintText: widget.name,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 13,
              color: Colors.white,
            ),
            suffixIcon: widget.obscure
                ? IconButton(
                    icon: Icon(
                      isObscured ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                      size: 19,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                  )
                : null,
          ),
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Colors.white,
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter the ${widget.name}";
            }
            return null;
          },
        ),
      ),
    );
  }
}

