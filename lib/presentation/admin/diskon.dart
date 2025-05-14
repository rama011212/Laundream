import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiskonPage extends StatefulWidget {
  @override
  _DiskonPageState createState() => _DiskonPageState();
}

class _DiskonPageState extends State<DiskonPage> {
  final List<Map<String, dynamic>> diskonList = [
    {
      'type': 'Nominal',
      'amount': 5000.0,
    },
  ];

  void _navigateToAddDiscountPage({Map<String, dynamic>? diskon, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TambahDiskonPage(diskon: diskon)),
    );

    if (result != null) {
      setState(() {
        if (index == null) {
          diskonList.add(result);
        } else {
          diskonList[index] = result;
        }
      });
    }
  }

  void _confirmDelete(int index) {
    final diskon = diskonList[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Hapus "${diskon['type'] == 'Nominal' ? 'Diskon ${formatCurrency(diskon['amount'])}' : 'Diskon ${formatPercentage(diskon['amount'])}'}" ?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14), // Ukuran teks dikurangi
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      diskonList.removeAt(index);
                    });
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                  ),
                  child: Text('Hapus'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                  child: Text('Batal'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String formatCurrency(double amount) {
    final format = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return format.format(amount);
  }

  String formatPercentage(double percentage) {
    final format = NumberFormat.decimalPattern('id');
    return format.format(percentage) + '%';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diskon'),
      ),
      body: Column(
        children: <Widget>[
          Divider(thickness: 2, color: Colors.grey[300]), // Pembatas langsung di bawah AppBar
          Container(
            margin: EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _navigateToAddDiscountPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add),
                  SizedBox(width: 8.0),
                  Text('Tambah Diskon'),
                ],
              ),
            ),
          ),
          Divider(thickness: 1, color: Colors.grey[300]), // Pembatas langsung di bawah tombol tambah
          Expanded(
            child: ListView.separated(
              itemCount: diskonList.length,
              itemBuilder: (context, index) {
                final diskon = diskonList[index];
                return ListTile(
                  title: Text(diskon['type'] == 'Nominal' ? formatCurrency(diskon['amount']) : formatPercentage(diskon['amount'])),
                  subtitle: Text(diskon['type'] == 'Nominal' ? 'Diskon Nominal' : 'Diskon Persentase'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: () => _navigateToAddDiscountPage(diskon: diskon, index: index),
                        child: Container(
                          padding: EdgeInsets.all(8.0), // Ubah sesuai kebutuhan Anda
                          decoration: BoxDecoration(
                            color: Color(0xFF0E1446), // Warna biru tua
                            borderRadius: BorderRadius.circular(10.0), // Ubah sesuai kebutuhan Anda
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white, // Warna ikon putih
                            size: 20, // Ukuran ikon edit
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Colors.grey,
                        onPressed: () => _confirmDelete(index),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(thickness: 1, color: Colors.grey[300]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TambahDiskonPage extends StatefulWidget {
  final Map<String, dynamic>? diskon;

  TambahDiskonPage({this.diskon});

  @override
  _TambahDiskonPageState createState() => _TambahDiskonPageState();
}

class _TambahDiskonPageState extends State<TambahDiskonPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedType;
  double? _amount;

  @override
  void initState() {
    super.initState();
    if (widget.diskon != null) {
      _selectedType = widget.diskon!['type'];
      _amount = widget.diskon!['amount'];
    }
  }

  void _saveDiscount() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(context, {'type': _selectedType, 'amount': _amount});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Diskon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Tipe Diskon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                value: _selectedType,
                items: ['Nominal', 'Persentase']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tipe diskon harus dipilih';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Jumlah Diskon',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  prefixText: _selectedType == 'Nominal' ? 'Rp ' : '% ',
                ),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _amount = double.tryParse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah diskon harus diisi';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveDiscount,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Tambahkan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
