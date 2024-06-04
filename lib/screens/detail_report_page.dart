import 'package:flutter/material.dart';
import 'package:trash_scout/shared/theme/theme.dart';
import 'package:trash_scout/shared/widgets/custom_button.dart';

class DetailReportPage extends StatelessWidget {
  const DetailReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/detail_image.png',
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 335),
              padding: EdgeInsets.only(
                top: 26,
                left: 16,
                right: 16,
                bottom: 55,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: ReportDetailContent(),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 16,
                top: 60,
              ),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportDetailContent extends StatelessWidget {
  const ReportDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tumpukan Sampah di Sungai Nil Amazon Selatan',
          style: semiBoldTextStyle.copyWith(
            color: blackColor,
            fontSize: 24,
          ),
        ),
        SizedBox(height: 10),
        Text(
          '12 Mei 2024',
          style: regularTextStyle.copyWith(
            fontSize: 16,
            color: darkGreyColor,
          ),
        ),
        SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: [],
        ),
        SizedBox(height: 16),
        Text(
          'Deskripsi',
          style: semiBoldTextStyle.copyWith(
            color: blackColor,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 9),
        Text(
          'Sampah di Sungai Nil Amazon Selatan Blok G Papua Nugini berceceran di sungai disebabkan oleh para OPM (Organisasi Pace Minecraft) berbuat ulah.',
          style: regularTextStyle.copyWith(
            color: darkGreyColor,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Lihat Lokasi',
          style: semiBoldTextStyle.copyWith(
            color: blackColor,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 9),
        Text(
          'Klik disini untuk melihat lokasi',
          style: regularTextStyle.copyWith(
            color: darkGreyColor,
          ),
        ),
        SizedBox(height: 9),
        CustomButton(
          buttonText: 'Lihat Lokasi',
          onPressed: () {},
        ),
        SizedBox(height: 12),
        Text(
          'Patokan lokasi',
          style: mediumTextStyle.copyWith(
            color: darkGreyColor,
            fontSize: 16,
          ),
        ),
        Text(
          'Sebelah Gedung Kerajaan Kesultanan Clan Waker cik.',
          style: regularTextStyle.copyWith(
            color: darkGreyColor,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
