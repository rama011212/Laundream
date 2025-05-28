import 'package:flutter/material.dart';

class DialogHapusPesanan extends StatelessWidget {
  const DialogHapusPesanan({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Hapus Pesanan'),
      content: const Text('Yakin ingin menghapus pesanan ini?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false), // Mengembalikan false jika dibatalkan
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true), // Mengembalikan true jika dihapus
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: const Text('Hapus', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}