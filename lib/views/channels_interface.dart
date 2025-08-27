import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/extensions/app_extension.dart';
import '/widgets/image_card.dart';
import '/constants/app_colors.dart';
import '/providers/home_provider.dart';
import '/helper/ui_helper.dart';
import '../providers/fav_provider.dart';
import '../widgets/grid_items.dart';
import '/model/Channel.dart';
import '/user/data.dart';
import 'drawer.dart';

class Channels extends StatefulWidget {
  const Channels({super.key});

  @override
  State<Channels> createState() => _ChannelsState();
}

class _ChannelsState extends State<Channels> {
  bool isSearching = false;
  String searchedValue = '';
  final searchedController = TextEditingController();

  @override
  void dispose() {
    searchedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resp = context.screenResp;
    final fav = context.watch<FavProvider>();
    final ref = context.watch<HomeProvider>();
    final filteredItems =
        UserData.items.where((item) {
          final title = (item['title'] ?? '').toString().toLowerCase();
          if (searchedValue.isEmpty) return true;
          return title.contains(searchedValue.toLowerCase());
        }).toList();

    return Scaffold(
      drawer: AppDrawer(),

      appBar: AppBar(
        toolbarHeight: resp.height * 0.07,
        title:
            isSearching
                ? TextField(
                  controller: searchedController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Search channels...",
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.mooli(color: AppColors.white70),
                  ),
                  style: GoogleFonts.mooli(color: AppColors.white),
                  onChanged: (value) {
                    setState(() {
                      searchedValue = value;
                    });
                  },
                )
                : UIHelper.text(
                  'Channels',
                  fontSize: 20,
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchedValue = '';
                  searchedController.clear();
                }
              });
            },
            icon: Icon(
              isSearching ? Icons.close : Icons.search,
              size: resp.height * 0.035,
            ),
          ),
        ],
      ),

      body:
          ref.isLoading
              ? Center(child: CircularProgressIndicator(color: AppColors.red))
              : filteredItems.isEmpty
              ? Center(
                child: UIHelper.text(
                  'No channels found!',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              )
              : RefreshIndicator(
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                onRefresh: ref.refreshChannels,
                child: GridItems(
                  itemCount: filteredItems.length,
                  builder: (_, i) {
                    final channel = Channel.fromJson(filteredItems[i]);
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
