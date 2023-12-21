
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/presentation/state/motion/motion_cubit.dart';

class AccelerometerWidget extends StatefulWidget {
  const AccelerometerWidget({super.key});

  @override
  State<AccelerometerWidget> createState() => _AccelerometerWidgetState();
}

class _AccelerometerWidgetState extends State<AccelerometerWidget> {

  @override
  void initState() {
    super.initState();

    context.read<MotionCubit>().onMotion();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: FittedBox(
          child: Row(
            children: [
              const Icon(Icons.speed, color: Color(0xFF4A4A4A)),
              const SizedBox(width: 5),
              BlocConsumer<MotionCubit, MotionState>(
                listener: (context, state) {
                  if (state is CarCrashDetectedState) {
                    context.router.push(SOSRoute());
                  }
                },
                builder: (context, state) {
                  return Text.rich(
                    TextSpan(
                      text: state.value?.magnitude.floor().toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23, color: Color(0xFF4A4A4A)),
                      children: const [
                        TextSpan(
                          text: " kph",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15
                            )
                          )
                        ]
                    )
                  );
                },
              )
            ],
          )
        ),
      ),
    );
  }
}