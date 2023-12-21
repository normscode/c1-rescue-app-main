
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ralert/presentation/state/admin/admin_cubit.dart';

@RoutePage()
class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users List",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder(
              future: context.read<AdminCubit>().getAllUsers(),
              builder: (context, snapshot) {
                
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }

                if (snapshot.data == null) {
                  return const Center(
                    child: Text("Something went wrong."),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {

                    final user = snapshot.data![i];
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.6),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${user.firstName} ${user.lastName}",
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text("Type: ${user.userType}",
                                style: const TextStyle(
                                  fontSize: 16
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                    );
                  },
                );

              },
            )
          ),
        ),
      ),
    );
  }
}