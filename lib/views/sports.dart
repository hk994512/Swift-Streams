import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/extensions/app_extension.dart';
import '../model/Channel.dart';
import '../user/data.dart';
import '/widgets/image_card.dart';

import '/providers/home_provider.dart';
import '/providers/fav_provider.dart';
import '../widgets/grid_items.dart';
import '/widgets/appbar.dart';

class Sports extends StatelessWidget {
  const Sports({super.key});

  @override
  Widget build(BuildContext context) {
    final fav = context.watch<FavProvider>();
    final ref = context.watch<HomeProvider>();
    final resp = context.screenResp;
    return Scaffold(
      appBar: MyAppBar('Sports', appSize: resp.height * 0.07),
      body:
          ref.isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.red))
              : RefreshIndicator(
                onRefresh: () => ref.refreshChannels(),
                child: GridItems(
                  itemCount: UserData.sportsItems.length,
                  builder: (_, i) {
                    final channel = Channel.fromJson(UserData.sportsItems[i]);
                    return GestureDetector(
                      onLongPress: () {
                        fav.toggleFavs(channel);
                        fav.favChannel(channel, context);
                      },
                      child: ImageCard(channel: channel),
                    );
                  },
                ),
              ),
    );
  }
}
