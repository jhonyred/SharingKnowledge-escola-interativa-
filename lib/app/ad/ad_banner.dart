import 'package:escola_interativa/app/ad/ad_state.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({Key? key}) : super(key: key);

  @override
  _AdBannerState createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  final BannerAd banner = BannerAd(
    adUnitId: AdState.bannerID,
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  void initState() {
    super.initState();
    banner.load();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30.0,
      left: 30.0,
      child: Container(
        height: 50.0,
        width: 320.0,
        child: AdWidget(ad: banner),
      ),
    );
  }
}
