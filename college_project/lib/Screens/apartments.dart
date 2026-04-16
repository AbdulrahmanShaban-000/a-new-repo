import 'package:college_project/Apartments_Data/apartment_image.dart';
import 'package:college_project/Provider/AuthProvider.dart';
import 'package:college_project/Apartments_Data/appartmentsData.dart';
import 'package:college_project/Apartments_Data/favouritesManager.dart';
import 'package:college_project/Provider/theme_provider.dart';
import 'package:college_project/Screens/ApartmentsDetails.dart';
import 'package:college_project/Screens/CustomSearch.dart';
import 'package:college_project/Screens/aprtments-additon-screen.dart';
import 'package:college_project/Screens/favourites.dart';
import 'package:college_project/Screens/myBookingPage.dart';
import 'package:college_project/login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Apartments extends StatefulWidget {
  final String role; // tenant أو renter
  const Apartments({super.key, required this.role});

  @override
  State<Apartments> createState() => _ApartmentsState();
}

class _ApartmentsState extends State<Apartments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 205, 0, 212), Color(0xFF00ACC1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Luxury Apartments',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () =>
              showSearch(context: context, delegate: CustomSearch()),
          icon: const Icon(Icons.search_rounded, color: Colors.white, size: 30),
        ),
        actions: [_buildPopupMenu(context)],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: info.length,
        itemBuilder: (context, index) {
          final apartmentInfo = info[index];
          return _buildLargeApartmentCard(context, apartmentInfo);
        },
      ),
      floatingActionButton: widget.role == 'renter'
          ? FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ApartmentAddPage()),
                );

                if (result == true) {
                  setState(() {});
                }
              },
              backgroundColor: Colors.cyan,
              tooltip: 'Add Apartment',
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  Widget _buildLargeApartmentCard(BuildContext context, var apartment) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(
              MaterialPageRoute(
                builder: (context) => Apartmentsdetails(apartment: apartment),
              ),
            )
            .then((_) => setState(() {}));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
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
                Positioned(
                  top: 15,
                  right: 15,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        FavouritesManager.isFavourite(apartment)
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        color: Colors.red,
                        size: 26,
                      ),
                      onPressed: () {
                        setState(() {
                          FavouritesManager.toggleFavourite(apartment);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 500),
                            content: Text(
                              FavouritesManager.isFavourite(apartment)
                                  ? "Added to Favourites"
                                  : "Removed from Favourites",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        apartment.area,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "\$${apartment.price.toStringAsFixed(0)}",
                        style: const TextStyle(
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.king_bed_outlined,
                        size: 22,
                        color: Colors.cyan,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${apartment.rooms.toStringAsFixed(0)} Bedrooms",
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "/night",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
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

  Widget _buildPopupMenu(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return PopupMenuButton<int>(
      icon: const Icon(Icons.more_vert_rounded, color: Colors.white, size: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onSelected: (value) async {
        if (value == 2) {
          final authProvider = context.read<AuthProvider>();
          await authProvider.logout();
          if (!mounted) return;
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) =>   Loginscreen()),
            (route) => false,
          );
        } else if (value == 0) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => Favourites()));
        } else if (value == 3) {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => MyBookingsPage()));
        }
      },
      itemBuilder: (ctx) => <PopupMenuEntry<int>>[
        _menuItem(0, "Favourites", Icons.favorite_border_outlined, Colors.blue),
        _menuItem(3, "My Bookings", Icons.calendar_month_rounded, Colors.blue),
        const PopupMenuDivider(),
        _menuItem(
          2,
          "Logout",
          Icons.logout_rounded,
          const Color.fromARGB(255, 82, 81, 81),
        ),
 
        PopupMenuItem(
          enabled: true,
           
          onTap: () {
            themeProvider.toggleTheme(!themeProvider.isDarkMode);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dark Mode"),
              
              Switch(
                value: themeProvider.isDarkMode,
                activeColor: Colors.cyan,
                onChanged: (bool newValue) {
                  themeProvider.toggleTheme(newValue);
                  Navigator.pop(context);  
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  PopupMenuItem<int> _menuItem(
    int value,
    String title,
    IconData icon,
    Color color,
  ) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
