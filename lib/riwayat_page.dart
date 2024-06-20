import 'package:flutter/material.dart';
import 'dart:math';

class RiwayatPage extends StatefulWidget {
  @override
  _RiwayatPageState createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  final List<String> _restaurants = [
    "Warung Sate Bu Slamet",
    "Bakmi Jawa Mbah Mo",
    "Soto Ayam Bu Karti",
    "Pecel Lele Mbah Manto"
  ];

  final List<String> _orderStatus = [
    "Semua",
    "Diterima",
    "Diproses",
    "Dikirim",
    "Selesai"
  ];
  String _selectedStatus = "Semua";

  List<Map<String, dynamic>> _generateRandomOrders() {
    Random random = Random();
    List<Map<String, dynamic>> orders = [];

    for (int i = 0; i < 20; i++) {
      int restaurantIndex = random.nextInt(_restaurants.length);
      int statusIndex = random.nextInt(_orderStatus.length - 1) + 1;

      Map<String, dynamic> order = {
        'restaurant': _restaurants[restaurantIndex],
        'orderNumber': '#${1000 + random.nextInt(9000)}',
        'totalPrice': (10 + random.nextInt(200)) * 1000,
        'status': _orderStatus[statusIndex],
      };

      orders.add(order);
    }

    return orders;
  }

  List<Map<String, dynamic>> _filterOrders(
      String status, List<Map<String, dynamic>> orders) {
    if (status == "Semua") return orders;
    return orders.where((order) => order['status'] == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> orders = _generateRandomOrders();
    List<Map<String, dynamic>> filteredOrders =
        _filterOrders(_selectedStatus, orders);

    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pesanan'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            color: Colors.green[50],
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _orderStatus.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedStatus = _orderStatus[index];
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: _selectedStatus == _orderStatus[index]
                          ? Colors.green
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Text(
                      _orderStatus[index],
                      style: TextStyle(
                        color: _selectedStatus == _orderStatus[index]
                            ? Colors.white
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) {
                return _buildOrderCard(filteredOrders[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              order['restaurant'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Number: ${order['orderNumber']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  'Rp ${order['totalPrice']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(order['status']),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                order['status'],
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Diterima":
        return Colors.blue;
      case "Diproses":
        return Colors.orange;
      case "Dikirim":
        return Colors.purple;
      case "Selesai":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
