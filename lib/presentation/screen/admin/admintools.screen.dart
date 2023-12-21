
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/presentation/state/admin/admin_cubit.dart';
import 'package:ralert/presentation/widgets/drawer.dart';

@RoutePage()
class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<AdminCubit>().getAdminAnalytics(),
      builder: (context, snapshot) {

        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        return Scaffold(
          endDrawer: const MyDrawer(),
          appBar: AppBar(
            title: const Text("Hello, Admin!",
              style: TextStyle(color: Colors.black),
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: BlocBuilder<AdminCubit, AdminState>(
                builder: (context, state) {

                  if (state is AdminAnalyticsState) {

                    List<Map<String, dynamic>> analytics = [
                      {"title": "On Going", "value": state.analytics['onGoing']},
                      {"title": "Solved", "value": state.analytics['solved']},
                      {"title": "Total Emergency", "value": state.analytics['totalEmergency']},
                      {"title": "Total Users", "value": state.analytics['totalUsers']},
                    ];

                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: analytics.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              childAspectRatio: (1 / .4)
                            ),
                            itemBuilder: (context, i) {
                              return _buildAnalytic(analytics[i]['title'], analytics[i]['value']);
                            }
                          ),
                          _buildUserPendingVerification(state.analytics['pendingUsersVerification'])
                        ],
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
              )
            ),
          ),
        );
      }
    );
  }

  _buildAnalytic(String title, value) {

    Function() functionClick;
    bool hasArrow = true;

    if (title == "Total Emergency") {
      functionClick = () => context.router.push(const AdminIncidentListRoute());
    } else if (title == "Total Users") {
      functionClick = () => context.router.push(const UserListRoute());
    } else {
      hasArrow = false;
      functionClick = () {};
    }

    return GestureDetector(
      onTap: functionClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(225, 224, 225, 1),
          borderRadius: BorderRadius.circular(3)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value.length.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600
                  )
                ),
                Text(title,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black45
                  ),
                ),
              ],
            ),
            hasArrow == true
              ? const Icon(Icons.keyboard_arrow_right, color: Colors.black)
              : const SizedBox()
          ],
        )
      ),
    );
  }

  _buildUserPendingVerification(pending) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GestureDetector(
        onTap: () {
          context.router.push(UserPendingVerificationRoute(pending: pending));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(3)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pending.length.toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    )
                  ),
                  const Text("Users Pending Verification",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              const Icon(Icons.keyboard_arrow_right, color: Colors.white)
            ],
          )
        ),
      ),
    );
  }
}