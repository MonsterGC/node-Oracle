const express = require('express');
const router = express.Router();
const oracledb = require('oracledb');
const db = require('../../utils/db');

// $routes /api/getmsg/msg
// @desc 获取评论
// @access public
router.get('/msg', async(req, res) => {
    let result;
    let obj = {
        sql: `select (select m_time from movie_msg where m_id = r_msgid) as m_time,(select m_content from movie_msg where m_id = r_msgid) as m_content,(select u_email from user_table where u_id = r_userid) as u_email from movie_msg_relate where r_movieid =${req.query.movieid}`,
        binds: {},
        options: {
            outFormat: oracledb.OUT_FORMAT_OBJECT, // query result format
        }
    }
    console.log(obj.sql)
    result = await db.select(obj);
    console.log(result)
    res.json(result)
})


// $routes /api/getmsg/mineMsg
// @desc 获取我的评论
// @access public
router.get('/mineMsg', async(req, res) => {
    let result;
    let obj = {
        sql: `select (select v_title from movie where v_id = r_movieid) as v_title,(select v_img from movie where v_id = r_movieid) as v_img,(select m_content from movie_msg where m_id = r_msgid) as m_content,(select v_director from movie where v_id = r_movieid) as v_director,r_userid,r_msgid,r_movieid from movie_msg_relate where r_userid = ${req.query.userid}`,
        binds: {},
        options: {
            outFormat: oracledb.OUT_FORMAT_OBJECT, // query result format
        }
    }

    result = await db.select(obj);
    res.json(result)
})

// $routes /api/getmsg/delMsg
// @desc 删除我的评论
// @access public
router.post('/delMsg', async(req, res) => {
    let result, result1;
    let obj = {
        sql: `delete from movie_msg where m_id = ${req.body.msgid}`,
        binds: {},
        options: {
            outFormat: oracledb.OUT_FORMAT_OBJECT, // query result format
        }
    }
    let obj1 = {
        sql: `delete from movie_msg_relate where r_msgid = ${req.body.msgid} and r_movieid = ${req.body.movieid} and r_userid = ${req.body.userid}`,
        binds: {},
        options: {
            outFormat: oracledb.OUT_FORMAT_OBJECT, // query result format
        }
    }
    result = await db.select(obj);
    result1 = await db.select(obj1);
    res.json({
        msg: 1
    })
})
module.exports = router;