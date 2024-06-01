import 'package:flutter/material.dart';
import 'package:trash_scout/screens/detail_report_page.dart';
import 'package:trash_scout/shared/theme/theme.dart';

class ReportHistory extends StatelessWidget {
  const ReportHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: HistoryDate(
            dateTime: 'Hari ini',
          ),
        ),
        ReportHistoryItem(
          reportTitle: 'Depan Rumah Pak RT',
          status: 'Dibuat',
          imageUrl: 'assets/trash_photo_1.png',
          statusBackgroundColor: darkGreenColor,
        ),
        ReportHistoryItem(
          reportTitle: 'Parkiran Mall B',
          status: 'Diproses',
          imageUrl: 'assets/trash_photo_2.png',
          statusBackgroundColor: lightGreenColor,
        ),
        SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: HistoryDate(
            dateTime: '17 Agustus 2017',
          ),
        ),
        ReportHistoryItem(
          reportTitle: 'Sungai Amazon Kotor',
          status: 'Selesai',
          imageUrl: 'assets/trash_photo_3.png',
          statusBackgroundColor: Color(0xff6BC2A2),
        ),
        SizedBox(height: 70),
      ],
    );
  }
}

class HistoryDate extends StatelessWidget {
  final String dateTime;

  const HistoryDate({required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        height: 25,
        decoration: BoxDecoration(
          color: Color(0xffE6E6E6),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        child: Text(
          dateTime,
          style: regularTextStyle.copyWith(
            color: blackColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class ReportHistoryItem extends StatelessWidget {
  final String reportTitle;
  final String status;
  final String imageUrl;
  final Color statusBackgroundColor;

  const ReportHistoryItem({
    required this.reportTitle,
    required this.status,
    required this.imageUrl,
    required this.statusBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      ),
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
                      image: AssetImage(
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
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: statusBackgroundColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          status,
                          style: mediumTextStyle.copyWith(
                            color: whiteColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailReportPage(),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 3.5,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: blackColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Lihat',
                style: mediumTextStyle.copyWith(
                  color: whiteColor,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
