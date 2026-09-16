class HomeCollection {
  const HomeCollection({
    required this.name,
    required this.description,
    required this.image,
  });

  final String name;
  final String description;
  final String image;
}

abstract final class HomeMockData {
  static const collections = [
    HomeCollection(
      name: 'Essentials',
      description: 'Everyday elevated staples',
      image: 'assets/images/home/essentials.jpg',
    ),
    HomeCollection(
      name: 'Street',
      description: 'Architectural cuts & denim',
      image: 'assets/images/home/trending_now_2.jpg',
    ),
    HomeCollection(
      name: 'Minimal',
      description: 'Clean lines, neutral palette',
      image: 'assets/images/home/minimal.jpg',
    ),
    HomeCollection(
      name: 'Everyday',
      description: 'Effortless modular wardrobe',
      image: 'assets/images/home/everyday.jpg',
    ),
  ];
}
