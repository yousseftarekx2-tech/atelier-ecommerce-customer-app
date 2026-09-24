import 'package:flutter/material.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({super.key, required this.subtotal});

  final int subtotal;

  static const int freeDeliveryThreshold = 5000;
  static const int standardShipping = 150;

  @override
  Widget build(BuildContext context) {
    final hasFreeShipping = subtotal >= freeDeliveryThreshold;
    final shipping = hasFreeShipping ? 0 : standardShipping;
    final total = subtotal + shipping;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE6E4E0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SUMMARY',
                style: TextStyle(
                  color: Color(0xFF151515),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              _SummaryRow(label: 'Subtotal', value: _formatPrice(subtotal)),
              const SizedBox(height: 11),
              _SummaryRow(
                label: 'Estimated shipping',
                value: hasFreeShipping
                    ? 'FREE'
                    : _formatPrice(standardShipping),
                valueColor: hasFreeShipping
                    ? const Color(0xFF3D7A4A)
                    : const Color(0xFF151515),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Divider(height: 1, color: Color(0xFFE6E4E0)),
              ),
              _SummaryRow(
                label: 'Total',
                value: _formatPrice(total),
                isTotal: true,
              ),
              const SizedBox(height: 8),
              const Text(
                'Taxes included where applicable.',
                style: TextStyle(color: Color(0xFF999999), fontSize: 10),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: _TrustBadge(
                icon: Icons.lock_outline,
                text: 'Secure Checkout',
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _TrustBadge(
                icon: Icons.assignment_return_outlined,
                text: '14-Day Free Returns',
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatPrice(int value) {
    return 'EGP ${value.toString().replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => ',')}';
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final Color? valueColor;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: isTotal
                  ? const Color(0xFF151515)
                  : const Color(0xFF666666),
              fontSize: isTotal ? 14 : 12,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? const Color(0xFF151515),
            fontSize: isTotal ? 16 : 12,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _TrustBadge extends StatelessWidget {
  const _TrustBadge({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F3F0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE6E4E0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF666666)),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
