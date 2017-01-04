//alert();
document.forms['formEmp']['txtName'].focus();
var employees = [];
function isValidData() {
    var name = document.forms['formEmp']['txtName'].value;
    var phoneNo = document.forms['formEmp']['txtMobileNo'].value;
    var department = document.forms['formEmp']['txtDepartment'].value;
    var salary = document.forms['formEmp']['txtSalary'].value;
    var isValid = true;
    var errorHtml = "";
    var regPhoneNo = /^[0-9]{10}$/;
    if (name == "" || phoneNo == "" || department == "" || salary == "") {
        isValid = false;
        errorHtml += "* all fields must be required.";
    }
    if (!regPhoneNo.test(phoneNo)) {
        isValid = false
        errorHtml += "<br/>Invalid mobile number.";
    }
    if (isNaN(salary)) {
        isValid = false
        errorHtml += "<br/>Invalid salary."
    }
    if (!isValid) {
        document.getElementById('error').innerHTML = errorHtml;
    } else {
        document.getElementById('error').innerHTML = "";
        var emp = {
            "name": name,
            "phoneNo": phoneNo,
            "department": department,
            "salary": salary
        }
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
        html += "<td><a onclick='deleteEmployee(" + i + ")' style='color: blue;'>Delete</a></td></tr>";
    }
    document.getElementById('empVal').innerHTML = html;
}
function clearAll() {
    document.forms['formEmp']['txtName'].value = "";
    document.forms['formEmp']['txtMobileNo'].value = "";
    document.forms['formEmp']['txtDepartment'].value = "";
    document.forms['formEmp']['txtSalary'].value = "";
}
function deleteEmployee(index) {
    employees.splice(index, 1);
    reloadEmployees();
}