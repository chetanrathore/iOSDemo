/**
 * Created by LaNet on 1/12/17.
 */
const express = require('express');
const router = express.Router();
const userBLL = require('./../model/userbll');
var constants = require('./../constant');
var ERROR = constants.ERRORS;
var MESSAGE = constants.MESSAGES;

router.post('/userregister', function (req, res, next) {
    userBLL.userRegister(req.body)
        .then(function (result) {
            console.log("inside success");
            res.json({ status: 1, message: MESSAGE.REGISTERED});
        }).catch(function (err) {
            console.log("inside error");
            if (err == false){
                res.json({status: 0, message: ERROR.EMAIL_Id_EXISTS});
            }else {
                res.json({status: 0, message: ERROR.REGISTRATION_FAIL});
            }
        });
});

router.post('/userlogin',function (req, res, next) {
   userBLL.userLogin(req.body).then(function (result) {
        result = result[0];
        result.status = 1;
        result.message = MESSAGE.REGISTERED;
        result.password = "";
        res.send(result);
   }).catch(function (err) {
       if (err == false){
           res.json({ status: 0, message: ERROR.WRONG_PASSWORD });
       }else if (err == true) {
           res.json({ status: 0, message: ERROR.WRONG_USERNAME });
       }else{
           res.json({ status: 0, message: ERROR.WRONG_USERNAME });
       }
   });
});

module.exports = router;