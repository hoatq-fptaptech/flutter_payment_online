import 'package:flutter/material.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';

class VNPayOnline extends StatefulWidget {
  const VNPayOnline({super.key});

  @override
  State<VNPayOnline> createState() => _VNPayOnlineState();
}

class _VNPayOnlineState extends State<VNPayOnline> {
  String responseCode = '';

  Future<void> onPayment() async {
    final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
      url: 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html', //vnpay url, default is https://sandbox.vnpayment.vn/paymentv2/vpcpay.html
      version: '2.0.1',
      tmnCode: 'xxxx', //vnpay tmn code, get from vnpay
      txnRef: DateTime.now().millisecondsSinceEpoch.toString(),
      orderInfo: 'Pay 30.000 VND', //order info, default is Pay Order
      amount: 30000,
      returnUrl: 'xxxxxx', //https://sandbox.vnpayment.vn/apis/docs/huong-dan-tich-hop/#code-returnurl
      ipAdress: '192.168.10.10',
      vnpayHashKey: 'xxxxxxx', //vnpay hash key, get from vnpay
      vnPayHashType: VNPayHashType.HMACSHA512, //hash type. Default is HMACSHA512, you can chang it in: https://sandbox.vnpayment.vn/merchantv2,
      vnpayExpireDate: DateTime.now().add(const Duration(hours: 1)),
    );
    await VNPAYFlutter.instance.show(
      paymentUrl: paymentUrl,
      onPaymentSuccess: (params) {
        setState(() {
          responseCode = params['vnp_ResponseCode'];
        });
      },
      onPaymentError: (params) {
        setState(() {
          responseCode = 'Error';
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 350,
              child: FloatingActionButton.extended(
                onPressed: onPayment,
                backgroundColor: Colors.pink[800],
                icon: const Icon(Icons.payment, color: Colors.white),
                label: const Text(
                  'Pay with VN Pay',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )
        )

    );
  }
}