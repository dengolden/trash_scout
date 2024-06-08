import 'package:flutter/material.dart';
import 'package:trash_scout/shared/theme/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    bool notification = false;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 70),
                child: Center(
                  child: Text(
                    'Profil Saya',
                    style: semiBoldTextStyle.copyWith(
                      color: blackColor,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/trash-scout-3c117.appspot.com/o/users%2Fdefault_profile_image%2Fuser%20default%20profile.png?alt=media&token=79ef1308-3d3d-477d-b566-0c4e66848a4d'),
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Agus Halim',
                style: mediumTextStyle.copyWith(
                  color: blackColor,
                  fontSize: 24,
                ),
              ),
              Text(
                'Pria, Jakarta',
                style: regularTextStyle.copyWith(
                  color: darkGreyColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 15),
              Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: darkGreenColor,
                ),
                child: Center(
                  child: Text(
                    'Edit Profil',
                    style: mediumTextStyle.copyWith(
                        color: whiteColor, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 23),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.5,
                ),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: blackColor.withOpacity(0.1),
                      offset: Offset(0, 2),
                      blurRadius: 2.5,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xffE9E9E9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Icon(
                        Icons.notifications_none_rounded,
                        size: 30,
                        color: blackColor,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Notifikasi',
                      style: mediumTextStyle.copyWith(
                        color: blackColor,
                        fontSize: 20,
                      ),
                    ),
                    Expanded(child: Container()),
                    Switch(
                      value: notification,
                      activeColor: lightGreenColor,
                      onChanged: (value) {
                        setState(() {
                          notification = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 230),
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: darkGreenColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      size: 24,
                      color: whiteColor,
                    ),
                    SizedBox(width: 2),
                    Text(
                      'Keluar',
                      style: mediumTextStyle.copyWith(
                        color: whiteColor,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
