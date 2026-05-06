import 'package:flutter/material.dart';

import 'base_mixin.dart';

abstract class BaseStateFullWidget extends StatefulWidget with BaseMixin {
  BaseStateFullWidget({super.key});
}

abstract class BaseStateLessWidget extends StatelessWidget with BaseMixin {
  BaseStateLessWidget({super.key});
}
