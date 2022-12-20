import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_cash_mobile/providers/auth_provider.dart';
import 'package:my_cash_mobile/theme.dart';
import 'package:my_cash_mobile/widget/loading_button.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullnameController = TextEditingController(text: '');

  TextEditingController ageController = TextEditingController(text: '');

  TextEditingController phoneController = TextEditingController(text: '');

  TextEditingController emailController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleLogin() async {
      Navigator.pushNamed(context, '/login');
    }

    handleSignUp() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.register(
        fullname: fullnameController.text,
        age: ageController.text,
        phonenumber: phoneController.text,
        email: emailController.text,
        password: passwordController.text,
      )) {
        Navigator.pushNamed(context, '/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: dangerColor,
            content: Text(
              'Gagal Register!',
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
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/logo/logo-2.png',
              ),
            ),
          ),
        ),
      );
    }

    Widget nameInput() {
      return Container(
          margin: EdgeInsets.only(top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Fullname",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: fullnameController,
                cursorColor: primaryColor,
                validator: MultiValidator(
                    [RequiredValidator(errorText: 'Name is required')]),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 16,
                  ),
                  hintText: "My Cash",
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

    Widget ageInput() {
      return Container(
          margin: EdgeInsets.only(top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Age",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: ageController,
                cursorColor: primaryColor,
                validator: MultiValidator(
                    [RequiredValidator(errorText: 'Age is required')]),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 16,
                  ),
                  hintText: "exp: 16",
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

    Widget phoneInput() {
      return Container(
          margin: EdgeInsets.only(top: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Age",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                cursorColor: primaryColor,
                validator: MultiValidator(
                    [RequiredValidator(errorText: 'Phone is required')]),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 16,
                  ),
                  hintText: "exp: 08123456789",
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

    Widget emailInput() {
      return Container(
          margin: EdgeInsets.only(top: 12),
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
                  RequiredValidator(errorText: 'name is required'),
                  EmailValidator(errorText: 'Invalid email address')
                ]),
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
          margin: EdgeInsets.only(top: 12),
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
                validator: MultiValidator(
                    [RequiredValidator(errorText: 'Password is required')]),
                obscureText: true,
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

    Widget signUpButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: handleSignUp,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Sign Up',
            style: primaryTextStyle.copyWith(
                fontSize: 16, fontWeight: medium, color: bglight),
          ),
        ),
      );
    }

    Widget loginButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          border: Border.all(
            color: primaryColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextButton(
          onPressed: handleLogin,
          style: TextButton.styleFrom(
            backgroundColor: bglight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Login',
            style: primaryTextStyle.copyWith(
                fontSize: 16, fontWeight: medium, color: primaryColor),
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              margin: EdgeInsets.only(
                bottom: 24,
                left: defaultMargin,
                right: defaultMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageIllustration(),
                  SizedBox(
                    height: 47,
                  ),
                  Text("Register Yourself",
                      style: primaryTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      )),
                  nameInput(),
                  ageInput(),
                  phoneInput(),
                  emailInput(),
                  passwordInput(),
                  isLoading ? LoadingButton() : signUpButton(),
                  loginButton()
                ],
              )),
        ),
      ),
    );
  }
}
