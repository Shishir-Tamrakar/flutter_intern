part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class OrderStoreEvent extends OrderEvent {}

class OrderFetchEvent extends OrderEvent {}
