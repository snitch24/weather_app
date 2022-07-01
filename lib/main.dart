import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme().apply(
          bodyColor: Colors.white,
        ),
      ),
      home: Scaffold(
        backgroundColor: const Color(0xff000A18),
        body: Builder(builder: (context) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: const Color(0xff12ABFE),
                forceElevated: true,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color(0xff126CF4),
                        Color(0xff12ABFE),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Text(
                          "hello World",
                          style: Theme.of(context).textTheme.displayLarge,
                        )
                      ],
                    ),
                  ),
                ),
                floating: false,
                expandedHeight: MediaQuery.of(context).size.height * 0.8,
                collapsedHeight: MediaQuery.of(context).size.height * 0.5,
                pinned: true,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Color(0xff12A6FD)),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, index) {
                    return Container(
                      height: 250,
                      color: const Color(0xff000A18),
                    );
                  },
                  childCount: 5,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
