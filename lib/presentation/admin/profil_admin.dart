import 'package:flutter/material.dart';

class ProfilAdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      appBar: AppBar(
        backgroundColor: Color(0xFF0E1446),
        title: Text('Profil Admin', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 60, color: Colors.white),
            ),
            SizedBox(height: 20),
            buildInfoTile('Nama', 'Admin Laundry'),
            buildInfoTile('Email', 'laristylaundry@gmail.com'),
            buildInfoTile('Nomor Telepon', '081234567890'),
            buildInfoTile('Level Pengguna', 'Admin'),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // logika logout
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: Icon(Icons.logout),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoTile(String label, String value) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: '$label:\n',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
