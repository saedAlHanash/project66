import 'package:project66/core/api_manager/api_url.dart';
import 'package:project66/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/temp_response.dart';

part 'temp_state.dart';

class TempCubit extends MCubit<TempInitial> {
  TempCubit() : super(TempInitial.initial());

  @override
  String get nameCache => 'temp';

  @override
  String get filter => state.request ?? '';

  Future<void> getTemp({bool newData = false, required String tempId}) async {

    emit(state.copyWith(request: tempId));

    await getDataAbstract(
      fromJson: Temp.fromJson,
      state: state,
      getDataApi: _getTemp,
      newData: newData,
    );

  }

  Future<Pair<Temp?, String?>> _getTemp() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.temp,
      query: {'Id': state.request},
    );
    return Pair(null,null);
  }
  void setTemp(dynamic temp) {
    if(temp is! Temp)return;

    emit(state.copyWith(result: temp));
  }
}
