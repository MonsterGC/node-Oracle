//index.js
const app = getApp();
const { $Message } = require('../../dist/base/index');
const { request } = require('../../utils/request');
Page({

  /**
   * 页面的初始数据
   */
  data: {
    current: 'homepage',
    homepage: {
      slider: [
        'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3313972875,875581971&fm=26&gp=0.jpg',
        'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=7100224,342802200&fm=26&gp=0.jpg',
        'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=893535924,2794187512&fm=26&gp=0.jpg'
      ],
      indicatorDots: true,
      autoplay: true,
      interval: 2000,
      duration: 1000,
      current_scroll: '',
      select: [],
      height: 0,
      content: [],
      start: 0,
      type: 1
    },
    remind: {
      content: [],
      userId: 0,
      height: 0
    },
    mine: {
      userEmail: '',
      visible1: false
    }
  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: async function (options) {
    let _this = this
    let result = await request({
      url: `http://${app.host}:5000/api/getmovie/class`,
      data: {},
      header: {},
      method: 'GET'
    });
    let select = []
    result.data.rows.map((value, key) => {
      select.push(value.C_NAME)
    })
    this.setData({
      'homepage.select': select,
      'homepage.current_scroll': select[0],
      'homepage.height': wx.getSystemInfoSync().windowHeight - 247,
      'remind.height': wx.getSystemInfoSync().windowHeight - 50
    })

    let content = await this.getContent(this.data.homepage.start, this.data.homepage.start + 5, this.data.homepage.type)
    this.setData({
      'homepage.content': content.data.rows
    })

    wx.getStorage({
      key: 'token',
      success: async function (res) {
        console.log(res)
        let useremail = await request({
          url: `http://${app.host}:5000/api/user/deToken`,
          data: {
            token: res.data
          },
          header: {
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          method: 'POST'
        });
        if (useremail.data.msg == 0) {
          wx.navigateTo({
            url: '../login/index',
          })
          return false
        }
        _this.setData({
          'mine.userEmail': useremail.data.email,
          'remind.userId': useremail.data.id
        })
      },
      fail: function (err) {
        wx.navigateTo({
          url: '../login/index',
        })
      }
    })
  },
  async handleChange({ detail }) {
    this.setData({
      current: detail.key
    });
    let temp = {
      'homepage': '电影迷',
      'remind': '我的点评',
      'mine': '我的'
    }
    wx.setNavigationBarTitle({
      title: temp[detail.key]
    })
    if (detail.key == 'remind') {
      let result = await request({
        url: `http://${app.host}:5000/api/getmsg/mineMsg?userid=${this.data.remind.userId}`,
        data: {},
        header: {},
        method: 'GET'
      });
      this.setData({
        'remind.content': result.data.rows
      })
    }
  },
  async handleChangeScroll({ detail }) {
    let index = this.data.homepage.select.indexOf(detail.key) + 1
    let content = await this.getContent(this.data.homepage.start, this.data.homepage.start + 5, index)
    this.setData({
      'homepage.current_scroll': detail.key,
      'homepage.content': content.data.rows
    });
  },
  getContent: async function (start, end, type = 1) {
    let content = await request({
      url: `http://${app.host}:5000/api/getmovie/pageDetail?start=${start}&end=${end}&type=${type}`,
      data: {},
      header: {},
      method: 'GET'
    })
    return content
  },
  navDetail: function (e) {
    let obj = JSON.stringify(e.currentTarget.dataset.data);
    wx.navigateTo({
      url: `../detail/index?obj=${obj}`,
    })
  },
  close: function () {
    wx.clearStorage({
      success: (res) => {
        $Message({
          content: '注销成功',
          type: 'success'
        });
        setTimeout(() => {
          wx.reLaunch({
            url: '../login/index'
          })
        }, 1000);
      },
    })
  },
  del: async function (e) {
    let data = e.currentTarget.dataset.data
    let index = e.currentTarget.dataset.index
    console.log(data.R_USERID, data.R_MOVIEID, data.R_MSGID)
    let result = await request({
      url: `http://${app.host}:5000/api/getmsg/delMsg?userid=${data.R_USERID}`,
      data: {
        userid: data.R_USERID,
        movieid: data.R_MOVIEID,
        msgid: data.R_MSGID
      },
      header: {
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      method: 'POST'
    });
    let content = this.data.remind.content
    content.splice(index, 1)
    if (result.data.msg == 1) {
      $Message({
        content: '删除成功',
        type: 'success'
      });
      this.setData({
        'remind.content': content
      })
    }
  },
  navModify: function () {
    wx.navigateTo({
      url: `../modify/index?userEmail=${this.data.mine.userEmail}`,
    })
  }
})