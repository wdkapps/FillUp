import 'package:intl/intl.dart';

class CurrencyManager {
  static CurrencyManager? _instance;
  static CurrencyManager get instance => _instance ??= CurrencyManager._();

  CurrencyManager._();

  List<CurrencyInfo> getAvailableCurrencies() {
    final currencies = _allCurrencyData
        .map((d) => CurrencyInfo(
              code: d['code'] as String,
              symbol: d['symbol'] as String,
              name: d['name'] as String,
              localName: d['localName'] as String,
            ))
        .toList();
    currencies.sort((a, b) => a.code.compareTo(b.code));
    return currencies;
  }

  CurrencyInfo? getCurrencyByCode(String code) {
    try {
      return getAvailableCurrencies().firstWhere((c) => c.code == code);
    } catch (_) {
      return null;
    }
  }

  String formatCurrency(double amount, String currencyCode) {
    final info = getCurrencyByCode(currencyCode);
    if (info == null) return amount.toStringAsFixed(2);
    final formatter = NumberFormat.currency(symbol: info.symbol, decimalDigits: 2);
    return formatter.format(amount);
  }

  static const List<Map<String, String>> _allCurrencyData = [
    {'code': 'AED', 'symbol': 'د.إ', 'name': 'UAE Dirham', 'localName': 'درهم إماراتي'},
    {'code': 'AFN', 'symbol': 'Af', 'name': 'Afghan Afghani', 'localName': ' أفغاني'},
    {'code': 'ALL', 'symbol': 'L', 'name': 'Albanian Lek', 'localName': 'ليك ألباني'},
    {'code': 'AMD', 'symbol': '֏', 'name': 'Armenian Dram', 'localName': 'درام أرميني'},
    {'code': 'ANG', 'symbol': 'ƒ', 'name': 'Netherlands Antillean Guilder', 'localName': 'غيلدر'},
    {'code': 'AOA', 'symbol': 'Kz', 'name': 'Angolan Kwanza', 'localName': 'كوانزا'},
    {'code': 'ARS', 'symbol': '\$', 'name': 'Argentine Peso', 'localName': 'بيزو أرجنتيني'},
    {'code': 'AUD', 'symbol': 'A\$', 'name': 'Australian Dollar', 'localName': 'دولار أسترالي'},
    {'code': 'AWG', 'symbol': 'ƒ', 'name': 'Aruban Florin', 'localName': 'فلورن'},
    {'code': 'AZN', 'symbol': '₼', 'name': 'Azerbaijani Manat', 'localName': 'مانات أذربيجاني'},
    {'code': 'BAM', 'symbol': 'KM', 'name': 'Bosnia-Herzegovina Mark', 'localName': 'مارك'},
    {'code': 'BBD', 'symbol': 'Bds\$', 'name': 'Barbadian Dollar', 'localName': 'دولار بربادوسي'},
    {'code': 'BDT', 'symbol': '৳', 'name': 'Bangladeshi Taka', 'localName': 'تاكا بنغلاديشي'},
    {'code': 'BGN', 'symbol': 'лв', 'name': 'Bulgarian Lev', 'localName': 'ليف بلغاري'},
    {'code': 'BHD', 'symbol': 'BD', 'name': 'Bahraini Dinar', 'localName': 'دينار بحريني'},
    {'code': 'BIF', 'symbol': 'FBu', 'name': 'Burundian Franc', 'localName': 'فرنك بوروندي'},
    {'code': 'BMD', 'symbol': '\$', 'name': 'Bermudan Dollar', 'localName': 'دولار برمودي'},
    {'code': 'BND', 'symbol': 'B\$', 'name': 'Brunei Dollar', 'localName': 'دولار بروناي'},
    {'code': 'BOB', 'symbol': 'Bs', 'name': 'Bolivian Boliviano', 'localName': 'بوليفاريو'},
    {'code': 'BRL', 'symbol': 'R\$', 'name': 'Brazilian Real', 'localName': 'ريال برازيلي'},
    {'code': 'BSD', 'symbol': 'B\$', 'name': 'Bahamian Dollar', 'localName': 'دولار باهامي'},
    {'code': 'BTN', 'symbol': 'Nu.', 'name': 'Bhutanese Ngultrum', 'localName': 'ناغولتريوم'},
    {'code': 'BWP', 'symbol': 'P', 'name': 'Botswanan Pula', 'localName': 'بولا'},
    {'code': 'BYN', 'symbol': 'Br', 'name': 'Belarusian Ruble', 'localName': 'روبل بيلاروسي'},
    {'code': 'BZD', 'symbol': 'BZ\$', 'name': 'Belize Dollar', 'localName': 'دولار بليزي'},
    {'code': 'CAD', 'symbol': 'CA\$', 'name': 'Canadian Dollar', 'localName': 'دولار كندي'},
    {'code': 'CDF', 'symbol': 'FC', 'name': 'Congolese Franc', 'localName': 'فرنك كونغولي'},
    {'code': 'CHF', 'symbol': 'Fr.', 'name': 'Swiss Franc', 'localName': 'فرنك سويسري'},
    {'code': 'CLP', 'symbol': '\$', 'name': 'Chilean Peso', 'localName': 'بيزو تشيلي'},
    {'code': 'CNY', 'symbol': '¥', 'name': 'Chinese Yuan', 'localName': 'يوان صيني'},
    {'code': 'COP', 'symbol': '\$', 'name': 'Colombian Peso', 'localName': 'بيزو كولومبي'},
    {'code': 'CRC', 'symbol': '₡', 'name': 'Costa Rican Colón', 'localName': 'كولون'},
    {'code': 'CUP', 'symbol': '₱', 'name': 'Cuban Peso', 'localName': 'بيزو كوبي'},
    {'code': 'CVE', 'symbol': '\$', 'name': 'Cape Verdean Escudo', 'localName': 'إسكودو'},
    {'code': 'CZK', 'symbol': 'Kč', 'name': 'Czech Koruna', 'localName': 'كورونا تشيكية'},
    {'code': 'DJF', 'symbol': 'Fdj', 'name': 'Djiboutian Franc', 'localName': 'فرنك جيبوتي'},
    {'code': 'DKK', 'symbol': 'kr', 'name': 'Danish Krone', 'localName': 'كرون دانماركي'},
    {'code': 'DOP', 'symbol': 'RD\$', 'name': 'Dominican Peso', 'localName': 'بيزو دومينيكي'},
    {'code': 'DZD', 'symbol': 'DA', 'name': 'Algerian Dinar', 'localName': 'دينار جزائري'},
    {'code': 'EGP', 'symbol': 'E£', 'name': 'Egyptian Pound', 'localName': 'جنيه مصري'},
    {'code': 'ERN', 'symbol': 'Nfk', 'name': 'Eritrean Nakfa', 'localName': 'ناكفا إريتري'},
    {'code': 'ETB', 'symbol': 'Br', 'name': 'Ethiopian Birr', 'localName': 'بير إثيوبي'},
    {'code': 'EUR', 'symbol': '€', 'name': 'Euro', 'localName': 'يورو'},
    {'code': 'FJD', 'symbol': 'FJ\$', 'name': 'Fijian Dollar', 'localName': 'دولار فيجي'},
    {'code': 'GBP', 'symbol': '£', 'name': 'British Pound', 'localName': 'جنيه إسترليني'},
    {'code': 'GEL', 'symbol': '₾', 'name': 'Georgian Lari', 'localName': 'لاري جورجي'},
    {'code': 'GHS', 'symbol': 'GH₵', 'name': 'Ghanaian Cedi', 'localName': 'سيدي غاني'},
    {'code': 'GMD', 'symbol': 'D', 'name': 'Gambian Dalasi', 'localName': 'دلاسي'},
    {'code': 'GNF', 'symbol': 'FG', 'name': 'Guinean Franc', 'localName': 'فرنك غيني'},
    {'code': 'GTQ', 'symbol': 'Q', 'name': 'Guatemalan Quetzal', 'localName': 'كيتزال'},
    {'code': 'GYD', 'symbol': 'GY\$', 'name': 'Guyanaese Dollar', 'localName': 'دولار غياني'},
    {'code': 'HKD', 'symbol': 'HK\$', 'name': 'Hong Kong Dollar', 'localName': 'دولار هونغ كونغي'},
    {'code': 'HNL', 'symbol': 'L', 'name': 'Honduran Lempira', 'localName': 'ليمبورا'},
    {'code': 'HRK', 'symbol': 'kn', 'name': 'Croatian Kuna', 'localName': 'كونا كرواتية'},
    {'code': 'HTG', 'symbol': 'G', 'name': 'Haitian Gourde', 'localName': 'غورد هايتي'},
    {'code': 'HUF', 'symbol': 'Ft', 'name': 'Hungarian Forint', 'localName': 'فورنت هنغاري'},
    {'code': 'IDR', 'symbol': 'Rp', 'name': 'Indonesian Rupiah', 'localName': 'روبية إندونيسية'},
    {'code': 'ILS', 'symbol': '₪', 'name': 'Israeli Shekel', 'localName': 'شيكل إسرائيلي'},
    {'code': 'INR', 'symbol': '₹', 'name': 'Indian Rupee', 'localName': 'روبية هندية'},
    {'code': 'IQD', 'symbol': 'ع.د', 'name': 'Iraqi Dinar', 'localName': 'دينار عراقي'},
    {'code': 'IRR', 'symbol': '﷼', 'name': 'Iranian Rial', 'localName': 'ريال إيراني'},
    {'code': 'ISK', 'symbol': 'kr', 'name': 'Icelandic Krona', 'localName': 'كرونا أيسلندية'},
    {'code': 'JMD', 'symbol': 'J\$', 'name': 'Jamaican Dollar', 'localName': 'دولار جامايكي'},
    {'code': 'JOD', 'symbol': 'JD', 'name': 'Jordanian Dinar', 'localName': 'دينار أردني'},
    {'code': 'JPY', 'symbol': '¥', 'name': 'Japanese Yen', 'localName': 'ين ياباني'},
    {'code': 'KES', 'symbol': 'KSh', 'name': 'Kenyan Shilling', 'localName': 'شيلينغ كيني'},
    {'code': 'KGS', 'symbol': 'som', 'name': 'Kyrgystani Som', 'localName': 'سوم قيرغيزي'},
    {'code': 'KHR', 'symbol': '៛', 'name': 'Cambodian Riel', 'localName': 'ريال كمبودي'},
    {'code': 'KMF', 'symbol': 'CF', 'name': 'Comorian Franc', 'localName': 'فرنك قمري'},
    {'code': 'KRW', 'symbol': '₩', 'name': 'South Korean Won', 'localName': 'وون كوري'},
    {'code': 'KWD', 'symbol': 'د.ك', 'name': 'Kuwaiti Dinar', 'localName': 'دينار كويتي'},
    {'code': 'KZT', 'symbol': '₸', 'name': 'Kazakhstani Tenge', 'localName': 'تينغ كازاخستاني'},
    {'code': 'LAK', 'symbol': '₭', 'name': 'Lao Kip', 'localName': 'كيب لاوي'},
    {'code': 'LBP', 'symbol': 'L£', 'name': 'Lebanese Pound', 'localName': 'جنيه لبناني'},
    {'code': 'LKR', 'symbol': 'Rs', 'name': 'Sri Lankan Rupee', 'localName': 'روبية سريلانكية'},
    {'code': 'LRD', 'symbol': 'L\$', 'name': 'Liberian Dollar', 'localName': 'دولار ليبيري'},
    {'code': 'LSL', 'symbol': 'L', 'name': 'Lesotho Loti', 'localName': 'لوتي'},
    {'code': 'LYD', 'symbol': 'LD', 'name': 'Libyan Dinar', 'localName': 'دينار ليبي'},
    {'code': 'MAD', 'symbol': 'MAD', 'name': 'Moroccan Dirham', 'localName': 'درهم مغربي'},
    {'code': 'MDL', 'symbol': 'MDL', 'name': 'Moldovan Leu', 'localName': 'ليو مولدوفي'},
    {'code': 'MGA', 'symbol': 'Ar', 'name': 'Malagasy Ariary', 'localName': 'أرياري'},
    {'code': 'MKD', 'symbol': 'ден', 'name': 'Macedonian Denar', 'localName': 'دينار مقدوني'},
    {'code': 'MMK', 'symbol': 'K', 'name': 'Myanmar Kyat', 'localName': 'كيات ميانماري'},
    {'code': 'MNT', 'symbol': '₮', 'name': 'Mongolian Tugrik', 'localName': 'تغريك منغولي'},
    {'code': 'MOP', 'symbol': 'MOP\$', 'name': 'Macanese Pataca', 'localName': 'باتاكا'},
    {'code': 'MRU', 'symbol': 'UM', 'name': 'Mauritanian Ouguiya', 'localName': 'أوغية موريتانية'},
    {'code': 'MUR', 'symbol': '₨', 'name': 'Mauritian Rupee', 'localName': 'روبية موريشية'},
    {'code': 'MVR', 'symbol': 'Rf', 'name': 'Maldivian Rufiyaa', 'localName': 'روفية'},
    {'code': 'MWK', 'symbol': 'MK', 'name': 'Malawian Kwacha', 'localName': 'كواча ملاوي'},
    {'code': 'MXN', 'symbol': 'MX\$', 'name': 'Mexican Peso', 'localName': 'بيزو مكسيكي'},
    {'code': 'MYR', 'symbol': 'RM', 'name': 'Malaysian Ringgit', 'localName': 'رينغيت ماليزي'},
    {'code': 'MZN', 'symbol': 'MT', 'name': 'Mozambican Metical', 'localName': 'ميتيكال'},
    {'code': 'NAD', 'symbol': 'N\$', 'name': 'Namibian Dollar', 'localName': 'دولار ناميبي'},
    {'code': 'NGN', 'symbol': '₦', 'name': 'Nigerian Naira', 'localName': 'نايرا نيجيري'},
    {'code': 'NIO', 'symbol': 'C\$', 'name': 'Nicaraguan Cordoba', 'localName': 'كوردوبا'},
    {'code': 'NOK', 'symbol': 'kr', 'name': 'Norwegian Krone', 'localName': 'كرون نرويجي'},
    {'code': 'NPR', 'symbol': '₨', 'name': 'Nepalese Rupee', 'localName': 'روبية نيبالية'},
    {'code': 'NZD', 'symbol': 'NZ\$', 'name': 'New Zealand Dollar', 'localName': 'دولار نيوزيلندي'},
    {'code': 'OMR', 'symbol': 'ر.ع', 'name': 'Omani Rial', 'localName': 'ريال عُماني'},
    {'code': 'PAB', 'symbol': 'B/.', 'name': 'Panamanian Balboa', 'localName': 'Balboa'},
    {'code': 'PEN', 'symbol': 'S/', 'name': 'Peruvian Sol', 'localName': 'سول بيروفي'},
    {'code': 'PGK', 'symbol': 'K', 'name': 'Papua New Guinean Kina', 'localName': 'كينا'},
    {'code': 'PHP', 'symbol': '₱', 'name': 'Philippine Peso', 'localName': 'بيزو فلبيني'},
    {'code': 'PKR', 'symbol': '₨', 'name': 'Pakistani Rupee', 'localName': 'روبية باكستانية'},
    {'code': 'PLN', 'symbol': 'zł', 'name': 'Polish Zloty', 'localName': 'زلوتي بولندي'},
    {'code': 'PYG', 'symbol': '₲', 'name': 'Paraguayan Guarani', 'localName': 'غواراني'},
    {'code': 'QAR', 'symbol': 'ر.ق', 'name': 'Qatari Riyal', 'localName': 'ريال قطري'},
    {'code': 'RON', 'symbol': 'lei', 'name': 'Romanian Leu', 'localName': 'ليو روماني'},
    {'code': 'RSD', 'symbol': 'din', 'name': 'Serbian Dinar', 'localName': 'دينار صربي'},
    {'code': 'RUB', 'symbol': '₽', 'name': 'Russian Ruble', 'localName': 'روبل روسي'},
    {'code': 'RWF', 'symbol': 'FRw', 'name': 'Rwandan Franc', 'localName': 'فرنك رواندي'},
    {'code': 'SAR', 'symbol': 'ر.س', 'name': 'Saudi Riyal', 'localName': 'ريال سعودي'},
    {'code': 'SBD', 'symbol': 'SI\$', 'name': 'Solomon Islands Dollar', 'localName': 'دولار جزر سليمان'},
    {'code': 'SCR', 'symbol': '₨', 'name': 'Seychellois Rupee', 'localName': 'روبية سيشلية'},
    {'code': 'SDG', 'symbol': 'SDG', 'name': 'Sudanese Pound', 'localName': 'جنيه سوداني'},
    {'code': 'SEK', 'symbol': 'kr', 'name': 'Swedish Krona', 'localName': 'كرون سويدي'},
    {'code': 'SGD', 'symbol': 'S\$', 'name': 'Singapore Dollar', 'localName': 'دولار سنغافوري'},
    {'code': 'SHP', 'symbol': '£', 'name': 'Saint Helena Pound', 'localName': 'جنيه سانت هيليني'},
    {'code': 'SLL', 'symbol': 'Le', 'name': 'Sierra Leonean Leone', 'localName': 'ليوني'},
    {'code': 'SOS', 'symbol': 'S', 'name': 'Somali Shilling', 'localName': 'شيلينغ صومالي'},
    {'code': 'SRD', 'symbol': 'SR\$', 'name': 'Surinamese Dollar', 'localName': 'دولار سورينامي'},
    {'code': 'SSP', 'symbol': '£S', 'name': 'South Sudanese Pound', 'localName': 'جنيه جنوب سوداني'},
    {'code': 'STN', 'symbol': 'Db', 'name': 'São Tomé and Príncipe Dobra', 'localName': 'دوبرا'},
    {'code': 'SVC', 'symbol': '₡', 'name': 'Salvadoran Colón', 'localName': 'كولون'},
    {'code': 'SYP', 'symbol': '£S', 'name': 'Syrian Pound', 'localName': 'ليرة سورية'},
    {'code': 'SZL', 'symbol': 'E', 'name': 'Swazi Lilangeni', 'localName': 'ليلانغيني'},
    {'code': 'THB', 'symbol': '฿', 'name': 'Thai Baht', 'localName': 'بات تايلاندي'},
    {'code': 'TJS', 'symbol': 'SM', 'name': 'Tajikistani Somoni', 'localName': 'سوموني'},
    {'code': 'TMT', 'symbol': 'T', 'name': 'Turkmenistani Manat', 'localName': 'مانات تركماني'},
    {'code': 'TND', 'symbol': 'DT', 'name': 'Tunisian Dinar', 'localName': 'دينار تونسي'},
    {'code': 'TOP', 'symbol': 'T\$', 'name': 'Tongan Pa\'anga', 'localName': 'بانغا'},
    {'code': 'TRY', 'symbol': '₺', 'name': 'Turkish Lira', 'localName': 'ليرة تركية'},
    {'code': 'TTD', 'symbol': 'TT\$', 'name': 'Trinidad and Tobago Dollar', 'localName': 'دولار ترينيدادي'},
    {'code': 'TWD', 'symbol': 'NT\$', 'name': 'New Taiwan Dollar', 'localName': 'دولار تايواني'},
    {'code': 'TZS', 'symbol': 'TSh', 'name': 'Tanzanian Shilling', 'localName': 'شيلينغ تنزاني'},
    {'code': 'UAH', 'symbol': '₴', 'name': 'Ukrainian Hryvnia', 'localName': 'هريفنيا أوكرانية'},
    {'code': 'UGX', 'symbol': 'USh', 'name': 'Ugandan Shilling', 'localName': 'شيلينغ أوغندي'},
    {'code': 'USD', 'symbol': '\$', 'name': 'US Dollar', 'localName': 'دولار أمريكي'},
    {'code': 'UYU', 'symbol': '\$U', 'name': 'Uruguayan Peso', 'localName': 'بيزو أوروغواياني'},
    {'code': 'UZS', 'symbol': 'so\'m', 'name': 'Uzbekistani Som', 'localName': 'سوم أوزبكي'},
    {'code': 'VES', 'symbol': 'Bs.S', 'name': 'Venezuelan Bolivar', 'localName': 'بوليفار فنزويلي'},
    {'code': 'VND', 'symbol': '₫', 'name': 'Vietnamese Dong', 'localName': 'دونغ فيتنامي'},
    {'code': 'VUV', 'symbol': 'VT', 'name': 'Vanuatu Vatu', 'localName': 'فاتو'},
    {'code': 'WST', 'symbol': 'WS\$', 'name': 'Samoan Tala', 'localName': 'تالا'},
    {'code': 'XAF', 'symbol': 'FCFA', 'name': 'Central African CFA Franc', 'localName': 'فرنك وسط أفريقي'},
    {'code': 'XCD', 'symbol': 'EC\$', 'name': 'East Caribbean Dollar', 'localName': 'دولار الكاريبي الشرقي'},
    {'code': 'XOF', 'symbol': 'CFA', 'name': 'West African CFA Franc', 'localName': 'فرنك غرب أفريقي'},
    {'code': 'XPF', 'symbol': '₣', 'name': 'CFP Franc', 'localName': 'فرنك المحيط الهادئ'},
    {'code': 'YER', 'symbol': '﷼', 'name': 'Yemeni Rial', 'localName': 'ريال يمني'},
    {'code': 'ZAR', 'symbol': 'R', 'name': 'South African Rand', 'localName': 'راند جنوب أفريقي'},
    {'code': 'ZMW', 'symbol': 'ZK', 'name': 'Zambian Kwacha', 'localName': 'كواча زامبياني'},
    {'code': 'ZWL', 'symbol': 'Z\$', 'name': 'Zimbabwean Dollar', 'localName': 'دولار زيمبابوي'},
  ];
}

class CurrencyInfo {
  final String code;
  final String symbol;
  final String name;
  final String localName;

  const CurrencyInfo({
    required this.code,
    required this.symbol,
    required this.name,
    required this.localName,
  });

  @override
  String toString() => '$code - $name ($symbol)';
}
