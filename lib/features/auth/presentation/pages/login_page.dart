import 'package:flutter/material.dart';
import 'package:scanner/features/auth/data/datasource/auth_remote_data_source_impl.dart';
import 'package:scanner/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:scanner/features/auth/domain/usecase/sign_in_use_case.dart';
import 'package:scanner/features/auth/presentation/pages/register_page.dart';
import 'package:scanner/features/auth/presentation/widgets/account_decider.dart';
import 'package:scanner/features/auth/presentation/widgets/custom_button.dart';
import 'package:scanner/features/auth/presentation/widgets/custom_password_field.dart';
import 'package:scanner/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:scanner/features/home/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final SignInUseCase signInUseCase = SignInUseCase(
    AuthRepositoryImpl(AuthRemoteDataSourceImpl()),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/scanner_biru.png'),
          SizedBox(height: 100.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomTextField(
              label: "Name",
              hint: "John doe",
              controller: emailController,
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
              label: "Login",
              onPressed: () async {
                try {
                  await signInUseCase(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        width: 90.0,
                        content: const Text(
                          'Login Succesfull.',
                        ),
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
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false,
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login Failed: ${e.toString()}'),
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
          AccountDecider(text: "new user?", action: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
          },actionText:"Register")
        ],
      ),
    );
  }
}
