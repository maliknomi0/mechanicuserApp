import 'package:flutter/material.dart';
import 'package:repair/themes/theme_constants.dart';

class ShopCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String address;
  final double rating;
  final String distance;
  final String services;
  final VoidCallback? onTap;

  const ShopCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.address,
    required this.rating,
    required this.distance,
    required this.services,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonradius),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(buttonradius)),
              child: Image.asset(
                imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.all(p),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name & Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: goldColor, size: 18),
                          const SizedBox(width: 2),
                          Text(rating.toString(),
                              style: const TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // Address
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 16, color: grayColor),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          address,
                          style: TextStyle(color: grayColor, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // Distance
                  Row(
                    children: [
                      const Icon(Icons.directions_walk,
                          size: 16, color: grayColor),
                      const SizedBox(width: 5),
                      Text(
                        distance,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),

                  // Services
                  Row(
                    children: [
                      const Icon(Icons.build, size: 16, color: grayColor),
                      const SizedBox(width: 5),
                      Text(
                        services,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
