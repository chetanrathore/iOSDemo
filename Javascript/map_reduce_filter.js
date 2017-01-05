/**
 * Created by LaNet on 1/5/17.
 */
class Employee{
    constructor(name, salary) {
        this.name = name;
        this.salary = salary;
    }
}

const employee1 = new Employee('Abc',5000);

var myArr = [2,4,56,25,3,2,34,70,8];

console.log("original of elements");
console.log(myArr);


// in map argument order = element, index, and array
var squareOfMyArray = myArr.map(element => {
    return element*element;
})

console.log("square of elements");
console.log(squareOfMyArray);

var filteredArr = myArr.filter((element, index, myArr) => {
    return myArr.indexOf(element) === index;
});
console.log("unique array");
console.log(filteredArr);

//reduce
var employees = [
    { name:'abc', salary: 5000 },
    { name:'abcd', salary: 25000 },
    { name:'xyz', salary: 5500 },
    { name:'dfgdfg', salary: 5200 },
];

const totalSalary = employees.reduce((preVal,element) => preVal + element.salary, 0);
console.log(totalSalary);