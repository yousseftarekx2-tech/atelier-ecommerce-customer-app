import 'package:atelier_customer/features/products/data/product_mock_data.dart';

import '../domain/entities/look.dart';

abstract final class LookMockData {
  static final List<Look> looks = [
    Look(
      id: 'light-after-dark',
      title: 'LIGHT AFTER DARK',
      eyebrow: 'LOOK 01',
      tag: 'MINIMAL',
      description:
          'A clean layered uniform built for late city hours and gallery openings.',
      heroImage: 'assets/images/home/picked_3.jpg',
      products: [
        ProductMockData.findById('product_003')!,
        ProductMockData.findById('product_016')!,
        ProductMockData.findById('product_006')!,
        ProductMockData.findById('product_005')!,
      ],
    ),
    Look(
      id: 'city-static',
      title: 'CITY STATIC',
      eyebrow: 'LOOK 02',
      tag: 'STREET',
      description:
          'Clean structure with a decisive street tailoring edge and technical outerwear.',
      heroImage: 'assets/images/home/trending_now_2.jpg',
      products: [
        ProductMockData.findById('product_010')!,
        ProductMockData.findById('product_014')!,
        ProductMockData.findById('product_022')!,
        ProductMockData.findById('product_005')!,
      ],
    ),
    Look(
      id: 'off-duty',
      title: 'OFF DUTY',
      eyebrow: 'LOOK 03',
      tag: 'CASUAL',
      description:
          'Relaxed silhouette pieces constructed for everyday unscripted movement.',
      heroImage: 'assets/images/home/new_arrivals_1.jpg',
      products: [
        ProductMockData.findById('product_007')!,
        ProductMockData.findById('product_014')!,
        ProductMockData.findById('product_023')!,
      ],
    ),
    Look(
      id: 'after-hours',
      title: 'AFTER HOURS',
      eyebrow: 'LOOK 04',
      tag: 'BOLD',
      description:
          'Sharper tonal silhouettes tailored for dusk onwards and refined nightlife.',
      heroImage: 'assets/images/home/trending_now_2.jpg',
      products: [
        ProductMockData.findById('product_003')!,
        ProductMockData.findById('product_018')!,
        ProductMockData.findById('product_005')!,
        ProductMockData.findById('product_024')!,
      ],
    ),
  ];

  static Look? findById(String id) {
    for (final look in looks) {
      if (look.id == id) {
        return look;
      }
    }

    return null;
  }
}
