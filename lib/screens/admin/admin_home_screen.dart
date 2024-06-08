import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trash_scout/screens/auth/login_screen.dart';
import 'package:trash_scout/services/firestore_service.dart';
import 'package:trash_scout/shared/theme/theme.dart';
import 'package:trash_scout/shared/widgets/admin/admin_recap_widget.dart';
import 'package:trash_scout/shared/widgets/admin/map_status.dart';
import 'package:trash_scout/shared/widgets/admin/report_item_widget.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminHomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final FirestoreService _firestoreService = FirestoreService();
  String? displayName;

  int totalPending = 0;
  int totalInProcess = 0;
  int totalCompleted = 0;
  int totalReport = 0;
  List<Map<String, dynamic>> latestReports = [];

  @override
  void initState() {
    _getUserData();
    _getReportStats();
    _getLatestReports();
    super.initState();
  }

  Future<void> _getUserData() async {
    String? name = await _firestoreService.getUserName(user.uid);

    setState(() {
      displayName = name;
    });
  }

  Future<void> _getReportStats() async {
    try {
      QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      int reportCount = 0;
      int inProcessCount = 0;
      int completedCount = 0;
      int pendingCount = 0;

      for (var userDoc in usersSnapshot.docs) {
        QuerySnapshot reportsSnapshot =
            await userDoc.reference.collection('reports').get();

        for (var reportDoc in reportsSnapshot.docs) {
          String status = reportDoc['status'];
          reportCount++;
          if (status == 'Diproses') {
            inProcessCount++;
          } else if (status == 'Selesai') {
            completedCount++;
          } else if (status == 'Dibuat') {
            pendingCount++;
          }
        }
      }

      setState(() {
        totalPending = pendingCount;
        totalInProcess = inProcessCount;
        totalCompleted = completedCount;
        totalReport = reportCount;
      });
    } catch (e) {
      print('Error mendapatkan statistik laporan: $e');
    }
  }

  Future<void> _getLatestReports() async {
    try {
      QuerySnapshot usersSnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      List<Map<String, dynamic>> allReports = [];

      for (var userDoc in usersSnapshot.docs) {
        QuerySnapshot reportsSnapshot =
            await userDoc.reference.collection('reports').get();

        for (var reportDoc in reportsSnapshot.docs) {
          Map<String, dynamic> reportData =
              reportDoc.data() as Map<String, dynamic>;
          reportData['date'] = (reportData['date'] as Timestamp).toDate();
          reportData['userId'] = userDoc.id;
          reportData['reportId'] = reportDoc.id;
          allReports.add(reportData);
        }
      }

      allReports.sort((a, b) => b['date'].compareTo(a['date']));

      setState(() {
        latestReports = allReports.take(5).toList();
      });
    } catch (e) {
      print('Error mendapatkan laporan terbaru: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              logoutUser();
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdminHeader(userDisplayName: displayName),
                SizedBox(height: 20),
                ReportRecapAdmin(
                  totalPending: totalPending,
                  totalInProcess: totalInProcess,
                  totalCompleted: totalCompleted,
                  totalReport: totalReport,
                ),
                SizedBox(height: 15),
                Text(
                  'Laporan Terbaru:',
                  style: boldTextStyle.copyWith(
                    color: blackColor,
                    fontSize: 20,
                  ),
                ),
                for (var report in latestReports)
                  ReportItemWidget(
                    reportTitle: report['title'],
                    status: mapStatus(report['status']),
                    statusBackgroundColor: _getStatusColor(
                      report['status'],
                    ),
                    imageUrl: report['imageUrl'],
                    date: DateFormat('dd MMMM yyyy').format(report['date']),
                    userId: report['userId'],
                    reportId: report['reportId'],
                    onUpdateStatus: _getLatestReports,
                    description: report['description'],
                    categories: List<String>.from(report['categories']),
                    latitude: report['latitude'],
                    longitude: report['longitude'],
                    locationDetail: report['locationDetail'],
                  ),
                SizedBox(height: 100),
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

class AdminHeader extends StatelessWidget {
  final String? userDisplayName;

  const AdminHeader({required this.userDisplayName, super.key});

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
              onPressed: () {},
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

class ReportRecapAdmin extends StatelessWidget {
  final int totalPending;
  final int totalInProcess;
  final int totalCompleted;
  final int totalReport;

  const ReportRecapAdmin({
    required this.totalPending,
    required this.totalInProcess,
    required this.totalCompleted,
    required this.totalReport,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rekap Laporan:',
          style: boldTextStyle.copyWith(
            color: blackColor,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 9),
        Row(
          children: [
            AdminRecapWidget(
              totalReport: totalPending,
              reportTitle: 'Pending',
              backgroundColor: darkGreenColor,
              iconBackgroundColor: Color(0xff3F8377),
            ),
            SizedBox(width: 6),
            AdminRecapWidget(
              totalReport: totalInProcess,
              reportTitle: 'Diproses',
              backgroundColor: lightGreenColor,
              iconBackgroundColor: Color(0xff41BB9E),
            ),
            SizedBox(width: 6),
            AdminRecapWidget(
              totalReport: totalCompleted,
              reportTitle: 'Selesai',
              backgroundColor: Color(0xff6BC2A2),
              iconBackgroundColor: Color(0xff8CDCBE),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          width: double.infinity,
          height: 85,
          padding: EdgeInsets.only(
            right: 12,
          ),
          decoration: BoxDecoration(
            color: darkGreenColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Text(
                totalReport.toString(),
                style: boldTextStyle.copyWith(
                  color: whiteColor,
                  fontSize: 40,
                ),
              ),
              Text(
                'Total Laporan Diterima',
                style: regularTextStyle.copyWith(
                  color: whiteColor,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
