import 'package:blabla/theme/theme.dart';
import 'package:blabla/utils/date_time_util.dart';
import 'package:blabla/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import './ride_pref_textfield.dart';
import '../../../widgets/inputs/bla_location_picker.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      arrival = null;
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void onDeparture() async {
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(
        builder: (_) => BlaLocationPicker(initLocation: departure),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onArrival() async {
    Location? selectedLocation = await Navigator.of(context).push<Location>(
      MaterialPageRoute(
        builder: (_) => BlaLocationPicker(initLocation: arrival),
      ),
    );
    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void onSwapLocations() {
    setState(() {
      Location? temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  String get dateLabel => DateTimeUtils.formatDateTime(departureDate);
  bool get isFormValid => departure != null && arrival != null;
  Color get departureColor =>
      departure != null ? BlaColors.primary : BlaColors.greyLight;
  Color get arrivalColor => arrival != null ? BlaColors.primary : BlaColors.greyLight;
  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //Depature
        RidePrefTextField(
          label: departure != null ? departure!.name : "Leaving from",
          icon: Icons.location_on,
          iconColor: departure != null ? BlaColors.primary : BlaColors.iconLight,
          labelColor: departure != null ? BlaColors.primary : BlaColors.neutralLight,
          onPressed: onDeparture,
          rightIcon: Icons.swap_vert,
          onRightIconPressed: onSwapLocations,
        ),
        Divider(height: 1, thickness: 1, color: BlaColors.greyLight),
        //Arrival
        RidePrefTextField(
          label: arrival != null ? arrival!.name : "Going to",
          icon: Icons.location_on,
          iconColor: arrival != null ? BlaColors.primary : BlaColors.iconLight,
          labelColor: arrival != null ? BlaColors.primary : BlaColors.neutralLight,
          onPressed: onArrival,
        ),
        Divider(height: 1, thickness: 1, color: BlaColors.greyLight),
        RidePrefTextField(
          label: dateLabel,
          icon: Icons.calendar_month,
          iconColor: departure != null ? BlaColors.primary : BlaColors.iconLight,
          labelColor: departure != null ? BlaColors.primary : BlaColors.neutralLight,
          onPressed: () => {},
        ),
        Divider(height: 1, thickness: 1, color: BlaColors.greyLight),
        RidePrefTextField(
          label: requestedSeats.toString(),
          icon: Icons.person_2_outlined,
          onPressed: () => {},
        ),
        BlaButton(text: "Search", onPressed: isFormValid ? () {} : null),
        // SizedBox(
        //   child: OutlinedButton(
        //     style: OutlinedButton.styleFrom(
        //       backgroundColor: BlaColors.primary,
        //       padding: EdgeInsets.symmetric(vertical: 20),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(BlaSpacings.radius),
        //       ),
        //       side: BorderSide(color: BlaColors.primary),
        //     ),
        //     onPressed: () => {},
        //     child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //       Text("Search", style: BlaTextStyles.button.copyWith(color: BlaColors.white),)
        //     ],),
        //   ),
        // ),
      ],
    );
  }
}
