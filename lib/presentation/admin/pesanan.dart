import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> with TickerProviderStateMixin {
  final List<Map<String, dynamic>> orders = [
    {
      'id': '1',
      'customer': 'Rama Anandya Putra',
      'service': 'Cuci & Setrika',
      'status': 'Diproses',
      'package': 'Ekspres',
      'price': 25000.0,
      'orderDate': DateTime(2024, 5, 20, 15, 9),
      'completionDate': DateTime(2024, 5, 20, 21, 9), // 6 hours after orderDate
      'paymentStatus': 'Belum Bayar',
      'quantity': 0.0,
      'discount': 0.0,
    },
    {
      'id': '2',
      'customer': 'Putra Wijaya',
      'service': 'Cuci Saja',
      'status': 'Siap Ambil',
      'package': 'Reguler',
      'price': 20000.0,
      'orderDate': DateTime(2024, 5, 21, 14, 30),
      'completionDate': DateTime(2024, 5, 24, 14, 30), // 3 days after orderDate
      'paymentStatus': 'Lunas',
      'quantity': 0.0,
      'discount': 0.0,
    },
    {
      'id': '3',
      'customer': 'Robert Brown',
      'service': 'Setrika Saja',
      'status': 'Diterima',
      'package': 'Kilat',
      'price': 15000.0,
      'orderDate': DateTime(2024, 5, 22, 16, 0),
      'completionDate': DateTime(2024, 5, 23, 16, 0), // 1 day after orderDate
      'paymentStatus': 'Belum Bayar',
      'quantity': 0.0,
      'discount': 0.0,
    },
    {
      'id': '4',
      'customer': 'Ahmad Bustomi',
      'service': 'Cuci Saja',
      'status': 'Belum Diterima',
      'package': 'Reguler',
      'price': 20000.0,
      'orderDate': null,
      'completionDate': null,
      'paymentStatus': 'Belum Bayar',
      'quantity': 0.0,
      'discount': 0.0,
    },
  ];

  String searchQuery = '';

  late TabController _tabController;
  late TabController _packageTabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _packageTabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _packageTabController.dispose();
    super.dispose();
  }

  void _editOrderStatus(BuildContext context, Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) {
        String? status = order['status'];
        return AlertDialog(
          title: Text('Edit Status Pesanan'),
          content: DropdownButton<String>(
            value: status,
            items: ['Belum Diterima', 'Diterima', 'Diproses', 'Siap Ambil', 'Selesai']
                .map((status) => DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                if (value == 'Diterima') {
                  _showQuantityDialog(context, order);
                }
                status = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (status != null) {
                    order['status'] = status;
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showQuantityDialog(BuildContext context, Map<String, dynamic> order) {
    TextEditingController quantityController = TextEditingController();
    TextEditingController discountController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Masukkan Detail Layanan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Jumlah (Kiloan, Satuan, atau Meteran)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: discountController,
                decoration: InputDecoration(labelText: 'Diskon'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  order['quantity'] = double.tryParse(quantityController.text) ?? 0.0;
                  order['discount'] = double.tryParse(discountController.text) ?? 0.0;
                  order['orderDate'] = DateTime.now();
                  if (order['package'] == 'Reguler') {
                    order['completionDate'] = order['orderDate']!.add(Duration(days: 3));
                  } else if (order['package'] == 'Kilat') {
                    order['completionDate'] = order['orderDate']!.add(Duration(days: 1));
                  } else {
                    order['completionDate'] = order['orderDate']!.add(Duration(hours: 6));
                  }

                  order['price'] = (order['price'] * order['quantity']) - order['discount'];
                });
                Navigator.of(context).pop();
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _addOrder(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String? customer;
        String? service;
        String? package;
        double? price;
        return AlertDialog(
          title: Text('Tambah Pesanan Baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nama Pelanggan'),
                onChanged: (value) {
                  customer = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Layanan'),
                onChanged: (value) {
                  service = value;
                },
              ),
              DropdownButton<String>(
                hint: Text('Pilih Paket'),
                value: package,
                items: ['Reguler', 'Kilat', 'Ekspres']
                    .map((pkg) => DropdownMenuItem(
                          value: pkg,
                          child: Text(pkg),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    package = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Harga per unit'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  price = double.tryParse(value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                if (customer != null && service != null && package != null && price != null) {
                  setState(() {
                    orders.add({
                      'id': (orders.length + 1).toString(),
                      'customer': customer!,
                      'service': service!,
                      'status': 'Belum Diterima',
                      'package': package!,
                      'price': price!,
                      'orderDate': null,
                      'completionDate': null,
                      'paymentStatus': 'Belum Bayar',
                      'quantity': 0.0,
                      'discount': 0.0,
                    });
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Tambah'),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> _filterOrders(String query, String status, String package) {
    return orders.where((order) {
      final matchesStatus = order['status'] == status;
      final matchesPackage = order['package'] == package;
      final matchesQuery = order['customer'].toLowerCase().contains(query.toLowerCase());
      return matchesStatus && matchesPackage && matchesQuery;
    }).toList();
  }

  String _formatCurrency(double amount) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Pesanan'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(108.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Cari nama pelanggan',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                            ),
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      RawMaterialButton(
                        onPressed: () {
                          _addOrder(context);
                        },
                        child: Icon(Icons.add, color: Colors.white),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: Color(0xFF0E1446),
                        constraints: BoxConstraints(
                          minWidth: 70.0,
                          minHeight: 40.0,
                        ),
                        elevation: 2.0,
                      ),
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        'Belum Diterima',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Diterima',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Diproses',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Siap Ambil',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Selesai',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              controller: _packageTabController,
              tabs: [
                Tab(text: 'Reguler'),
                Tab(text: 'Kilat'),
                Tab(text: 'Ekspres'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOrderList('Belum Diterima'),
                  _buildOrderList('Diterima'),
                  _buildOrderList('Diproses'),
                  _buildOrderList('Siap Ambil'),
                  _buildOrderList('Selesai'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(String status) {
    return TabBarView(
      controller: _packageTabController,
      children: [
        _buildOrderListView(status, 'Reguler'),
        _buildOrderListView(status, 'Kilat'),
        _buildOrderListView(status, 'Ekspres'),
      ],
    );
  }

  Widget _buildOrderListView(String status, String package) {
    final filteredOrders = _filterOrders(searchQuery, status, package);
    return ListView.builder(
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        final order = filteredOrders[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('images/icon/laundry-basket.png', width: 40, height: 40),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NOTA-${order['id']} ${order['package']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(order['customer']),
                    Text('Masuk: ${order['orderDate'] != null ? DateFormat('dd/MM/yyyy - HH:mm').format(order['orderDate']) : 'Belum Diterima'}'),
                    Text('Selesai: ${order['completionDate'] != null ? DateFormat('dd/MM/yyyy - HH:mm').format(order['completionDate']) : 'Belum Diterima'}'),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatCurrency(order['price']),
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    order['paymentStatus'],
                    style: TextStyle(
                      color: order['paymentStatus'] == 'Belum Bayar'
                          ? Colors.red
                          : Colors.green,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(80, 30),
                      padding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    onPressed: () {
                      _editOrderStatus(context, order);
                    },
                    child: Text(order['status'], style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}