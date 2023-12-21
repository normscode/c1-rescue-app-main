
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/presentation/widgets/transparent_button.widget.dart';

@RoutePage()
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/welcome_images/welcome_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: const SizedBox()
            ),
      
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Welcome Back",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),                  
                  Column(
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/welcome_images/ralert-logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const SizedBox(),
                      ),
                      Text("RALERT",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor
                        )
                      ),
                      const Text("Get help in seconds.",
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        )
                      )
                    ],
                  ),

                  TransparentButton(
                    onTap: () {
                      context.router.push(const OnboardingRoutes());
                    },
                    text: "LET'S GO"
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}