class SlotResponse {
  List<ServiceDaySlots>? serviceDaySlots;

  SlotResponse({this.serviceDaySlots});

  SlotResponse.fromJson(Map<String, dynamic> json) {
    if (json['serviceDaySlots'] != null) {
      serviceDaySlots = <ServiceDaySlots>[];
      json['serviceDaySlots'].forEach((v) {
        serviceDaySlots!.add( ServiceDaySlots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    if (serviceDaySlots != null) {
      data['serviceDaySlots'] =
          serviceDaySlots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceDaySlots {
  String? slotStartTime;
  String? slotEndTime;
  List<Periods>? periods;

  ServiceDaySlots({this.slotStartTime, this.slotEndTime, this.periods});

  ServiceDaySlots.fromJson(Map<String, dynamic> json) {
    slotStartTime = json['slotStartTime'];
    slotEndTime = json['slotEndTime'];
    if (json['periods'] != null) {
      periods = <Periods>[];
      json['periods'].forEach((v) {
        periods!.add( Periods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['slotStartTime'] = slotStartTime;
    data['slotEndTime'] = slotEndTime;
    if (periods != null) {
      data['periods'] = periods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Periods {
  int? id;
  String? from;
  String? to;
  int? serviceDaySlotId;

  Periods({this.id, this.from, this.to, this.serviceDaySlotId});

  Periods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    serviceDaySlotId = json['serviceDaySlotId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  {};
    data['id'] = id;
    data['from'] = from;
    data['to'] = to;
    data['serviceDaySlotId'] = serviceDaySlotId;
    return data;
  }
}
