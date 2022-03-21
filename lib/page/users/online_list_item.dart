import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/style/styles.dart';
import '../../model/zego_user_info.dart';

const placeholderImage =
    'https://upload.wikimedia.org/wikipedia/commons/c/cd/Portrait_Placeholder_Square.png';

class OnlineListItem extends StatelessWidget {
  const OnlineListItem({Key? key, required this.userInfo}) : super(key: key);
  final ZegoUserInfo userInfo;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 84.w,
          height: 84.h,
          child: CircleAvatar(
            maxRadius: 37.w,
            backgroundImage: NetworkImage(
              userInfo.avatar ?? placeholderImage),
            ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            SizedBox(
              width: 300.w,
              height: 33.h,
              child: Text(userInfo.userName, style: StyleConstant.roomMemberListNameText),
            ),
            SizedBox(
              width: 300.w,
              height: 33.h,
              child: Text(userInfo.userID, style: StyleConstant.roomMemberListNameText),
            ),
          ],
        ),
        Row(
            children: [
              SizedBox(
                width: 84.w,
                height: 84.h,
                child: TextButton(
                  child: const Text('Video'),
                  onPressed: () {
                    // TODO call to video
                  }
                ),
              ),
              SizedBox(
                width: 84.w,
                height: 84.h,
                child: TextButton(
                    child: const Text('Audio'),
                    onPressed: () {
                      // TODO call to audio
                    }
                ),
              ),
            ],
        ),
      ],
    );
  }
}