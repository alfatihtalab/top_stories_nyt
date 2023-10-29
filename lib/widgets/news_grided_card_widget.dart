import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../models/story_detail/story_detail.dart';
import '../utilities/shimmer_loading_effect.dart';

// Grided
class NewsGridedCardWidget extends StatelessWidget {
  const NewsGridedCardWidget(
      {super.key, required this.onTap, required this.storyDetail});

  final VoidCallback onTap;
  final StoryDetail storyDetail;

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final screenSize = MediaQuery.of(context).size;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    // print(isPortrait);
    return InkWell(
      onTap: onTap,
      child: Container(
          // height: 300,
          padding: const EdgeInsets.all(4.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,

                  child: CachedNetworkImage(
                    imageUrl: storyDetail.imageUrl! ,
                    fit: BoxFit.cover,
                    // height: 90,
                    // width: 90,

                    //   opacity: restaurantData.isAvailable
                    //       ? const AlwaysStoppedAnimation(1)
                    //       : const AlwaysStoppedAnimation(0.5),
                    placeholder: (context, url) => SizedBox(
                      child: Shimmer(
                          gradient: isDarkMode? shimmerGradientDark: shimmerGradientLight,
                          child:  const ImageLoadingPlaceholder(
                            isLoading: true,
                            // height: 90,
                            // width: 90,
                          )),
                    ),
                    errorWidget: (context, url, error) => const
                    ImageLoadingPlaceholder(
                      isLoading: true,
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,

                          // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn)


                        ),
                      ),
                    ),

                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                const Divider(),
                Flexible(
                  // flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        // height: 70,
                        child: Text(
                          "${storyDetail.title}",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(overflow: TextOverflow.ellipsis),
                          softWrap: false,
                          maxLines: 2,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        // height: 22,
                        child: Text(
                          "${storyDetail.description}",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                          softWrap: false,
                          maxLines: isPortrait ? 1 : 3,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ])),
    );
  }
}
