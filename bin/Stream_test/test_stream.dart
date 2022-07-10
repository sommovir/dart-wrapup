Future<int> sumAll(int num) async{
  var sum = 0;
  var stream = countBruh(num);

  await for (var val in stream){
    print("FOR => $val");
    sum += val;
  }

  return sum;
}

Stream<int> countBruh(int num) async* {
  for (var i = 1; i <= num; i++){
    print("STREAM =>  $i");
    yield i;
  }
}

void main(List<String> args) async{
  var sum = await sumAll(10);
  print(sum);
}