import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:laundryku/presentation/admin/diskon.dart';
import 'package:laundryku/presentation/admin/laporan.dart';
import 'package:line_icons/line_icons.dart';
import 'package:laundryku/presentation/admin/layanan.dart';
import 'package:laundryku/presentation/admin/pelanggan.dart';
import 'package:laundryku/presentation/admin/pesanan.dart';
import 'package:laundryku/presentation/admin/transaksi.dart';

class HomeAdmin extends StatefulWidget {
  @override
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    HomeContent(),
    DiskonPage(),
    LaporanPage(),
    // LaporanPage(),
    // AkunPage(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Color(0xFF0E1446), boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: GNav(
              rippleColor: Colors.grey[800]!,
              hoverColor: Colors.grey[700]!,
              gap: 8,
              activeColor: Color(0xFFFFD130),
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              duration: Duration(milliseconds: 300),
              tabBackgroundColor: Colors.yellow.withOpacity(0.1),
              color: Colors.white,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  onPressed: () => _onTabSelected(0),
                ),
                GButton(
                  icon: LineIcons.tag,
                  text: 'Diskon',
                  onPressed: () => _onTabSelected(1),
                ),
                GButton(
                  icon: LineIcons.barChart,
                  text: 'Laporan',
                  onPressed: () => _onTabSelected(2),
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Akun',
                  onPressed: () => _onTabSelected(3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang,',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Admin',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  color: Color(0xFF0E1446), // Dark blue color
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: IconButton(
                  icon: Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pendapatan Hari Ini',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(Icons.arrow_downward, color: Colors.green, size: 18),
                        SizedBox(width: 5),
                        Text(
                          'Rp 0',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pengeluaran Hari Ini',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(Icons.arrow_upward, color: Colors.red, size: 18),
                        SizedBox(width: 5),
                        Text(
                          'Rp 0',
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.refresh, color: Colors.orange),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Manajemen Layanan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 40,
              mainAxisSpacing: 40,
              children: [
                _buildFeatureTile('Pesanan', Icons.list_alt_outlined, context, OrdersScreen()),
                _buildFeatureTile('Pelanggan', Icons.person, context, PelangganPage()),
                _buildFeatureTile('Layanan', Icons.local_laundry_service, context, LayananPage()),
                _buildFeatureTile('Transaksi', Icons.monetization_on, context, TransaksiPage()),
                // Hapus bagian Promosi
                // _buildFeatureTile('Promosi', Icons.card_giftcard, context, PromosiPage()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureTile(String title, IconData icon, BuildContext context, Widget destination) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color:Color(0xFF0E1446)),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
