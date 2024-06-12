import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F7FF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                const Spacer(
                  flex: 9,
                ),
                _buildSectionTitle('بياناتي'),
                const Spacer(
                  flex: 7,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  height: 32,
                  width: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    'assets/icon_images/Arrow - Left 2.svg',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Anwar Supermarket',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(width: 20),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _customButton("اضافة", "assets/icon_images/basil_add-solid.svg"),
                _customButton("حذف", "assets/icon_images/fluent_delete-48-regular.svg"),
                _customButton("معاينة", "assets/icon_images/lets-icons_search.svg"),
              ],
            ),
            const SizedBox(height: 20),
            TextFormField(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                hintStyle:  const TextStyle(fontSize: 16 ),
                hintTextDirection: TextDirection.rtl,
                label: const Text('من نحن' ,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildStoreDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(label: 'Anwar Supermarket'),
        _buildTextField(label: 'الفئات'),
        _buildTextField(label: 'نوع المتجر'),
        _buildTextField(label: 'الموقع'),
        _buildTextField(label: 'العنوان'),
        _buildTextField(label: 'الموقع الالكتروني'),
        _buildTextField(label: 'البريد الالكتروني'),
        _buildTextField(label: 'رقم الهاتف'),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.whatshot),
            Icon(Icons.facebook),
            Icon(Icons.facebook),
            Icon(Icons.facebook),
            Icon(Icons.snapchat),
          ],
        ),
      ],
    );
  }

  Widget _customButton(String text, String icon) {
    return Row(
      children: [
        Text(text),
        const SizedBox(width: 8),
        SvgPicture.asset(
          icon,
        ),
      ],
    );
  }

  Widget _buildBranchFields() {
    return Row(
      children: [
        Expanded(child: _buildTextField(label: 'الدولة')),
        SizedBox(width: 8),
        Expanded(child: _buildTextField(label: 'المدينة')),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildStoreProducts() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildProductField(label: 'عدد المشاركات')),
            Expanded(child: _buildProductField(label: 'عدد المشاهدات')),
            Expanded(child: _buildProductField(label: 'عدد المتابعين')),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({required String label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildProductField({required String label}) {
    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          color: Colors.grey[200],
          child: Center(child: Text('Image Placeholder')),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
