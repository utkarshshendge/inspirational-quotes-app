import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:quotes_app/models/qoutemodel.dart';
import 'package:quotes_app/offline_quotes/offline_quotes.dart';
import 'package:quotes_app/widgets/quotes_container.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Quotes> quotesList;

  Box offlineQuotes = Hive.box("offlineQuotes");
  bool onlineQuotesTrue = false;
  int quoteListIndex = 0;
  static Future<List<Quotes>> fetchQuotes() async {
    final response = await http.get('https://zenquotes.io/api/quotes');
    if (response.statusCode == 200) {
      print(quotesFromJson(response.body).length);
      print(quotesFromJson(response.body));

      return quotesFromJson(response.body);
    } else {
      throw Exception('Failed!');
    }
  }

  @override
  void initState() {
    super.initState();
    getOfflineQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242A42),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    quoteListIndex++;
                  });
                },
                child: onlineQuotesTrue && quotesList != null
                    ? QuoteContainer(
                        quoteText: quotesList[quoteListIndex].q,
                      )
                    : QuoteContainer(
                        quoteText: InbuiltQuotes.quotes[quoteListIndex],
                        ite: quoteListIndex,
                      )),
            FlatButton(
                color: Colors.black,
                onPressed: () {
                  getOnlineQuotes();
                },
                child: Text(
                  "Show New Quotes",
                  style: TextStyle(color: Color(0xffD11151)),
                )),
            FlatButton(
                color: Colors.black,
                onPressed: () {
                  offlineQuotes.add(quotesList[quoteListIndex].q);
                },
                child: Text(
                  "Save Quotes",
                  style: TextStyle(color: Color(0xffD11151)),
                )),
          ],
        ),
      ),
    );
  }

  getOnlineQuotes() async {
    quotesList = await fetchQuotes();
    setState(() {
      onlineQuotesTrue = true;
    });
  }

  getOfflineQuotes() {
    if (offlineQuotes.isEmpty) {
      for (int i = 0; i < InbuiltQuotes.quotes.length; i++) {
        offlineQuotes.add(InbuiltQuotes.quotes[i]);
      }
    } else {
      print(offlineQuotes.getAt(5));
    }
  }
}
