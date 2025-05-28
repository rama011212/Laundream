import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:laundream/presentation/home/pesan_laundry.dart';
import 'package:laundream/presentation/home/profil_page.dart';
import 'package:laundream/presentation/home/profil_usaha.dart';
import 'package:laundream/presentation/home/status_pesanan.dart';
import 'package:laundream/presentation/home/riwayat_pesanan.dart';
import 'package:laundream/presentation/home/voucher_saya.dart';
import 'package:laundream/presentation/home/promo_notification.dart';
import 'package:laundream/presentation/admin/home.dart';

class HomeUser extends StatefulWidget {
  @override
  _HomeUserState createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    StatusPesananBaru(),
    ProfilUsahaPage(),
    ProfilePage(),
    HomeAdmin(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF0E1446),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: GNav(
            gap: 6,
            activeColor: const Color(0xFFFFD130),
            color: Colors.white,
            iconSize: 22,
            tabBorderRadius: 200,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            tabBackgroundColor: Colors.yellow.withOpacity(0.15),
            duration: const Duration(milliseconds: 250),
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
                textSize: 12,
                onPressed: () => _onTabSelected(0),
              ),
              GButton(
                icon: LineIcons.box,
                text: 'Pesanan',
                textSize: 12,
                onPressed: () => _onTabSelected(1),
              ),
              GButton(
                icon: LineIcons.store,
                leading: Image.asset(
                  'images/outlet.png',
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
                text: 'Outlet',
                textSize: 12,
                onPressed: () => _onTabSelected(2),
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profil',
                textSize: 12,
                onPressed: () => _onTabSelected(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  final bool _hasActiveOrder = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Halo,',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    'Rama Anandya Putra',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF0E1446),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: IconButton(
                  icon: Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                     PromoNotificationService.showPromoNotification();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_hasActiveOrder)
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.notifications_active, color: Colors.orange),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Pesanan kamu sedang diproses!',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'images/banner_promo.png',
              fit: BoxFit.cover,
              height: 210,
              width: double.infinity,
            ),
          ),
          const SizedBox(height: 0),
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildMenuTile(
                title: 'Pesan Laundry',
                icon: Icons.shopping_bag_outlined,
                context: context,
                destination: const PesanLaundryPage(),
              ),
              _buildMenuTile(
                title: 'Status Pesanan',
                icon: Icons.local_laundry_service,
                context: context,
                destination: StatusPesananBaru(),
              ),
              _buildMenuTile(
                title: 'Riwayat Pesanan',
                icon: Icons.history,
                context: context,
                destination: RiwayatPesananPage(),
              ),
              _buildMenuTile(
                title: 'Voucher Saya',
                icon: Icons.card_giftcard,
                context: context,
                destination: VoucherSayaPage(),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required String title,
    required IconData icon,
    required BuildContext context,
    required Widget destination,
  }) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => destination),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: const Color(0xFF0E1446)),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
