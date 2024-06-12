

import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> CustomSnackbar(BuildContext context,
String massege){
return  ScaffoldMessenger.of(context).showSnackBar( SnackBar(duration: const Duration(seconds: 2),
                                                    content: Center(child: Text(massege))));

}
