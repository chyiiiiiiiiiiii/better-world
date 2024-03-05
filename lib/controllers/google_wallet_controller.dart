import 'package:envawareness/constants/constants.dart';
import 'package:envawareness/data/google_wallet_pass_property.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'google_wallet_controller.g.dart';

@Riverpod(keepAlive: true)
class GoogleWalletController extends _$GoogleWalletController {
  @override
  void build() {
    return;
  }

  String getPassJson({
    required String header,
    required String subHeader,
    required String logoImageUrl,
    required String heroImageUrl,
    required String endangeredLevel,
    required List<GoogleWalletPassProperty> properties,
  }) {
    final passId = const Uuid().v4();

    final propertiesJsonTemp = properties.map((e) => e.toJson()).join(',');

    final propertiesJson = propertiesJsonTemp
        .replaceAllMapped(RegExp(r'(?<=\{| )\w(.*?)(?=\: |, |})'), (match) {
      return '"${match.group(0)!}"';
    });

    final result = '''
    {
      "iss": "${Constants.googleWalletIssuerEmail}",
      "aud": "google",
      "typ": "savetowallet",
      "origins": [],
      "payload": {
        "genericObjects": [
          {
            "id": "${Constants.googleWalletIssuerId}.$passId",
            "classId": "${Constants.googleWalletIssuerId}.${Constants.googleWalletPassClassEndangeredSpecies}",
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#F9EDD6",
            "logo": {
              "sourceUri": {
                "uri": "$logoImageUrl"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "Better World"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "$subHeader"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "$header"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "$passId"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "$heroImageUrl"
              }
            },
            "textModulesData": [
              $propertiesJson
            ]
          }
        ]
      }
    }
''';

    return result;
  }
}
