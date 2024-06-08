import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trash_scout/screens/user/detail_report_page.dart';
import 'package:trash_scout/shared/theme/theme.dart';

class ReportItemWidget extends StatelessWidget {
  final String reportTitle;
  final String status;
  final String imageUrl;
  final String date;
  final Color statusBackgroundColor;
  final String reportId;
  final String userId;
  final Function onUpdateStatus;
  final String description;
  final List<String> categories;
  final String latitude;
  final String longitude;
  final String locationDetail;
  final VoidCallback? onTap;

  const ReportItemWidget({
    required this.reportTitle,
    required this.status,
    required this.imageUrl,
    required this.date,
    required this.statusBackgroundColor,
    required this.reportId,
    required this.userId,
    required this.onUpdateStatus,
    required this.description,
    required this.categories,
    required this.latitude,
    required this.longitude,
    required this.locationDetail,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
          () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailReportPage(
                    reportTitle: reportTitle,
                    status: status,
                    imageUrl: imageUrl,
                    date: date,
                    description: description,
                    categories: categories,
                    latitude: latitude,
                    longitude: longitude,
                    locationDetail: locationDetail,
                  ),
                ),
              );
            }
          },
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: 85,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 11,
        ),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.1),
                offset: Offset(0, 1),
                blurRadius: 0.3,
                spreadRadius: 0.0,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 71,
                    height: 62,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          imageUrl,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 11),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reportTitle,
                          style: mediumTextStyle.copyWith(
                            color: blackColor,
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          date,
                          style: regularTextStyle.copyWith(
                            color: blackColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (String newStatus) {
                if (status != 'Selesai') {
                  _updateReportStatus(context, newStatus);
                }
              },
              itemBuilder: (BuildContext context) {
                if (status == 'Selesai') {
                  return [];
                } else {
                  return <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'Diproses',
                      child: Text('Diproses'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'Selesai',
                      child: Text('Selesai'),
                    ),
                  ];
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: statusBackgroundColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: status == 'Selesai'
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                      )
                    : Text(
                        status,
                        style: mediumTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _updateReportStatus(BuildContext context, String newStatus) async {
    // Update status di Firestore
    DocumentReference reportRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('reports')
        .doc(reportId);

    DocumentSnapshot reportSnapshot = await reportRef.get();

    if (reportSnapshot.exists) {
      await reportRef.update({'status': newStatus});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status laporan diperbarui menjadi $newStatus')),
      );
      onUpdateStatus();
    } else {
      print('Report not found: $userId, $reportId');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Report not found')),
      );
    }
    (context as Element).markNeedsBuild();
  }
}
