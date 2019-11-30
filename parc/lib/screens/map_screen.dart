import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parc/blocs/areas_bloc/areas_bloc.dart';
import 'package:parc/blocs/areas_bloc/areas_state.dart';
import 'package:parc/blocs/map_bloc/bloc.dart';
import 'package:parc/blocs/reservation_bloc/bloc.dart';
import 'package:parc/blocs/timer_bloc/bloc.dart';
import 'package:parc/models/user.dart';
import 'package:parc/widgets/parcade_modal.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:async';
import 'dart:math';
import '../blocs/areas_bloc/bloc.dart';
import '../blocs/balance_bloc/bloc.dart';
import '../models/area.dart';

List<String> matches;

List<Area> areasList;

class BackendService {
  static Future<List> getSuggestions(String query) async {
    await Future.delayed(Duration(seconds: 1));
    List<Area> matches = List();

    matches.addAll(areasList);

    matches.retainWhere((s) => s.name.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

class MapScreen extends StatelessWidget {

  final User _user;
  final SuggestionsBoxController _searchController = SuggestionsBoxController();

  MapScreen(this._user);

  @override
  Widget build(BuildContext parentContext) {
    return BlocListener<MapBloc, MapState>(
      listener: (context, state) {
        if (state.openModal) {
          var future = showModalBottomSheet(
            context: parentContext,
            builder: (context) => ParcadeModal(
              parcade: state.tappedParcade,
              onPressed: () {
                BlocProvider.of<ReservationBloc>(parentContext)
                    .add(Reserve(state.tappedParcade, _user.id));
                BlocProvider.of<TimerBloc>(parentContext).add(Start());
                Navigator.pop(parentContext); // Close Modal
              },
            ),
          );
          future.then(
            (v) => BlocProvider.of<MapBloc>(parentContext).add(UnTapMarker()),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
              BlocBuilder<AreasBloc, AreasState>(
                // ignore: missing_return
                builder: (context, state) {
                  if (state is AreasLoaded) {
                    return TypeAheadField(
                      suggestionsBoxController: _searchController,
                      textFieldConfiguration: TextFieldConfiguration(
                          autofocus: true,
                          style: DefaultTextStyle.of(context).style.copyWith(fontStyle: FontStyle.italic),
                          decoration:
                              InputDecoration(border: OutlineInputBorder())),
                      suggestionsCallback: (pattern) async {
                        areasList = state.areas;
                        return BackendService.getSuggestions(pattern);
                      },
                      onSuggestionSelected:(suggestion){print('ana hena');},
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          leading: Icon(Icons.place),
                          title: Text(suggestion.name),
                          onTap: (){},
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
            ),
            SizedBox(
              height: 18,
            ),
            Expanded(
              flex: 1,
              child: BlocBuilder<MapBloc, MapState>(
                builder: (context, state) {
                  if (!state.isLoading) {
                    return GoogleMap(
                      markers: state.markers,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      zoomGesturesEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: state.latLng,
                        zoom: 15,
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
