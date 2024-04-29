// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_chat_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMultiChatModelCollection on Isar {
  IsarCollection<MultiChatModel> get multiChatModels => this.collection();
}

const MultiChatModelSchema = CollectionSchema(
  name: r'MultiChatModel',
  id: 2697483922978031541,
  properties: {
    r'isRead': PropertySchema(
      id: 0,
      name: r'isRead',
      type: IsarType.bool,
    ),
    r'message': PropertySchema(
      id: 1,
      name: r'message',
      type: IsarType.string,
    ),
    r'messageType': PropertySchema(
      id: 2,
      name: r'messageType',
      type: IsarType.byte,
      enumMap: _MultiChatModelmessageTypeEnumValueMap,
    ),
    r'sender': PropertySchema(
      id: 3,
      name: r'sender',
      type: IsarType.byte,
      enumMap: _MultiChatModelsenderEnumValueMap,
    ),
    r'sentTime': PropertySchema(
      id: 4,
      name: r'sentTime',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _multiChatModelEstimateSize,
  serialize: _multiChatModelSerialize,
  deserialize: _multiChatModelDeserialize,
  deserializeProp: _multiChatModelDeserializeProp,
  idName: r'messageId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _multiChatModelGetId,
  getLinks: _multiChatModelGetLinks,
  attach: _multiChatModelAttach,
  version: '3.1.0+1',
);

int _multiChatModelEstimateSize(
  MultiChatModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.message;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _multiChatModelSerialize(
  MultiChatModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isRead);
  writer.writeString(offsets[1], object.message);
  writer.writeByte(offsets[2], object.messageType.index);
  writer.writeByte(offsets[3], object.sender.index);
  writer.writeDateTime(offsets[4], object.sentTime);
}

MultiChatModel _multiChatModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MultiChatModel();
  object.isRead = reader.readBool(offsets[0]);
  object.message = reader.readStringOrNull(offsets[1]);
  object.messageId = id;
  object.messageType = _MultiChatModelmessageTypeValueEnumMap[
          reader.readByteOrNull(offsets[2])] ??
      MessageType.text;
  object.sender =
      _MultiChatModelsenderValueEnumMap[reader.readByteOrNull(offsets[3])] ??
          Sender.user;
  object.sentTime = reader.readDateTime(offsets[4]);
  return object;
}

P _multiChatModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (_MultiChatModelmessageTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          MessageType.text) as P;
    case 3:
      return (_MultiChatModelsenderValueEnumMap[
              reader.readByteOrNull(offset)] ??
          Sender.user) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MultiChatModelmessageTypeEnumValueMap = {
  'text': 0,
  'image': 1,
};
const _MultiChatModelmessageTypeValueEnumMap = {
  0: MessageType.text,
  1: MessageType.image,
};
const _MultiChatModelsenderEnumValueMap = {
  'user': 0,
  'bot': 1,
};
const _MultiChatModelsenderValueEnumMap = {
  0: Sender.user,
  1: Sender.bot,
};

Id _multiChatModelGetId(MultiChatModel object) {
  return object.messageId;
}

List<IsarLinkBase<dynamic>> _multiChatModelGetLinks(MultiChatModel object) {
  return [];
}

void _multiChatModelAttach(
    IsarCollection<dynamic> col, Id id, MultiChatModel object) {
  object.messageId = id;
}

extension MultiChatModelQueryWhereSort
    on QueryBuilder<MultiChatModel, MultiChatModel, QWhere> {
  QueryBuilder<MultiChatModel, MultiChatModel, QAfterWhere> anyMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MultiChatModelQueryWhere
    on QueryBuilder<MultiChatModel, MultiChatModel, QWhereClause> {
  QueryBuilder<MultiChatModel, MultiChatModel, QAfterWhereClause>
      messageIdEqualTo(Id messageId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: messageId,
        upper: messageId,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterWhereClause>
      messageIdNotEqualTo(Id messageId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: messageId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: messageId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: messageId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: messageId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterWhereClause>
      messageIdGreaterThan(Id messageId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: messageId, includeLower: include),
      );
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterWhereClause>
      messageIdLessThan(Id messageId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: messageId, includeUpper: include),
      );
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterWhereClause>
      messageIdBetween(
    Id lowerMessageId,
    Id upperMessageId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerMessageId,
        includeLower: includeLower,
        upper: upperMessageId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MultiChatModelQueryFilter
    on QueryBuilder<MultiChatModel, MultiChatModel, QFilterCondition> {
  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      isReadEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isRead',
        value: value,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'message',
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'message',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'message',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'message',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'message',
        value: '',
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageId',
        value: value,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageId',
        value: value,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageId',
        value: value,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageTypeEqualTo(MessageType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageTypeGreaterThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageTypeLessThan(
    MessageType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'messageType',
        value: value,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      messageTypeBetween(
    MessageType lower,
    MessageType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'messageType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      senderEqualTo(Sender value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sender',
        value: value,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      senderGreaterThan(
    Sender value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sender',
        value: value,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      senderLessThan(
    Sender value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sender',
        value: value,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      senderBetween(
    Sender lower,
    Sender upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sender',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      sentTimeEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sentTime',
        value: value,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      sentTimeGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sentTime',
        value: value,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      sentTimeLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sentTime',
        value: value,
      ));
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterFilterCondition>
      sentTimeBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sentTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MultiChatModelQueryObject
    on QueryBuilder<MultiChatModel, MultiChatModel, QFilterCondition> {}

extension MultiChatModelQueryLinks
    on QueryBuilder<MultiChatModel, MultiChatModel, QFilterCondition> {}

extension MultiChatModelQuerySortBy
    on QueryBuilder<MultiChatModel, MultiChatModel, QSortBy> {
  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy> sortByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy>
      sortByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy> sortByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy>
      sortByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy>
      sortByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy>
      sortByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy> sortBySender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sender', Sort.asc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy>
      sortBySenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sender', Sort.desc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy> sortBySentTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sentTime', Sort.asc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy>
      sortBySentTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sentTime', Sort.desc);
    });
  }
}

extension MultiChatModelQuerySortThenBy
    on QueryBuilder<MultiChatModel, MultiChatModel, QSortThenBy> {
  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy> thenByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.asc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy>
      thenByIsReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isRead', Sort.desc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy> thenByMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.asc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy>
      thenByMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'message', Sort.desc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy> thenByMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.asc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy>
      thenByMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageId', Sort.desc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy>
      thenByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.asc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy>
      thenByMessageTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'messageType', Sort.desc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy> thenBySender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sender', Sort.asc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy>
      thenBySenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sender', Sort.desc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy> thenBySentTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sentTime', Sort.asc);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QAfterSortBy>
      thenBySentTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sentTime', Sort.desc);
    });
  }
}

extension MultiChatModelQueryWhereDistinct
    on QueryBuilder<MultiChatModel, MultiChatModel, QDistinct> {
  QueryBuilder<MultiChatModel, MultiChatModel, QDistinct> distinctByIsRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isRead');
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QDistinct> distinctByMessage(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'message', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QDistinct>
      distinctByMessageType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'messageType');
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QDistinct> distinctBySender() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sender');
    });
  }

  QueryBuilder<MultiChatModel, MultiChatModel, QDistinct> distinctBySentTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sentTime');
    });
  }
}

extension MultiChatModelQueryProperty
    on QueryBuilder<MultiChatModel, MultiChatModel, QQueryProperty> {
  QueryBuilder<MultiChatModel, int, QQueryOperations> messageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageId');
    });
  }

  QueryBuilder<MultiChatModel, bool, QQueryOperations> isReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isRead');
    });
  }

  QueryBuilder<MultiChatModel, String?, QQueryOperations> messageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'message');
    });
  }

  QueryBuilder<MultiChatModel, MessageType, QQueryOperations>
      messageTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'messageType');
    });
  }

  QueryBuilder<MultiChatModel, Sender, QQueryOperations> senderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sender');
    });
  }

  QueryBuilder<MultiChatModel, DateTime, QQueryOperations> sentTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sentTime');
    });
  }
}
