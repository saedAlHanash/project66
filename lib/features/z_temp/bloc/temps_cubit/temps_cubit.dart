import 'package:project66/core/api_manager/api_url.dart';
import 'package:project66/core/api_manager/request_models/command.dart';
import 'package:project66/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import 'package:m_cubit/abstraction.dart';
import '../../../../core/util/pair_class.dart';
import '../../data/response/temp_response.dart';

part 'temps_state.dart';

class TempsCubit extends MCubit<TempsInitial> {
  TempsCubit() : super(TempsInitial.initial());

  @override
  String get nameCache => 'temps';

  @override
  String get filter => (state.filterRequest?.getKey) ?? state.request?.toString() ?? '';

  Future<void> getTemps({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Temp.fromJson,
      state: state,
      getDataApi: _getTemps,
      newData: newData,
    );
  }

  Future<Pair<List<Temp>?, String?>> _getTemps() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.temps,
      body: state.filterRequest?.toJson() ?? {},
    );
    return Pair(null, null);
  }

  Future<void> addOrUpdateTempToCache(Temp item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Temp.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteTempFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Temp.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
