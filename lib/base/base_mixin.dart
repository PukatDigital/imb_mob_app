import '../application/core/extensions/extensions.dart';
import '../data/local_data_source/preference/i_pref_helper.dart';
import '../di/di.dart';
import '../nav-service/i_nav_service.dart';

mixin BaseMixin {
  final INavService _navigator = inject<INavService>();

  final Px _dimens = inject<Px>();

  final IPrefHelper _iPrefHelper = inject<IPrefHelper>();

  INavService get navigator => _navigator;

  Px get dimens => _dimens;

  IPrefHelper get iPrefHelper => _iPrefHelper;
}
