var myObj = {
    name: {first: "Abc", last: "Xyz"},
    ciry: "Surat"
};
console.log(myObj);
console.log(myObj.name.first + ' ' + myObj.name.last);

Object.defineProperty(myObj, 'getFullName',{
   value: myObj.name.first + ' ' + myObj.name.last,
});

console.log(myObj.getFullName);

//define value & get
Object.defineProperty(myObj, 'fullName', {
   get: function () {
     return myObj.name.first + ' ' + myObj.name.last;
   }
});

console.log(myObj.fullName);

//if want to set
Object.defineProperty(myObj, 'setCity', {
   set: function(newVal) {
       "use strict";
       myObj.ciry = newVal;
   }
});
myObj.setCity = "Baroda";

console.log(myObj);

//if freeze an object
//Object.freeze(myObj);

//error cannot change object
//myObj.setCity = "Surat";

Object.defineProperty(myObj, 'name', {
    value: "ABCD",
    enumerable: true,
    writable: false,
});

console.log(myObj);
myObj.name = "change name";

console.log(myObj);//name not be change

for (prop in myObj){
    console.log(prop);
}

function Student(name,mark) {
    this.name = name;
    this.mark = mark;
}

let student = new Student("abc", 65);

console.log(student);

student.mark = 78;

console.log(student.mark);

Student.prototype.rollno = 1;

console.log(student.__proto__);

student.rollno = 3;

console.log(student.__proto__);

console.log(Student.__proto__);

console.log(myObj.__proto__);

console.log(myObj.__proto__.__proto__);

var task = {};
task.title = "iOS task";
task.description = "Imp App";

console.log(task);

task.toString = function () {
   return task.title + '-' + task.description;
}

console.log(task.toString());

console.log(Object.keys(task));

console.log(Object.valueOf(task));

var impTask = Object.create(task);

console.log(impTask);
var impTask = Object.create(task);

console.log(impTask);
var impTask = Object.create(task);

console.log(impTask);