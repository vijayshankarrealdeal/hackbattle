String lettersCapital(String s) {
  var k = s.split('_');
  //  print(k);
  return k[0].substring(0, 1).toUpperCase() +
      k[0].substring(1).toLowerCase() +
      ' ' +
      k[1].substring(0, 1).toUpperCase() +
      k[1].substring(1).toLowerCase();
}
