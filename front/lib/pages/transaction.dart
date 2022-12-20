import 'package:flutter/material.dart';
import 'package:my_cash_mobile/models/user_model.dart';
import 'package:my_cash_mobile/providers/auth_provider.dart';
import 'package:my_cash_mobile/providers/chart_provider.dart';
import 'package:my_cash_mobile/providers/transaction_provider.dart';
import 'package:my_cash_mobile/theme.dart';
import 'package:provider/provider.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  bool isLoading = false;
  bool isIncome = true;
  String? _dropdownValue;
  TextEditingController amountController = TextEditingController(text: '');
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;
    TransactionProvider transactionProvider =
        Provider.of<TransactionProvider>(context);

    dropdownCallback(String value) {
      if (value is String) {
        _dropdownValue = value;
        if (_dropdownValue == "Income") {
          isIncome = true;
        } else {
          isIncome = false;
        }
        print(isIncome);
      }
    }

    changeIncome() async {
      setState(() {
        isIncome = true;
        print(isIncome);
      });
    }

    changeExpenses() async {
      setState(() {
        isIncome = false;
        print(isIncome);
      });
    }

    handleIncome() async {
      setState(() {
        isLoading = true;
      });

      if (await transactionProvider.income(
          amount: int.parse(amountController.text), userid: user.id)) {
        Navigator.pushNamed(context, '/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: dangerColor,
            content: Text(
              'Gagal masukin Jumlah!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    handleExpenses() async {
      setState(() {
        isLoading = true;
      });

      if (await transactionProvider.expense(
          amount: int.parse(amountController.text), userid: user.id)) {
        Navigator.pushNamed(context, '/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: dangerColor,
            content: Text(
              'Gagal masukin Jumlah!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      setState(() {
        isLoading = false;
      });
    }

    Widget amountInput() {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          margin: EdgeInsets.only(top: 24),
          child: Column(
            children: [
              Text(
                "Amount",
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: regular,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              TextField(
                controller: amountController,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 16,
                  ),
                  hintText: "Rp: 100.000",
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

    Widget submitButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: TextButton(
          onPressed: isIncome ? handleIncome : handleExpenses,
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Submit',
            style: primaryTextStyle.copyWith(
                fontSize: 16, fontWeight: medium, color: bglight),
          ),
        ),
      );
    }

    Widget category() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
        ),
        child: Row(
          children: [
            SizedBox(
              width: defaultMargin,
            ),
            ChoiceChip(
              label: Text("Income",
                  style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                      color: isIncome ? bglight : blackColor)),
              selected: isIncome ? true : false,
              selectedColor: primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value) {
                  setState(() {
                    changeIncome();
                  });
                }
              },
            ),
            SizedBox(
              width: 16,
            ),
            ChoiceChip(
              label: Text("Expense",
                  style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                      color: isIncome ? blackColor : bglight)),
              selected: isIncome ? false : true,
              selectedColor: primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) {
                if (value) {
                  setState(() {
                    changeExpenses();
                  });
                }
              },
            ),
          ],
        ),
      );
    }

    Widget TextTransaction(String type) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        margin: EdgeInsets.only(top: 24),
        child: Center(
          widthFactor: 1,
          child: Text(type,
              style: primaryTextStyle.copyWith(
                fontSize: 32,
                fontWeight: bold,
              )),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'Transaction',
          style: primaryTextStyle.copyWith(color: bglight),
        ),
      ),
      body: ListView(
        children: [
          category(),
          isIncome ? TextTransaction("Income") : TextTransaction("Expense"),
          amountInput(),
          submitButton(),
        ],
      ),
    );
  }
}
