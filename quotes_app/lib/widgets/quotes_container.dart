import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuoteContainer extends StatelessWidget {
  final String quoteText;

  final int ite;

  const QuoteContainer({Key key, this.quoteText, this.ite}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height) * 3 / 4,
      width: (MediaQuery.of(context).size.height) * 0.9,
      color: Colors.transparent,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          child: new Center(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "“",
                          style: GoogleFonts.paytoneOne(
                              color: Colors.white, fontSize: 35),
                        ),
                      ],
                    ),
                    Text(
                      quoteText,
                      style: GoogleFonts.anton(
                          fontSize: 40, color: Color(0xffCD0014)),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "”",
                          style: GoogleFonts.paytoneOne(
                              color: Colors.white, fontSize: 35),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
