import 'package:flutter/material.dart';
import 'package:scanner/features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'package:scanner/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:scanner/features/auth/domain/usecase/sign_up_use_case.dart';
import 'package:scanner/features/auth/presentation/pages/login_page.dart';
import 'package:scanner/features/auth/presentation/widgets/account_decider.dart';
import 'package:scanner/features/auth/presentation/widgets/custom_button.dart';
import 'package:scanner/features/auth/presentation/widgets/custom_password_field.dart';
import 'package:scanner/features/auth/presentation/widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final SignUpUseCase signUpUseCase = SignUpUseCase(
    AuthRepositoryImpl(AuthRemoteDataSourceImpl()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 120,),
          Image.asset('images/scanner_biru.png'),
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomTextField(
              label: "Name",
              hint: "John doe",
              controller: nameController,
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomTextField(
              label: "Email",
              hint: "Johndoe@gmail.com",
              controller: emailController,
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomTextField(
              label: "Phone Number",
              hint: "0987654321",
              controller: phoneNumberController,
            ),
          ),
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomPasswordField(
              label: "Password",
              hint: "********",
              controller: passwordController,
            ),
          ),
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomButton(
              label: "Register",
              onPressed: () async {
                try {
                  await signUpUseCase.call(
                    name: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    phoneNumber: phoneNumberController.text,
                  );

                  if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Registration successful! Please login.'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height - 150,
                        left: 10,
                        right: 10,
                      ),
                    ),
                  );
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Registration failed: ${e.toString()}'),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 3),
                        behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height - 150,
                        left: 10,
                        right: 10,
                      ),
                      ),
                    );
                  }
                }
              },
              width: double.infinity,
            ),
          ),
          AccountDecider(text: "already have an account?", action: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          },actionText:"Login")
        ],
      ),
    );
  }
}
