import 'package:flutter/material.dart';
import 'package:my_cash_mobile/models/user_model.dart';
import 'package:my_cash_mobile/providers/auth_provider.dart';
import 'package:my_cash_mobile/providers/data_provider.dart';
import 'package:my_cash_mobile/theme.dart';
import 'package:my_cash_mobile/widget/loading_button.dart';
import 'package:provider/provider.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    handleSignUp() async {
      Navigator.pushNamed(context, '/sign-up');
    }

    handleSignIn() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(
        email: emailController.text,
        password: passwordController.text,
      )) {
        Provider.of<DataProvider>(context, listen: false)
            .getIncome(userid: user.id);
        Provider.of<DataProvider>(context, listen: false)
            .getExpense(userid: user.id);
        Navigator.pushNamed(context, '/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: dangerColor,
            content: Text(
              'Gagal Login!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget imageIllustration() {
      return Center(
        heightFactor: 1,
        child: Container(
          margin: EdgeInsets.only(top: 70),
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/illustration/login.png',
              ),
            ),
          ),
        ),
      );
    }

    Widget emailInput() {
      return Container(
          margin: EdgeInsets.only(top: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email Address",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: emailController,
                cursorColor: primaryColor,
                validator: MultiValidator([
                  EmailValidator(errorText: 'enter a valid email address'),
                  RequiredValidator(errorText: 'email is required')
                ]),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 16,
                  ),
                  hintText: "MyCash@gmail.com",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: greyColor,
                    ),
                  ),
                ),
              ),
            ],
          ));
    }

    Widget passwordInput() {
      return Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Password",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: passwordController,
                cursorColor: primaryColor,
                obscureText: true,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'password is required'),
                  MinLengthValidator(6,
                      errorText: 'password should be at least 6 digits')
                ]),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 16,
                  ),
                  hintText: "********",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: greyColor,
                    ),
                  ),
                ),
              ),
            ],
          ));
    }

    Widget signInButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: InkWell(
          child: TextButton(
            onPressed: handleSignIn,
            style: TextButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Sign In',
              style: primaryTextStyle.copyWith(
                  fontSize: 16, fontWeight: medium, color: bglight),
            ),
          ),
        ),
      );
    }

    Widget signUpButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          child: InkWell(
            hoverColor: primaryColor,
            splashColor: primaryColor,
            child: TextButton(
              onPressed: handleSignUp,
              style: TextButton.styleFrom(
                backgroundColor: bglight,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Sign Up',
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: medium, color: primaryColor),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              margin: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                bottom: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageIllustration(),
                  SizedBox(
                    height: 47,
                  ),
                  Text("Login",
                      style: primaryTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      )),
                  emailInput(),
                  passwordInput(),
                  isLoading ? LoadingButton() : signInButton(),
                  signUpButton(),
                ],
              )),
        ),
      ),
    );
  }
}
