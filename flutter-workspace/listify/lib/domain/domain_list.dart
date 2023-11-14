import 'domain_list_item.dart';

class DomainList {
  String id;
  String name;

  String ownerId;
  List<String> memberIdList;

  List<DomainListItem> itemList;

  DomainList(
    this.id,
    this.name,
    this.ownerId,
    this.memberIdList,
    this.itemList,
  );
}
