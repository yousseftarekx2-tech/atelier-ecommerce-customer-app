import 'package:flutter/material.dart';

class CheckoutPaymentSection extends StatefulWidget {
  const CheckoutPaymentSection({super.key});

  @override
  State<CheckoutPaymentSection> createState() => _CheckoutPaymentSectionState();
}

class _CheckoutPaymentSectionState extends State<CheckoutPaymentSection> {
  String _selectedMethod = 'cash_on_delivery';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '04  PAYMENT',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        _PaymentOption(
          title: 'Cash on Delivery',
          subtitle: 'Pay when your order arrives',
          icon: Icons.payments_outlined,
          value: 'cash_on_delivery',
          selectedValue: _selectedMethod,
          onTap: () {
            setState(() {
              _selectedMethod = 'cash_on_delivery';
            });
          },
        ),
        const SizedBox(height: 10),
        _PaymentOption(
          title: 'Card Payment',
          subtitle: 'Credit or debit card',
          icon: Icons.credit_card_outlined,
          value: 'card',
          selectedValue: _selectedMethod,
          enabled: false,
          trailing: 'Coming Soon',
          onTap: null,
        ),
      ],
    );
  }
}

class _PaymentOption extends StatelessWidget {
  const _PaymentOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.value,
    required this.selectedValue,
    required this.onTap,
    this.enabled = true,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String value;
  final String selectedValue;
  final VoidCallback? onTap;
  final bool enabled;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == selectedValue;

    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.black : const Color(0xFFE6E4E0),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: enabled ? Colors.black : const Color(0xFFAAAAAA),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: enabled ? Colors.black : const Color(0xFF999999),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: enabled
                          ? const Color(0xFF777777)
                          : const Color(0xFFAAAAAA),
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              Text(
                trailing!,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF999999),
                ),
              )
            else
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
