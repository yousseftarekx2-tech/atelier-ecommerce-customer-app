import 'package:flutter/material.dart';

class CheckoutContactSection extends StatelessWidget {
  const CheckoutContactSection({
    super.key,
    required this.fullName,
    required this.email,
  });

  final String? fullName;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '01  CONTACT',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE6E4E0)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (fullName != null && fullName!.isNotEmpty) ...[
                Text(
                  fullName!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
              ],
              if (email != null && email!.isNotEmpty)
                Text(
                  email!,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF777777),
                  ),
                ),
              if ((fullName == null || fullName!.isEmpty) &&
                  (email == null || email!.isEmpty))
                const Text(
                  'Account information is unavailable.',
                  style: TextStyle(fontSize: 13, color: Color(0xFF777777)),
                ),
              const SizedBox(height: 16),
              const Text(
                'Phone number (optional)',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Enter phone number',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
