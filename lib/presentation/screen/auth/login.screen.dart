import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/core/dto/login.dto.dart';
import 'package:ralert/presentation/state/auth/auth_cubit.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                        image: const AssetImage(
                            "assets/images/welcome_images/ralert-logo.png"),
                        height: MediaQuery.of(context).size.height * 0.2),
                    Text("Welcome Back,",
                        style: Theme.of(context).textTheme.headlineMedium),
                    Text("Get Help in Seconds with Ralert App",
                        style: Theme.of(context).textTheme.headlineSmall),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined),
                          labelText: "Email",
                          hintText: "Email",
                          border: OutlineInputBorder()),
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                                    .hasMatch(value)) {
                              return "Enter correct email";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          obscureText: isObsecure,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.fingerprint),
                            labelText: "Password",
                            hintText: "Password",
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isObsecure = !isObsecure;
                                });
                              },
                              icon: isObsecure
                                ? const Icon(Icons.remove_red_eye_sharp)
                                : const Icon(Icons.remove_red_eye_outlined),
                            ),
                          ),
                          controller: password,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                                    .hasMatch(value)) {
                              return "Enter valid password";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {}, child: const Text("Forget Password")),
                        ),
                        SizedBox(width: double.infinity, child: _buildLoginButton())
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("OR"),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Image(
                            image: AssetImage("assets/logo/google-logo.png"), width: 20.0),
                        onPressed: () {},
                        label: const Text("Sign-In with Google"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildLoginButton() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoggingIn) {
          EasyLoading.show(
            status: 'logging in...',
            dismissOnTap: false,
          );
        } else if (state is LoggedIn) {
          EasyLoading.showSuccess(
            'Login success',
            dismissOnTap: false,
          ).then((value) {
            context.router.replace(const AuthManagerRoute());
          });
        } else if (state is AuthFailure) {
          EasyLoading.dismiss();
          EasyLoading.showToast(state.message);
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () async {
            context.read<AuthCubit>().onLogin(
              loginDto: LoginDto(email: email.text, password: password.text)
            );
          },
          child: const Text("LOGIN"),
        );
      },
    );
  }
}