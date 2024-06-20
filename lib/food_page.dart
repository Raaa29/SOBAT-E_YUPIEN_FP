import 'package:flutter/material.dart';
import 'menu_page.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  List<Map<String, dynamic>> categories = [
    {'name': 'Jajan', 'icon': Icons.local_cafe},
    {'name': 'Minuman', 'icon': Icons.local_bar},
    {'name': 'Jepang', 'icon': Icons.ramen_dining},
    {'name': 'Korea', 'icon': Icons.restaurant},
    {'name': 'Roti', 'icon': Icons.bakery_dining},
  ];

  List<Map<String, dynamic>> stores = [
    {
      'name': 'Kantin Bela Negara 1',
      'distance': 600,
      'deliveryTime': 10,
      'rating': 4.3,
      'discount': 10,
      'image': 'https://images.unsplash.com/photo-1560341208-305f47d5e901?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Y2FudGVlbnxlbnwwfHwwfHx8MA%3D%3D',
    },
    {
      'name': 'Kantin Bela Negara 2',
      'distance': 500,
      'deliveryTime': 8,
      'rating': 4.4,
      'discount': 5,
      'image': 'https://images.unsplash.com/photo-1569351390041-1aac8f5774bf?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fGNhbnRlZW58ZW58MHx8MHx8fDA%3D',
    },
    {
      'name': 'Kantin Bela Negara 3',
      'distance': 500,
      'deliveryTime': 8,
      'rating': 4.4,
      'discount': 5,
      'image': 'https://images.unsplash.com/photo-1520209268518-aec60b8bb5ca?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGNhbnRlZW58ZW58MHx8MHx8fDA%3D',
    },
    {
      'name': 'Kantin Bela Negara 4',
      'distance': 500,
      'deliveryTime': 8,
      'rating': 4.4,
      'discount': 5,
      'image': 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGthbnRpbmV8ZW58MHx8MHx8fDA%3D',
    },
    {
      'name': 'Kantin Bela Negara 5',
      'distance': 500,
      'deliveryTime': 8,
      'rating': 4.4,
      'discount': 5,
      'image': 'https://images.unsplash.com/photo-1617222296320-7a2846d461bb?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8a2FudGluZXxlbnwwfHwwfHx8MA%3D%3D',
    },
    {
      'name': 'Kantin Bela Negara 6',
      'distance': 500,
      'deliveryTime': 8,
      'rating': 4.4,
      'discount': 5,
      'image': 'https://images.unsplash.com/photo-1529973565457-a60a2ccf750d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGthbnRpbmV8ZW58MHx8MHx8fDA%3D',
    },
    {
      'name': 'Kantin Bela Negara 7',
      'distance': 500,
      'deliveryTime': 8,
      'rating': 4.4,
      'discount': 5,
      'image': 'https://images.unsplash.com/photo-1508170754725-6e9a5cfbcabf?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fGthbnRpbmV8ZW58MHx8MHx8fDA%3D',
    },
    {
      'name': 'Kantin Bela Negara 8',
      'distance': 500,
      'deliveryTime': 8,
      'rating': 4.4,
      'discount': 5,
      'image': 'https://images.unsplash.com/photo-1555244162-803834f70033?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGthbnRpbmV8ZW58MHx8MHx8fDA%3D',
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredStores = stores
        .where((store) =>
            store['name'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lagi Mau Makan Apa Hari Ini?'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari Kantin',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            height: 50.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Chip(
                    label: Text(categories[index]['name']),
                    avatar: Icon(categories[index]['icon']),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStores.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MenuPage(canteenName: filteredStores[index]['name'])),
                            );
                          },
                          child: Image.network(
                            filteredStores[index]['image'],
                            width: double.infinity,
                            height: 150.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          filteredStores[index]['name'],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Icon(Icons.location_on),
                            Text('${filteredStores[index]['distance']} m'),
                            SizedBox(width: 10.0),
                            Icon(Icons.access_time),
                            Text('${filteredStores[index]['deliveryTime']} min'),
                          ],
                        ),
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow),
                            Text('${filteredStores[index]['rating']}'),
                            SizedBox(width: 10.0),
                            Chip(
                              label: Text('-${filteredStores[index]['discount']}%'),
                              backgroundColor: Colors.green,
                              labelStyle: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
