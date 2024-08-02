import 'package:flutter/material.dart';

class DialogService {
  static showMessageOptionDialog (BuildContext context){
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}