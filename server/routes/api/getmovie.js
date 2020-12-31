const express = require('express');
const router = express.Router();
const oracledb = require('oracledb');
const db = require('../../utils/db');


// $routes /api/getmovie/num
// @desc 获取书本总数
// @access public
router.get('/num', async(req, res) => {
    let result;
    let obj = {
        sql: `select count(*) as num from movie`,
        binds: {},
        options: {
            outFormat: oracledb.OUT_FORMAT_OBJECT, // query result format
        }
    }
    result = await db.select(obj);
    res.json(result)
})

// $routes /api/getmovie/class
// @desc 获取书本类型(全部类型)
// @access public
router.get('/class', async(req, res) => {
    let result;
    let obj = {
        sql: `select * from movie_class`,
        binds: {},
        options: {
            outFormat: oracledb.OUT_FORMAT_OBJECT, // query result format
        }
    }
    result = await db.select(obj);
    res.json(result)
})

// $routes /api/getmovie/classNum
// @desc 获取某个分类的总数
// @access public
router.get('/classNum', async(req, res) => {
    let result;
    let obj = {
        sql: `select count(*) as num from (select b.*,c.c_name as c_name from movie b,movie_class c where b.b_class = c.c_id) where c_name = '${req.query.type}'`,
        binds: {},
        options: {
            outFormat: oracledb.OUT_FORMAT_OBJECT, // query result format
        }
    }
    result = await db.select(obj);
    res.json(result)
})

// $routes /api/getmovie/pageDetail
// @desc 分页获取书本信息
// @access public
router.get('/pageDetail', async(req, res) => {
    let result;
    let obj = {
        sql: `select * from (select v_id,v_title,(select c_name from movie_class where c_id = v_class) as v_class,v_img,v_director,v_writer,v_starring,v_detail,v_time,rownum num from movie where v_class = ${req.query.type}) 
        where num<=${req.query.end} and num>${req.query.start}`,
        binds: {},
        options: {
            outFormat: oracledb.OUT_FORMAT_OBJECT, // query result format
        }
    }
    console.log(obj.sql)
    result = await db.select(obj);
    res.json(result)
})

// $routes /api/getmovie/pageTypeDetail
// @desc 分页获取书本信息(类别)
// @access public
router.get('/pageTypeDetail', async(req, res) => {
    let result;
    let obj = {
        sql: `select * from (select b_id,b_title,b_class,b_img,b_author,b_detail,rownum num from (select b_id,b_title,(select c_name from movie_class where c_id = b_class) as b_class,b_img,b_author,b_detail from movie) where b_class = '${req.query.type}') 
        where num<=${req.query.end} and num>${req.query.start}`,
        binds: {},
        options: {
            outFormat: oracledb.OUT_FORMAT_OBJECT, // query result format
        }
    }
    result = await db.select(obj);
    res.json(result)
})
module.exports = router;