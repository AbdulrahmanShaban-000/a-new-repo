    import 'package:college_project/Apartments_Data/apartment_image.dart';
    import 'package:college_project/Apartments_Data/bookingManager.dart';
    import 'package:college_project/Apartments_Data/bookingModel.dart';
    import 'package:flutter/material.dart';
    import 'package:intl/intl.dart';
    import 'package:college_project/Apartments_Data/appartmentsData.dart';

    class ApartmentBookingPage extends StatefulWidget {
      final Appartmentsdata apartment;

      const ApartmentBookingPage({super.key, required this.apartment});

      @override
      _ApartmentBookingPageState createState() => _ApartmentBookingPageState();
    }

    class _ApartmentBookingPageState extends State<ApartmentBookingPage> {
      DateTimeRange? _selectedDateRange;


      double _calculateTotalPrice() {
        if (_selectedDateRange == null) return 0.0;
        final days = _selectedDateRange!.duration.inDays;
      
        return (days == 0 ? 1 : days) * widget.apartment.price;
      }

      void _showDatePicker() async {
        final DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime(2027),
          helpText: "Select Booking Dates",
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Colors.cyan,
                  onPrimary: Colors.white,
                  onSurface: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          setState(() {
            _selectedDateRange = picked;
          });
        }
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            title: const Text(
              "Confirm Booking",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
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

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
                      Text(
                        "Apartment in ${widget.apartment.area}",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.cyan,
                            size: 24,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.apartment.city,
                            style: TextStyle(color: Colors.grey[600], fontSize: 20),
                          ),
                        ],
                      ),

                      const Divider(height: 40, thickness: 1.2),

                  
                      const Text(
                        "Select Stay Duration:",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      InkWell(
                        onTap: _showDatePicker,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.cyan.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.cyan.withOpacity(0.05),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.calendar_month, color: Colors.cyan[700]),
                              Text(
                                _selectedDateRange == null
                                    ? "Choose Dates"
                                    : "${DateFormat('MMM dd, yyyy').format(_selectedDateRange!.start)} - ${DateFormat('MMM dd, yyyy').format(_selectedDateRange!.end)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Icon(Icons.edit, size: 20, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                  
                      if (_selectedDateRange != null)
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            children: [
                              _buildPriceRow(
                                "Price per night",
                                "\$${widget.apartment.price.toStringAsFixed(0)}",
                              ),
                              const SizedBox(height: 10),
                              _buildPriceRow(
                                "Total Nights",
                                "${_selectedDateRange!.duration.inDays} nights",
                              ),
                              const Divider(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total Amount",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    "\$${_calculateTotalPrice().toStringAsFixed(0)}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                      const SizedBox(height: 40),

                      // 5. زر التأكيد النهائي
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: _selectedDateRange == null
                              ? null
                              : () {
                                  
                                  final newBooking = BookingModel(
                                    id: widget.apartment.id
                                        .toString(),  
                                    apartmentArea: widget.apartment.area,
                                    image: widget.apartment.image,
                                    dateRange: _selectedDateRange!,
                                    totalPrice: _calculateTotalPrice(),
                                  );

                                  
                                  BookingManager.addBooking(newBooking);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Booking Saved Successfully! Now you can rate it.",
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );

                          
                                  Navigator.pop(context);
                                },
                          child: const Text(
                            "CONFIRM BOOKING",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }

    
      Widget _buildPriceRow(String label, String value) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 16)),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        );
      }
    }
