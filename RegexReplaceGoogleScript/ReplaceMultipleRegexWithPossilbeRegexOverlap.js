function example2() {
  const str = 'Go to Google,Work on Upwork,Up,Ogle Go to Google,Work on Upwork,Up,Ogle';
  const arr = [["Go","GO1"],["Google","GOOGLE2"],["Work", "WORK3"],["Upwork","UPWORK4"],["Up","UP5"],["Ogle", "OGLE6"], ["、", "punct"]];
  ProcessText(arr, str);
}

function ProcessText(arr, str) {
    
  const dic = arr.reduce(function (a,c) {
    a[c[0]] = c[1];
    return a;
  },{});
  
  var regexstr = '\(\\b' + Object.keys(dic).join('\\b\)|\(\\b') + '\\b\)';
  var regex = new RegExp(regexstr,"gi");
  
  return result = str.replace(regex, function(matched){
    return dic[matched];
  });

console.log(str);
}