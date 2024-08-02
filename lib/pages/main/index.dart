import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mkh_chat/providers/main/index.dart';
import 'package:mkh_chat/providers/main/location.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: context.read<LocationProvider>().mapController,
            options: MapOptions(
              initialCenter: LatLng(37.5665, 126.9780),
              initialZoom: 19,
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.all,
                debugMultiFingerGestureWinner: true,
                enableMultiFingerGestureRace: true,
              )
            ),
            children: [

              TileLayer(
                urlTemplate:
                'https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key={accessToken}',
                additionalOptions: {
                  'accessToken': '7pWvUMyW9PnJY5JS1OY1',
                },
              ),
              MarkerLayer(markers: [
                Marker(
                  rotate: false,
                  width: 100,
                  height: 100,
                  point: context.watch<LocationProvider>().currentLocation??LatLng(37.5665, 126.9780),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red,
                    ),
                    child: Center(child: Text("내 위치임 ㅅㄱ")),
                  ),
                )
              ]),
            ],),
          SlidingUpPanel(
            panel: const Center(child: Text("This is the sliding Widget"),),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.chat_bubble_outline_rounded, size: 40, color: Colors.white,),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: context.watch<MainProvider>().currentIndex,
      onTap:context.read<MainProvider>().onTapBottomNavigationBarItem,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 10,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.group, size: 40, color: Theme.of(context).iconTheme.color,),
          activeIcon: Column(
            children: [
              Text("Home", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).iconTheme.color,
                fontWeight: FontWeight.w500
              ),),
              const SizedBox(height: 8,),
              CircleAvatar(radius: 3,backgroundColor: Theme.of(context).iconTheme.color)
            ],
          ),
          label: ''
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined, size: 40 , color: Theme.of(context).iconTheme.color,),
            activeIcon: Column(
              children: [
                Text("Place", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).iconTheme.color,
                    fontWeight: FontWeight.w500
                ),),
                const SizedBox(height: 8,),
                CircleAvatar(radius: 3,backgroundColor: Theme.of(context).iconTheme.color)
              ],
            ),
            label: ""
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.more_horiz, size: 40,),
          activeIcon: Column(
            children: [
              Text("More", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).iconTheme.color,
                  fontWeight: FontWeight.w500
              ),),
              const SizedBox(height: 8,),
              CircleAvatar(radius: 3,backgroundColor: Theme.of(context).iconTheme.color)
            ],
          ),
          label: ""
        ),

      ],
    );
  }
}
