import 'package:flutter/material.dart';
import 'home_page.dart'; // Impor file home_page.dart untuk navigasi kembali ke beranda

class PesananSedangDiantarPage extends StatefulWidget {
  final List<Map<String, dynamic>> itemList;
  final String titikAntar;
  final String metodePembayaran;
  final String namaDriver;
  final String nomorTeleponDriver;

  PesananSedangDiantarPage({
    required this.itemList,
    required this.titikAntar,
    required this.metodePembayaran,
    required this.namaDriver,
    required this.nomorTeleponDriver,
  });

  @override
  _PesananSedangDiantarPageState createState() =>
      _PesananSedangDiantarPageState();
}

class _PesananSedangDiantarPageState extends State<PesananSedangDiantarPage> {
  bool _isPesananSelesai = false;

  void _markPesananAsSelesai() {
    setState(() {
      _isPesananSelesai = true;
    });
  }

  void _kembaliKeBeranda() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isPesananSelesai ? "Pesanan Sudah Sampai" : "Pesanan Sedang Diantar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _isPesananSelesai
            ? _buildPesananSelesaiContent()
            : _buildPesananDiantarContent(),
      ),
      bottomNavigationBar: !_isPesananSelesai
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: _markPesananAsSelesai,
                child: Text(
                  'Pesanan Sudah Sampai',
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
            )
          : null,
    );
  }

  Widget _buildPesananDiantarContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.network(
            'https://www.gambaranimasi.org/data/media/169/animasi-bergerak-berlari-0050.gif',
            height: 200,
            width: 200,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, size: 200, color: Colors.red);
            },
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: Text(
            "Harap ditunggu yaa..",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Pesanan Anda:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
        SizedBox(height: 8),
        _buildOrderList(),
        SizedBox(height: 16),
        Text(
          "Titik Antar:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          widget.titikAntar,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          "Metode Pembayaran:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          widget.metodePembayaran,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          "Driver:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          widget.namaDriver,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 8),
        Text(
          "Nomor Telepon Driver:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          widget.nomorTeleponDriver,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildPesananSelesaiContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.network(
                  'https://tenor.com/view/fd-gif-22781835.gif',
                  height: 200,
                  width: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, size: 200, color: Colors.red);
                  },
                ),
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  "Pesanan sudah sampai selamat menikmati..",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ElevatedButton(
            onPressed: _kembaliKeBeranda,
            child: Text(
              'Kembali ke Beranda',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white, // ubah warna tulisan menjadi putih
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[800],
              padding: EdgeInsets.symmetric(vertical: 16),
              minimumSize: Size(200, 0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.itemList
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                "${item['qty']} x ${item['title']} - Rp${item['price'] * item['qty']}",
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
          .toList(),
    );
  }
}