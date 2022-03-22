
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foods_yodeput/start.dart';

import 'gen/assets.gen.dart';

Future<void> main() async {
  await dotenv.load(fileName: Assets.env.envProduction);
  await start();
}
