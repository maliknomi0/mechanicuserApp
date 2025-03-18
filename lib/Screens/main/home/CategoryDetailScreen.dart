import 'package:flutter/material.dart';
import 'package:repair/Screens/main/home/mechanicdetailscreen.dart';
import 'package:repair/Utils/ShopCard.dart';
import 'package:repair/_Configs/assets.dart';
import 'package:repair/themes/theme_constants.dart';

class CategoryDetailScreen extends StatelessWidget {
  final String title;
  final String image;
  final List<Map<String, dynamic>> shops = [
    {
      "imageUrl": AppIamges.mechanic,
      "name": "John's Auto Repair",
      "address": "123 Main Street",
      "rating": 4.7,
      "distance": "2 km",
      "services": "Bike, Cars",
    },
    {
      "imageUrl": AppIamges.mechanic,
      "name": "Mike's Garage",
      "address": "456 Elm Street",
      "rating": 4.5,
      "distance": "3.5 km",
      "services": "Cars, Trucks",
    },
    {
      "imageUrl": AppIamges.mechanic,
      "name": "Elite Auto Service",
      "address": "789 Oak Avenue",
      "rating": 4.9,
      "distance": "1.2 km",
      "services": "Bikes, Cars",
    },
  ];

  CategoryDetailScreen({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(p),
          child: Column(
            spacing: smallspascing,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.search,
                  ),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.3 / 2,
                ),
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  final shop = shops[index];
                  return ShopCard(
                    imageUrl: shop["imageUrl"],
                    name: shop["name"],
                    address: shop["address"],
                    rating: shop["rating"],
                    distance: shop["distance"],
                    services: shop["services"],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MechanicDetails()),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
