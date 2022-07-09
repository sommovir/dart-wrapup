class Person{
  var name;
  var surname;
  var age;

  Person(this.name, this.surname, this.age);

  factory Person.fromJson(Map<String, dynamic> json){
    
    final nome = json['name'] as String;
    final cognome = json['surname'] as String;
    final eta = json['age'] as int;
    
    return Person(nome, cognome, eta);

    
  }

  static Map<String, dynamic> toJson(Person value) =>
      {'name': value.name, 'surname': value.surname, 'age' : value.age};

}