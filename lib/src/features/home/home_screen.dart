import 'package:assignment/src/constants/color_constants.dart';
import 'package:assignment/src/constants/routing_constants.dart';
import 'package:assignment/src/constants/string_constants.dart';
import 'package:assignment/src/extensions/gesture_extensions.dart';
import 'package:assignment/src/features/home/provider/home_provider.dart';
import 'package:assignment/src/service/auth_service.dart';
import 'package:assignment/src/utils/progress_loader_utils.dart';
import 'package:assignment/src/utils/toast_utils.dart';
import 'package:assignment/src/widgets/shimmer_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeProvider>(context, listen: false).getHomeData(code: 'in');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.lightBlue,
      appBar: AppBar(
        centerTitle: false,
        title: GestureDetector(
          onTap: () async {
            LoaderUtils.showProgressDialog(context);
            await authService.signOut().then((value) {
              ToastUtils.showSuccess(message: StringConstants.logoutSuccess);
              context.goNamed(RoutingConstants.login);
              LoaderUtils.dismissProgressDialog(context);
            });
          },
          child: const Text(
            StringConstants.myNews,
            style: TextStyle(
              color: ColorConstants.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Row(
            children: [
              const Icon(
                Icons.location_pin,
                color: ColorConstants.white,
                size: 16,
              ),
              const SizedBox(width: 5),
              const Text(
                'IN',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.white,
                  fontWeight: FontWeight.w500,
                ),
              ).onPressedWithHaptic(() async {
                final remoteConfig = FirebaseRemoteConfig.instance;
                await remoteConfig.setConfigSettings(RemoteConfigSettings(
                  fetchTimeout: const Duration(minutes: 1),
                  minimumFetchInterval: const Duration(hours: 1),
                ));
                await remoteConfig.fetchAndActivate();
              }),
              const SizedBox(width: 12),
            ],
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Text(
                StringConstants.topHeadlines,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ColorConstants.black),
              ),
              const SizedBox(height: 10),
              Consumer<HomeProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  if (value.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final homeData = value.home;
                  return Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: homeData.length,
                      separatorBuilder: (c, i) {
                        return const SizedBox(height: 10);
                      },
                      itemBuilder: (c, i) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                          decoration: BoxDecoration(
                            color: ColorConstants.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if ((homeData[i].author ?? '').isNotEmpty)
                                      Text(
                                        homeData[i].author ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: ColorConstants.black,
                                        ),
                                      ),
                                    if ((homeData[i].title ?? '').isNotEmpty)
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              homeData[i].title ?? '',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: ColorConstants.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    if ((homeData[i].publishedAt ?? '').isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          appState.formatDateTime(dateTime: homeData[i].publishedAt ?? ''),
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: ColorConstants.grey,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 5),
                              SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        imageUrl: homeData[i].url ?? '',
                                        height: 80,
                                        fit: BoxFit.cover,
                                        width: 80,
                                        placeholder: (context, url) => const ShimmerWidgets(height: 80, width: 80),
                                        errorWidget: (context, url, error) => const FlutterLogo(
                                          size: 80,
                                          textColor: Colors.blue,
                                          style: FlutterLogoStyle.stacked,
                                        ),
                                      )))
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          )),
    );
  }
}
