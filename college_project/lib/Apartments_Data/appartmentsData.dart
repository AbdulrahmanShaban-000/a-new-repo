class Appartmentsdata {
  final int id;
  final String area;
  final double price;
  final String details;
  final String image;
  final int rooms;
  final String city;

  const Appartmentsdata({
    required this.city,
    required this.rooms,
    required this.id,
    required this.area,
    required this.price,
    required this.details,
    required this.image,
  });
  
factory Appartmentsdata.fromJson(Map<String, dynamic> json) {
    return Appartmentsdata(
      city: json['city'],
      rooms: json['rooms'],
      id: json['id'],
      area: json['area'],
      price: json['price'],
      details: json['details'],
      image: json['image'],
    );
  }
}


 List<Appartmentsdata> info = [
  Appartmentsdata(
    id: 1,
    area: "Damascus",
    price: 100,
    details:
        "This apartment (ID: 1) in Damascus offers a comfortable living experience at an attractive price of \$100. It features a spacious layout and classic interior design, with balconies overlooking a serene garden. The apartment is located in an upscale residential neighborhood, close to all essential services and public transportation, making it an ideal choice for small families or young individuals looking to settle in the vibrant heart of the city.",
    image: "images/img1.png",
    city: "Mazzeh",
    rooms: 2,
  ),
  Appartmentsdata(
    id: 2,
    area: "Damascus",
    price: 150,
    details:
        "A modern apartment (ID: 2) for rent in Damascus at \$150. It has been recently renovated and includes two bedrooms and two bathrooms, with an open-plan, fully equipped kitchen. It enjoys excellent natural light and luxurious finishes, offering a panoramic view of the city skyline. Perfect for young couples or professionals seeking elegance and comfort simultaneously.",
    image: "images/img2.png",
    city: "Mazzeh",
    rooms: 3,
  ),
  Appartmentsdata(
    id: 3,
    area: "Damascus",
    price: 150,
    details:
        "Discover this unique apartment (ID: 3) in the heart of Damascus, priced at \$150. It boasts a strategic location near markets and commercial centers, providing easy access to main roads. The apartment is fully furnished and consists of three spacious bedrooms, with an interior design that blends modernity and authenticity, making it ideal for large families looking for luxury and practicality.",
    image: "images/img3.png",
    city: "Mazzeh",
    rooms: 3,
  ),
  Appartmentsdata(
    id: 4,
    area: "Damascus",
    price: 150,
    details:
        "A quiet and comfortable apartment (ID: 4) in the peaceful suburbs of Damascus, priced at \$150. It offers an ideal environment for relaxation away from the city's hustle and bustle. It includes two bedrooms and an open living space, with a small private garden. Perfect for families with young children or anyone who appreciates tranquility and nearby green spaces.",
    image: "images/img4.png",
    city: "Abo-Rmaneh",
    rooms: 3,
  ),
  Appartmentsdata(
    id: 5,
    area: "Lattakia",
    price: 200,
    details:
        "Enjoy the beauty of the coast from this sea-view apartment (ID: 5) in Lattakia, priced at \$200. It features a spacious interior design and large balconies directly overlooking the Mediterranean Sea. It consists of two master bedrooms and a modern kitchen, ideal for lovers of tranquility and breathtaking sea views, and is just steps away from the beach.",
    image: "images/img5.png",
    city: "Jableh",
    rooms: 4,
  ),
  Appartmentsdata(
    id: 6,
    area: "Tartous",
    price: 200,
    details:
        "A luxurious apartment (ID: 6) in Tartous, located in a vibrant area near the port and services, priced at \$200. The apartment boasts elegant interior design and modern furniture, with three bedrooms and two bathrooms. It offers easy access to famous restaurants and cafes, making it ideal for those seeking a modern and comfortable life on the coast.",
    image: "images/img6.png",
    city: "Arowad",
    rooms: 4,
  ),
  Appartmentsdata(
    id: 7,
    area: "Tartous",
    price: 120,
    details:
        "An economical and excellent apartment (ID: 7) in Tartous, priced at \$120. Perfect for students or individuals. It is located in a quiet neighborhood near Tishreen University, providing a comfortable study and living environment. The apartment is small but practical, comprising one bedroom, a living room, and a small kitchen, with easy access to public transportation.",
    image: "images/img7.png",
    city: "Ein-Alzarqa",
    rooms: 2,
  ),
  Appartmentsdata(
    id: 8,
    area: "Lattakia",
    price: 230,
    details:
        "A distinctive investment apartment (ID: 8) in Lattakia, priced at \$230. Located in a vibrant tourist area, suitable as a holiday home or for short-term rental investment. It features a partial sea view and good finishes, with two spacious bedrooms, offering a good return on investment.",
    image: "images/img8.png",
    city: "Tshreen",
    rooms: 3,
  ),
  Appartmentsdata(
    id: 9,
    area: "Homs",
    price: 440,
    details:
        "In the heart of Homs, a lavish apartment (ID: 9) priced at \$440. It offers a regal stay with vast interior spaces and contemporary design. It consists of four master bedrooms, a large living room, and a fully equipped modern kitchen. The apartment features central heating and cooling, private parking, and is ideal for large families seeking the highest levels of luxury.",
    image: "images/img9.png",
    city: "Tadmur",
    rooms: 5,
  ),
  Appartmentsdata(
    id: 10,
    area: "Homs",
    price: 220,
    details:
        "A family apartment (ID: 10) in Homs, priced at \$220. It is located in a quiet residential neighborhood close to schools and parks, making it an excellent choice for families. The apartment consists of three bedrooms, two living rooms, and an equipped kitchen, providing ample and comfortable space for all family members, in addition to a wide balcony overlooking the neighborhood.",
    image: "images/img10.png",
    city: "Alhaddara",
    rooms: 4,
  ),
  Appartmentsdata(
    id: 11,
    area: "Homs",
    price: 220,
    details:
        "A brand new apartment (ID: 11) for rent in Homs, priced at \$220. Never lived in before, it features modern finishes and high quality. It is located in a new building with an elevator, offering two bedrooms, two bathrooms, and an American kitchen. Ideal for those seeking a clean, contemporary apartment at the best possible prices.",
    image: "images/img11.png",
    city: "Masyaf",
    rooms: 4,
  ),
  Appartmentsdata(
    id: 12,
    area: "Homs",
    price: 120,
    details:
        "An affordable apartment (ID: 12) in Homs, priced at \$120. Located in a popular and vibrant area, close to markets and transportation. The apartment is suitable for individuals or couples, consisting of one bedroom, a living room, a bathroom, and a kitchen. It is an excellent economic option for those looking for practical housing and a convenient location.",
    image: "images/img12.png",
    city: "Alzahraa",
    rooms: 3,
  ),
  Appartmentsdata(
    id: 13,
    area: "Homs",
    price: 410,
    details:
        "In the upscale area of Homs, a duplex apartment (ID: 13) priced at \$410. It boasts spacious areas and luxurious interior design spread over two floors, with an elegant internal staircase. It contains five bedrooms, three bathrooms, and multiple living spaces. It offers privacy and comfort, with a beautiful view of the city, and is considered a residential architectural masterpiece.",
    image: "images/img13.png",
    city: "Alzahraa",
    rooms: 5,
  ),
  Appartmentsdata(
    id: 14,
    area: "Aleppo",
    price: 400,
    details:
        "A restored historical apartment (ID: 14) in Old Aleppo, priced at \$400. The original character of the apartment has been preserved with the addition of modern touches. It features a traditional inner courtyard and spacious bedrooms with high ceilings. Ideal for history and heritage lovers who wish to reside in the heart of the ancient city, offering a unique living experience.",
    image: "images/img14.png",
    city: "Efrin",
    rooms: 5,
  ),
  Appartmentsdata(
    id: 15,
    area: "Aleppo",
    price: 120,
    details:
        "A student apartment (ID: 15) in Aleppo, priced at \$120. Located near Aleppo University and several colleges. The apartment is simple and practical, offering two shared bedrooms, a kitchen, and a bathroom. Suitable for a group of students or young individuals looking for shared accommodation at a low cost and a convenient location for studying.",
    image: "images/img15.png",
    city: "Salah-Eldeen",
    rooms: 4,
  ),
  Appartmentsdata(
    id: 16,
    area: "Aleppo",
    price: 220,
    details:
        "A medium-sized apartment (ID: 16) in Aleppo, priced at \$220. Located in a quiet and modern residential area, with easy access to commercial complexes and facilities. The apartment consists of two bedrooms and a spacious living room, with good finishes, making it a good choice for small families or new couples.",
    image: "images/img16.png",
    city: "Salah-Eldeen",
    rooms: 4,
  ),
  Appartmentsdata(
    id: 17,
    area: "Idlib",
    price: 190,
    details:
        "A charming rural apartment (ID: 17) in Idlib, priced at \$190. It offers a beautiful view of nature and green areas. The apartment is spacious and consists of three bedrooms, a rustic kitchen, and is ideal for families looking for peace and fresh air, away from the hustle of big cities, providing a healthy and comfortable environment.",
    image: "images/img17.png",
    city: "Sarmada",
    rooms: 3,
  ),
  Appartmentsdata(
    id: 18,
    area: "Daraa",
    price: 80,
    details:
        "The cheapest apartment (ID: 18) in Daraa, priced at \$80. It is a great opportunity for those looking for very low-cost housing. The apartment is simple and needs some renovations, but it provides a good foundation for living. It consists of one bedroom and a living room, located in a highly populated area close to local services.",
    image: "images/img18.png",
    city: "Ghabagheb",
    rooms: 1,
  ),
  Appartmentsdata(
    id: 19,
    area: "Daraa",
    price: 50,
    details:
        "A small and practical apartment (ID: 19) in Daraa, priced at \$50. Ideal for individuals or students. The apartment is compact and consists of a studio (one room with a small kitchen) and a bathroom. It is located in a central area and offers easy access to markets and transportation, making it the perfect choice for anyone looking for an extremely economical housing solution.",
    image: "images/img19.png",
    city: "Ghabagheb",
    rooms: 1,
  ),
  Appartmentsdata(
    id: 20,
    area: "Idlib",
    price: 300,
    details:
        "In Idlib, a modern apartment (ID: 20) priced at \$300. Located in a newly developed area, it features contemporary finishes and good facilities. It includes two bedrooms and two bathrooms, with a spacious balcony overlooking the city. Ideal for couples or small families looking for comfort and quality in a calm and beautiful environment.",
    image: "images/img20.png",
    city: "Sarmada",
    rooms: 4,
  ),
];
