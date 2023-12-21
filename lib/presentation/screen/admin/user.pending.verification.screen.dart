
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/core/global/global.variable.dart';

@RoutePage()
class UserPendingVerificationScreen extends StatefulWidget {
  const UserPendingVerificationScreen(this.pending, {super.key});

  final List<dynamic> pending;

  @override
  State<UserPendingVerificationScreen> createState() => _UserPendingVerificationScreenState();
}

class _UserPendingVerificationScreenState extends State<UserPendingVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users Pending Verification",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                                
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.pending.length,
                  itemBuilder: (context, i) {
          
                    dynamic currentItem = widget.pending[i];
          
                    return FutureBuilder(
                      future: getUser(currentItem['userId']),
                      builder: (context, snapshot) {
                        
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        }
          
                        final user = snapshot.data;
          
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              context.router.push(UserVerificationRoute(
                                verification: currentItem,
                                user: user
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 0.6),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${user['firstName']} ${user['lastName']}",
                                        style: const TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text("Type: ${user['userType']}",
                                        style: const TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                      Text("Status: ${currentItem['status']}",
                                        style: const TextStyle(
                                          fontSize: 16
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                  const Icon(Icons.keyboard_arrow_right, size: 35)
                                ],
                              )
                            ),
                          ),
                        );
          
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}