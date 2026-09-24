class ShippingMethod {
  const ShippingMethod({
    required this.id,
    required this.name,
    required this.description,
  });

  final String id;
  final String name;
  final String description;

  static const standard = ShippingMethod(
    id: 'standard',
    name: 'Standard Delivery',
    description: '3–5 business days',
  );

  static const express = ShippingMethod(
    id: 'express',
    name: 'Express Delivery',
    description: '1–2 business days',
  );

  static const List<ShippingMethod> availableMethods = [standard, express];
}
