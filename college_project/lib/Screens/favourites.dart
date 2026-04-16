import 'package:college_project/Apartments_Data/apartment_image.dart';
import 'package:college_project/Apartments_Data/favouritesManager.dart';
import 'package:flutter/material.dart';
import 'package:college_project/Screens/apartmentsDetails.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
         
        backgroundColor: Colors.cyan,
        title: const Text(
          'Favourites page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FavouritesManager.favourites.isEmpty
          ? const Center(
              child: Text(
                'No favourites yet ❤️',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: FavouritesManager.favourites.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                childAspectRatio: 1.2,  
              ),
              itemBuilder: (context, index) {
                final apartment = FavouritesManager.favourites[index];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Apartmentsdetails(apartment: apartment),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(25),
                            ),
                            child: Hero(
                           
                              tag: 'apt_${apartment.id}',
                              child: ApartmentImage(
                                imagePath: apartment.image,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                apartment.area,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${apartment.price.toStringAsFixed(0)} / night",
                                style: const TextStyle(
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
