import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/ApiCall.dart';
import 'package:flutterapp/models/apiModel.dart';

class ApiBloc extends Bloc<ApiEvent , ApiState>{
  @override
  // TODO: implement initialState
  ApiState get initialState => ApiState(state: resultState.Empty);

  @override
  Stream<ApiState> mapEventToState(ApiEvent event)async* {
    // TODO: implement mapEventToState
    yield ApiState(state: resultState.Loading );
    var apiResponse = await ApiCall.getApiResponse();
    if(apiResponse!=null)
      yield ApiState(state: resultState.Loaded , model: apiResponse );
else
      yield ApiState(state: resultState.Error );




  }

}
class ApiEvent {}
class ApiState {
  resultState state ;
  apiModel model;
  ApiState({this.state, this.model});

}
enum resultState {
  Empty , Loaded , Loading , Error
}
