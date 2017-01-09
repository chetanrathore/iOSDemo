var Category = function (categoryName) {
    this.categoryName = categoryName;
    this.isImp = false;
};

Category.prototype.isImpTask = function () {
    this.isImp = true;
};

Category.prototype.save = function () {
    console.log("Save the category - " + this.categoryName);
}

module.exports = Category;