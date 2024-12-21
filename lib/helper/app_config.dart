import 'package:flutter/material.dart';

class AppConfig {
  late BuildContext _context;
  late double _height;
  late double _width;
  late double _heightPadding;
  late double _widthPadding;

  AppConfig(BuildContext _context) {
    this._context = _context;
    var _queryData = MediaQuery.of(this._context);
    _height = _queryData.size.height / 100.0;

    _width = _queryData.size.width / 100.0;
    _heightPadding = _height -
        ((_queryData.padding.top + _queryData.padding.bottom) / 100.0);
    _widthPadding =
        _width - (_queryData.padding.left + _queryData.padding.right) / 100.0;
  }

  double appHeight(double v) {
    return _height * v;
  }

  double appWidth(double v) {
    return _width * v;
  }

  double appVerticalPadding(double v) {
    return _heightPadding * v;
  }

  double appHorizontalPadding(double v) {
//    int.parse(settingRepo.setting.mainColor.replaceAll("#", "0xFF"));
    return _widthPadding * v;
  }
}

class AppColors {
  Color mainColor(double opacity) {
    try {
      return const Color.fromARGB(255, 28, 36, 89);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color secondColor(double opacity) {
    try {
      return const Color(0xFFB4BCC8);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color accentColor(double opacity) {
    try {
      return const Color(0xFF454545);
      // return  const Color(0xFF4FCD07);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color colorPrimary(double opacity) {
    try {
      // return  const Color.fromARGB(255, 42, 49, 91);
      // return const Color(0xff6e5fc0);
      return const Color(0xFF053B50);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }




  Color colorPrimaryLight(double opacity) {
    try {
      // return  const Color.fromARGB(255, 42, 49, 91);
      // return const Color(0xff6e5fc0);
      return const Color(0xFFF4FCFF);
    } catch (e) {
      return const Color(0xFFF4FCFF).withOpacity(opacity);
    }
  }

  Color colorWhite(double opacity) {
    try {
      // return  const Color.fromARGB(255, 42, 49, 91);
      // return const Color(0xff6e5fc0);
      return const Color(0xFFFFFFFF);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }


  Color textColor(double opacity) {
    try {
      // return  const Color.fromARGB(255, 42, 49, 91);
      // return const Color(0xff6e5fc0);
      return const Color(0xFF454545);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color colorDark(double opacity) {
    try {
      return const Color(0xFF3C99EF);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color colorPrimaryLightS(double opacity) {
    try {
      // return  const Color.fromARGB(255, 42, 49, 91);
      return const Color(0xffF4FCFF);
    } catch (e) {
      return const Color(0xFFF4FCFF).withOpacity(opacity);
    }
  }

  Color colorPrimaryLightSS(double opacity) {
    try {
      // return  const Color.fromARGB(255, 42, 49, 91);
      return const Color(0xff7aa8b9);
    } catch (e) {
      return const Color(0xFFF4FCFF).withOpacity(opacity);
    }
  }
  Color colorPrimaryDark(double opacity) {
    try {
      return const Color(0xffFFFFFF).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color colorText(double opacity) {
    try {
      return const Color(0xFFFFFFFF);
    } catch (e) {
      return const Color(0xFFFFFFFF).withOpacity(opacity);
    }
  }

  Color colorTextOrange(double opacity) {
    try {
      return const Color(0xFFFD9F9F);
    } catch (e) {
      return const Color(0xFFFFFFFF).withOpacity(opacity);
    }
  }

  Color colorTextGreen(double opacity) {
    try {
      return const Color(0xFF6AAB94);
    } catch (e) {
      return const Color(0xFFFFFFFF).withOpacity(opacity);
    }
  }

  Color colorDivider(double opacity) {
    try {
      return const Color(0xFF001757).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color textFieldBackgroundColor(double opacity) {
    try {
      return const Color(0xFFF4F5F7).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color scaffoldColor(double opacity) {
    try {
      return const Color(0xFFFFFFFF);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color gradientFirst(double opacity) {
    try {
      return const Color(0xFFFFFFFF);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color gradientSecond(double opacity) {
    try {
      return const Color(0xFFFFFFFF).withOpacity(opacity);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color gradientThird(double opacity) {
    try {
      return const Color(0xFFFFFFFF);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color blackColor(double opacity) {
    try {
      return const Color(0xFF000000);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }

  Color boxBackColor(double opacity) {
    try {
      return const Color(0xFFE1F7FF);
    } catch (e) {
      return const Color(0xFFCCCCCC).withOpacity(opacity);
    }
  }
}
