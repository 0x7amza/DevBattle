import 'package:flutter/cupertino.dart';

class mediaQuery {
  var size;
  var context;

  mediaQuery(context) {
    this.context = context;
    size = MediaQuery.of(context).size;
  }

  double getWidth() {
    return size.width * 0.01;
  }

  double getHeight() {
    return (size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom) *
        0.01;
  }
}
