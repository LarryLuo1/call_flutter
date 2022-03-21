import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:zego_call_flutter/common/style/styles.dart';
import 'package:zego_call_flutter/constants/zego_page_constant.dart';

import '../../service/zego_user_service.dart';

/// Displayed as a profile image if the user doesn't have one.
const placeholderImage =
    'https://upload.wikimedia.org/wikipedia/commons/c/cd/Portrait_Placeholder_Square.png';

class WelcomeTitleBar extends StatefulWidget {
  const WelcomeTitleBar({Key? key}) : super(key: key);

  @override
  _WelcomeTitleBarState createState() => _WelcomeTitleBarState();
}

class _WelcomeTitleBarState extends State<WelcomeTitleBar> {
  late User user;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser!;
    FirebaseAuth.instance.userChanges().listen((event) {
      if (event != null && mounted) {
        setState(() {
          user = event;
        });
      }
    });

    log(user.toString());

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// Example code for sign out.
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    Navigator.pushReplacementNamed(context, PageRouteNames.auth);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          maxRadius: 37.w,
          backgroundImage: NetworkImage(
            user.photoURL ?? placeholderImage,
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(36.w, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.displayName ?? '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: const Color(0xFF1B1B1B),
                  fontWeight: FontWeight.bold,
                  fontSize: 32.sp,
                ),
              ),
              Text(
                user.uid,
                style: TextStyle(
                  color: const Color(0xFF606060),
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
        ),
        const Expanded(child: SizedBox()),
        IconButton(
          icon: Image.asset(StyleIconUrls.titleBarSettings),
          iconSize: 68.w,
          onPressed: _signOut,
        ),
      ],
    );
  }
}