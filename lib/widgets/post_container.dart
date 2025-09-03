import 'package:breach/models/post_model.dart';
import 'package:breach/theme/palette.dart';
import 'package:breach/widgets/image_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: 200),
                                    child: Text(
                                      widget.post.author.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTheme.normalText(
                                        context,
                                      ).copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(width: 2),

                                  SizedBox(width: 4),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'widget.post.createdAt.shortFrom()',
                                    style: AppTheme.smallText(context).copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.public,
                                    color: Colors.grey[500],
                                    size: 12.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            widget.isWide ? SizedBox(height: 20) : SizedBox(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                0.0,
                                0.0,
                                0.0,
                                0.0,
                              ),
                              // child: Text(
                              //   post.description ?? "",
                              //   style: AppTheme.mediumText(context)
                              //       .copyWith(
                              //         height: 1.4,
                              //         fontWeight: FontWeight.w500,
                              //       )
                              //       .merge(),
                              //   maxLines: 20,
                              // ),
                              child: RichText(
                                text: TextSpan(
                                  text: widget.post.description ?? "",
                                  style: AppTheme.mediumText(
                                    context,
                                  ).copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),

                            widget.post.imageUrl.isNotEmpty
                                ? ImageFullScreenWrapperWidget(
                                    images: [widget.post.imageUrl],
                                    post: widget.post,
                                    index: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ExtendedImage.network(
                                        widget.post.imageUrl,
                                        fit: BoxFit.cover,
                                        cache: true,
                                      ),
                                    ),
                                    dark: true,
                                  )
                                : Container(),

                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 0.4),
        ],
      ),
    );
  }
}
