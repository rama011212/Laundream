import 'package:flutter/material.dart';
import 'package:laundream/presentation/admin/utilitas/pembantu_aplikasi.dart';
import 'package:laundream/presentation/admin/utilitas/konstanta_aplikasi.dart';

class DialogEditPesanan extends StatefulWidget {
  const DialogEditPesanan({super.key, required this.pesanan});

  final Map<String, dynamic> pesanan;

  @override
  State<DialogEditPesanan> createState() => _DialogEditPesananState();
}

class _DialogEditPesananState extends State<DialogEditPesanan> {
  late TextEditingController _kontrolBerat;
  late String _satuan;
  late String _layananTerpilih;
  late String _jenisTerpilih;
  late String? _promoTerpilih;

  int _hargaDasarPerSatuan = 0;
  int _hargaFinal = 0;
  double? _potonganPersenSaatIni;
  int? _potonganNominalSaatIni;

  @override
  void initState() {
    super.initState();
    _satuan = PembantuAplikasi.dapatkanSatuan(widget.pesanan['jenis'] ?? '');
    _kontrolBerat = TextEditingController(
      text: RegExp(r'\d+(\.\d+)?').stringMatch(widget.pesanan['beratLuas'] ?? '') ?? '',
    );

    _layananTerpilih = KonstantaAplikasi.dataLayanan.firstWhere(
      (layananData) => layananData['jenis'].any((jenis) => jenis['nama'] == widget.pesanan['layanan'] && layananData['title'] == widget.pesanan['jenis']),
      orElse: () => {'title': 'Cuci Setrika'},
    )['title'] as String;

    _jenisTerpilih = widget.pesanan['layanan'] as String;

    _promoTerpilih = widget.pesanan['promoDigunakan'] as String?;
    _potonganPersenSaatIni = widget.pesanan['potonganPersen'] as double?;
    _potonganNominalSaatIni = widget.pesanan['potonganNominal'] as int?;

    _hitungUlangHarga();
  }

  @override
  void dispose() {
    _kontrolBerat.dispose();
    super.dispose();
  }

  void _hitungUlangHarga() {
    setState(() {
      final double jumlahSatuan = double.tryParse(_kontrolBerat.text) ?? 0.0;
      _hargaDasarPerSatuan = PembantuAplikasi.dapatkanHargaPerSatuan(_jenisTerpilih, _layananTerpilih);

      final Map<String, dynamic>? detailPromo = PembantuAplikasi.dapatkanDetailPromo(_promoTerpilih);
      _potonganPersenSaatIni = null;
      _potonganNominalSaatIni = null;

      if (detailPromo != null && detailPromo.isNotEmpty) {
        if (detailPromo['tipe'] == 'persentase') {
          _potonganPersenSaatIni = detailPromo['nilai'] as double;
        } else if (detailPromo['tipe'] == 'nominal') {
          _potonganNominalSaatIni = detailPromo['nilai'] as int;
        }
      }

      _hargaFinal = PembantuAplikasi.hitungHargaAkhir(
        _hargaDasarPerSatuan,
        jumlahSatuan,
        _potonganPersenSaatIni,
        _potonganNominalSaatIni,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Pesanan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F265E),
                ),
              ),
              const SizedBox(height: 24),

              Text('Layanan Utama', style: TextStyle(color: Colors.grey[700], fontSize: 14)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _layananTerpilih,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                items: KonstantaAplikasi.dataLayanan.map((layanan) {
                  return DropdownMenuItem(
                    value: layanan['title'] as String,
                    child: Text(layanan['title'] as String),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _layananTerpilih = newValue!;
                    _jenisTerpilih = (KonstantaAplikasi.dataLayanan.firstWhere((l) => l['title'] == _layananTerpilih)['jenis'] as List<Map<String, dynamic>>).first['nama'] as String;
                    _satuan = PembantuAplikasi.dapatkanSatuan(_layananTerpilih);
                    _hitungUlangHarga();
                  });
                },
              ),
              const SizedBox(height: 18),

              Text('Jenis Layanan', style: TextStyle(color: Colors.grey[700], fontSize: 14)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _jenisTerpilih,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                items: (KonstantaAplikasi.dataLayanan.firstWhere((l) => l['title'] == _layananTerpilih)['jenis'] as List<Map<String, dynamic>>).map((jenis) {
                  return DropdownMenuItem(
                    value: jenis['nama'] as String,
                    child: Text(jenis['nama'] as String),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _jenisTerpilih = newValue!;
                    _hitungUlangHarga();
                  });
                },
              ),
              const SizedBox(height: 18),

              Text('Berat / Luas', style: TextStyle(color: Colors.grey[700], fontSize: 14)),
              const SizedBox(height: 6),
              TextField(
                controller: _kontrolBerat,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.monitor_weight_outlined),
                  suffixText: _satuan,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                onChanged: (value) => _hitungUlangHarga(),
              ),
              const SizedBox(height: 18),

              Text('Promo', style: TextStyle(color: Colors.grey[700], fontSize: 14)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _promoTerpilih ?? 'Tanpa Promo',
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                items: KonstantaAplikasi.dataPromo.map((promo) {
                  return DropdownMenuItem(
                    value: promo['nama'] as String,
                    child: Text(promo['nama'] as String),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _promoTerpilih = newValue;
                    _hitungUlangHarga();
                  });
                },
              ),
              const SizedBox(height: 18),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Harga Final: Rp ${PembantuAplikasi.formatMataUang(_hargaFinal)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const Divider(height: 1),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF1F265E),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text('Batal'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.save, size: 18, color: Colors.white),
                      label: const Text('Simpan', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        setState(() {
                          final double jumlahSatuan = double.tryParse(_kontrolBerat.text) ?? 0.0;
                          widget.pesanan['beratLuas'] = '${jumlahSatuan.toStringAsFixed(jumlahSatuan.truncateToDouble() == jumlahSatuan ? 0 : 2)} $_satuan';
                          widget.pesanan['layanan'] = _jenisTerpilih;
                          widget.pesanan['jenis'] = _layananTerpilih;
                          widget.pesanan['harga'] = _hargaFinal;
                          widget.pesanan['promoDigunakan'] = _promoTerpilih;
                          widget.pesanan['potonganPersen'] = _potonganPersenSaatIni;
                          widget.pesanan['potonganNominal'] = _potonganNominalSaatIni;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pesanan berhasil diubah.')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F265E),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}