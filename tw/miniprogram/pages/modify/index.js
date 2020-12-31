// pages/modify/index.js
const app = getApp();
const { request } = require('../../utils/request');
const { $Message } = require('../../dist/base/index');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    resourcePass: '',
    passw: '',
    passw2: '',
    userEmail: ''
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    console.log(options.userEmail)
    if (options.userEmail == undefined) {
      wx.navigateTo({
        url: '../login/index',
      })
      return false;
    }
    this.setData({
      userEmail: options.userEmail
    })
  },
  bindChange: function (e) {
    this.setData({
      resourcePass: e.detail.detail.value
    })
  },
  bindChange1: function (e) {
    this.setData({
      passw: e.detail.detail.value
    })
  },
  bindChange2: function (e) {
    console.log(e)
    this.setData({
      passw2: e.detail.detail.value
    })
  },
  handleClick: async function () {
    console.log(this.data)
    if (!this.data.resourcePass) {
      $Message({
        content: '原密码不可为空',
        type: 'warning'
      });
      return false;
    }
    if (!this.data.passw) {
      $Message({
        content: '密码不可为空',
        type: 'warning'
      });
      return false;
    } else if (this.data.passw != this.data.passw2) {
      $Message({
        content: '前后两次密码不一样',
        type: 'warning'
      });
      return false;
    } else {
      let auth = await request({
        url: `http://${app.host}:5000/api/user/auth`,
        data: {
          email: this.data.userEmail,
          resourcePassw: this.data.resourcePass,
          passw: this.data.passw
        },
        header: {
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        method: 'POST'
      })
      console.log(auth.data.msg)
      if (auth.data.msg == 0) {
        $Message({
          content: '原密码错误',
          type: 'error'
        });
        return false
      }
      $Message({
        content: '修改成功',
        type: 'success'
      });
      setTimeout(() => {
        wx.reLaunch({
          url: '../login/index'
        })
      }, 1000);
    }
  }
})