import 'package:breach/notifiers/providers.dart';
import 'package:breach/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsTab extends ConsumerStatefulWidget {
  const PostsTab({super.key});

  @override
  ConsumerState<PostsTab> createState() => _PostsTabState();
}

class _PostsTabState extends ConsumerState<PostsTab>
    with TickerProviderStateMixin {
  late TabController tabController;

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          fit: StackFit.passthrough,
          children: [
            Container(
              color: ref.read(themeNotifier).data.scaffoldBackgroundColor,
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.label,
                controller: tabController,
                labelColor: AppTheme.primaryColor,
                indicatorWeight: 3.0,
                indicatorColor: AppTheme.primaryColor,
                indicatorPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 0,
                ),
                padding: EdgeInsets.only(top: 4),
                labelStyle: AppTheme.smallText(context).copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w800,
                ),
                onTap: ((value) {
                  if (value == 0) {
                  } else if (value == 1) {
                  } else if (value == 2) {}
                }),
                unselectedLabelColor: ref.read(themeNotifier).darkTheme
                    ? AppTheme.white
                    : AppTheme.grayColor,
                unselectedLabelStyle: AppTheme.smallText(context).copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Featured',
                          style: AppTheme.smallText(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Popular',
                          style: AppTheme.smallText(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Recent',
                          style: AppTheme.smallText(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ref.read(themeNotifier).darkTheme
                      ? AppTheme.white.withValues(alpha: 0.4)
                      : AppTheme.grayColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 1.5),
        Expanded(
          child: TabBarView(
            // physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              ref.read(postsNotifierProvider).postsFeatured.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 2.5),
                        Text(
                          "No Featured posts",
                          textAlign: TextAlign.center,
                          style: AppTheme.smallText(context).copyWith(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF828282),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: ref
                          .read(postsNotifierProvider)
                          .postsFeatured
                          .length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 0.3),
                          child: InkWell(
                            onTap: () {},
                            child: Ink(
                              decoration: BoxDecoration(
                                color: ref
                                    .read(themeNotifier)
                                    .data
                                    .scaffoldBackgroundColor,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    blurRadius: 1.0,
                                    offset: Offset(0.0, 0.75),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 18.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 10.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [SizedBox(height: 0.5)],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              ref.read(postsNotifierProvider).postsPopular.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 2.5),
                        Text(
                          "No Popular posts",
                          textAlign: TextAlign.center,
                          style: AppTheme.smallText(context).copyWith(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF828282),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: ref
                          .read(postsNotifierProvider)
                          .postsPopular
                          .length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 0.3),
                          child: InkWell(
                            onTap: () {},
                            child: Ink(
                              decoration: BoxDecoration(
                                color: ref
                                    .read(themeNotifier)
                                    .data
                                    .scaffoldBackgroundColor,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    blurRadius: 1.0,
                                    offset: Offset(0.0, 0.75),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 18.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 10.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [SizedBox(height: 0.5)],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

              ref.read(postsNotifierProvider).postsRecent.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 2.5),
                        Text(
                          "No Recent posts",
                          textAlign: TextAlign.center,
                          style: AppTheme.smallText(context).copyWith(
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF828282),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: ref
                          .read(postsNotifierProvider)
                          .postsRecent
                          .length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 0.3),
                          child: InkWell(
                            onTap: () {},
                            child: Ink(
                              decoration: BoxDecoration(
                                color: ref
                                    .read(themeNotifier)
                                    .data
                                    .scaffoldBackgroundColor,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.1),
                                    blurRadius: 1.0,
                                    offset: Offset(0.0, 0.75),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 18.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: 10.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [SizedBox(height: 0.5)],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
        SizedBox(height: 2.0),
      ],
    );
  }
}
