
import 'package:airwallex_payment_flutter/types/payment_result.dart';

class PaymentResultExtend extends PaymentResult{
  String ? paymentIntentId;

  PaymentResultExtend(super.status);

}