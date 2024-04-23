import 'package:agendai/app.dart';
import 'package:agendai/core/flavor/flavor_config.dart';

void main(){
  bootstrap(
    FlavorConfig(baseUrl: 'www.google.com.br', flavor: AppFlavor.prod,),
  );
}