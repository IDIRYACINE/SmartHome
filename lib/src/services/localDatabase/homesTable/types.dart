

enum HomeTableAttributes {
  homeId,
  homeName,
}

extension Attributes on HomeTableAttributes {
  String get name {
    switch (this) {
      case HomeTableAttributes.homeId:
        return 'home_id';
      case HomeTableAttributes.homeName:
        return 'home_name';
    }
  }

  String get type {
    switch (this) {
      case HomeTableAttributes.homeId:
        return 'INTEGER PRIMARY KEY';
      case HomeTableAttributes.homeName:
        return 'TEXT NOT NULL';
    }
  }
}

class UpdateHomeData {
  final int homeId;
  final String homeName;

  UpdateHomeData(this.homeId, this.homeName);
}

class DeleteHomeData {
  final int homeId;

  DeleteHomeData(this.homeId);
}

class InsertHomeData {
  final int homeId;
  final String homeName;

  InsertHomeData(this.homeId, this.homeName);
}

class SelectHomeData {
  final int homeId;

  SelectHomeData(this.homeId);
}
