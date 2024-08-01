import 'package:flutter/material.dart';

class BooksInfo extends StatefulWidget {
  const BooksInfo({super.key});

  @override
  State<BooksInfo> createState() => _BooksInfoState();
}

class _BooksInfoState extends State<BooksInfo> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemBuilder: (context, index) {
        return Container(
          width: 169,
          height: 275,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
        );
      },
    );
  }
}