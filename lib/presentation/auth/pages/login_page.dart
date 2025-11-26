import 'package:flune/common/widgets/appbar/app_bar.dart';
import 'package:flune/common/widgets/button/basic_app_button.dart';
import 'package:flune/core/configs/assets/app_vectors.dart';
import 'package:flune/data/models/auth/sign_in_user_req.dart';
import 'package:flune/domain/usecases/auth/sign_in_usecase.dart';
import 'package:flune/presentation/auth/pages/signup_page.dart';
import 'package:flune/presentation/root/pages/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../service_locator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            SizedBox(height: 24),
            _emailField(context),
            SizedBox(height: 12),
            _passwordField(context),
            SizedBox(height: 18),
            BasicAppButton(
                onPressed: () async {
                  var result = await serviceLocator<SignInUseCase>().call(
                      params: SignInUserReq(
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
                title: 'Login'
            ),
          ],
        ),
      ),
      bottomNavigationBar: _sigInText(context),
    );
  }

  Widget _registerText() {
    return Text(
      'Login',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: InputDecoration(
        hintText: 'Enter Username Or Email',
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
            'Not A Member?',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SignupPage()
                  )
              );
            },
            child: Text(
              'Register Now',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
