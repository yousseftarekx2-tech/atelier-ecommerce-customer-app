import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class LocationPickerResult {
  const LocationPickerResult({
    required this.latitude,
    required this.longitude,
    this.street,
    this.city,
    this.governorate,
    this.country,
  });

  final double latitude;
  final double longitude;
  final String? street;
  final String? city;
  final String? governorate;
  final String? country;
}

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  MapLibreMapController? _mapController;

  final Geocoding _geocoding = Geocoding(locale: const Locale('en', 'EG'));

  LatLng _selectedLocation = const LatLng(31.0994, 29.0661);

  bool _isConfirming = false;
  bool _isMovingToCurrentLocation = false;

  static const String _mapStyle = 'https://demotiles.maplibre.org/style.json';

  @override
  void initState() {
    super.initState();

    // Use the default Android platform-view rendering path.
    MapLibreMap.useHybridComposition = false;

    debugPrint('[LOCATION_PICKER] Screen initialized');
    debugPrint(
      '[MAPLIBRE] Hybrid composition: '
      '${MapLibreMap.useHybridComposition}',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Location'), centerTitle: true),
      body: Stack(
        children: [
          MapLibreMap(
            styleString: _mapStyle,
            initialCameraPosition: CameraPosition(
              target: _selectedLocation,
              zoom: 15,
            ),
            myLocationEnabled: false,
            myLocationTrackingMode: MyLocationTrackingMode.none,
            onMapCreated: (controller) {
              _mapController = controller;

              debugPrint('[MAPLIBRE] MAP CREATED');
            },
            onStyleLoadedCallback: () async {
              debugPrint('[MAPLIBRE] MAP STYLE LOADED');

              final controller = _mapController;

              if (controller == null) {
                debugPrint('[MAPLIBRE] CONTROLLER IS NULL');
                return;
              }

              try {
                final sourceIds = await controller.getSourceIds();

                final style = await controller.getStyle();

                debugPrint(
                  '[MAPLIBRE] STYLE SOURCE IDS COUNT: '
                  '${sourceIds.length}',
                );

                for (final sourceId in sourceIds) {
                  debugPrint(
                    '[MAPLIBRE] STYLE SOURCE ID: '
                    '$sourceId',
                  );
                }

                debugPrint(
                  '[MAPLIBRE] STYLE JSON AVAILABLE: '
                  '${style != null}',
                );

                if (style != null) {
                  debugPrint(
                    '[MAPLIBRE] STYLE JSON LENGTH: '
                    '${style.length}',
                  );
                }
              } catch (error, stackTrace) {
                debugPrint(
                  '[MAPLIBRE] STYLE INSPECTION ERROR: '
                  '$error',
                );

                debugPrint(
                  '[MAPLIBRE] STACK TRACE: '
                  '$stackTrace',
                );
              }
            },
            onMapClick: (point, coordinates) {
              _selectedLocation = coordinates;

              debugPrint(
                '[MAPLIBRE] MAP CLICK '
                'lat=${coordinates.latitude}, '
                'lng=${coordinates.longitude}',
              );
            },
            onMapIdle: () {
              debugPrint('[MAPLIBRE] MAP IDLE');
            },
            onCameraMove: (position) {
              _selectedLocation = position.target;

              debugPrint(
                '[MAPLIBRE] CAMERA MOVE '
                'lat=${position.target.latitude}, '
                'lng=${position.target.longitude}',
              );
            },
          ),
          const IgnorePointer(
            child: Center(
              child: Icon(Icons.location_pin, size: 48, color: Colors.black),
            ),
          ),
          Positioned(
            left: 8,
            bottom: 90,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.white,
              child: const Text(
                '© MapToolkit',
                style: TextStyle(fontSize: 10, color: Colors.black87),
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 100,
            child: FloatingActionButton(
              onPressed: _isMovingToCurrentLocation
                  ? null
                  : _goToCurrentLocation,
              child: _isMovingToCurrentLocation
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.my_location),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: FilledButton(
              onPressed: _isConfirming ? null : _confirmLocation,
              child: _isConfirming
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Confirm Location'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLocation() async {
    if (_isConfirming || !mounted) {
      return;
    }

    setState(() {
      _isConfirming = true;
    });

    final latitude = _selectedLocation.latitude;
    final longitude = _selectedLocation.longitude;

    debugPrint(
      '[LOCATION_PICKER] CONFIRM LOCATION '
      'lat=$latitude, '
      'lng=$longitude',
    );

    String? street;
    String? city;
    String? governorate;
    String? country;

    try {
      debugPrint('[GEOCODING] Starting reverse geocoding...');

      final placemarks = await _geocoding.placemarkFromCoordinates(
        latitude,
        longitude,
      );

      debugPrint(
        '[GEOCODING] Results count: '
        '${placemarks.length}',
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;

        debugPrint('[GEOCODING] Placemark: $placemark');

        street = _buildStreet(placemark);

        city = _firstNonEmpty([
          placemark.locality,
          placemark.subAdministrativeArea,
        ]);

        governorate = _firstNonEmpty([placemark.administrativeArea]);

        country = _firstNonEmpty([placemark.country]);

        debugPrint('[GEOCODING] STREET: $street');
        debugPrint('[GEOCODING] CITY: $city');
        debugPrint('[GEOCODING] GOVERNORATE: $governorate');
        debugPrint('[GEOCODING] COUNTRY: $country');
      } else {
        debugPrint('[GEOCODING] No placemark found');
      }
    } catch (error, stackTrace) {
      debugPrint('[GEOCODING] ERROR: $error');
      debugPrint('[GEOCODING] STACK TRACE: $stackTrace');
    }

    if (!mounted) {
      return;
    }

    final result = LocationPickerResult(
      latitude: latitude,
      longitude: longitude,
      street: street,
      city: city,
      governorate: governorate,
      country: country,
    );

    debugPrint('[LOCATION_PICKER] Returning location result');

    Navigator.of(context).pop(result);
  }

  String? _buildStreet(Placemark placemark) {
    final parts = <String>[];

    final street = placemark.street?.trim();
    final thoroughfare = placemark.thoroughfare?.trim();
    final subThoroughfare = placemark.subThoroughfare?.trim();

    if (street != null && street.isNotEmpty) {
      parts.add(street);
    }

    if (thoroughfare != null &&
        thoroughfare.isNotEmpty &&
        !parts.contains(thoroughfare)) {
      parts.add(thoroughfare);
    }

    if (subThoroughfare != null &&
        subThoroughfare.isNotEmpty &&
        !parts.contains(subThoroughfare)) {
      parts.add(subThoroughfare);
    }

    if (parts.isEmpty) {
      return null;
    }

    return parts.join(', ');
  }

  String? _firstNonEmpty(List<String?> values) {
    for (final value in values) {
      final normalized = value?.trim();

      if (normalized != null && normalized.isNotEmpty) {
        return normalized;
      }
    }

    return null;
  }

  Future<void> _goToCurrentLocation() async {
    if (_isMovingToCurrentLocation) {
      return;
    }

    setState(() {
      _isMovingToCurrentLocation = true;
    });

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      debugPrint(
        '[LOCATION_PICKER] Location service enabled: '
        '$serviceEnabled',
      );

      if (!serviceEnabled) {
        return;
      }

      var permission = await Geolocator.checkPermission();

      debugPrint(
        '[LOCATION_PICKER] Location permission: '
        '$permission',
      );

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        debugPrint(
          '[LOCATION_PICKER] Requested location permission: '
          '$permission',
        );
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      }

      final position = await Geolocator.getCurrentPosition();

      debugPrint(
        '[LOCATION_PICKER] Current position '
        'lat=${position.latitude}, '
        'lng=${position.longitude}',
      );

      if (!mounted) {
        return;
      }

      final location = LatLng(position.latitude, position.longitude);

      _selectedLocation = location;

      await _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: location, zoom: 16),
        ),
      );

      debugPrint('[LOCATION_PICKER] Camera moved to current location');
    } catch (error, stackTrace) {
      debugPrint('[LOCATION_PICKER] Location error: $error');
      debugPrint('[LOCATION_PICKER] Stack trace: $stackTrace');
    } finally {
      if (mounted) {
        setState(() {
          _isMovingToCurrentLocation = false;
        });
      }
    }
  }
}
