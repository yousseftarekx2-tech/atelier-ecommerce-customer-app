class Address {
  const Address({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.label,
    required this.street,
    required this.city,
    this.governorate,
    this.country = 'Egypt',
    this.isDefault = false,
    this.latitude,
    this.longitude,
  });

  final String id;
  final String fullName;
  final String phone;
  final String label;
  final String street;
  final String city;
  final String? governorate;
  final String country;
  final bool isDefault;
  final double? latitude;
  final double? longitude;
}