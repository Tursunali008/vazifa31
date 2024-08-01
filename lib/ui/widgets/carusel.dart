import 'package:flutter/material.dart';
import 'package:vazifa31/ui/widgets/containers_rox_widget.dart';

class RowsWidget extends StatefulWidget {
  const RowsWidget({super.key});

  @override
  State<RowsWidget> createState() => _RowsWidgetState();
}

class _RowsWidgetState extends State<RowsWidget> {
  bool isTapped1 = true;
  bool isTapped2 = false;
  bool isTapped3 = false;
  bool isTapped4 = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isTapped1 = true;
                isTapped2 = false;
                isTapped3 = false;
                isTapped4 = false;
              });
            },
            child: ContainersRowWidget(isTapped: isTapped1, text: "All"),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isTapped2 = true;
                isTapped1 = false;
                isTapped3 = false;
                isTapped4 = false;
              });
            },
            child: ContainersRowWidget(isTapped: isTapped2, text: "Romance"),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isTapped3 = true;
                isTapped1 = false;
                isTapped2 = false;
                isTapped4 = false;
              });
            },
            child: ContainersRowWidget(isTapped: isTapped3, text: "Sci-Fi"),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isTapped4 = true;
                isTapped2 = false;
                isTapped3 = false;
                isTapped1 = false;
              });
            },
            child: ContainersRowWidget(isTapped: isTapped4, text: "Fantasy"),
          ),
        ],
      ),
    );
  }
}
