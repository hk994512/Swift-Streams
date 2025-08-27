import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/widgets/image_card.dart';

import '/helper/ui_helper.dart';
import '/widgets/grid_items.dart';
import '/providers/fav_provider.dart';
import '/widgets/appbar.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    final favProvider = context.watch<FavProvider>();
    return Scaffold(
      appBar: MyAppBar('Favorites'),
      body:
          favProvider.favsItems.isEmpty
              ? Center(
                child: UIHelper.text(
                  'No Favorite Channel found',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              )
              : GridItems(
                itemCount: favProvider.favsItems.length,
                builder: (_, i) {
                  final channel = favProvider.favsItems[i];
                  return GestureDetector(
                    onLongPress: () {
                      favProvider.toggleFavs(channel);
                      favProvider.favChannel(channel, context);
                    },
                    onTap: () => favProvider.toggleFavs(channel),
                    child: ImageCard(channel: channel),
                  );
                },
              ),
    );
  }
}
