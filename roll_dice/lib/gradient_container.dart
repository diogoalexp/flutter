import 'package:flutter/material.dart';
import 'package:roll_dice/styled_text.dart';

Alignment startAligment = Alignment.topLeft; //typed
var endAligment = Alignment.bottomRight; //typed in assignation
final firstColor = Color.fromARGB(
  255,
  84,
  47,
  168,
); //typed in runtime, can accept functions result but will not be reassigned
const secondColor = Color.fromARGB(
  255,
  45,
  7,
  98,
); //typed in compilation time, cannot be reassigned

class GradientContainer extends StatelessWidget {
  const GradientContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [firstColor, secondColor],
          begin: startAligment,
          end: endAligment,
        ),
      ),
      child: Center(child: StyledText('Hello World!')),
    );
  }
}
