import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData? _pickedLocation;
  bool _isGettingLocation = false;

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No location choses',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );

    void _getCurrentLocation() async {
      Location location = Location();

      bool serviceEnabled;
      PermissionStatus permissionGranted;
      LocationData locationData;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      setState(() {
        _isGettingLocation = true;
      });

      locationData = await location.getLocation();

      setState(() {
        _isGettingLocation = false;
        _pickedLocation = locationData;
      });

      print(locationData);
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    if (_pickedLocation != null) {
      previewContent = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _pickedLocation!.latitude.toString(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            _pickedLocation!.longitude.toString(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Get current location'),
              onPressed: _getCurrentLocation,
            ),
            TextButton.icon(
              icon: const Icon(Icons.location_on),
              label: const Text('Select on Map'),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
