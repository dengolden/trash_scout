import 'package:flutter/material.dart';
import 'package:trash_scout/shared/theme/theme.dart';
import 'package:trash_scout/shared/widgets/report_history.dart';

class SeeAllHistoryPage extends StatelessWidget {
  const SeeAllHistoryPage({super.key});

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
            FilterByStatus(),
            SizedBox(height: 5),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  ReportHistory(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilterByStatus extends StatelessWidget {
  const FilterByStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Dibuat',
          style: regularTextStyle.copyWith(
            color: darkGreyColor,
            fontSize: 16,
          ),
        ),
        Text(
          'Diproses',
          style: semiBoldTextStyle.copyWith(
            color: lightGreenColor,
            fontSize: 16,
          ),
        ),
        Text(
          'Selesai',
          style: regularTextStyle.copyWith(
            color: darkGreyColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
