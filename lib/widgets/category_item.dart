import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryItem extends StatelessWidget {
  final String title;
  final String imageURL;
  AppBar? appBar = AppBar();

  // ignore: use_key_in_widget_constructors
  CategoryItem({required this.title, required this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Stack(alignment: Alignment.center, children: [
          SizedBox(
              width: double.infinity,
              height: (MediaQuery.of(context).size.height -
                      56 -
                      MediaQuery.of(context).padding.top) *
                  0.33,
              child: Image.asset(
                imageURL,
                fit: BoxFit.cover,
              )),
          Container(
            width: double.infinity,
            height: (MediaQuery.of(context).size.height -
                    56 -
                    MediaQuery.of(context).padding.top) *
                0.33,
            color: Colors.black45,
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 35),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
