import 'package:flutter/gestures.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ralert/config/routes/app_router.gr.dart';
import 'package:ralert/core/dto/register.dto.dart';
import 'package:ralert/presentation/state/auth/auth_cubit.dart';
import 'package:ralert/presentation/state/common/common_cubit.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.userType});

  final String userType;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SignUpHeader(),
                SignUpForm(userType: widget.userType),
                const SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: const AssetImage(
                "assets/images/welcome_images/ralert-logo.png"),
            height: MediaQuery.of(context).size.height * 0.2),
        Text("Get On Board", style: Theme.of(context).textTheme.headlineMedium),
        Text("Create your profile to start using this app...",
            style: Theme.of(context).textTheme.headlineSmall),
      ],
    );
  }
}

class SignUpForm extends StatelessWidget {
  SignUpForm({super.key, required this.userType});

  final String userType;

  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();
  final contactNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final genderFromState = context.select(
      (GenderCubit gender) => gender.state.gender,
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  label: Text("First Name"),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                  return "Enter correct first name";
                } else {
                  return null;
                }
              },
              controller: firstNameController,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text("Last Name"),
                  prefixIcon: Icon(Icons.person_outline_rounded)),
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                  return "Enter correct last name";
                } else {
                  return null;
                }
              },
              controller: lastNameController,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text("Age"), prefixIcon: Icon(Icons.numbers)),
              controller: ageController,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text("Phone Number"), prefixIcon: Icon(Icons.numbers)),
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$')
                        .hasMatch(value)) {
                  return "Enter correct Phone No";
                } else {
                  return null;
                }
              },
              controller: contactNumberController,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                  label: Text("Email"), prefixIcon: Icon(Icons.email_outlined)),
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}')
                        .hasMatch(value)) {
                  return "Enter correct email";
                } else {
                  return null;
                }
              },
              controller: emailController,
            ),
            const SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              obscuringCharacter: '*',
              decoration: const InputDecoration(
                  label: Text("Password"), prefixIcon: Icon(Icons.fingerprint)),
              validator: (value) {
                if (value!.isEmpty ||
                    !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
                        .hasMatch(value)) {
                  return "Enter valid password";
                } else {
                  return null;
                }
              },
              controller: passwordController,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: DropdownButton(
                value: genderFromState,
                hint: const Text('Pick gender'),
                underline: const SizedBox.shrink(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                items: genderList.map((e) {
                  return DropdownMenuItem(
                    value: e.title,
                    child: Text(e.title),
                  );
                }).toList(),
                isExpanded: true,
                onChanged: (value) {
                  context.read<GenderCubit>().pickGender(title: value!);
                },
              ),
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: "By creating an account you agree to our ",
                children: [
                  TextSpan(text: "Terms of Condition", style: TextStyle(color: Theme.of(context).primaryColor),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      context.router.push(const TermsAndConditionsRoute());
                    }
                  )
                ]
              )
            ),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: _buildSignUpButton(genderFromState)),
          ],
        ),
      ),
    );
  }

  _buildSignUpButton(genderFromState) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Registering) {
          EasyLoading.show(
            status: 'Signing Up...',
            dismissOnTap: false,
          );
        } else if (state is Registered) {
          EasyLoading.showSuccess(
            'Signing Up Successfully...',
            dismissOnTap: false,
          ).then((value) {
            context.router.replace(const AuthManagerRoute());
          });
        } else if (state is AuthFailure) {
          EasyLoading.showToast(state.message);
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            context.read<AuthCubit>().onRegister(
              registerDto: RegisterDto(
                email: emailController.text,
                password: passwordController.text,
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                age: ageController.text,
                contactNumber: contactNumberController.text,
                userType: userType,
                gender: genderFromState
              ));
          },
          child: const Text("SIGN UP"),
        );
      },
    );
  }
}

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Image(
              image: AssetImage("assets/logo/google-logo.png"),
              width: 20.0,
            ),
            label: const Text("SIGN IN WITH GOOGLE"),
          ),
        ),
      ],
    );
  }
}
