import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class RincianPesananPage extends StatelessWidget {
  final String layanan;
  final String jenis;
  final double jumlah;
  final double total;
  final String? promoName;
  final double? potongan;

  const RincianPesananPage({
    Key? key,
    required this.layanan,
    required this.jenis,
    required this.jumlah,
    required this.total,
    this.promoName,
    this.potongan,
  }) : super(key: key);

  String formatRupiah(double number) {
    final formatter = NumberFormat('#,###', 'id_ID');
    return formatter.format(number);
  }

  @override
  Widget build(BuildContext context) {
    final isPromoUsed = promoName != null && potongan != null && potongan! > 0;
    final double totalSebelumPromo = isPromoUsed ? total + potongan! : total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Pesanan'),
        backgroundColor: const Color(0xFF0E1446),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TicketWidget(
              width: double.infinity,
              height: isPromoUsed ? 300 : 240,
              isCornerRounded: true,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'RINCIAN PESANAN',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF34495E),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    buildRow('Layanan', layanan),
                    buildRow('Jenis', jenis),
                    buildRow('Jumlah', '${jumlah.toStringAsFixed(1)} ${layanan == 'Cuci Karpet' ? 'm²' : 'kg'}'),
                    if (isPromoUsed) ...[
                      buildRow('Total Sebelum Promo', 'Rp ${formatRupiah(totalSebelumPromo)}'),
                      buildRow('Promo "$promoName"', '- Rp ${formatRupiah(potongan!)}'),
                    ],
                    buildRow('Total Bayar', 'Rp ${formatRupiah(total)}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Metode Pembayaran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: const [
                  Icon(Icons.radio_button_checked),
                  SizedBox(width: 8),
                  Icon(Icons.account_balance_wallet),
                  SizedBox(width: 8),
                  Text('Bayar di Tempat'),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  AnimatedSnackBar.material(
                    'Pesanan dibatalkan.',
                    type: AnimatedSnackBarType.error,
                    duration: const Duration(seconds: 2),
                  ).show(context);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Batalkan Pesanan',
                  style: TextStyle(fontSize: 16, color: Colors.redAccent),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  AnimatedSnackBar.material(
                    'Pembayaran berhasil!',
                    type: AnimatedSnackBarType.success,
                    duration: const Duration(seconds: 2),
                  ).show(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF1C40F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Bayar Sekarang',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 16)),
            Flexible(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
