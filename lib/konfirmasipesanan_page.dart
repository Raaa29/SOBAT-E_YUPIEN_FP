import 'package:flutter/material.dart';
import 'pesanan_sedang_diantar_page.dart';

class KonfirmasiPesananPage extends StatefulWidget {
  final List<Map<String, dynamic>> itemList;

  KonfirmasiPesananPage({required this.itemList});

  @override
  _KonfirmasiPesananPageState createState() => _KonfirmasiPesananPageState();
}

class _KonfirmasiPesananPageState extends State<KonfirmasiPesananPage> {
  int _metodePembayaran = 1;
  final TextEditingController _titikAntarController = TextEditingController();
  String _titikAntar = '';
  final int _biayaLayanan = 1000;
  final int _ongkir = 2000;

  // Informasi driver - ini bisa diubah sesuai dengan data yang Anda miliki
  final String _namaDriver = 'Budi Santoso';
  final String _nomorTeleponDriver = '081234567890';

  @override
  void initState() {
    super.initState();
    _titikAntarController.text = '';
  }

  @override
  void dispose() {
    _titikAntarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalHarga = widget.itemList.fold<int>(
      0,
      (sum, item) => sum + (item['price'] as int) * (item['qty'] as int),
    );
    final totalPembayaran = totalHarga + _biayaLayanan + _ongkir;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Konfirmasi Pesanan",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green[800],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle("Pesanan:", Colors.green[800]!),
          SizedBox(height: 8),
          _buildOrderList(),
          SizedBox(height: 16),
          _buildSectionTitle("Biaya:", Colors.green[800]!),
          SizedBox(height: 8),
          _buildCostItem("Total Harga", totalHarga),
          _buildCostItem("Biaya Layanan", _biayaLayanan),
          _buildCostItem("Ongkir", _ongkir),
          SizedBox(height: 16),
          _buildSectionTitle("Total Pembayaran: Rp$totalPembayaran", Colors.green[800]!),
          SizedBox(height: 16),
          _buildSectionTitle("Titik Jemput:", Colors.green[800]!),
          SizedBox(height: 8),
          Text(
            "Kantin Bela Negara 1",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          _buildSectionTitle("Titik Antar:", Colors.green[800]!),
          SizedBox(height: 8),
          TextField(
            controller: _titikAntarController,
            decoration: InputDecoration(
              labelText: "Masukkan Titik Antar",
              labelStyle: TextStyle(color: Colors.green[800]),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green[800]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green[800]!),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _titikAntar = value;
              });
            },
          ),
          SizedBox(height: 16),
          _buildSectionTitle("Pembayaran:", Colors.green[800]!),
          _buildPaymentOption("Tunai", 1),
          _buildPaymentOption("QRIS", 2),
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
                        "https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=https://qris.id/qris/payment?amount=$totalPembayaran&note=PembayaranKantin",
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_titikAntar.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Tolong isi titik antar terlebih dahulu."),
                  backgroundColor: Colors.red,
                ),
              );
            } else {
              // Navigate to PesananSedangDiantarPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PesananSedangDiantarPage(
                    itemList: widget.itemList,
                    titikAntar: _titikAntar,
                    metodePembayaran: _metodePembayaran == 1 ? 'Tunai' : 'QRIS',
                    namaDriver: _namaDriver, // Pass the driver's name
                    nomorTeleponDriver: _nomorTeleponDriver, // Pass the driver's phone number
                  ),
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

  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color,
      ),
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

  Widget _buildCostItem(String label, int amount) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "Rp$amount",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String title, int value) {
    return ListTile(
      title: Text(title),
      leading: Radio(
        value: value,
        groupValue: _metodePembayaran,
        onChanged: (int? newValue) {
          setState(() {
            _metodePembayaran = newValue!;
          });
        },
        activeColor: Colors.green[800],
      ),
    );
  }
}
