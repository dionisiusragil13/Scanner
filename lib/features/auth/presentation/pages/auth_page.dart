import 'package:flutter/material.dart';
import 'package:scanner/core/widgets/transparent_button.dart';
import 'package:scanner/core/widgets/white_button.dart';
import 'package:scanner/features/auth/presentation/pages/login_page.dart';
import 'package:scanner/features/auth/presentation/pages/register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191970),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/scanner_putih.png'),
          Text(
            "No more paper receipt!",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 150.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: WhiteButton(
              text: "Register",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
            ),
          ),
          SizedBox(height: 20.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TransparentButton(
              text: "Login",
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
