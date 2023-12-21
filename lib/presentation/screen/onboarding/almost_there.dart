import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/presentation/widgets/transparent_button.widget.dart';
import 'package:flutter/gestures.dart';

@RoutePage()
class AlmostThereScreen extends StatefulWidget {
  const AlmostThereScreen({super.key});

  @override
  State<AlmostThereScreen> createState() => _AlmostThereScreenState();
}

class _AlmostThereScreenState extends State<AlmostThereScreen> {

  String selected = "user";
  
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Almost there...",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("I am a",
                        style: TextStyle(fontSize: 21.0, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      _buildUserTypeWidget(
                        "user"
                      ),
                      const SizedBox(height: 15),
                      _buildUserTypeWidget(
                        "rescuer"
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      TransparentButton(
                        text: "PROCEED",
                        onTap: () {
                          context.router.push(SignUpRoute(userType: selected));
                        }
                      ),
                      const SizedBox(height: 40),
                      Text.rich(TextSpan(children: [
                        const TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white
                          )
                        ),
                        TextSpan(text: "LOGIN",
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {
                            context.router.push(const LoginRoute());
                          }
                        )
                      ])),
                    ],
                  ),
                  const SizedBox(height: 10),
                  
                ],
              ),
            )
          ],
        )
      ),
    );
  }

  _buildUserTypeWidget(String userType) {
    return InkWell(
      onTap: () {
        setState(() {
          selected = userType;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: userType == selected
            ? Theme.of(context).primaryColor
            : Colors.transparent
          ,
          borderRadius: BorderRadius.circular(5)
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              userType == "user"
                ? Icons.person_2_rounded
                : Icons.health_and_safety,
              color: userType == selected
                ? Colors.black
                : Colors.white
            ),
            const SizedBox(width: 8),
            Text(
              userType == "user"
                ? "REGULAR USER"
                : "RESCUER"
              ,
              style: TextStyle(
                fontSize: 19.0, fontWeight: FontWeight.bold,
                color: userType == selected
                  ? Colors.black
                  : Colors.white
              ),
            )
          ],
        ),
      ),
    );
  }
}