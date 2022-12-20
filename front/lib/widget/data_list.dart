import 'package:flutter/material.dart';
import 'package:my_cash_mobile/models/transaction_model.dart';
import 'package:my_cash_mobile/models/user_model.dart';
import 'package:my_cash_mobile/providers/auth_provider.dart';
import 'package:my_cash_mobile/providers/transaction_provider.dart';
import 'package:my_cash_mobile/theme.dart';
import 'package:provider/provider.dart';

class DataList extends StatelessWidget {
  final TransactionModel data;
  DataList(this.data);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/edit-profile');
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 16, left: 24, right: 24),
        padding: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 2,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Text("Amount:\t ${data.amount}",
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: semiBold, color: bglight)),
          ],
        ),
      ),
    );
  }
}
