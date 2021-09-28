class TimeConverter{

  final int hour;

  const TimeConverter({required this.hour});

  String get convertedTime{
    switch(hour){
      case 1:
        return '7';
      case 2:
        return '8';
      case 3:
        return '9';
      case 4:
        return '10';
      case 5:
        return '11';
      case 6:
        return '12';
      case 7:
        return '1';
      case 8:
        return '2';
      case 9:
        return '3';
      case 10:
        return '4';
      case 11:
        return '5';
      case 12:
        return '6';
      case 13:
        return '7';
      case 14:
        return '8';
      case 15:
        return '9';
      case 16:
        return '10';
      case 17:
        return '11';
      case 18:
        return '12';
      case 19:
        return '1';
      case 20:
        return '2';
      case 21:
        return '3';
      case 22:
        return '4';
      case 23:
        return '5';
      case 0:
        return '6';
      default:
        return '0';
    }
  }

}