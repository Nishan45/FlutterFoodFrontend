import 'package:flutter/material.dart';

class InfoSection extends StatelessWidget {
  final String title;
  final String content;

  const InfoSection({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 1, offset: Offset(1, 1))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: !title.isEmpty,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
          Visibility(
            visible: !title.isEmpty,
            child: SizedBox(
              height: 10,
            ),
          ),
          Text(
            content,
            style: const TextStyle(
                overflow: TextOverflow.clip, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
