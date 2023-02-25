import 'package:flutter/material.dart';

class EmptyWidget extends Widget{
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Element createElement() {
    return EmptyElement(this);
  }

}
class EmptyElement extends Element {
  EmptyElement(super.widget);

  @override
  bool get debugDoingBuild =>false;

  @override
  void performRebuild() {
  }
}