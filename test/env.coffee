exports.config =
  baseUrl: 'http://localhost:3333'

exports.helpers =
  register: (username)->
    @$('input[ng-model="name"]').type username
    @browser.page.render 'tmp/last.png'
    @$(button: 'Join').click()
  register_ready: (callback)->
    wait.until @$('input[ng-model="name"]').is.visible, callback
