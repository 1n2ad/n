import 'package:flutter/cupertino.dart';
import 'package:smart_guide_to_medication/Smart_Guide/data/models/login/login_screen.dart';
import 'package:smart_guide_to_medication/Smart_Guide/shared/components/components.dart';
import 'package:smart_guide_to_medication/Smart_Guide/shared/network/local/cache_helper.dart';

/////////////////////////////////
// void userLogout(context) {
//   CacheHelper.removeDataFromSharedPreferences(key: 'userToken').then(
//     (value) {
//       if (value) {
//         navigateAndFinish(context, LoginScreen());
//       }
//     },
//   );
// }

/////////////////////////////////
void closeKeyboard(context) {
  // To close keyboard
  FocusScope.of(context).unfocus();
}

/////////////////////////////////
dynamic userToken = '';

var shopLayoutItems = {
  'en': [
    'Home',
    'Categories',
    'Favorites',
    'Settinges',
  ],
  'ar': [
    'الصفحة الرئيسية',
    'الفئات',
    'المفضلة',
    'الإعدادات',
  ],
};

/////////////////////////////////
Map appWords = {
  'Protect_and_monitor': {
    'en': 'Protect and monitor applications',
    'ar': 'تطبيق حماية ومراقبة التطبيقات',
  },
  'Next': {
    'en': 'Next',
    'ar': 'التالي',
  },
  'Login_with_Google': {
    'en': 'Login with Google',
    'ar': 'تسجيل الدخول مع جوجل',
  },
  'Wall_protection': {
    'en': 'Wall protection',
    'ar': 'جدار الحماية',
  },
  'Network_management': {
    'en': 'Network management',
    'ar': 'إدارة الشبكة',
  },
  'Device_information': {
    'en': 'Device information',
    'ar': 'معلومات الجهاز',
  },
  'Item_location': {
    'en': 'Item location',
    'ar': 'موقع السلعة',
  },
  'Presentation_title': {
    'en': 'Presentation title',
    'ar': 'عنوان العرض',
  },
  'Change_Location': {
    'en': 'Change Location',
    'ar': 'تغيير الموقع',
  },
  'Add_a_photo': {
    'en': 'Add a photo',
    'ar': 'اضافة صورة',
  },
  'malee': {
    'en': 'male',
    'ar': 'ذكر',
  },
  'WhatsApp_code': {
    'en': 'WhatsApp code',
    'ar': 'كود واتساب',
  },
  'message_code': {
    'en': 'Text message code',
    'ar': 'رسالة نصية',
  },
  'Send_verification': {
    'en': 'Send verification code via',
    'ar': 'ارسال كود التحقق عبر',
  },
  'verification_sms': {
    'en': 'Enter the verification code sent to you via text message',
    'ar': 'ادخل كود التحقق المرسل اليك عبر رسالة نصية',
  },
  'femalee': {
    'en': 'female',
    'ar': 'انثئ',
  },
  'agree': {
    'en': 'I agree to all terms and conditions',
    'ar': 'أوافق على جميع الشروط والأحكام',
  },
  'firstName': {
    'en': 'firstName',
    'ar': 'الاسم الاول',
  },
  'user_name': {
    'en': 'user name',
    'ar': 'اسم المستخدم',
  },
  'lastName': {
    'en': 'lastName',
    'ar': 'الاسم الثالث',
  },
  'middleName': {
    'en': 'middleName',
    'ar': 'الاسم الثاني',
  },
  'Title': {
    'en': 'Title',
    'ar': 'اللقب',
  },
  'loginTitle': {
    'en': 'Log in to your account',
    'ar': 'تسجيل الدخول إلى حسابك',
  },
  'login': {
    'en': 'LOGIN',
    'ar': 'تسجيل الدخول',
  },
  'noAccount': {
    'en': 'Don\'t have an account?',
    'ar': 'لا تملك حساب؟',
  },
  'haveAccount': {
    'en': 'Do you already have an account?',
    'ar': 'هل لديك حساب بالفعل؟',
  },
  'createAccount': {
    'en': 'Create a new account',
    'ar': 'إنشاء حساب جديد',
  },
  'register': {
    'en': 'REGISTER',
    'ar': 'تسجيل',
  },
  'logout': {
    'en': 'LOGOUT',
    'ar': 'تسجيل الخروج',
  },
  /////////////
  'username': {
    'en': 'Username',
    'ar': 'اسم المستخدم',
  },
  'usernameError': {
    'en': 'Please enter your username',
    'ar': 'يرجي إدخال اسم المستخدم الخاص بك',
  },
  'email': {
    'en': 'Email Address',
    'ar': 'عنوان البريد الإلكتروني',
  },
  'emailError': {
    'en': 'Please enter a valid email address',
    'ar': 'يرجى إدخال عنوان بريد إلكتروني صحيح',
  },
  'password': {
    'en': 'Password',
    'ar': 'كلمة المرور',
  },
  'Confirm': {
    'en': 'Confirm password',
    'ar': 'تأكيد كلمة المرور',
  },
  'passwordError': {
    'en': 'Password is too short',
    'ar': 'كلمة المرور قصيرة جدا',
  },
  'phone': {
    'en': 'Phone',
    'ar': 'الهاتف',
  },
  'phone_number': {
    'en': 'Phone Number',
    'ar': 'رقم الهاتف',
  },
  'forget': {
    'en': 'forget the password',
    'ar': 'نسيت كلمة المرور؟',
  },
  'remmber': {
    'en': 'remmber',
    'ar': 'ذكرني',
  },
  'verification': {
    'en': 'Enter the verification code',
    'ar': 'ادخل رمز التحقق',
  },
  'verification1': {
    'en': 'verification',
    'ar': 'تحقق',
  },
  'Change': {
    'en': 'Change phone number',
    'ar': 'تغيير رقم الهاتف',
  },
  'WhatsApp': {
    'en': 'Enter the verification code sent to you via WhatsApp',
    'ar': 'ادخل رمز التحقق المرسل اليك عبر واتساب',
  },


  'email_login': {
    'en': 'Email',
    'ar': 'البريد الإلكتروني',
  },
  'phoneError': {
    'en': 'Please enter your phone number',
    'ar': 'يرجى إدخال رقم هاتفك',
  },
  //////////////
  'home': {
    'en': 'Home',
    'ar': 'الصفحة الرئيسية',
  },
  'categories': {
    'en': 'Categories',
    'ar': 'الفئات',
  },
  'products': {
    'en': 'Products',
    'ar': 'المنتجات',
  },
  'favorites': {
    'en': 'Favorites',
    'ar': 'المفضلة',
  },
  'settings': {
    'en': 'Settings',
    'ar': 'الإعدادات',
  },
  /////////
  'cart': {
    'en': 'Shopping Cart',
    'ar': 'عربة التسوق',
  },
  'addCart': {
    'en': 'Add to cart',
    'ar': 'أضف إلى العربة',
  },
  'total': {
    'en': 'Total',
    'ar': 'المجموع',
  },
  'checkout': {
    'en': 'CHECKOUT',
    'ar': 'إتمام الشراء',
  },
  ///////////
  'account': {
    'en': 'Account',
    'ar': 'الحساب',
  },
  'update': {
    'en': 'Updating Data',
    'ar': 'تحديث البيانات',
  },
  ///////////
  'shere_site': {
    'en': 'Share your website',
    'ar': 'شارك موقعك الإلكتروني',
  },
  'ad': {
    'en': 'Add an ad',
    'ar': 'اضف عرض',
  },
  'view': {
    'en': 'View campaigns',
    'ar': 'حملات المشاهدة',
  },
  'follower': {
    'en': 'List of followers',
    'ar': 'قائمة المتابعين',
  },
  'Favorites': {
    'en': 'Favorites list',
    'ar': 'قائمة المفضلة',
  },
  'Payment': {
    'en': 'Payment and subscriptions',
    'ar': 'سداد الرسوم والاشتراكات',
  },
  'services': {
    'en': 'Features and services',
    'ar': 'مميزات وخدمات',
  },
  'call': {
    'en': 'Contact us',
    'ar': 'اتصل بنا',
  },
  'Share': {
    'en': 'Share with your friends',
    'ar': 'شارك مع اصدقائك',
  },
  'policy': {
    'en': 'Tashleeh.com website policy',
    'ar': 'سياسية موقع تشليح كوم',
  },
  'Security': {
    'en': 'Security Center',
    'ar': 'مركز الامان',
  },
  'account_settings': {
    'en': 'account settings',
    'ar': 'اعدادات الحساب',
  },
  'profile': {
    'en': 'My profile My ads',
    'ar': 'ملفي الشخصي , عروضي',
  },
  'home_tap': {
    'en': 'home',
    'ar': 'الرئيسية',
  },
  'work_tap': {
    'en': 'workshop',
    'ar': 'السيارات',
  },
  'Engines_tap': {
    'en': 'Engines',
    'ar': 'محركات',
  },
  'spare': {
    'en': 'spare parts',
    'ar': 'قطع غيار',
  },
  'delivery': {
    'en': 'delivery',
    'ar': 'توصيل',
  },
  'Search': {
    'en': 'Search for parts',
    'ar': 'ابحث في قطع الغيار',
  },
  'Search_images': {
    'en': 'Search by image',
    'ar': 'بحث بالصورة',
  },
  'Search_latest': {
    'en': 'The latest',
    'ar': 'ألاحدث',
  },
  'Search_data': {
    'en': 'By date',
    'ar': 'حسب التاريخ',
  },
  'Messages': {
    'en': 'Messages',
    'ar': 'الرسايل',
  },
  'Notifications': {
    'en': 'Notifications',
    'ar': 'إشعارات',
  },
  'Favorites1': {
    'en': 'Favorites',
    'ar': 'المفضلة',
  },
  'Najran': {
    'en': 'Najran',
    'ar': 'نجران',
  },
  'Cities': {
    'en': 'Cities',
    'ar': 'كل المدن',
  },
  'Model': {
    'en': 'Model',
    'ar': 'الموديل',
  },
  'filtering': {
    'en': 'filter',
    'ar': 'تصفية',
  },
  'near': {
    'en': 'near',
    'ar': 'القريب',
  },
  'Sections': {
    'en': 'search and words',
    'ar': 'كلمات البحث',
  },
  'followers': {
    'en': 'followers',
    'ar': 'المتابعين',
  },
  'following': {
    'en': 'following',
    'ar': 'اتابعهم',
  },
  'Pay': {
    'en': 'Pay site fees',
    'ar': 'سداد رسوم الموقع',
  },
  'subscriptions': {
    'en': 'Annual subscriptions',
    'ar': 'الاشتراكات السنوية',
  },
  'Increase': {
    'en': 'Increase views of shows',
    'ar': 'زيادة مشاهدات العروض',
  },
  'Fee': {
    'en': 'Fee reduction policy',
    'ar': 'سياسة تخفيض الرسوم',
  },
  'Evaluation': {
    'en': 'Evaluation system',
    'ar': 'نظام التقييم',
  },
  'Special': {
    'en': 'Special offers',
    'ar': 'العروض المميزة',
  },
  'Usage_policy': {
    'en': 'Usage policy',
    'ar': 'سياية الاستخدام',
  },
  'Banned_accounts': {
    'en': 'Banned accounts',
    'ar': 'الحسابات والارقام المحظوره',
  },
  'Prohibited_substances': {
    'en': 'Prohibited substances',
    'ar': 'المواد المحظوره',
  },
  'Privacy_policy': {
    'en': 'Privacy policy',
    'ar': 'سياسية الخصوصية',
  },
  'Tashleh_com': {
    'en': 'Tashleh com',
    'ar': 'تشليح كوم',
  },
  'Register_or_log_in': {
    'en': 'Log in/create account',
    'ar': 'تسجيل دحول/حساب جديد',
  },
  'all': {
    'en': 'All',
    'ar': 'الكل',
  },
  ////////////////////////////////السيارات

  "1": {
    "en": "Toyota",
    "ar": "تويوتا"
  },
  "2": {
    "en": "Lexus",
    "ar": "لكزس"
  },
  "3": {
    "en": "BMW",
    "ar": "بي ام دبليو"
  },
  "4": {
    "en": "hounda",
    "ar": "هوندا"
  },
  "5": {
    "en": "land Rover",
    "ar": "لاند روفر"
  },
  "6": {
    "en": "Great Wall",
    "ar": "جريت وول"
  },
  "Land": {
    "ar": "لاندكروزر",
    "en": "Land Cruiser"
  },
  "Camry": {
    "en": "Camry",
    "ar": "كامري"
  },
  "Hilux": {
    "en": "Hilux",
    "ar": "هايلوكس"
  },
  "Corolla": {
    "en": "Corolla",
    "ar": "كورولا"
  },
  "FJ": {
    "en": "FJ Cruiser",
    "ar": "اف جي"
  },
  "RAV4": {
    "en": "RAV4",
    "ar": "راف فور"
  },
  "Cruiser": {
    "en": "Land Cruiser 70 Series",
    "ar": "ربع"
  },

  'theme': {
    'en': 'Theme',
    'ar': 'المظهر',
  },
  'lightMode': {
    'en': 'Light Mode',
    'ar': 'الوضع الفاتح',
  },
  'darkMode': {
    'en': 'Dark Mode',
    'ar': 'الوضع الداكن',
  },
  'themeTitle1': {
    'en': 'Choose your application mode',
    'ar': 'اختر وضع التطبيق الخاص بك',
  },
  'themeTitle2': {
    'en': 'Choose your accent color',
    'ar': 'اختر لون التمييز الخاص بك',
  },
  ///////////
  'language': {
    'en': 'Language',
    'ar': 'اللغة',
  },
  'changeLanguage': {
    'en': 'Please wait while changing the application language',
    'ar': 'يرجى الانتظار أثناء تغيير لغة التطبيق',
  },
  'arabic': {
    'en': 'Arabic',
    'ar': 'العربية',
  },
  ///////////
  'search': {
    'en': 'Search...',
    'ar': 'بحث...',
  },
  'noSearch': {
    'en': 'No results found',
    'ar': 'لم يتم العثور على نتائج',
  },
  ////////////
  'messageAdding': {
    'en': 'Added Successfully',
    'ar': 'تمت الإضافة بنجاح',
  },
  'price': {
    'en': 'EGP',
    'ar': 'جنيه',
  },
    ////////////
  'payment': {
    'en': 'Payment Method',
    'ar': 'طريقة الدفع',
  },
};
