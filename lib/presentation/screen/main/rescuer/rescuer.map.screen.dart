import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralert/presentation/state/emergency_live/emergency_live_cubit.dart';
import 'package:ralert/presentation/state/radar/radar_cubit.dart';
import 'package:ralert/presentation/widgets/google.map.widget.dart';
import 'package:ralert/presentation/widgets/incident_alert.widget.dart';

@RoutePage()
class RescuerMapScreen extends StatefulWidget {
  const RescuerMapScreen({super.key});

  @override
  State<RescuerMapScreen> createState() => _RescuerMapScreenState();
}

class _RescuerMapScreenState extends State<RescuerMapScreen> {

  bool hasIncidentAlert = false;

  @override
  void initState() {
    super.initState();

    context.read<RadarCubit>().onRadar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [ 
          const GoogleMapWidget(),

          BlocBuilder<RadarCubit, RadarState>(
            builder: (context, state) {
              if (state is RadarStateValue) {

                context.read<EmergencyLiveCubit>().onLive(state.data['id']);

                final liveState = context.select((EmergencyLiveCubit live) => live.state);

                if (liveState is EmergencyOfflineState) return const SizedBox(); 

                return IncidentAlertWidget(liveState.data);
                
              }

              return const SizedBox();
            },
          )
        ],
      )
    );
  }
}