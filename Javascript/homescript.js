//alert();
document.forms['formEmp']['txtName'].focus();
var employees = [];
function isValidData() {
    var name = document.forms['formEmp']['txtName'].value;
    var phoneNo = document.forms['formEmp']['txtMobileNo'].value;
    var department = document.forms['formEmp']['txtDepartment'].value;
    var salary = document.forms['formEmp']['txtSalary'].value;
    var isValid = true;
    var emp = {
        "name": name,
        "phoneNo": phoneNo,
        "department": department,
        "salary": salary
    }
    if (isValid) {
        clearAll();
        employees.push(emp);
        reloadEmployees();
    }
}
function reloadEmployees() {
    var html = "";
    for (var i = 0; i < employees.length; i++) {
        var obj = employees[i];
        html += "<tr><td>" + obj.name + "</td>";
        html += "<td>" + obj.phoneNo + "</td>";
        html += "<td>" + obj.department + "</td>";
        html += "<td>Rs." + obj.salary + "</td>";
        html += "<td>" + obj.salary + "</td></tr>";

    }
    document.getElementById('empVal').innerHTML = html;
}
function clearAll() {
    document.forms['formEmp']['txtName'].value = "";
    document.forms['formEmp']['txtMobileNo'].value = "";
    document.forms['formEmp']['txtDepartment'].value = "";
    document.forms['formEmp']['txtSalary'].value = "";
}