import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pos_flutter/pages/view/home_page.dart';
import 'package:pos_flutter/pages/view/login_page.dart';
import 'package:provider/provider.dart';

class UserValidation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return (user == null) ? LoginPage() : HomePage();
  }
}
