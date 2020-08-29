import 'package:flutter/material.dart';

const kAppBarTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
  fontFamily: 'Quesha',
  color: Colors.white,
);
const kTitleTextStyle = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.w500,
  fontFamily: 'Quesha',
  color: Colors.white,
);
const kContainerTextStyle = TextStyle(
  fontSize: 20,
  color: Colors.lightGreenAccent,
  fontWeight: FontWeight.w600,
  fontFamily: 'Quesha',
);
const kPriceOfArticle = TextStyle(
  color: Colors.black,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Search items here',
  hintStyle: TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter a Value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFF6BF3E), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFF6BF3E), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
