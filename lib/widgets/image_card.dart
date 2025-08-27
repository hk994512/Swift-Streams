import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/widgets/marquee.dart';
import '/extensions/app_extension.dart';
import '../constants/app_colors.dart';
import '../helper/ui_helper.dart';
import '../model/Channel.dart';
import '../providers/player_pro.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({super.key, required this.channel});
  final Channel channel;
  @override
  Widget build(BuildContext context) {
    final play = context.read<PlayerPro>();
    final resp = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GestureDetector(
        onTap: () => play.openMiniPlayer(stream: channel.videoUrl),
        child: Card(
          child: ClipRect(
            clipBehavior: Clip.hardEdge,
            child: Container(
              height: resp.height * 0.3,
              width: resp.width,
              decoration: BoxDecoration(
                color: AppColors.appColor,
                border: Border.all(width: 4, color: AppColors.appColor),
                borderRadius: BorderRadius.horizontal(),
              ),
              child: Wrap(
                spacing: 10,
                alignment: WrapAlignment.center,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  UIHelper.image(
                    channel.image,
                    width: 150,
                    fit: BoxFit.cover,
                    isAsset: false,
                  ),
                  3.0.getSize,
                  SizedBox(
                    height: resp.height * 0.025,
                    child: marqeeText(
                      channel.title,
                      GoogleFonts.mooli(color: AppColors.white ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
