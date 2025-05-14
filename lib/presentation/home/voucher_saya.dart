import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:dotted_line/dotted_line.dart';

class VoucherSayaPage extends StatelessWidget {
  final List<Map<String, dynamic>> vouchers = [
    {
      'discount': 'Diskon 10%',
      'description': 'Min. pembelian Rp100.000',
      'expiry': 'Berlaku sampai 30 Desember 2025',
      'quantity': 2,
    },
    {
      'discount': 'Diskon 20%',
      'description': 'Min. pembelian Rp20.000',
      'expiry': 'Berlaku sampai 31 Mei 2025',
      'quantity': 1,
    },
    {
      'discount': 'Diskon 15%',
      'description': 'Min. pembelian Rp50.000',
      'expiry': 'Berlaku sampai 25 Mei 2025',
      'quantity': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Voucher Saya'),
        backgroundColor: const Color(0xFF0E1446),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          itemCount: vouchers.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final voucher = vouchers[index];

            return TicketWidget(
              width: double.infinity,
              height: 100,
              isCornerRounded: false,
              padding: const EdgeInsets.all(6),
              color: Colors.redAccent, // Warna tiket
              child: Row(
                children: [
                  // Kiri: Isi voucher
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          voucher['discount'],
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          voucher['description'],
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          voucher['expiry'],
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Garis potong-putus penuh (Expanded)
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: DottedLine(
                        direction: Axis.vertical,
                        dashLength: 4,
                        dashGapLength: 2,
                        dashColor: Colors.grey.shade300,
                        lineThickness: 1,
                      ),
                    ),
                  ),

                  // Kanan: Jumlah voucher
                  // Kanan: Jumlah voucher di tengah
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'X${voucher['quantity']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
