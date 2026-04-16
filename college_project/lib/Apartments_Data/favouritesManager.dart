import 'appartmentsData.dart';

class FavouritesManager {
  static List<Appartmentsdata> favourites = [];

  static bool isFavourite(Appartmentsdata apartment) {
    return favourites.any((item) => item.id == apartment.id);
  }

  static void toggleFavourite(Appartmentsdata apartment) {
    if (isFavourite(apartment)) {
      favourites.removeWhere((item) => item.id == apartment.id);
    } else {
      favourites.add(apartment);
    }
  }
}
