import 'package:flutter/material.dart';
import 'package:foods_yodeput/common/routes/pages.dart';
import 'package:foods_yodeput/common/style/style.dart';
import 'package:foods_yodeput/common/utils/utils.dart';
import 'package:foods_yodeput/global.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foods_yodeput/main_bindings.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

Future<void> start() async {
  await Global.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (_context, _widget) => RefreshConfiguration(
        headerBuilder: () => ClassicHeader(),
        footerBuilder: () => ClassicFooter(),
        hideFooterWhenNotFull: true,
        headerTriggerDistance: 80,
        maxOverScrollExtent: 100,
        footerTriggerDistance: 150,
        child: GetMaterialApp(
          title: 'Foodies',
          theme: AppTheme.light.copyWith(pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),),
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          initialBinding: MainBindings(),
          getPages: AppPages.routes,
          navigatorObservers: [AppPages.observer],
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          enableLog: false,
          logWriterCallback: Logger.sys,
        ),
      ),
    );
  }
}
