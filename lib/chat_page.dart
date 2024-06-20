import 'package:flutter/material.dart';
import 'dart:math';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> _customerMessages = [
    "Halo, saya ingin memesan makanan.",
    "Apakah ada menu baru hari ini?",
    "Saya ingin memesan nasi goreng dan jus jeruk.",
    "Tolong kirim ke : Fakultas Ilmu Komputer",
    "Berapa lama pengiriman?",
  ];

  final String _driverName = "Koko";
  final String _driverImage =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp3oYa9BljpcyhfIwVizBrEuo4HjsWq1mNzw&s";

  final TextEditingController _textController = TextEditingController();
  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Obrolan - Pesanan Makanan'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _customerMessages.length *
                  2, // Include both customer and driver messages
              itemBuilder: (context, index) {
                if (index.isEven) {
                  // Customer message
                  return _buildChatBubble(_customerMessages[index ~/ 2],
                      isFromCustomer: true);
                } else {
                  // Driver message
                  return _buildChatBubble(_generateDriverReply(),
                      isFromCustomer: false);
                }
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  String _generateDriverReply() {
    List<String> replies = [
      "Halo! Tentu, kami memiliki beberapa menu baru hari ini. Apakah Anda ingin melihat daftar menu?",
      "Ya, kami bisa mengirim nasi goreng dan jus jeruk. Pesanan Anda akan segera diproses.",
      "Pengiriman akan memakan waktu sekitar 10 menit. Terima kasih telah memesan dengan kami!",
      "Pesanan Anda sudah dalam perjalanan. Mohon menunggu di alamat pengiriman. Terima kasih!",
    ];
    return replies[_random.nextInt(replies.length)];
  }

  Widget _buildChatBubble(String message, {bool isFromCustomer = true}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment:
            isFromCustomer ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isFromCustomer ? Colors.green : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isFromCustomer) ...[
                CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(_driverImage),
                ),
                SizedBox(height: 4),
                Text(
                  _driverName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isFromCustomer ? Colors.white : Colors.black,
                  ),
                ),
              ],
              SizedBox(height: 4),
              Text(
                message,
                style: TextStyle(
                    color: isFromCustomer ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'Ketik pesan...',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                setState(() {
                  _customerMessages.add(_textController.text);
                  _textController.clear();
                });
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
