import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QRWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace the Base64 string with your actual image data
    String base64String =
        "iVBORw0KGgoAAAANSUhEUgAAAJMAAACTAQMAAACwK7lWAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAAB+0lEQVRIieWWsa30IBCE1yIgww0g0QYZLdkNcHYDdktktGGJBuzMAfL+w/NJ7w/Z+CF0uvtOstjZ2cFEf22NzFvglSlqhy+PhBlSe+L15o3U4vFTwkLZtLpS24/HP1JGkWz0NMnZynXk2k4hZaQ2cqd3V6r0W1sXa/r58t3/adrDsIbs1uROXc7f1nWxMfHi7efmi92m3SNhAx9zVlto+s25iBg0uzIvZMmrHa6RsTqn+kmKs+NEk4SN7fh2vI/hdsCnhA23Nb4s4RhZMb8972XGu0WXKzUB1vuto5vpGuHTYCftlvD2rZdBthXHCage8h8iNqTaqk/V6MP4GkXshkNphtcCPK4eCTMeHwWRsGnI956lm2mHIFk8r1mh50bCSKN09Lys6YgBppOwgPjBY9ye7OSPKGGQLVIz2kZ1ZhmDfmdAzzFefNK3b50MvQK+Ms2MIFGLiIWykIN+m3c72yhhQ7KwjKG2YyARw2Dt8ClVCgdy9BSxgDzAPYMTlTWXRcIouEfzdaNvdUhv/nUz5FC2GM3PXT9sjYSNCTEAk7rmU+ZTwugbJ7AMxJMx3DMIsE9CQRV5YCSs3W9N/jbTkd6rppuFNtA/2dn2JGQtwzR8Wh5fScjg061djBaX1SNi7f3lGHKdMJ3fvvUy6Ldnd6Hh7fXnPUsv+1vrH6ThjE2DVkpUAAAAAElFTkSuQmCC";

    String jsonString = '''
    {
        "rq_uuid": "E253B30C410911EB86A634BE08A20EFB",
        "rs_datetime": "2020-12-18 15:22:48",
        "error_code": "0000",
        "error_message": "Success",
        "trx_id": "ESP1608279768GQUZ",
        "amount": 100,
        "QRLink": "https://sandbox-api.espay.id/rest/digitalnotify/qr/?trx_id=ESP1608279768GQUZ",
        "QRCode": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAJMAAACTAQMAAACwK7lWAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAAB+0lEQVRIieWWsa30IBCE1yIgww0g0QYZLdkNcHYDdktktGGJBuzMAfL+w/NJ7w/Z+CF0uvtOstjZ2cFEf22NzFvglSlqhy+PhBlSe+L15o3U4vFTwkLZtLpS24/HP1JGkWz0NMnZynXk2k4hZaQ2cqd3V6r0W1sXa/r58t3/adrDsIbs1uROXc7f1nWxMfHi7efmi92m3SNhAx9zVlto+s25iBg0uzIvZMmrHa6RsTqn+kmKs+NEk4SN7fh2vI/hdsCnhA23Nb4s4RhZMb8972XGu0WXKzUB1vuto5vpGuHTYCftlvD2rZdBthXHCage8h8iNqTaqk/V6MP4GkXshkNphtcCPK4eCTMeHwWRsGnI956lm2mHIFk8r1mh50bCSKN09Lys6YgBppOwgPjBY9ye7OSPKGGQLVIz2kZ1ZhmDfmdAzzFefNK3b50MvQK+Ms2MIFGLiIWykIN+m3c72yhhQ7KwjKG2YyARw2Dt8ClVCgdy9BSxgDzAPYMTlTWXRcIouEfzdaNvdUhv/nUz5FC2GM3PXT9sjYSNCTEAk7rmU+ZTwugbJ7AMxJMx3DMIsE9CQRV5YCSs3W9N/jbTkd6rppuFNtA/2dn2JGQtwzR8Wh5fScjg061djBaX1SNi7f3lGHKdMJ3fvvUy6Ldnd6Hh7fXnPUsv+1vrH6ThjE2DVkpUAAAAAElFTkSuQmCC"
    }
  ''';

    // Mengonversi string JSON ke objek Dart
    Map<String, dynamic> jsonData = json.decode(jsonString);

    // Mengambil nilai dari setiap kunci
    String trxId = jsonData['trx_id'];
    int amount = jsonData['amount'];
    String qrCode = jsonData['QRCode'];

    // Memecah string QRCode berdasarkan koma
    List<String> parts = qrCode.split(',');

    // Mengambil bagian kedua (indeks 1) yang berisi data gambar
    String base64Image = parts.length > 1 ? parts[1] : '';

    String formatCurrency(int amount) {
      final NumberFormat currencyFormat = NumberFormat.currency(
        locale: 'id_ID',
        symbol: 'Rp',
        decimalDigits: 0,
      );
      return currencyFormat.format(amount);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formatCurrency(amount),
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Image.memory(
              base64Decode(base64Image),
              scale: 0.4,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              trxId,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
