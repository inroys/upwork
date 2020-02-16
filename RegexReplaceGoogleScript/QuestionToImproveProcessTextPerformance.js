function parseGmail() 
{
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = ss.getSheetByName('シート1');
  var settings = ss.getSheetByName('設定');
  
  var recipient = settings.getRange('A2').getDisplayValue();
  var senderName = settings.getRange('B2').getDisplayValue();
  var receivedFrom = settings.getRange('C2').getDisplayValue().trim();
  
  var body1 = settings.getRange('A4').getDisplayValue();
  var body2 = settings.getRange('B4').getDisplayValue();
  var subject = settings.getRange('C4').getDisplayValue();
  
  
  var val = sheet.getDataRange().getDisplayValues();
  var threads = GmailApp.search('from:'+receivedFrom+' has:attachment newer_than:1d; is:unread');
  var param = {
    title: 'OCR File',
    mimeType: 'image/png'
  };
  var arr = '';
  for(var i in threads)
  {
    var messages = threads[i].getMessages();
    for(var j in messages)
    {
      var attachments = messages[j].getAttachments();
      for(var k in attachments)
      {
        var file = attachments[k];
        var type = file.getContentType();
        if(type.match('image'))
        {
          var OCR = file.copyBlob();
          var textDoc = Drive.Files.insert(param, file, {ocr: true});
          var url = textDoc.alternateLink;
          var doc = DocumentApp.openByUrl(url);
          var id = doc.getId();
          var text = doc.getBody().getText();
          doc.saveAndClose();
          Drive.Files.remove(id);          
          text = text.replace(/\n/g, '').replace(/\s/g, '');
          var ret = ProcessText(val, text);
          if(ret !== false)
          {
            var body = body1 + ret +body2;
            body = body.trim();
            MailApp.sendEmail(
              {
                to: recipient,
                subject: subject,
                name: senderName,
                htmlBody: body
              })
          }
        }
      }
      messages[j].markRead();
    }
  }
}


function example() {
    const str = 'Go to Google,Work on Upwork,Up,Ogle';
    const arr = [["Go","GO1"],["Google","GOOGLE2"],["Work", "WORK3"],["Upwork","UPWORK4"],["Up","UP5"],["Ogle", "OGLE6"], ["、", "punct"]];
    Logger.log(ProcessText(arr, str));
}


function ProcessText(val, text)
{
  const dic = val.reduce(function (a,c) {
      a[c[0]] = c[1];
      return a;
  },{});
  var poses = toPos(text);
  Object.keys(dic).forEach(function (e) { getPoses(text,e).forEach(function (f) { if(poses[f] < f + e.length) { poses[f] = f + e.length;}})});
  var cursor = 0;
  var ret = "";
  for(var s = 0; s < poses.length;) {
      var e = poses[s];
      if (s === e) { s++; continue;}
      var needle = text.substring(s,e);
      ret += text.substring(cursor,s) + anchor(needle, dic[needle]);
      cursor = e;
      s = e;
  }
  ret += text.substring(cursor);
  return ret;
}
function anchor(word, url) {
  return ' <a href="'+url+'" target="blank">' +word+ '</a> ';
}
function toPos(str) {
  return str.split("").map(function(_,i){ return i;});
}
function getPoses(haystack, needle) {
  var ret = [];
  var pos = haystack.indexOf(needle);
  const len = needle.length;
  while (pos !== -1) {
      ret.push(pos);
      pos = haystack.indexOf(needle, pos + len);
  }
  return ret;
}