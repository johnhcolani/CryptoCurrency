import 'package:advance_crypto_currency/helpers/decimal_rounder.dart';
import 'package:advance_crypto_currency/models/CryptoData.dart';
import 'package:advance_crypto_currency/provider/crypto_data_provider.dart';
import 'package:advance_crypto_currency/ui/theme_switcher.dart';
import 'package:advance_crypto_currency/ui/ui_helper/home_page_view.dart';
import 'package:advance_crypto_currency/ui/ui_helper/language_drop_down.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:advance_crypto_currency/network/ResponseModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageViewController = PageController(initialPage: 0);

  var defaultChoiceIndex = 0;




  @override
  void initState() {
    super.initState();

    final cryptoProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoProvider.getTopMarketCapData();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _choicesList = [
      AppLocalizations.of(context)!.topMarketCap,
      AppLocalizations.of(context)!.topGainers,
      AppLocalizations.of(context)!.topLosers,
      // 'Top MarketCaps',
      // 'Top Gainers',
      // 'Top Losers'
    ];
    final cryptoProvider = Provider.of<CryptoDataProvider>(context);
    var he = MediaQuery.of(context).size.height;
    var colorTheme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorTheme.appBarTheme.backgroundColor,
        title: Text(AppLocalizations.of(context)!.exchange,
            style: colorTheme.textTheme.titleLarge),
        actions: const [
          ThemeSwitcher(),
          // LanguageSwitcher(),
          LanguageDropdown()
        ],
      ),
      drawer: Drawer(
        backgroundColor: colorTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      HomePageView(conntroller: _pageViewController),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SmoothPageIndicator(
                            controller: _pageViewController,
                            count: 4,
                            effect: const ExpandingDotsEffect(
                                dotWidth: 10, dotHeight: 10),
                            onDotClicked: (index) =>
                                _pageViewController.animateToPage(index,
                                    duration: Duration(microseconds: 300),
                                    curve: Curves.easeInOut),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: Marquee(
                    text: '🤟This is the place for news in Application',
                    style: colorTheme.textTheme.bodySmall,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: Colors.green),
                              onPressed: () {},
                              child: Text(
                                AppLocalizations.of(context)!.buy,
                                style: colorTheme.textTheme.titleLarge,
                              ))),

                      /*
                      Text(AppLocalizations.of(context)!.exchange,
            style: colorTheme.textTheme.titleLarge),
                       */
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor: Colors.red),
                              onPressed: () {},
                              child: Text(AppLocalizations.of(context)!.sale,

                                style: colorTheme.textTheme.titleLarge,
                              ))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5.0),
                    child: Row(
                      children: [
                        Wrap(
                          spacing: 8,
                          children: List.generate(_choicesList.length, (index) {
                            return ChoiceChip(
                              label: Text(_choicesList[index],),
                              selected: defaultChoiceIndex == index,
                              selectedColor: Colors.blue,
                              onSelected: (value) {
                                setState(() {
                                  defaultChoiceIndex =
                                      value ? index : defaultChoiceIndex;
                                  switch (index) {
                                    case 0:
                                      cryptoProvider.getTopMarketCapData();
                                      break;
                                    case 1:
                                      cryptoProvider.getTopGainersData();
                                      break;
                                    case 2:
                                      cryptoProvider.getTopLosersData();
                                      break;
                                  }
                                });
                              },
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 500,
                  child: Consumer<CryptoDataProvider>(
                    builder: (context, cryptoDataProvider, child) {
                      switch (cryptoDataProvider.state.status) {
                        case Status.LOADING:
                          return SizedBox(
                            height: 80,
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey.shade400,
                                highlightColor: Colors.white,
                                child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.0, bottom: 8, left: 8),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 30,
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0, left: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 15,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: SizedBox(
                                                      width: 25,
                                                      height: 15,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0, left: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 90,
                                                    height: 40,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0, left: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 15,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 8.0),
                                                    child: SizedBox(
                                                      width: 25,
                                                      height: 15,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      );
                                    })),
                          );
                        case Status.COMPLETED:
                          List<CryptoData>? model = cryptoDataProvider
                              .dataFuture.data!.cryptoCurrencyList;
                          print(model![0].symbol);
                          return ListView.separated(
                              itemBuilder: (context, index) {
                                var number = index + 1;
                                var tokenId = model[index].id;
                                MaterialColor filterColor =
                                    DecimalRounder.setColorFilter(model[index]
                                        .quotes![0]
                                        .percentChange24h);
                                var finalPrice =
                                    DecimalRounder.removePriceDecimals(
                                        model[index].quotes![0].price);

                                // percent change setup decimals and colors
                                var percentChange =
                                    DecimalRounder.removePercentDecimals(
                                        model[index]
                                            .quotes![0]
                                            .percentChange24h);

                                Color percentColor =
                                    DecimalRounder.setPercentChangesColor(
                                        model[index]
                                            .quotes![0]
                                            .percentChange24h);
                                Icon percentIcon =
                                    DecimalRounder.setPercentChangesIcon(
                                        model[index]
                                            .quotes![0]
                                            .percentChange24h);
                                return SizedBox(
                                  height: he * 0.075,
                                  child: Row(
                                    children: [
                                      Text(
                                        number.toString(),
                                        style: colorTheme.textTheme.bodySmall,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: CachedNetworkImage(
                                          fadeInDuration:
                                              Duration(milliseconds: 500),
                                          height: 32,
                                          width: 32,
                                          imageUrl:
                                              'https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png',
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              model[index].name!,
                                              style: colorTheme
                                                  .textTheme.bodySmall,
                                            ),
                                            Text(
                                              model[index].symbol!,
                                              style: colorTheme
                                                  .textTheme.labelSmall,
                                            )
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                filterColor, BlendMode.srcATop),
                                            child: SvgPicture.network(
                                                'https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg')),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '\$$finalPrice',
                                              style: colorTheme
                                                  .textTheme.labelSmall,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                percentIcon,
                                                Text(
                                                  "$percentChange%",
                                                  style: GoogleFonts.ubuntu(
                                                      color: percentColor,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Divider();
                              },
                              itemCount: 10);

                        case Status.ERROR:
                          return Text(cryptoDataProvider.state.message);
                        default:
                          return Container();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
