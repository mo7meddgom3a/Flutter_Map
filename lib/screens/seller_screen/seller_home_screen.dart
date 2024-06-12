import 'package:flutter/material.dart';

import 'info_screen/info_screen.dart';

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF3F7FF),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0 , horizontal: 16.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            children: [
              _buildGridItem('إضافة العروض' , () {
                Navigator.of(context).pushNamed('/add_promotion');
              }),
              _buildGridItem('بياناتي', () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoScreen()));
              }),
              _buildGridItem('الإعلانات', () {
                Navigator.of(context).pushNamed('/seller_ads');
              }),
              _buildGridItem('المتجر الإلكتروني', () {
                Navigator.of(context).pushNamed('/seller_store');
              }),
              _buildGridItem('إعدادات', () {
                Navigator.of(context).pushNamed('/seller_settings');
              },),
              _buildGridItem('عملائي',(){
                Navigator.of(context).pushNamed('/seller_clients');
              }),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildGridItem(String title , void Function()? onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 18.0, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}