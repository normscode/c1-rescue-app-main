import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/presentation/widgets/crash_dtc.widget.dart';
import 'package:ralert/presentation/widgets/google.map.widget.dart';

@RoutePage()
class UserMapScreen extends StatefulWidget {
  const UserMapScreen({super.key});

  @override
  State<UserMapScreen> createState() => _UserMapScreenState();
}

class _UserMapScreenState extends State<UserMapScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [ 
          const GoogleMapWidget(),

          const Positioned(
            bottom: 0,
            child: AutomaticCarCrashDetectionWidget(),
          ),

          Positioned(
            bottom: 70,
            right: 20,
            child: GestureDetector(
              onTap: () {
                context.router.push(SOSRoute());
              },
              child: Container(
                height: 50,
                width: 110,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(3)
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8),
                  child: FittedBox(
                    child: Row(
                      children: [
                        Icon(Icons.phone, color: Color(0xFF4A4A4A)),
                        SizedBox(width: 5),
                        Text("SOS", style: TextStyle(color: Color(0xFF4A4A4A)))
                      ],
                    )
                  ),
                ),
              ),
            ),
          )

          // Positioned(
          //   top: 65.0,
          //   left: 15.0,
          //   child: AccelerometerWidget()
          // )
        ],
      ),
    );
  }
}