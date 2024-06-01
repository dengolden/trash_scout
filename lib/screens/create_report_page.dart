import 'package:flutter/material.dart';
import 'package:trash_scout/shared/theme/theme.dart';
import 'package:trash_scout/shared/widgets/custom_button.dart';
import 'package:trash_scout/shared/widgets/trash_category.dart';

class CreateReportPage extends StatefulWidget {
  const CreateReportPage({super.key});

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor,
        title: Text(
          'Buat Laporan',
          style: semiBoldTextStyle.copyWith(
            color: blackColor,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReportTitleForm(),
              TrashCategory(),
              ReportDescForm(),
              UploadPhoto(),
              SelectLocation(),
              SizedBox(height: 30),
              CustomButton(buttonText: 'Kirim Laporan', onPressed: () {}),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class ReportTitleForm extends StatelessWidget {
  const ReportTitleForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Judul',
          style: mediumTextStyle.copyWith(
            color: blackColor,
            fontSize: 18,
          ),
        ),
        TextFormField(
          style: mediumTextStyle.copyWith(
            color: blackColor,
            fontSize: 24,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Masukan Judul Laporan',
            hintStyle: regularTextStyle.copyWith(
              color: lightGreyColor,
            ),
          ),
          cursorColor: lightGreenColor,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 3,
        ),
        Divider(),
      ],
    );
  }
}

class TrashCategory extends StatelessWidget {
  const TrashCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Kategori Sampah',
            style: mediumTextStyle.copyWith(
              color: blackColor,
              fontSize: 18,
            ),
          ),
          Text(
            'Pilih kategori sampah yang dilaporkan',
            style: regularTextStyle.copyWith(
              color: darkGreyColor,
              fontSize: 13,
            ),
          ),
          Wrap(
            spacing: 6.0,
            runSpacing: 3.0,
            alignment: WrapAlignment.start,
            children: [
              TrashCategoryItem(title: 'Organik'),
              TrashCategoryItem(title: 'Plastik'),
              TrashCategoryItem(title: 'Kertas & Karton'),
              TrashCategoryItem(title: 'Logam'),
              TrashCategoryItem(title: 'Kaca'),
              TrashCategoryItem(title: 'Elektronik'),
              TrashCategoryItem(title: 'Berbahaya'),
            ],
          ),
        ],
      ),
    );
  }
}

class ReportDescForm extends StatelessWidget {
  const ReportDescForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deskripsi',
            style: mediumTextStyle.copyWith(
              color: blackColor,
              fontSize: 18,
            ),
          ),
          TextFormField(
            style: regularTextStyle.copyWith(
              color: darkGreyColor,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Masukan Deskripsi (Opsional)',
              hintStyle: regularTextStyle.copyWith(
                color: darkGreyColor,
              ),
            ),
            cursorColor: lightGreenColor,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: null,
            maxLength: 300,
          ),
          Divider(),
        ],
      ),
    );
  }
}

class UploadPhoto extends StatelessWidget {
  const UploadPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Masukan Foto',
            style: mediumTextStyle.copyWith(
              color: blackColor,
              fontSize: 18,
            ),
          ),
          Text(
            'Wajib memasukan foto!',
            style: regularTextStyle.copyWith(
              color: darkGreyColor,
              fontSize: 13,
            ),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 227,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: lightGreyColor,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IntrinsicWidth(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 28,
                      ),
                      decoration: BoxDecoration(
                        color: darkGreenColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Buka Kamera',
                          style: mediumTextStyle.copyWith(
                            color: whiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 6),
                  IntrinsicWidth(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 28,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: darkGreenColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Pilih di Galeri',
                          style: mediumTextStyle.copyWith(
                            color: darkGreenColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectLocation extends StatelessWidget {
  const SelectLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pilih Lokasi',
            style: mediumTextStyle.copyWith(
              color: blackColor,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 10),
          CustomButton(
            buttonText: 'Ambil Lokasi',
            onPressed: () {},
          ),
          SizedBox(height: 10),
          Text(
            'Patokan lokasi (Opsional)',
            style: mediumTextStyle.copyWith(
              color: darkGreyColor,
            ),
          ),
          Text(
            'Patokan untuk mempemudah Petugas',
            style: regularTextStyle.copyWith(
              color: darkGreyColor,
              fontSize: 12,
            ),
          ),
          TextFormField(
            style: regularTextStyle.copyWith(
              color: darkGreyColor,
              fontSize: 13,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(16),
              prefixIcon: Icon(
                Icons.location_city_outlined,
                size: 24,
                color: darkGreyColor,
              ),
              border: InputBorder.none,
              hintText: 'Masukan Patokan Lokasi',
              hintStyle: regularTextStyle.copyWith(
                color: darkGreyColor,
              ),
            ),
            cursorColor: lightGreenColor,
            minLines: 1,
            maxLines: null,
          ),
          Divider(
            height: 0.5,
          ),
        ],
      ),
    );
  }
}
