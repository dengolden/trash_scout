import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trash_scout/shared/date_formatter.dart';
import 'package:trash_scout/shared/theme/theme.dart';
import 'package:trash_scout/shared/widgets/report_history.dart';

class SeeAllHistoryPage extends StatefulWidget {
  const SeeAllHistoryPage({super.key});

  @override
  State<SeeAllHistoryPage> createState() => _SeeAllHistoryPageState();
}

class _SeeAllHistoryPageState extends State<SeeAllHistoryPage> {
  String _selectedStatus = 'Dibuat';

  void _updateStatus(String status) {
    setState(() {
      _selectedStatus = status;
    });
  }

  Map<String, List<QueryDocumentSnapshot>> _groupReportsByDate(
      List<QueryDocumentSnapshot> reports) {
    Map<String, List<QueryDocumentSnapshot>> groupedReports = {};
    for (var report in reports) {
      DateTime reportDate = (report['date'] as Timestamp).toDate();
      String formattedDate = DateFormatter.formatDate(reportDate);
      if (!groupedReports.containsKey(formattedDate)) {
        groupedReports[formattedDate] = [];
      }
      groupedReports[formattedDate]!.add(report);
    }
    return groupedReports;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor,
        title: Text(
          'Riwayat Laporan',
          style: semiBoldTextStyle.copyWith(
            color: blackColor,
            fontSize: 26,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(6.0), // Tinggi garis
          child: Container(
            color: Color(0xffC7C7C7), // Warna garis
            height: 0.4, // Ketebalan garis
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            SizedBox(height: 16),
            FilterByStatus(
              selectedStatus: _selectedStatus,
              onStatusChanged: _updateStatus,
            ),
            SizedBox(height: 5),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('reports')
                    .where('status', isEqualTo: _selectedStatus)
                    .orderBy('date', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                        child: Text('Belum ada laporan untuk status ini'));
                  }
                  var reports = snapshot.data!.docs;
                  var groupedReports = _groupReportsByDate(reports);
                  return ListView(
                    children: groupedReports.entries.map((entry) {
                      String date = entry.key;
                      List<QueryDocumentSnapshot> reports = entry.value;
                      return Column(
                        children: [
                          HistoryDate(dateTime: date),
                          ...reports.map((report) {
                            return ReportHistory(
                              reportTitle: report['title'],
                              status: report['status'],
                              imageUrl: report['imageUrl'],
                              statusBackgroundColor: _getStatusColor(
                                report['status'],
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
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

class FilterByStatus extends StatefulWidget {
  final String selectedStatus;
  final Function(String) onStatusChanged;

  const FilterByStatus({
    required this.selectedStatus,
    required this.onStatusChanged,
  });

  @override
  State<FilterByStatus> createState() => _FilterByStatusState();
}

class _FilterByStatusState extends State<FilterByStatus> {
  @override
  Widget build(BuildContext context) {
    final List<String> statuses = ['Dibuat', 'Diproses', 'Selesai'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: statuses.map((status) {
        final isSelected = status == widget.selectedStatus;
        final color = isSelected ? lightGreenColor : darkGreyColor;

        return TextButton(
          style: TextButton.styleFrom(
            overlayColor: darkGreenColor,
          ),
          onPressed: () => widget.onStatusChanged(status),
          child: Text(
            status,
            style: mediumTextStyle.copyWith(
              color: color,
              fontSize: 16,
            ),
          ),
        );
      }).toList(),
    );
  }
}
