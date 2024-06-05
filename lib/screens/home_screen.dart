import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trash_scout/screens/create_report_page.dart';
import 'package:trash_scout/screens/login_screen.dart';
import 'package:trash_scout/screens/notification_history_screen.dart';
import 'package:trash_scout/screens/see_all_history_page.dart';
import 'package:trash_scout/services/firestore_service.dart';
import 'package:trash_scout/shared/theme/theme.dart';
import 'package:trash_scout/shared/widgets/custom_button.dart';
import 'package:trash_scout/shared/widgets/report_history.dart';
import 'package:trash_scout/shared/widgets/report_recap_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final FirestoreService _firestoreService = FirestoreService();
  String? displayName;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    String? name = await _firestoreService.getUserName(user.uid);

    setState(() {
      displayName = name;
    });
  }

  void logoutUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            color: darkGreenColor,
          ),
        );
      },
    );

    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              logoutUser();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                HomeScreenHeader(
                  userDisplayName: displayName,
                ),
                SizedBox(height: 20),
                // Make Report BUtton
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tumpukan sampah ilegal?',
                      style: mediumTextStyle.copyWith(
                        fontSize: 16,
                        color: blackColor,
                      ),
                    ),
                    SizedBox(height: 14),
                    CustomButton(
                      buttonText: 'Buat Laporan',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateReportPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 19),
                ReportRecapHomeScreen(),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Riwayat Laporan',
                      style: boldTextStyle.copyWith(
                        color: blackColor,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeeAllHistoryPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Lihat Semua',
                        style: mediumTextStyle.copyWith(
                          color: blackColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(user.uid)
                      .collection('reports')
                      .orderBy('date', descending: true)
                      .limit(5)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    var reports = snapshot.data!.docs;
                    if (reports.isEmpty) {
                      return Text(
                        'Tidak ada laporan terbaru.',
                        style: regularTextStyle.copyWith(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: reports.length,
                      itemBuilder: (context, index) {
                        var report = reports[index];
                        return ReportHistory(
                          reportTitle: report['title'],
                          status: report['status'],
                          imageUrl: report['imageUrl'],
                          statusBackgroundColor: _getStatusColor(
                            report['status'],
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 90),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Dibuat':
        return darkGreenColor;
      case 'Diproses':
        return lightGreenColor;
      case 'Selesai':
        return Color(0xff6BC2A2);
      default:
        return darkGreyColor;
    }
  }
}

class HomeScreenHeader extends StatelessWidget {
  final String? userDisplayName;

  const HomeScreenHeader({required this.userDisplayName, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/avatar_man.png'),
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo $userDisplayName!',
                  style: semiBoldTextStyle.copyWith(
                    color: blackColor,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Ayo bersihkan Bumi kita!',
                  style: regularTextStyle.copyWith(
                    color: lightGreyColor,
                    fontSize: 15,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: whiteColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationHistoryScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.notifications_none_rounded,
                size: 26,
                color: blackColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ReportRecapHomeScreen extends StatelessWidget {
  const ReportRecapHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Laporan Anda',
          style: boldTextStyle.copyWith(
            color: blackColor,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 9),
        Row(
          children: [
            ReportRecapWidget(
              totalReport: 150,
              reportTitle: 'Dibuat',
              backgroundColor: darkGreenColor,
              iconBackgroundColor: Color(
                0xff3F8377,
              ),
            ),
            SizedBox(width: 6),
            ReportRecapWidget(
              totalReport: 80,
              reportTitle: 'Diproses',
              backgroundColor: lightGreenColor,
              iconBackgroundColor: Color(
                0xff41BB9E,
              ),
            ),
            SizedBox(width: 6),
            ReportRecapWidget(
              totalReport: 21,
              reportTitle: 'Selesai',
              backgroundColor: Color(0xff6BC2A2),
              iconBackgroundColor: Color(
                0xff8CDCBE,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
