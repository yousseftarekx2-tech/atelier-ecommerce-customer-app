import 'package:atelier_customer/core/theme/app_radius.dart';
import 'package:atelier_customer/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class CartQuantityControl extends StatelessWidget {
  const CartQuantityControl({
    super.key,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(AppRadius.r9),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QuantityButton(icon: Icons.remove, onPressed: onDecrease),
          SizedBox(
            width: 28,
            child: Center(
              child: Text(
                '$quantity',
                style: AppTextStyles.labelMedium.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          _QuantityButton(icon: Icons.add, onPressed: onIncrease),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(AppRadius.r8),
        child: SizedBox(
          width: 32,
          height: 32,
          child: Icon(icon, size: 15, color: colorScheme.onSurface),
        ),
      ),
    );
  }
}
