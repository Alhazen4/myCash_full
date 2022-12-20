import 'package:flutter/material.dart';
import 'package:my_cash_mobile/theme.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({super.key});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    Widget Card(String image, String title, String description) {
      return GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(
            bottom: 24,
          ),
          margin: EdgeInsets.only(
            left: defaultMargin,
            right: defaultMargin,
            bottom: defaultMargin,
          ),
          decoration: BoxDecoration(
            color: bglight,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  '${image}',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${title}",
                      style: primaryTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "${description}",
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Article'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: defaultMargin),
            child: Column(children: [
              Card("assets/illustration/media.png", "Investment in Indonesia",
                  "Investment is the most important economic factor for a nation. It is the building blocks on which an economy is built. Investment leads to asset creations, ..."),
              Card(
                  "assets/illustration/media-2.png",
                  "Financial Health: Definition and How to Measure and Improve It",
                  "Financial health is a term used to describe the state of one's personal monetary affairs. There are many dimensions to financial health, including the amount of savings you have, how much you’re putting away for retirement,"),
              Card(
                  "assets/illustration/media-3.png",
                  "Mengenal Financial Freedom dan Cara Mencapainya di Usia Muda",
                  "Financial freedom bisa diartikan sebagai kemapanan finansial untuk seorang individu. Saat seseorang sudah mencapai kebebasan finansial, maka tidak ada lagi kekhawatiran untuk kekurangan uang saat membeli barang-barang atau memenuhi kebutuhan yang diinginkan."),
            ]),
          ),
        ),
      ),
    );
  }
}
