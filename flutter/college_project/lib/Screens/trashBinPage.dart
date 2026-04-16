import 'package:college_project/Apartments_Data/apartment_image.dart';
import 'package:flutter/material.dart';
import 'package:college_project/Apartments_Data/bookingManager.dart';
import 'package:intl/intl.dart';

class TrashBinPage extends StatefulWidget {
  const TrashBinPage({super.key});

  @override
  State<TrashBinPage> createState() => _TrashBinPageState();
}

class _TrashBinPageState extends State<TrashBinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Cancelled Bookings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        elevation: 0,
      ),
      body: BookingManager.deletedBookings.isEmpty
          ? const Center(child: Text("Trash is empty"))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: BookingManager.deletedBookings.length,
              itemBuilder: (context, index) {
                final booking = BookingManager.deletedBookings[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                     
                    leading: Opacity(
                      opacity: 0.6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 60,  
                          height: 60,  
                          child: ApartmentImage(
                            imagePath: booking.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      "Apartment in ${booking.apartmentArea}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration:
                            TextDecoration.lineThrough, 
                        color: Colors.grey,
                      ),
                    ),
                    subtitle: Text(
                      "Cancelled on: ${DateFormat('MMM dd').format(DateTime.now())}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      onPressed: () {
                        setState(() {
                          BookingManager.restoreBooking(booking);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Booking Restored!"),
                            backgroundColor: Colors.green,
                          ),
                        );
                      },
                      child: const Text(
                        "Restore",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
