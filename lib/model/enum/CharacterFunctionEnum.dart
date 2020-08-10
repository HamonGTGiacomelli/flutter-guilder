import 'package:flutter/cupertino.dart';

enum CharacterFunction { DAMAGE_PHYSIC, DAMAGE_MAGIC, HEALER, TANK }

String characterValueToString(CharacterFunction characterFunction) {

  debugPrint(characterFunction.toString() + " aqui");
  switch (characterFunction) {
    case CharacterFunction.DAMAGE_PHYSIC:
      return 'Dano Físico';
    case CharacterFunction.DAMAGE_MAGIC:
      return 'Dano Mágico';
    case CharacterFunction.HEALER:
      return 'Curandeiro';
    case CharacterFunction.TANK:
      return 'Tanque';
    default:
      return '';
  }
}
