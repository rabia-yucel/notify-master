
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constant.dart';

class TextArea extends StatelessWidget {
  final VoidCallback onClickedCopy;
  final String text;

    TextArea({Key? key,
    required this.text,
    required this.onClickedCopy,

  }) : super(key: key) ;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Row(
        children: [
          Expanded(child:Container(
            height: 250,
            decoration: BoxDecoration(border: Border.all()),
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,

            child: SelectableText(


              text.isEmpty ?  ' Scan' : text,
              textAlign: TextAlign.center,
              style: GoogleFonts.oswald(),


            ),

          ),
          ),
          const SizedBox(width: 8),
          IconButton(onPressed: onClickedCopy,
            icon: Icon(Icons.copy, color: primaryColor),
            color: Colors.grey,
          )

        ],
      ),
    );
  }
}