import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../products/data/product_mock_data.dart';
import '../../cubit/cart_cubit.dart';
import '../../domain/entities/cart_item.dart';
import 'cart_quantity_control.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    final product = ProductMockData.findById(item.productId);

    if (product == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE6E4E0)),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Color(0xFF999999)),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'This product is no longer available.',
                style: TextStyle(color: Color(0xFF666666), fontSize: 12),
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<CartCubit>().removeItem(item.key);
              },
              icon: const Icon(Icons.close, size: 18, color: Color(0xFF666666)),
            ),
          ],
        ),
      );
    }

    final hasOldPrice =
        product.compareAtPrice != null &&
        product.compareAtPrice! > item.unitPrice;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E4E0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductImage(image: product.image, badge: product.badge),
          const SizedBox(width: 14),
          Expanded(
            child: SizedBox(
              height: 105,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProductHeader(
                    name: product.name,
                    onRemove: () {
                      context.read<CartCubit>().removeItem(item.key);
                    },
                  ),
                  const SizedBox(height: 7),
                  _VariantInfo(color: item.color, size: item.size),
                  const Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _PriceInfo(
                          price: item.unitPrice,
                          oldPrice: hasOldPrice ? product.compareAtPrice : null,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CartQuantityControl(
                        quantity: item.quantity,
                        onDecrease: () {
                          context.read<CartCubit>().decrement(item.key);
                        },
                        onIncrease: () {
                          context.read<CartCubit>().increment(item.key);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.image, required this.badge});

  final String image;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: 84,
            height: 105,
            color: const Color(0xFFF4F3F0),
            child: image.startsWith('http')
                ? Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) {
                      return const Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: Color(0xFF999999),
                        ),
                      );
                    },
                  )
                : Image.asset(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) {
                      return const Center(
                        child: Icon(
                          Icons.image_outlined,
                          color: Color(0xFF999999),
                        ),
                      );
                    },
                  ),
          ),
        ),
        if (badge != null && badge!.isNotEmpty)
          Positioned(
            top: 7,
            left: 7,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: badge!.toUpperCase() == 'SALE'
                    ? const Color(0xFFE53935)
                    : const Color(0xFF151515),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                badge!.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ProductHeader extends StatelessWidget {
  const _ProductHeader({required this.name, required this.onRemove});

  final String name;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF151515),
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 6),
        GestureDetector(
          onTap: onRemove,
          behavior: HitTestBehavior.opaque,
          child: const SizedBox(
            width: 28,
            height: 28,
            child: Align(
              alignment: Alignment.topRight,
              child: Icon(Icons.close, size: 17, color: Color(0xFF666666)),
            ),
          ),
        ),
      ],
    );
  }
}

class _VariantInfo extends StatelessWidget {
  const _VariantInfo({required this.color, required this.size});

  final String color;
  final String size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 11,
          height: 11,
          decoration: BoxDecoration(
            color: _colorFromName(color),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE0DEDA)),
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            color,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, color: Color(0xFF666666)),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF4F3F0),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            'Size $size',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF666666),
            ),
          ),
        ),
      ],
    );
  }

  Color _colorFromName(String value) {
    final normalized = value.toLowerCase();

    if (normalized.contains('black') ||
        normalized.contains('obsidian') ||
        normalized.contains('charcoal')) {
      return const Color(0xFF252525);
    }

    if (normalized.contains('grey') || normalized.contains('gray')) {
      return const Color(0xFF737373);
    }

    if (normalized.contains('olive')) {
      return const Color(0xFF74765B);
    }

    if (normalized.contains('khaki')) {
      return const Color(0xFFA39A7A);
    }

    if (normalized.contains('bone') ||
        normalized.contains('oatmeal') ||
        normalized.contains('sand')) {
      return const Color(0xFFD8D0C0);
    }

    if (normalized.contains('umber')) {
      return const Color(0xFF5B4435);
    }

    return const Color(0xFFB7B3AC);
  }
}

class _PriceInfo extends StatelessWidget {
  const _PriceInfo({required this.price, required this.oldPrice});

  final int price;
  final int? oldPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'EGP ${_formatPrice(price)}',
          style: const TextStyle(
            color: Color(0xFF151515),
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        if (oldPrice != null) ...[
          const SizedBox(height: 2),
          Text(
            'EGP ${_formatPrice(oldPrice!)}',
            style: const TextStyle(
              color: Color(0xFF999999),
              fontSize: 10,
              decoration: TextDecoration.lineThrough,
              decorationColor: Color(0xFF999999),
            ),
          ),
        ],
      ],
    );
  }

  String _formatPrice(int value) {
    return value.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }
}
