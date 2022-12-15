
class Room{
  String name;
  int id;
  String? description;
  List<int> deviceIds;

  Room({
    required this.name,
    required this.id,
    this.description,
    required this.deviceIds,
  });
}