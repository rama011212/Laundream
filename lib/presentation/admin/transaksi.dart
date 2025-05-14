import 'package:flutter/material.dart';

class TransaksiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Transaksi'),
      ),
      body: ListView.builder(
        itemCount: 10, // Ganti dengan jumlah transaksi yang sebenarnya
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.monetization_on),
            title: Text('Transaksi ${index + 1}'),
            subtitle: Text('Detail transaksi'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Tambahkan logika untuk menavigasi ke detail transaksi
            },
          );
        },
      ),
    );
  }
}
