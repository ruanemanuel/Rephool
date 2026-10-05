import 'package:flutter/material.dart';
import 'package:iconly_plus/iconly_plus.dart';
import 'package:provider/provider.dart';
import 'package:rephool_test/screens/home_screen.dart';
import 'package:rephool_test/screens/image_screen.dart';
import 'package:rephool_test/screens/photo_screen.dart';
import 'package:rephool_test/screens/settings_screen.dart';
import 'package:rephool_test/state/image_store.dart';
import 'package:rephool_test/theme/theme_controller.dart';
import 'package:rephool_test/widgets/bottom_navigation_button.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const RephoolApp());
}

class RephoolApp extends StatefulWidget {
  const RephoolApp({super.key});

  @override
  State<RephoolApp> createState() => _RephoolAppState();
}

class _RephoolAppState extends State<RephoolApp> {
  final _theme = ThemeController();
  final _images = ImageStore();

  @override
  void initState() {
    super.initState();
    _images.loadRecent();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _theme),
        ChangeNotifierProvider.value(value: _images),
      ],
      child: AnimatedBuilder(
        animation: _theme,
        builder: (context, _) {
          return MaterialApp(
            title: 'Rephool',
            debugShowCheckedModeBanner: false,
            themeMode: _theme.mode,

            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: Color(0xFFECE7EF),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Color(0xFF27132F),
              useMaterial3: true,
            ),
            initialRoute: '/',
            routes: {
              '/': (_) => const MainTabs(),
              '/photo-screen': (_) => const PhotoScreen(),
              '/image-viewer': (_) => const ImageScreen(),
            },
          );
        },
      ),
    );
  }
}

class MainTabs extends StatefulWidget {
  const MainTabs({super.key});

  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [HomeScreen(), SettingsScreen()],
      ),
      bottomNavigationBar: (BuildContext context) {
        final colors = context.watch<ThemeController>().colorsOf(context);
        List<BottomNavigationButton> navigationButtons() => [
          BottomNavigationButton(
            icon: _index == 0 ? IconlyBold.home : IconlyBroken.home,
            setIndex: () => {
              setState(() {
                _index = 0;
              }),
            },
          ),
          BottomNavigationButton(
            icon: _index == 1 ? IconlyBold.setting : IconlyBroken.setting,
            setIndex: () => {
              setState(() {
                _index = 1;
              }),
            },
          ),
        ];
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
          child: Material(
            borderRadius: BorderRadius.circular(30),
            elevation: 20,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: colors.background,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: colors.background2,
                    offset: Offset(28, 28) / 10,
                  ),
                ],
              ),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: navigationButtons(),
              ),
            ),
          ),
        );
      }(context),
    );
  }
}
