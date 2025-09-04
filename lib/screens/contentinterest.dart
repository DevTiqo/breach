import 'package:breach/models/category_model.dart';
import 'package:breach/models/interest_model.dart';
import 'package:breach/modules/http.dart';
import 'package:breach/notifiers/categoriesNotifier.dart';
import 'package:breach/notifiers/interest_notifier.dart';
import 'package:breach/notifiers/providers.dart';
import 'package:breach/screens/home/navhome.dart';
import 'package:breach/theme/palette.dart';
import 'package:breach/utils/imageconsts.dart';
import 'package:breach/widgets/circularprogress.dart';
import 'package:breach/widgets/notification_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ContentInterest extends ConsumerStatefulWidget {
  static String routeName = '/contentinterest';
  const ContentInterest({super.key});

  @override
  ConsumerState<ContentInterest> createState() => _ContentInterestState();
}

class _ContentInterestState extends ConsumerState<ContentInterest> {
  List<int> selectedInterests = [];
  bool loading = false;

  saveInterests() async {
    setState(() {
      loading = true;
    });

    final service = ref.read(interestsApiProvider);
    final RequestResult result = await service.saveInterests(selectedInterests);

    if (result.ok) {
      context.pop();
    } else {
      callnotification(context, NotificationStatus.error, result.data);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final interestsAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(ImageConst.breachlogo, width: 100),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 36),
              Image.asset(ImageConst.beavercircle, width: 120),

              SizedBox(height: 36),
              Text(
                'What are your interests?',
                style: AppTheme.largeText(
                  context,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 12),
              Text(
                'Select your interests and I\'ll recommend some series I\'m certain you\'ll enjoy!',
                textAlign: TextAlign.center,
                style: AppTheme.mediumText(
                  context,
                ).copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 24),
              interestsAsync.when(
                data: (interests) => interests.isEmpty
                    ? const Center(child: Text("No interests found"))
                    : Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8.0, // Gap between chips
                          runSpacing: 4.0, // Gap between rows of chips

                          children: interests.map((category) {
                            return FilterChip(
                              selectedColor: AppTheme.primaryLight,
                              label: Text(
                                category.icon + " " + category.name,
                                style: AppTheme.smallText(
                                  context,
                                ).copyWith(fontWeight: FontWeight.w500),
                              ),
                              selected: selectedInterests.contains(category.id),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    selectedInterests.add(category.id);
                                  } else {
                                    selectedInterests.remove(category.id);
                                  }
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text("Error: $err")),
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  child: loading
                      ? CircularProgress()
                      : Text(
                          "Next",
                          textAlign: TextAlign.center,
                          style: AppTheme.bigText(context).copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    fixedSize: WidgetStatePropertyAll(
                      Size(MediaQuery.of(context).size.width - 100, 50),
                    ),
                    elevation: WidgetStatePropertyAll(0.0),
                    backgroundColor: WidgetStateProperty.resolveWith<Color>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.disabled)) {
                        return AppTheme.grayColor;
                      }
                      return AppTheme.black;
                    }),
                    textStyle: WidgetStatePropertyAll(
                      TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: selectedInterests.isEmpty || loading
                      ? null
                      : () async {
                          saveInterests();
                        },
                ),
              ),
              SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  context.pop();
                },
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  elevation: WidgetStatePropertyAll(0.0),
                  backgroundColor: WidgetStateProperty.resolveWith<Color>((
                    Set<WidgetState> states,
                  ) {
                    return Colors.transparent;
                  }),
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(color: Colors.white),
                  ),
                ),
                child: Text(
                  "Skip for now",
                  style: TextStyle(color: AppTheme.greyColor),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
