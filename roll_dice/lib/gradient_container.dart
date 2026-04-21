import 'package:flutter/material.dart';
import 'package:roll_dice/dice_roller.dart';
import 'package:roll_dice/styled_text.dart';

Alignment startAligment = Alignment.topLeft; //typed
var endAligment = Alignment.bottomRight; //typed in assignation
final thirdColor = Color.fromARGB(
  255,
  84,
  47,
  168,
); //typed in runtime, can accept functions result but will not be reassigned
const fortColor = Color.fromARGB(
  255,
  45,
  7,
  98,
); //typed in compilation time, cannot be reassigned

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.firstColor, this.secondColor, {super.key});

  final Color firstColor;
  final Color secondColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [firstColor, secondColor, thirdColor, fortColor],
          begin: startAligment,
          end: endAligment,
        ),
      ),
      child: Center(
        // child: StyledText('Hello World!')
        child: DiceRoller(),
      ),
    );
  }
}
