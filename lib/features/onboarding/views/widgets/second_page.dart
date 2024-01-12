import 'package:flutter/material.dart';
import 'package:todo_app/core/common/widgets/round_button.dart';

import '../../../../core/common/widgets/white_space.dart';
import '../../../../core/res/media_res.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Spacer(),
          Image.asset(ImageResource.todo),
          const WhiteSpce(height: 50),
          RoundButton(
            text: 'Login with Phone',
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
