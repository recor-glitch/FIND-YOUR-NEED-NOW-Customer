import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 65.9, end: 65.9),
            Pin(size: 196.1, middle: 0.3115),
            child:
                // Adobe XD layer: 'Icon awesome-wifi' (shape)
                SvgPicture.string(
              _svg_dv26vj,
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Align(
            alignment: Alignment(0.097, -0.412),
            child: Transform.rotate(
              angle: 0.4887,
              child: Container(
                width: 31.0,
                height: 282.0,
                decoration: BoxDecoration(
                  color: const Color(0xfffe7a7a),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.012, 0.175),
            child: SizedBox(
              width: 84.0,
              height: 43.0,
              child: Text(
                'Oops!',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 32,
                  color: const Color(0xff313030),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.051, 0.253),
            child: SizedBox(
              width: 176.0,
              height: 35.0,
              child: Text(
                'No connection',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 27,
                  color: const Color(0xff313030),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.359),
            child: SizedBox(
              width: 256.0,
              height: 40.0,
              child: Text(
                'Please check your internet connection\nand try again.',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 15,
                  color: const Color(0xff313030),
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                softWrap: false,
              ),
            ),
          ),
          Align(
            alignment: Alignment(-0.025, -0.139),
            child:
                // Adobe XD layer: 'sad emoji' (shape)
                Container(
              width: 96.0,
              height: 106.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/sad.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_dv26vj =
    '<svg viewBox="65.9 209.9 280.2 196.1" ><path transform="translate(65.9, 207.67)" d="M 277.9696655273438 56.048095703125 C 200.4028472900391 -15.69582748413086 79.76429748535156 -15.66955947875977 2.228140354156494 56.048095703125 C -0.6876747012138367 58.7450065612793 -0.7445901036262512 63.31135940551758 2.074906587600708 66.10896301269531 L 17.06552314758301 80.98137664794922 C 19.75367546081543 83.65201568603516 24.07923698425293 83.70893096923828 26.87246704101562 81.14774322509766 C 90.75772094726562 22.62130546569824 189.4313507080078 22.60816955566406 253.3296966552734 81.14774322509766 C 256.1229553222656 83.70893859863281 260.4485168457031 83.64763641357422 263.1366882324219 80.98137664794922 L 278.1272888183594 66.10896301269531 C 280.9424133300781 63.31135940551758 280.885498046875 58.7450065612793 277.9696655273438 56.04809188842773 Z M 140.0988922119141 142.3492126464844 C 124.6223220825195 142.3492126464844 112.0790634155273 154.8924713134766 112.0790634155273 170.3690490722656 C 112.0790634155273 185.8456420898438 124.6223220825195 198.3888854980469 140.0988922119141 198.3888854980469 C 155.5754852294922 198.3888854980469 168.1187438964844 185.8456420898438 168.1187438964844 170.3690490722656 C 168.1187438964844 154.8924713134766 155.5754852294922 142.3492126464844 140.0988922119141 142.3492126464844 Z M 228.8298645019531 105.7526550292969 C 178.3679046630859 61.12668991088867 101.7730331420898 61.17485046386719 51.36795043945312 105.7526550292969 C 48.34706115722656 108.4232940673828 48.25074005126953 113.0597076416016 51.1183967590332 115.8879699707031 L 66.19657135009766 130.7691345214844 C 68.82343292236328 133.3609771728516 73.05268096923828 133.5360870361328 75.85028076171875 131.119384765625 C 112.6044387817383 99.34750366210938 167.6765594482422 99.41754913330078 204.3431549072266 131.119384765625 C 207.1407470703125 133.5360870361328 211.3700256347656 133.3653411865234 213.9968719482422 130.7691345214844 L 229.0750579833984 115.8879699707031 C 231.9470825195312 113.0597229003906 231.8463897705078 108.4189224243164 228.8298645019531 105.7526550292969 Z" fill="#b7b7b7" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
