import 'package:chat_flutter_app/modal/introduce_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key, required this.introModel});

  final IntroModel introModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 120,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    introModel.assetsImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: Text(
              introModel.titleText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          Expanded(
              flex: 1,
              child: SizedBox(
                height: 10,
              ))
        ],
      ),
    );
  }
}
