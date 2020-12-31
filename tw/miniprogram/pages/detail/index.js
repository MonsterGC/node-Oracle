const app = getApp();
const { $Message } = require('../../dist/base/index');
const { request } = require('../../utils/request');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    content: {},
    visible1: false,
    msg: [],
    userId: 0,
    msg_content: ''
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: async function (options) {
    let _this = this
    let obj = JSON.parse(options.obj)
    this.setData({
      content: obj
    })
    wx.setNavigationBarTitle({
      title: JSON.parse(options.obj).V_TITLE
    })
    let msg = await this.getmsg(obj)
    console.log(msg)
    this.setData({
      msg: msg.data.rows
    })
  },
  onShow: async function () {
    let msg = await this.getmsg(this.data.content)
    console.log(msg)
    this.setData({
      msg: msg.data.rows
    })
  },
  getmsg: async function (obj) {
    // 获取点评
    let msg = await request({
      url: `http://${app.host}:5000/api/getmsg/msg?movieid=${obj.V_ID}`,
      data: {},
      header: {},
      method: 'GET'
    });
    msg.data.rows.map((value, key) => {
      value.M_TIME = `${value.M_TIME.split('-')[0]}-${value.M_TIME.split('-')[1]}-${value.M_TIME.split('-')[2].split('T')[0]}`
    })
    return msg
  },
  handleOpen: function () {
    wx.navigateTo({
      url: `../send/index?obj=${JSON.stringify(this.data.content)}`,
    })
  },
  handleClose: function () {
    this.setData({
      visible1: false
    });
    $Message({
      content: '用户点击取消',
      type: 'warning'
    });
  },
  handleOk: async function (e) {
    let result = await request({
      url: `http://${app.host}:5000/api/send/msg`,
      data: {
        msg: this.data.msg_content,
        bookid: this.data.content.B_ID,
        userid: this.data.userId
      },
      header: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      method: 'POST'
    });
    console.log(result)
    let msg = await this.getmsg(this.data.content)
    this.setData({
      msg: msg.data.rows,
      visible1: false
    })
    $Message({
      content: '点评成功',
      type: 'success'
    });
  },
  bindChange: function (e) {
    this.setData({
      msg_content: e.detail.value
    })
  }
})