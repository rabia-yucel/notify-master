import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'BarcodeDb/BarcodeDb.dart';

class BarcodePage extends StatelessWidget {
  const BarcodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const BarcodeDb();
  }
}
