import 'package:flutter/material.dart';

class ContainersRowWidget extends StatelessWidget {
  final bool isTapped;
  final String text;
  const ContainersRowWidget({
    super.key,
    required this.isTapped,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey.shade900),
        color: isTapped ? const Color(0xff404066) : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 7, bottom: 7, left: 10, right: 10),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xff919393),
          ),
        ),
      ),
    );
  }
}