import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '/extensions/app_extension.dart';
import '../constants/app_images.dart';
import '../favs/favorites.dart';
import '/widgets/appbar.dart';
import '../helper/ui_helper.dart';
import '../model/Channel.dart';
import '../providers/home_provider.dart';
import '../user/data.dart';
import '../widgets/carosual_slider.dart';
import '../widgets/image_card.dart';

class All extends StatelessWidget {
  const All({super.key});

  @override
  Widget build(BuildContext context) {
    final resp = context.screenResp;
    final ser = context.watch<HomeProvider>();
    final fav = {
      'lab': 'Favorites',
      'ico': AppImages.favorite,
      'onTap': () => context.pushScreen(Favorites()),
      'color': Colors.white,
    };
    return Scaffold(
      appBar: MyAppBar(
        leading: IconButton(
          onPressed: ser.refreshChannels,
          icon: Icon(size: resp.height * 0.030, Icons.refresh_outlined),
        ),
        actions: [
          IconButton(
            iconSize: resp.height * 0.030,
            onPressed: fav['onTap'] as VoidCallback,
            icon: UIHelper.image(
              height: resp.height * 0.075,
              fav['ico'] as String,
              color: fav['color'] as Color,
            ),
          ),
        ],
        'All Channels',
      ),
      body:
          ser.isLoading
              ? Center(child: CircularProgressIndicator(color: AppColors.red))
              : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(height: resp.height * 0.015),
                    flipImages,
                    _buildChannels(context),
                  ],
                ),
              ),
    );
  }

  _buildChannels(BuildContext context) {
    final resp = MediaQuery.of(context).size;
    final ser = context.watch<HomeProvider>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UIHelper.text(
                'Channels',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              UIHelper.button(() => ser.toggleItem(1), 'All'),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(UserData.allChannels.length - 35, (i) {
              final rev = UserData.allChannels.reversed.toList();
              final sport = Channel.fromJson(rev[i]);
              return SizedBox(
                height: resp.height * 0.17,
                width: resp.width * 0.29,
                child: ImageCard(channel: sport),
              );
            }),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UIHelper.text(
                'Sports',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              UIHelper.button(() => ser.toggleItem(2), 'All'),
            ],
          ),
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(UserData.sportsItems.length, (i) {
              final rev = UserData.sportsItems.reversed.toList();
              final sport = Channel.fromJson(rev[i]);
              return SizedBox(
                height: resp.height * 0.17,
                width: resp.width * 0.29,
                child: ImageCard(channel: sport),
              );
            }),
          ),
        ),
        SizedBox(height: resp.height * 0.03),
      ],
    );
  }
}
