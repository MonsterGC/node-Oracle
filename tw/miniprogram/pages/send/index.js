// pages/send/index.js
const app = getApp();
const { $Message } = require('../../dist/base/index');
const { request } = require('../../utils/request');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    content: {},
    value: ''
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    let _this = this
    this.setData({
      content: JSON.parse(options.obj)
    })
    wx.setNavigationBarTitle({
      title: `点评《${JSON.parse(options.obj).V_TITLE}》`
    })
    // 获取用户ID
    wx.getStorage({
      key: 'token',
      success: async function (res) {
        console.log(res)
        let userid = await request({
          url: `http://${app.host}:5000/api/user/deToken`,
          data: {
            token: res.data
          },
          header: {
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          method: 'POST'
        });
        if (userid.data.msg == 0) {
          wx.navigateTo({
            url: '../login/index',
          })
          return false
        }
        console.log(userid)
        _this.setData({
          userId: userid.data.id
        })
      },
      fail: function (err) {
        wx.navigateTo({
          url: '../login/index',
        })
      }
    })
  },
  nameValueChange: function (e) {
    this.setData({
      value: e.detail.detail.value
    })
  },
  handleClick: async function (e) {
    if(this.data.value == '') {
      $Message({
        content: '点评不可为空',
        type: 'warning'
      });
      return false;
    }
    let result = await request({
      url: `http://${app.host}:5000/api/send/msg`,
      data: {
        msg: this.data.value,
        movieid: this.data.content.V_ID,
        userid: this.data.userId
      },
      header: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      method: 'POST'
    });
    
    $Message({
      content: '点评成功',
      type: 'success'
    });

    setTimeout(() => {
      wx.navigateBack({
        delta: 1
      });
    }, 1000)
  }
})