import 'package:flutter/material.dart';
import 'package:repair/Screens/Drower.dart';
import 'package:repair/Screens/main/home/CategoryDetailScreen.dart';
import 'package:repair/Utils/ShopCard.dart';
import 'package:repair/_Configs/assets.dart';
import 'package:repair/_Configs/lang.dart';
import 'package:repair/themes/theme_constants.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {eng.gvtitle: eng.hsbicycletile, eng.gvimage: AppIamges.bicycle},
    {eng.gvtitle: eng.hsbiketile, eng.gvimage: AppIamges.bike},
    {eng.gvtitle: eng.hscartile, eng.gvimage: AppIamges.car},
    {eng.gvtitle: eng.hsbustile, eng.gvimage: AppIamges.bus},
  ];

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
      "services": "Bikes, Cars, Trucks",
    },
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eng.hsappbar),
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {},
          ),
        ],
      ),
      drawer: ThemeDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(p),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🏷️ Categories Grid
              Text(
                eng.hsheading,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to category details
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryDetailScreen(
                            title: categories[index][eng.gvtitle]!,
                            image: categories[index][eng.gvimage]!,
                          ),
                        ),
                      );
                    },
                    child: _buildCategoryCard(
                      title: categories[index][eng.gvtitle]!,
                      image: categories[index][eng.gvimage]!,
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),

              // 🏪 Shops Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    eng.hssubheading1,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: Text(eng.hssubheading2)),
                ],
              ),
              const SizedBox(height: 10),

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
                      // Navigator.pushNamed(context, "/shopDetails",);
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

  // ✅ Private Category Card Widget
  Widget _buildCategoryCard({
    required String title,
    required String image,
    double borderRadius = buttonradius,
    Color overlayColor = blackColor,
    Color textColor = whiteColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: overlayColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
