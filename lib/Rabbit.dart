class Rabbit{
  String _name;
  RabbitState _rabbitState;

  Rabbit({name, state}){
    this._name = name;
    this._rabbitState = state;
  }

  RabbitState get rabbitState => _rabbitState;

  set rabbitState(RabbitState value) {
    _rabbitState = value;
  }

  String get name => _name;
}

enum RabbitState{ SLEEP, WALK, RUN, EAT}