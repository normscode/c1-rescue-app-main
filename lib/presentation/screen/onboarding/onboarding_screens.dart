
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/presentation/widgets/transparent_button.widget.dart';

@RoutePage()
class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => OnboardingScreensState();
}

class OnboardingScreensState extends State<OnboardingScreens> {

  final LiquidController controller = LiquidController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            LiquidSwipe(
              liquidController: controller,
              pages: [
                OnboardingPage(
                  image: "assets/images/on_boarding_images/on-boarding-image-1.png",
                  title: "GET HELP IN SECONDS",
                  description: "You can get help in seconds with your smartphone when a car crash accident happens.",
                  onTap: () {
                    controller.animateToPage(page: controller.currentPage + 1);
                  },
                ),
                OnboardingPage(
                  image: "assets/images/on_boarding_images/on-boarding-image-2.png",
                  title: "FIND NEARBY RESCUERS",
                  description: "Find nearby rescuers through the Ralert app.",
                  onTap: () {
                    controller.animateToPage(page: controller.currentPage + 1);
                  },
                ),
                OnboardingPage(
                  image: "assets/images/on_boarding_images/on-boarding-image-3.png",
                  title: "CAR CRASH DETECTION",
                  description: "An application with Smart Car Crash Detection to send automatic alerts to Authorities.",
                  onTap: () {
                    context.router.push(const AlmostThereRoute());
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.onTap
  });

  final String image;
  final String title;
  final String description;
  final Function() onTap;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
              const SizedBox(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const SizedBox(),
                  ),
                  Text(widget.title,
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                    )
                  ),
                  const SizedBox(height: 8),
                  Text(widget.description,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              TransparentButton(
                onTap: widget.onTap,
                text: "CONTINUE"
              ),
              GestureDetector(
                onTap: () {
                  context.router.push(const AlmostThereRoute());
                },
                child: const Text("SKIP",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}