import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../app/app_widget.dart';
import 'app_color_manager.dart';

// enum CubitStatuses { init, loading, done, error }

enum ProfileCard {
  trips,
  shipments,
  pay,
  ern;
}

enum ApiType {
  get,
  post,
  put,
  patch,
  delete,
}

enum StartPage { login, home, signupOtp, passwordOtp }

enum GenderEnum { male, female }

enum NeedUpdateEnum { no, withLoading, noLoading }

enum FilterOrderBy {
  desc,
  asc,
}

enum FilterOperation {
  equals('Equals'),
  notEqual('NotEqual'),
  contains('Contains'),
  startsWith('StartsWith'),
  endsWith('EndsWith'),
  lessThan('LessThan'),
  lessThanEqual('LessThanEqual'),
  greaterThan('GreaterThan'),
  greaterThanEqual('GreaterThanEqual');

  const FilterOperation(this.realName);

  final String realName;

  static FilterOperation byName(String s) {
    switch (s) {
      case 'Equals':
        return FilterOperation.equals;
      case 'NotEqual':
        return FilterOperation.notEqual;
      case 'Contains':
        return FilterOperation.contains;
      case 'StartsWith':
        return FilterOperation.startsWith;
      case 'EndsWith':
        return FilterOperation.endsWith;
      case 'LessThan':
        return FilterOperation.lessThan;
      case 'LessThanEqual':
        return FilterOperation.lessThanEqual;
      case 'GreaterThan':
        return FilterOperation.greaterThan;
      case 'GreaterThanEqual':
        return FilterOperation.greaterThanEqual;
      default:
        return FilterOperation.equals;
    }
  }
}

enum SuspensionType {
  damage,
  complianceRules,
}

enum ShipmentStatus {
  pending('Pending'),
  dropped('Dropped'),
  carried('Carried'),
  delivered('Delivered'),
  pickedUp('PickedUp'),
  canceled('Canceled'),
  suspended('Suspended'),
  returned('Returned');

  const ShipmentStatus(this.realName);

  final String realName;

  bool get isStop => this == canceled || this == suspended || this == returned;

  bool get canCancelPairing => this == pending || this == dropped;

  bool isReturn(ShipmentStatus? previous) {
    if (previous == null) return false;
    return index < previous.index;
  }

  Widget get stateWidget {
    if (this == ShipmentStatus.pending) {
      return DrawableText(
        text: S().new_,
        color: AppColorManager.mainColor,
        size: 14.0.sp,
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0.r),
        color: getColor.withOpacity(0.1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getIcon,
          2.0.horizontalSpace,
          DrawableText(text: name),
        ],
      ),
    );
  }

  Color get getColor {
    switch (this) {
      case ShipmentStatus.pending:
        return AppColorManager.mainColor;
      case ShipmentStatus.dropped:
      case ShipmentStatus.carried:
      case ShipmentStatus.delivered:
      case ShipmentStatus.pickedUp:
        return Colors.green;
      case ShipmentStatus.canceled:
      case ShipmentStatus.suspended:
        return Colors.red;
      case ShipmentStatus.returned:
        return Colors.amber;
    }
  }

  Widget get getIcon {
    return ImageMultiType(
      height: 24.0.r,
      width: 24.0.r,
      url: (isStop)
          ? Icons.do_disturb_alt
          : this == ShipmentStatus.pickedUp
              ? Icons.done_all
              : Icons.radio_button_checked,
      color: getColor,
    );
  }
}

enum PairingStatus {
  active,
  canceled,
}

enum PairingRequestType {
  suggestion,
  request;

  String get getName {
    switch (this) {
      case PairingRequestType.suggestion:
        return 'From Me';
      case PairingRequestType.request:
        return 'From Sender';
    }
  }
}

enum PairingRequestStatus {
  pending,
  answered,
  accepted,
  ignored;

  bool get canCancel => this == pending;
}

enum PairingRequestButtons {
  canAnswer,
  canIgnore,
  canAccept,
}

enum NotificationTarget {
  none,
  newPairingRequest,
  newSuggestionRequest,
  pairingRequestUpdateStatus
}

enum ConstraintOperation {
  equals,
  contains,
  lessThan,
  greaterThan,
}

enum CandidateOfficeType {
  source,
  destination,
}

enum CandidateOfficeCreator {
  shipment,
  trip,
}

enum CriterionType { lov, scaler, range }

enum CriterionDataType {
  string,
  int,
  double,
  date,
  datetime,
  boolean,
  guid;
}

enum CriterionOperation {
  equals,
  notEquals,
  contains,
  between,
  lessThan,
  greaterThan,
  lessThanEqual,
  greaterThanEqual;

  String get name {
    switch (this) {
      case equals:
        return '';
      case notEquals:
        return 'Not';
      case contains:
        return 'Contain';
      case between:
        return 'Between';
      case lessThan:
        return 'Less than';
      case greaterThan:
        return 'Greater than';
      case lessThanEqual:
        return 'Less than or equal';
      case greaterThanEqual:
        return 'Greater than or equal';
    }
  }
}

enum CriterionGroup {
  personal,
  financial,
  legal;

  String get getName {
    switch (this) {
      case CriterionGroup.personal:
        return S.of(ctx!).personal;
      case CriterionGroup.financial:
        return S.of(ctx!).financial;
      case CriterionGroup.legal:
        return S.of(ctx!).legal;
    }
  }

  dynamic get getIcon {
    switch (this) {
      case CriterionGroup.personal:
        return Assets.iconsProfile;
      case CriterionGroup.financial:
        return Assets.iconsCreditCard;
      case CriterionGroup.legal:
        return Assets.iconsFile;
    }
  }
}

enum SortEnum {
  date,
  n,
  amount,
  id;

  String get name {
    switch (this) {
      case SortEnum.n:
        return 'حسب الاسم';
      case SortEnum.date:
        return 'حسب تاريخ الإضافة';
      case SortEnum.amount:
        return 'حسب عدد الأسهم';
      case SortEnum.id:
        return 'حسب رقم السند';
    }
  }
}

//
enum StoreEnum {
  store1,
  store2,
  store3,
  store4,
  store5,
  store6,
  store7,
  store8,
  store9;

  String get name {
    switch (this) {
      case StoreEnum.store1:
        return 'التخزين 1';
      case StoreEnum.store2:
        return 'التخزين 2';
      case StoreEnum.store3:
        return 'التخزين 3';
      case StoreEnum.store4:
        return 'التخزين 4';
      case StoreEnum.store5:
        return 'التخزين 5';
      case StoreEnum.store6:
        return 'التخزين 6';
      case StoreEnum.store7:
        return 'التخزين 7';
      case StoreEnum.store8:
        return 'التخزين 8';
      case StoreEnum.store9:
        return 'التخزين 9';
    }
  }
}
