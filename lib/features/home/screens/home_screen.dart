import 'dart:math';
import 'package:daily_spark/core/constants/strings.dart';
import 'package:daily_spark/features/save_quotes/screens/saved_quotes_screen.dart';
import 'package:daily_spark/features/home/widgets/change_quote_btn.dart';
import 'package:daily_spark/features/home/widgets/save_share_btn.dart';
import 'package:flutter/material.dart';
import 'package:daily_spark/data/quotes_data.dart';
import 'dart:ui';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  const HomeScreen({super.key, required this.toggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final quotesData = QuotesData();

  int currentQuoteIndex = 0;
  int currentImgIndex = 0 ;
  int previousImgIndex = 0 ;
  double opacity = 1.0;
  static const String savedQuotesKey = 'saved_quotes';

  List<String> savedQuotes = [];
  bool get isCurrentQuoteSaved => savedQuotes.contains(quotesData.quotesList[currentQuoteIndex]);

  @override
  void initState() {
    super.initState();
    loadSavedQuotes();
  }

  Future<void> removeQuote(String quote) async {
    setState(() {
      savedQuotes.remove(quote);
    });
    await persistSavedQuotes();
  }

  Future<void> loadSavedQuotes() async {
    final prefs = await SharedPreferences.getInstance();
    final quotes = prefs.getStringList(savedQuotesKey) ?? [];

    debugPrint('Loaded quotes :$quotes');

    setState(() {
      savedQuotes = quotes;
    });
  }

  Future<void> persistSavedQuotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(savedQuotesKey, savedQuotes);

    debugPrint('Saved Quotes: $savedQuotes');
  }

  void changeIndex(){
    Random random = Random();
    var newIndex = random.nextInt(quotesData.quotesList.length);
    var newImgIndex = random.nextInt(quotesData.quotesImages.length);

    setState(() {
      opacity = 0.0;
    });
    Future.delayed(Duration(milliseconds: 100), (){
      setState(() {
        currentQuoteIndex = newIndex;
        previousImgIndex = currentImgIndex;
        currentImgIndex = newImgIndex;
        opacity = 1.0;
      });
    });

  }

  void shareCurrentQuote(){
    var currentQuote = quotesData.quotesList[currentQuoteIndex];
    SharePlus.instance.share(
      ShareParams(
        text: '$currentQuote\n\n-- ${AppStrings.appBarTitle}',
      )
    );
  }

  Future<void> toggleSaveQuote()async{
    var currentQuote = quotesData.quotesList[currentQuoteIndex];
    setState(() {
      if(savedQuotes.contains(currentQuote)){
        savedQuotes.remove(currentQuote);
      } else {
        savedQuotes.add(currentQuote);
      }
    });
    await persistSavedQuotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            quotesData.quotesImages[previousImgIndex],
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.4),
          ),
          SafeArea(child: Padding(padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.appBarTitle,
                    style: Theme.of(context).textTheme.headlineLarge
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2)
                    ),
                    child: IconButton(onPressed: (){}, icon: const Icon(Icons.nightlight_round,
                    color: Colors.white,
                    size: 28,),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SavedQuotesScreen(
                            savedQuotes: savedQuotes,
                            onDelete: removeQuote,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.bookmark_outline,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60,),
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.2
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '❝',
                              style: TextStyle(
                                fontSize: 50,
                                color: Colors.white.withOpacity(0.5),
                                height: 0.8,
                              ),
                            ),
                            const SizedBox(height: 10),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 400),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(opacity: animation,child: child,);
                              },
                              child: Text(
                                quotesData.quotesList[currentQuoteIndex],
                                key: ValueKey(currentQuoteIndex),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //SizedBox(height: 24,),
              SaveShareBtn(isSaved: isCurrentQuoteSaved, saveQuote: toggleSaveQuote,shareQuote: shareCurrentQuote,),
              SizedBox(height: 24,),
              ChangeQuoteBtn(onPressed: changeIndex),
              SizedBox(height: 20,)
            ],
          ),),),
          // AnimatedOpacity(
          //   opacity: opacity,
          //   duration: Duration(milliseconds: 500),
          //   child: Image.asset(
          //     QuotesData().quotesImages[currentImgIndex],
          //     fit: BoxFit.cover,
          //     width: double.infinity,
          //     height: double.infinity,
          //   ),
          // ),

          // ClipRRect(
          //   borderRadius: BorderRadius.circular(25),
          //   child: BackdropFilter(
          //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //     child: Center(
          //       child: AnimatedSize(
          //         duration: Duration(
          //           milliseconds: 500
          //         ),
          //         curve: Curves.easeInOut,
          //         child: Container(
          //           constraints: BoxConstraints(
          //               minHeight: MediaQuery.of(context).size.height * 0.28
          //           ),
          //           width: MediaQuery.of(context).size.width * 0.8,
          //           padding: EdgeInsets.all(20),
          //           margin: EdgeInsets.symmetric(horizontal: 20),
          //           decoration: BoxDecoration(
          //             color: Theme.of(context).colorScheme.surface.withOpacity(0.25),
          //             borderRadius: BorderRadius.circular(25)),
          //           child: AnimatedSwitcher(
          //             duration: Duration(milliseconds: 500),
          //             child: Text(quotesData.quotesList[currentQuoteIndex],textAlign: TextAlign.center,
          //             key: ValueKey(currentQuoteIndex),
          //             style: TextStyle(fontSize: 26,
          //             color: Theme.of(context).colorScheme.onSurface,
          //             fontWeight: FontWeight.w500),),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // Positioned(
          //   bottom: 40,
          //     left: 70,
          //     right: 70,
          //     child: ChangeQuoteBtn(onPressed: changeIndex)),
        ],
      )
    );
  }
}
