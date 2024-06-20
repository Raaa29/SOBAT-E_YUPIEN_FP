import 'package:flutter/material.dart';
import 'loading_page.dart'; // Tambahkan import untuk LoadingPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pengiriman Barang',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ServicePage(),
    );
  }
}

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  String _nama = '';
  String _alamat = '';
  String _noTelp = '';
  double _biaya = 0.0;
  int _beratBarang = 0;
  String _jenisPengiriman = 'Reguler';
  String _titikAntar = '';
  String _titikJemput = '';
  String _selectedWeight = '';
  String _selectedDeliveryType = '';
  int _metodePembayaran = 1;

  void _hitungBiaya() {
    if (_beratBarang < 1) {
      if (_jenisPengiriman == 'Reguler') {
        _biaya = 3000;
      } else if (_jenisPengiriman == 'Instan') {
        _biaya = 5000;
      } else {
        _biaya = 10000;
      }
    } else if (_beratBarang == 3) {
      if (_jenisPengiriman == 'Reguler') {
        _biaya = 4000;
      } else if (_jenisPengiriman == 'Instan') {
        _biaya = 6000;
      } else {
        _biaya = 12000;
      }
    } else if (_beratBarang > 5) {
      if (_jenisPengiriman == 'Reguler') {
        _biaya = 8000;
      } else if (_jenisPengiriman == 'Instan') {
        _biaya = 12000;
      } else {
        _biaya = 20000;
      }
    }
  }

  void _showWeightDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green[800],
          title:
              Text('Pilih Berat Barang', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('< 1 kg', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _beratBarang = 0;
                    _selectedWeight = '< 1 kg';
                    _hitungBiaya();
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('3 kg', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _beratBarang = 3;
                    _selectedWeight = '3 kg';
                    _hitungBiaya();
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('> 5 kg', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _beratBarang = 6;
                    _selectedWeight = '> 5 kg';
                    _hitungBiaya();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeliveryTypeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green[800],
          title: Text('Pilih Jenis Pengiriman',
              style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Reguler', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _jenisPengiriman = 'Reguler';
                    _selectedDeliveryType = 'Reguler';
                    _hitungBiaya();
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Instan', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _jenisPengiriman = 'Instan';
                    _selectedDeliveryType = 'Instan';
                    _hitungBiaya();
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Super', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _jenisPengiriman = 'Super';
                    _selectedDeliveryType = 'Super';
                    _hitungBiaya();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPaymentOptionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green[800],
          title: Text('Pilih Metode Pembayaran',
              style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Tunai', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _metodePembayaran = 1;
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('QRIS', style: TextStyle(color: Colors.white)),
                onTap: () {
                  setState(() {
                    _metodePembayaran = 2;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool _validateInputs() {
    return _nama.isNotEmpty &&
        _alamat.isNotEmpty &&
        _noTelp.isNotEmpty &&
        _titikJemput.isNotEmpty &&
        _titikAntar.isNotEmpty &&
        _selectedWeight.isNotEmpty &&
        _selectedDeliveryType.isNotEmpty &&
        (_metodePembayaran == 1 || _metodePembayaran == 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengiriman Barang'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Titik Jemput',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on, color: Colors.green[800]),
                ),
                onChanged: (value) {
                  setState(() {
                    _titikJemput = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Titik Antar',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_on, color: Colors.red[800]),
                ),
                onChanged: (value) {
                  setState(() {
                    _titikAntar = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Data Penerima',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.green[800],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Nama',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _nama = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Alamat',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _alamat = value;
                          });
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'No. Telp',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _noTelp = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ListTile(
                title: Text('Berat Barang: $_selectedWeight',
                    style: TextStyle(color: Colors.green[800])),
                trailing:
                    Icon(Icons.keyboard_arrow_down, color: Colors.green[800]),
                onTap: _showWeightDialog,
              ),
              SizedBox(height: 8.0),
              ListTile(
                title: Text('Jenis Pengiriman: $_selectedDeliveryType',
                    style: TextStyle(color: Colors.green[800])),
                trailing:
                    Icon(Icons.keyboard_arrow_down, color: Colors.green[800]),
                onTap: _showDeliveryTypeDialog,
              ),
              SizedBox(height: 16.0),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Biaya Pengiriman',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.green[800],
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Rp${_biaya.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _showPaymentOptionDialog,
                child: Text(
                  _metodePembayaran == 1
                      ? 'Pembayaran: Tunai'
                      : 'Pembayaran: QRIS',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                ),
              ),
              SizedBox(height: 16.0),
              if (_metodePembayaran == 2)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Scan kode QR ini untuk melanjutkan pembayaran",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[800],
                            ),
                          ),
                          SizedBox(height: 16),
                          Image.network(
                            "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=https://qris.id/qris/payment?amount=$_biaya&note=PembayaranKantin",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_validateInputs()) {
              // Logika ketika tombol ditekan
              print('Nama: $_nama');
              print('Alamat: $_alamat');
              print('No. Telp: $_noTelp');
              print('Titik Jemput: $_titikJemput');
              print('Titik Antar: $_titikAntar');
              print('Berat Barang: $_beratBarang kg');
              print('Jenis Pengiriman: $_jenisPengiriman');
              print(
                  'Metode Pembayaran: ${_metodePembayaran == 1 ? 'Tunai' : 'QRIS'}');
              print('Biaya: Rp$_biaya');

              // Navigasi ke halaman loading
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoadingPage()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Silakan isi semua data terlebih dahulu'),
                ),
              );
            }
          },
          child: Text(
            'Pesan',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[800],
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}
