import 'package:flutter/material.dart';
import '../../models/cart.dart';
import '../../models/perfume.dart';
import '../../models/perfume_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  List<Perfume> allPerfumes = PerfumeService().getAllPerfumes();

  @override
  Widget build(BuildContext context) {
    List<Perfume> filtered =
        allPerfumes
            .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search perfumes...',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final item = filtered[index];
                return ListTile(
                  leading: Image.network(
                    item.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(item.name),
                  subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                  onTap: () {
                    Navigator.pushNamed(context, '/detail', arguments: item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
