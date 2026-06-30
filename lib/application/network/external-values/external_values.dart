import 'i_external_values.dart';

class ExternalValues implements IExternalValues {
  @override
  String getBaseUrl() {
    //return 'https://jsdealers.seccurio.com/api/v1/';
    return 'https://ideal.ssab-bms.com/api/';
  }
  @override
  String getChatUrl() {
    //return 'https://jsdealers.seccurio.com/api/v1/';
    return 'https://chat.ideal.ssab-bms.com';
  }
  @override
  String getImageUrl() {
    return "";
  }
}
//https://dealers.seccurio.com/api/v1/