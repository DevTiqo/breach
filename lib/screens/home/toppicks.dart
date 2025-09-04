import 'dart:math';

import 'package:breach/models/post_model.dart';
import 'package:breach/modules/http.dart';
import 'package:breach/notifiers/providers.dart';
import 'package:breach/theme/palette.dart';
import 'package:breach/utils/imageconsts.dart';
import 'package:breach/widgets/circularprogress.dart';
import 'package:breach/widgets/post_container.dart';
import 'package:breach/widgets/poststab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class TopPicks extends ConsumerStatefulWidget {
  final dynamic callDrawer;

  const TopPicks({required this.callDrawer, super.key});

  @override
  ConsumerState<TopPicks> createState() => _TopPicksState();
}

class _TopPicksState extends ConsumerState<TopPicks> {
  late RefreshController _refreshController;
  bool postloading = false;
  dynamic call;

  void _refreshPost() async {
    RequestResult? req;

    req = await ref
        .read(postsNotifierProvider.notifier)
        .getPosts(categoryId: 1);
    setState(() {});
    if (req?.ok ?? true) {
      _refreshController.refreshFailed();
    } else {
      _refreshController.refreshCompleted();
    }
    print('req.data');
  }

  callPostsAndCategories() async {
    await ref.read(categoriesNotifierProvider.notifier).getCategories();

    await ref
        .read(postsNotifierProvider.notifier)
        .getPosts(
          categoryId:
              ref.read(categoriesNotifierProvider).currentCategory?.id ?? 1,
        );

    return true;
  }

  @override
  void initState() {
    super.initState();
    call = callPostsAndCategories();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    callCategoriesModal() {
      showMaterialModalBottomSheet(
        //isDismissible: true,
        context: context,
        barrierColor: const Color(0xff07070C).withOpacity(0.9),
        backgroundColor: Colors.transparent,
        builder: (context) {
          return StatefulBuilder(
            builder: ((context, setStateModal) {
              return FractionallySizedBox(
                heightFactor: 0.85,
                child: Material(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(20),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Center(
                          child: SizedBox(
                            width: 70.0,
                            height: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.grayColor,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Select category',
                          style: AppTheme.bigText(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 1,
                          alignment: WrapAlignment.center,
                          children: ref
                              .read(categoriesNotifierProvider)
                              .categories
                              .map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(
                                          categoriesNotifierProvider.notifier,
                                        )
                                        .setCurrentCategory(e);
                                    Navigator.pop(context);
                                    callPostsAndCategories();
                                  },
                                  child: Chip(
                                    backgroundColor: AppTheme.primaryColor
                                        .withOpacity(0.1),
                                    label: Text(
                                      e.icon + e.name,
                                      style: AppTheme.normalText(context)
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.primaryColor,
                                          ),
                                    ),
                                  ),
                                );
                              })
                              .toList(),
                        ),

                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top Picks',
          style: AppTheme.bigText(
            context,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () {
            widget.callDrawer();
          },
          icon: Icon(Icons.view_list),
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Experience the best of Breach',
                          style: AppTheme.normalText(
                            context,
                          ).copyWith(fontWeight: FontWeight.w400),
                        ),

                        ref.read(postsNotifierProvider).postsFeatured.length > 0
                            ? BigPostContainer(
                                post: ref
                                    .read(postsNotifierProvider)
                                    .postsFeatured
                                    .first,
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 18),
                    onTap: () {
                      callCategoriesModal();
                    },
                    title: Text(
                      "Categories",
                      style: AppTheme.bigText(
                        context,
                      ).copyWith(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      "Discover content from topics you care about",
                      style: AppTheme.smallText(
                        context,
                      ).copyWith(fontWeight: FontWeight.w400),
                    ),
                    trailing:
                        ref.read(categoriesNotifierProvider).currentCategory !=
                            null
                        ? Chip(
                            backgroundColor: AppTheme.primaryColor.withOpacity(
                              0.1,
                            ),
                            label: Text(
                              ref
                                      .watch(categoriesNotifierProvider)
                                      .currentCategory!
                                      .icon +
                                  ref
                                      .watch(categoriesNotifierProvider)
                                      .currentCategory!
                                      .name,
                              style: AppTheme.normalText(context).copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            ),
          ];
        },
        body: FutureBuilder(
          future: call,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.waiting ||
                ref.watch(postsNotifierProvider).postsFeatured.isNotEmpty) {
              if (ref.watch(postsNotifierProvider).postsFeatured.isNotEmpty) {
                return PostsTab();
              } else {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      bottom: 54,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          'No  posts yet!',
                          style: AppTheme.bigText(context).copyWith(
                            //  color: Color(0),
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            'You can share your thoughts, get updates from categories above',
                            textAlign: TextAlign.center,
                            style: AppTheme.mediumText(context).copyWith(
                              color: AppTheme.grayColor,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Center(child: Text('Error'));
            } else {
              var shimmerlength = 4;
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: shimmerlength,
                itemBuilder: (_, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.1, horizontal: 5),
                  child: Shimmer.fromColors(
                    baseColor: AppTheme.grayColor.withOpacity(
                      shimmerlength / (shimmerlength + (index * shimmerlength)),
                    ),
                    highlightColor: AppTheme.grayColor.withOpacity(0.1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            // height: index == 1 ? 230 : 130.0,
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(5),
                              // border: Border.all(width: 5),
                              // color: Colors.red,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 45,
                                        width: 170,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: 75,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        height: index == 1 ? 150 : 45,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
