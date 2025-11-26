import 'package:flune/common/widgets/appbar/app_bar.dart';
import 'package:flune/common/widgets/button/basic_app_button.dart';
import 'package:flune/core/configs/assets/app_vectors.dart';
import 'package:flune/data/models/auth/create_user_req.dart';
import 'package:flune/domain/usecases/auth/signup_usecase.dart';
import 'package:flune/presentation/auth/pages/login_page.dart';
import 'package:flune/presentation/root/pages/root.dart';
import 'package:flune/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            SizedBox(height: 24),
            _fullNameField(context),
            SizedBox(height: 12),
            _emailField(context),
            SizedBox(height: 12),
            _passwordField(context),
            SizedBox(height: 18),
            BasicAppButton(
                onPressed: () async {
                  var result = await serviceLocator<SignupUseCase>().call(
                    params: CreateUserReq(
                        fullName: _fullName.text.toString(),
                        email: _email.text.toString(),
                        password: _password.text.toString()
                    )
                  );

                  result.fold(
                      (ifLeft) {
                        var snackBar = SnackBar(content: Text(ifLeft));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      (ifRight) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => const RootPage()
                          ),
                          (route) => false
                        );
                      }
                  );
                },
                title: 'Create Account'
            ),
          ],
        ),
      ),
      bottomNavigationBar: _sigInText(context),
    );
  }

  Widget _registerText() {
    return Text(
      'Register',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: InputDecoration(
        hintText: 'Full Name',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(
        hintText: 'Enter Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: InputDecoration(
        hintText: 'Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _sigInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Do You Have An Account?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage()
                )
              );
            },
            child: Text(
              'Sign In',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
