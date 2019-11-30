import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parc/blocs/map_bloc/bloc.dart';
import 'package:parc/widgets/parcade_modal.dart';

class MapScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Hardcoded Data
    return BlocListener<MapBloc, MapState>(
      listener: (context, state) {
        if (state.openModal) {
          var future = showModalBottomSheet(
            context: context,
            builder: (context) => ParcadeModal(state.tappedParcade),
          );
          future.then(
            (v) => BlocProvider.of<MapBloc>(context).add(UnTapMarker()),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Search ...',
              ),
              controller: _searchController,
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
