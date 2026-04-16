 
import 'package:college_project/Apartments_Data/apartment_image.dart';
import 'package:college_project/Apartments_Data/appartmentsData.dart';
import 'package:college_project/Apartments_Data/bookingManager.dart';
import 'package:college_project/Apartments_Data/favouritesManager.dart';
import 'package:college_project/Screens/apartmentBooking.dart';
import 'package:flutter/material.dart';

import 'package:rating_dialog/rating_dialog.dart';

class Apartmentsdetails extends StatefulWidget {
  final Appartmentsdata apartment;
  const Apartmentsdetails({super.key, required this.apartment});

  @override
  State<Apartmentsdetails> createState() => _ApartmentsdetailsState();
}

class _ApartmentsdetailsState extends State<Apartmentsdetails> {

  bool _isApartmentBooked() {
    return BookingManager.myBookings.any(
      (booking) => booking.id.toString() == widget.apartment.id.toString(),
    );
  }

   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        title: Text(
          "Details in ${widget.apartment.area}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            iconSize: 30,
            icon: Icon(
              FavouritesManager.isFavourite(widget.apartment)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                FavouritesManager.toggleFavourite(widget.apartment);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    FavouritesManager.isFavourite(widget.apartment)
                        ? "Added to favourites ❤️"
                        : "Removed from favourites",
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            Hero(
              tag: 'apt_${widget.apartment.id}',
              child: ApartmentImage(
              
                imagePath: widget.apartment.image,
                height: 300,
                width: double.infinity,
              ),
            ),

            const SizedBox(height: 20.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.apartment.area,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.apartment.city,
                        style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.apartment.price.toStringAsFixed(0)} / night',
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: 100,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.cyan[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '${widget.apartment.rooms} Rooms',
                          style: const TextStyle(
                            color: Colors.cyan,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 40, thickness: 1),

               
                  const Text(
                    'Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.apartment.details,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 40),

              
                  Row(
                    children: [
                   
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(
                                  MaterialPageRoute(
                                    builder: (context) => ApartmentBookingPage(
                                      apartment: widget.apartment,
                                    ),
                                  ),
                                )
                                .then((_) {
                                  setState(() {});
                                });
                          },
                          child: const Text(
                            "Book Now",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),

                  
                      if (_isApartmentBooked()) ...[
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber[700],
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () => _showRating(context),
                            child: const Text(
                              "Rate now",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 
  void _showRating(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => RatingDialog(
        initialRating: 0.0,
        title: const Text(
          'Rate this apartment',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        message: const Text(
          'How was your stay? Tap a star to set your rating.',
          textAlign: TextAlign.center,
        ),
        image: const Icon(Icons.rate_review, size: 100, color: Colors.amber),
        submitButtonText: 'Submit',
        onCancelled: () => print('cancelled'),
        onSubmitted: (response) {
          print('rating: ${response.rating}, comment: ${response.comment}');
        },
      ),
    );
  }
}
