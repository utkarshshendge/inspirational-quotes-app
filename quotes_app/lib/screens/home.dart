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

PageController pageController = PageController(keepPage: true);

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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
        child: Column(
          children: [
            // Row(
            //   mainA
            //   children: [
            //     SizedBox(
            //       width: 3,
            //     ),
            //     FlatButton.icon(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.share,
            //           color: Colors.white,
            //         ),
            //         label: Text("Share"))
            //   ],
            // ),
            // Row(
            //   children: [
            //     Text(
            //       "Good Morning, Friend ",
            //       style: GoogleFonts.arvo(fontSize: 20, color: Colors.white),
            //     ),
            //   ],
            // ),
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

            // FlatButton(
            //     onPressed: () {
            //       getOnlineQuotes();
            //     },
            //     child: Text("Show New Quotes")),
            // FlatButton(
            //     onPressed: () {
            //       offlineQuotes.add(quotesList[quoteListIndex].q);
            //     },
            //     child: Text("Save Quote"))
            // Expanded(
            //   flex: 8,
            //   child: FutureBuilder<List<Quotes>>(
            //     future: fetchQuotes(),
            //     builder: (BuildContext context,
            //         AsyncSnapshot<List<Quotes>> snapshot) {
            //       if (snapshot.connectionState == ConnectionState.done &&
            //           snapshot.hasData) {
            //         return buildPageView(snapshot);
            //       } else {
            //         return Center(child: CircularProgressIndicator());
            //       }
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  PageView buildPageView(AsyncSnapshot<List<Quotes>> snapshot) {
    return PageView.builder(
      controller: pageController,
      itemCount: snapshot.data.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: QuoteContainer(
            quoteText: snapshot.data[index].q,
          ),
        );
        // return Container(
        //   // height: MediaQuery.of(context).size.height * 0.87,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     color: Colors.amberAccent[700],
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(20),
        //       bottomLeft: Radius.circular(60),
        //     ),
        //   ),
        //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        //   margin: EdgeInsets.only(bottom: 10),

        //   child: Stack(
        //     children: [
        //       Text(
        //         'Quotes App',
        //         style: GoogleFonts.lobster(fontSize: 45, color: Colors.white),
        //       ),
        //       Align(
        //         alignment: Alignment.center,
        //         child: TyperAnimatedTextKit(
        //           isRepeatingAnimation: false,
        //           repeatForever: false,
        //           displayFullTextOnTap: true,
        //           speed: const Duration(milliseconds: 150),
        //           onFinished: () {
        //             pageController.nextPage(
        //               duration: Duration(seconds: 1),
        //               curve: Curves.easeInOutCirc,
        //             );
        //           },
        //           text: ['"' + snapshot.data[index].q + '"'],
        //           textStyle: GoogleFonts.montserratAlternates(
        //               fontSize: 30.0, color: Colors.white),
        //         ),
        //       ),
        //       Align(
        //         alignment: Alignment.bottomRight,
        //         child: Text(
        //           snapshot.data[index].a,
        //           style: GoogleFonts.lora(fontSize: 14),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      },
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
