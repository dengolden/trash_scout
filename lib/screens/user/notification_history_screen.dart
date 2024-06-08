import 'package:flutter/material.dart';
import 'package:trash_scout/shared/theme/theme.dart';

class NotificationHistoryScreen extends StatelessWidget {
  const NotificationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor,
        title: Text(
          'Notifikasi',
          style: semiBoldTextStyle.copyWith(
            color: blackColor,
            fontSize: 26,
          ),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: ListView(
            children: [
              SizedBox(height: 20),
              NotificationHistoryItem(
                reportTitle: 'Tumpukan Sampah Mall B',
                dateTime: '9.30',
                isDone: false,
              ),
              Divider(
                thickness: 0.5,
              ),
              NotificationHistoryItem(
                reportTitle: 'Sungai Neal Kotor',
                dateTime: '21.20',
                isDone: true,
              ),
              Divider(
                thickness: 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationHistoryItem extends StatelessWidget {
  final bool isDone;
  final String reportTitle;
  final String dateTime;

  const NotificationHistoryItem({
    this.isDone = false,
    required this.reportTitle,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/report_notification_icon.png',
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isDone
                      ? 'Laporan anda sudah selesai!'
                      : 'Laporan anda sedang diproses',
                  style: semiBoldTextStyle.copyWith(
                    color: blackColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: reportTitle,
                        style: semiBoldTextStyle.copyWith(
                          color: darkGreyColor,
                          fontSize: 13,
                        ),
                      ),
                      TextSpan(
                        text: isDone
                            ? ' telah berhasil ditangani!'
                            : ' sedang diproses oleh pihak berwajib',
                        style: regularTextStyle.copyWith(
                          color: darkGreyColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            dateTime,
            style: regularTextStyle.copyWith(
              color: darkGreyColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
