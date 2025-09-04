import 'package:breach/models/post_model.dart';
import 'package:breach/theme/palette.dart';
import 'package:breach/widgets/image_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';

class PostContainer extends ConsumerStatefulWidget {
  final Post post;
  final bool isWide;
  final bool isView;
  dynamic callbacktoReply;

  PostContainer({
    Key? key,
    required this.post,
    this.isWide = false,
    this.isView = false,
    this.callbacktoReply,
  }) : super(key: key);

  @override
  ConsumerState<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends ConsumerState<PostContainer> {
  bool showReactions = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool pollvoteloading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Key(widget.post.id.toString()),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Row(
        children: [
          widget.post.imageUrl != null && widget.post.imageUrl!.isNotEmpty
              ? ImageFullScreenWrapperWidget(
                  images: [widget.post.imageUrl!],
                  post: widget.post,
                  index: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ExtendedImage.network(
                        widget.post.imageUrl!,
                        fit: BoxFit.cover,

                        cache: true,
                      ),
                    ),
                  ),
                  dark: true,
                )
              : Container(),
          Column(
            children: [
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: widget.isView
                    ? null
                    : () {
                        // ref
                        //     .watch(postNotifierProvider.notifier)
                        //     .setCurrentPost(widget.post);
                        // context.push(
                        //   '/post/view/${widget.post.id}',
                        //   extra: widget.post,
                        // );
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.series.name.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: AppTheme.smallText(context).copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppTheme.greyColor,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 240),
                        child: Column(
                          children: [
                            Text(
                              widget.post.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.mediumText(
                                context,
                              ).copyWith(fontWeight: FontWeight.w600),
                            ),
                            RichText(
                              text: TextSpan(
                                text: widget.post.content ?? "",
                                style: AppTheme.smallText(context).copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.greyColor,
                                ),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            widget.post.author.name.toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppTheme.smallText(context).copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppTheme.greyColor,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.circle,
                            color: Colors.grey[500],
                            size: 4.0,
                          ),
                          SizedBox(width: 8),

                          Text(
                            Jiffy.parseFromDateTime(
                              widget.post.createdAt,
                            ).yMMMd.toUpperCase(),

                            style: AppTheme.smallText(context).copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppTheme.greyColor,
                            ),
                          ),
                          SizedBox(width: 4),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(height: 1, thickness: 0.4),
            ],
          ),
        ],
      ),
    );
  }
}

class BigPostContainer extends ConsumerStatefulWidget {
  final Post post;
  final bool isWide;
  final bool isView;
  dynamic callbacktoReply;

  BigPostContainer({
    Key? key,
    required this.post,
    this.isWide = false,
    this.isView = false,
    this.callbacktoReply,
  }) : super(key: key);

  @override
  ConsumerState<BigPostContainer> createState() => _BigPostContainerState();
}

class _BigPostContainerState extends ConsumerState<BigPostContainer> {
  bool showReactions = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool pollvoteloading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Key(widget.post.id.toString()),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      child: Column(
        children: [
          widget.post.imageUrl != null && widget.post.imageUrl!.isNotEmpty
              ? ImageFullScreenWrapperWidget(
                  images: [widget.post.imageUrl!],
                  post: widget.post,
                  index: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width - 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ExtendedImage.network(
                        widget.post.imageUrl!,
                        fit: BoxFit.cover,

                        cache: true,
                      ),
                    ),
                  ),
                  dark: true,
                )
              : Container(),
          Column(
            children: [
              InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: widget.isView
                    ? null
                    : () {
                        // ref
                        //     .watch(postNotifierProvider.notifier)
                        //     .setCurrentPost(widget.post);
                        // context.push(
                        //   '/post/view/${widget.post.id}',
                        //   extra: widget.post,
                        // );
                      },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 8),
                          Text(
                            widget.post.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.mediumText(
                              context,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
                          RichText(
                            text: TextSpan(
                              text: widget.post.content ?? "",
                              style: AppTheme.smallText(context).copyWith(
                                fontWeight: FontWeight.w400,
                                color: AppTheme.greyColor,
                              ),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
