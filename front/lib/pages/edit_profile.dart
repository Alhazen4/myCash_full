import 'package:flutter/material.dart';
import 'package:my_cash_mobile/models/user_model.dart';
import 'package:my_cash_mobile/providers/auth_provider.dart';
import 'package:my_cash_mobile/theme.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

bool isLoading = false;

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    String baseUrl = 'http://10.0.2.2:3000';
    UserModel user = authProvider.user;
    TextEditingController fullnameController =
        TextEditingController(text: "${user.fullname}");
    TextEditingController ageController =
        TextEditingController(text: "${user.age}");

    TextEditingController phoneController =
        TextEditingController(text: "${user.phonenumber}");

    TextEditingController emailController =
        TextEditingController(text: "${user.email}");
    print(user.id);

    handleEdit() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.edit(
        id: user.id,
        fullname: fullnameController.text,
        age: ageController.text,
        phonenumber: phoneController.text,
        email: emailController.text,
      )) {
        print(user.id);
        Navigator.pushNamed(context, '/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: dangerColor,
            content: Text(
              'Gagal Ganti Data!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          color: primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: bglight,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: primaryColor,
            ),
            onPressed: handleEdit,
          )
        ],
      );
    }

    Widget fullnameInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: primaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextField(
              controller: fullnameController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintText: user.fullname,
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget ageInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Age',
              style: primaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: ageController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget phoneInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone Number',
              style: primaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: phoneController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Email Address',
              style: primaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            TextField(
              controller: emailController,
              style: primaryTextStyle,
              decoration: InputDecoration(
                hintStyle: primaryTextStyle,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(
                top: defaultMargin,
              ),
            ),
            fullnameInput(),
            ageInput(),
            phoneInput(),
            emailInput(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bglight,
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(50), child: header()),
      body: content(),
      resizeToAvoidBottomInset: false,
    );
  }
}
