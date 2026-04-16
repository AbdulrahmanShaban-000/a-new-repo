import 'package:college_project/Apartments_Data/apartment_image.dart';
import 'package:college_project/Apartments_Data/appartmentsData.dart';
 
import 'package:college_project/Screens/apartmentsDetails.dart';
import 'package:flutter/material.dart';

class CustomSearch extends SearchDelegate {
  bool matchesSearch(apartment, String query) {
    final q = query.toLowerCase();
    final num? numberQuery = num.tryParse(query);

    final bool textMatch =
        apartment.city.toLowerCase().contains(q) ||
        apartment.area.toLowerCase().contains(q);

    final bool numberMatch =
        numberQuery != null &&
        (apartment.price <= numberQuery || apartment.rooms == numberQuery);

    return textMatch || numberMatch;
  }

  @override
  String get searchFieldLabel => 'ابحث بالمدينة، المنطقة، السعر أو عدد الغرف';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
            showSuggestions(context);
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List filteredResults = info
        .where((apartment) => matchesSearch(apartment, query))
        .toList();

    if (filteredResults.isEmpty) {
      return Center(
        child: Text(
          'لا توجد شقق تطابق البحث "$query"',
          style: const TextStyle(fontSize: 20, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 0.75,
      ),
      itemCount: filteredResults.length,
      itemBuilder: (context, index) {
        final apartment = filteredResults[index];

        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Apartmentsdetails(apartment: apartment),
              ),
            );
          },
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(10.0),
                    ),
                    child: Hero(
                      tag: 'apt_${apartment.id}',
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                        child: ApartmentImage(
                        
                          imagePath: apartment.image,
                          height: 220,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${apartment.area} - ${apartment.city}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'rooms: ${apartment.rooms}',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'price: \$${apartment.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.green,
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List suggestionList = query.isEmpty
        ? info
        : info.where((apartment) => matchesSearch(apartment, query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final apartment = suggestionList[index];

        return InkWell(
          onTap: () {
            query = apartment.area;
            showResults(context);
          },
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '${apartment.area} - ${apartment.city}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${apartment.price.toStringAsFixed(0)}\$',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        '${apartment.rooms} rooms',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
