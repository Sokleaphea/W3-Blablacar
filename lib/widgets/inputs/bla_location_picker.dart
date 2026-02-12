import 'package:blabla/services/locations_service.dart';
import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../theme/theme.dart';

class BlaLocationPicker extends StatefulWidget {
  const BlaLocationPicker({super.key, required this.initLocation});

  final Location? initLocation;

  @override
  State<BlaLocationPicker> createState() => _BlaLocationPickerState();
}

class _BlaLocationPickerState extends State<BlaLocationPicker> {
  String searchText = "";

  void onTap(Location location) {
    Navigator.pop<Location>(context, location);
  }

  void onBackTap() {
    Navigator.pop<Location>(context);
  }

  @override
  void initState() {
    super.initState();

    // Initilize the search bar if any initial location
    if (widget.initLocation != null) {
      setState(() {
        searchText = widget.initLocation!.name;
      });
    }
  }

  void onSearchChanged(String search) {
    setState(() {
      searchText = search;
    });
  }

  List<Location> get filteredLocation {
    return LocationsService.availableLocations
        .where(
          (location) =>
              location.name.toLowerCase().contains(searchText.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: BlaSpacings.m,
          right: BlaSpacings.m,
          top: BlaSpacings.s,
        ),
        child: Column(
          children: [
            LocationSearchBar(
              initSearch: searchText,
              onBack: onBackTap,
              onSearchChanged: onSearchChanged,
            ),

            SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: filteredLocation.length,
                itemBuilder: (context, index) => LocationTile(
                  location: filteredLocation[index],
                  onTap: onTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocationSearchBar extends StatefulWidget {
  final String initSearch;
  final VoidCallback onBack;
  final ValueChanged<String> onSearchChanged;
  const LocationSearchBar({
    super.key,
    required this.onBack,
    required this.onSearchChanged,
    required this.initSearch,
  });

  @override
  State<LocationSearchBar> createState() => _LocationSearchBarState();
}

class _LocationSearchBarState extends State<LocationSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  void onClearTap() {
    _searchController.clear();
  }

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initSearch;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool get searchIsNotEmpty => _searchController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BlaColors.greyLight,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBack,
            icon: Icon(
              Icons.arrow_back_ios,
              color: BlaColors.iconLight,
              size: 16,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: widget.onSearchChanged,
              style: TextStyle(color: BlaColors.textLight),
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: false,
              ),
            ),
          ),
          searchIsNotEmpty
              ? IconButton(
                  onPressed: onClearTap,
                  icon: Icon(Icons.close, color: BlaColors.iconLight, size: 16),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}

class LocationTile extends StatelessWidget {
  const LocationTile({super.key, required this.location, required this.onTap});

  final Location location;

  final ValueChanged<Location> onTap;

  String get title => location.name;

  String get subTitle => location.country.name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () => onTap(location),
          leading: Icon(Icons.history, color: BlaColors.iconLight),

          title: Text(title, style: BlaTextStyles.body),
          subtitle: Text(
            subTitle,
            style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
          ),

          trailing: Icon(
            Icons.arrow_forward_ios,
            color: BlaColors.iconLight,
            size: 16,
          ),
        ),
      ],
    );
  }
}
