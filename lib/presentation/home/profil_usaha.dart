import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilUsahaPage extends StatelessWidget {
  const ProfilUsahaPage({super.key});

  void _launchWhatsApp() async {
    final Uri url = Uri.parse(
        'https://wa.me/62895360476161?text=Halo%20Laristy%20Laundry,%20saya%20butuh%20bantuan.');

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Tidak dapat membuka WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1446),
        title: const Text('Profil Outlet'),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Logo dan Nama Usaha
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'images/profil_outlet.png',
                    width: 200,
                    height: 200,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Info Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: const [
                  InfoCard(
                    icon: Icons.location_on_outlined,
                    title: 'Alamat',
                    content: 'Jl. Halmahera No. 99, Tegal',
                  ),
                  InfoCard(
                    icon: Icons.calendar_today_outlined,
                    title: 'Senin – Minggu',
                    content: '08:00 – 21:00',
                  ),
                  InfoCard(
                    icon: Icons.phone_outlined,
                    title: '',
                    content: '0895-3604-76161',
                  ),
                  InfoCard(
                    icon: Icons.info_outline,
                    title: 'Tentang Usaha',
                    content:
                        'Laristy Laundry hadir dengan pelayanan profesional dan hasil cucian yang terjamin bersih maksimal. Kami menggunakan peralatan modern dan bahan pembersih berkualitas tinggi untuk memastikan setiap pakaian kembali segar, wangi, dan rapi seperti baru.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Butuh Bantuan?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ElevatedButton.icon(
                onPressed: _launchWhatsApp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E82D3),
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                icon: const Icon(Icons.chat, color: Colors.white),
                label: const Text(
                  'Butuh bantuan?',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Color(0xFF0E82D3)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title.isNotEmpty)
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                if (title.isNotEmpty) const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
