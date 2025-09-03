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

  callPosts() async {
    // if (ref.read(postsNotifierProvider).posts.isEmpty) {
    return await ref
        .read(postsNotifierProvider.notifier)
        .getPosts(categoryId: 1);
    // } else {
    //   return true;
    // }
  }

  @override
  void initState() {
    super.initState();
    call = callPosts();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top Picks',
          style: AppTheme.bigText(
            context,
          ).copyWith(fontWeight: FontWeight.w500),
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
              child: Padding(
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
                  ],
                ),
              ),
            ),
          ];
        },
        body: SmartRefresher(
          header: const MaterialClassicHeader(),
          enablePullDown: true,
          controller: _refreshController,
          onRefresh: _refreshPost,
          child: FutureBuilder(
            future: call,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.waiting ||
                  ref.watch(postsNotifierProvider).postsFeatured.isNotEmpty) {
                if (ref.watch(postsNotifierProvider).postsFeatured.isNotEmpty) {
                  return ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: ref
                                .watch(postsNotifierProvider)
                                .postsFeatured
                                .length,
                            itemBuilder: ((context, index) {
                              Post thispost = ref
                                  .watch(postsNotifierProvider)
                                  .postsFeatured[index];
                              return PostContainer(
                                key: Key(thispost.id.toString()),
                                post: thispost,
                              );
                            }),
                          );
                        },
                      ),
                      SizedBox(height: 30),
                      // postloading
                      //     ? Center(child: CircularProgress())
                      //     : (ref.watch(postsNotifierProvider).hasMorePosts !=
                      //               null &&
                      //           !ref.watch(postsNotifierProvider).hasMorePosts!)
                      //     ? Icon(
                      //         Icons.circle,
                      //         size: 12,
                      //         color: ref.watch(themeNotifier).data.cardColor,
                      //       )
                      //     : SizedBox(),
                      SizedBox(height: 100.0),
                    ],
                  );
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
                              'You can share your thoughts, get updates or banter your mates by sharing posts',
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
                        shimmerlength /
                            (shimmerlength + (index * shimmerlength)),
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
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 15,
                                          width: 170,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 25,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          height: index == 1 ? 150 : 25,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              20,
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
      ),
    );
  }
}
