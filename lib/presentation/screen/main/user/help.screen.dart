import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/help_images/help.png"),
                  )
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/help_images/help_1.png"),
                  )
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/help_images/help_2.png"),
                  )
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

}