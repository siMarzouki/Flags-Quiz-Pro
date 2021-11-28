import 'package:flutter/material.dart';

class Choice extends StatefulWidget {
  final String country;
  final Function voidCallback;
  Choice({Key key, this.country, this.voidCallback}) : super(key: key);

  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      //A widget that detects gestures. Attempts to recognize gestures that correspond to its non-null callbacks.
      child: GestureDetector(
        //A widget that clips its child using a rounded rectangle.
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          //getting the image from the country name
          child: Image.asset(
            "flags/${widget.country}.png".toLowerCase(),
            width: MediaQuery.of(context).size.width * 0.3,
            height: 100,
            fit: BoxFit.fill,
          ),
        ),
        onTap: widget.voidCallback,
      ),
    );
  }
}
