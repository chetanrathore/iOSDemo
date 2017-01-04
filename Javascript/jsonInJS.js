
var data = {"students":[
    {"rollNo":1,"name":"Abc","mark":50},
    {"rollNo":2,"name":"xyz","mark":80},
    {"rollNo":3,"name":"pqr","mark":30},
    {"rollNo":4,"name":"opq","mark":60},
]};

var jsonData = JSON.stringify(data);
document.getElementById('studentJSON').innerHTML = jsonData;

var objJson = JSON.parse(jsonData);
document.getElementById('studentObject').innerHTML = objJson.toString();
var html = "ID | NAME | MARK <br/>";
for(i=0;i<objJson.students.length;i++){
    html +=  + objJson.students[i].rollNo + " | " + objJson.students[i].name + " | " + objJson.students[i].mark + "<br/>";
}
document.getElementById('students').innerHTML = html;