feature "Index Page", (context, browser, $) ->
  before (done) -> browser.visit '/', done

  it "display an input and join button", (done) ->
    wait.until $('input[ng-model="name"]').is.visible, ->
      $(button: 'Join').visible.should.be.true
      done()

feature "Register As Ray", (context, browser, $) ->
  before (done) -> browser.visit '/', done
  it "display register's name after click Join", (done) ->
    context.register_ready ->
      $("#chatters").visible.should.be.false
      context.register('ray')
      wait.until $(link: 'ray').is.present, ->
        $(button: 'Join').visible.should.be.false
        browser.page.render 'tmp/public_msg.png'
        $("#public_msg_box").text.should.to.include('Welcome ray')
        done()

feature "Register As System", (context, browser, $) ->
  before (done) -> browser.visit '/', done
  it  "show error when register as System", (done) ->
    context.register_ready ->
      context.register('System')
      $('#register_fail').text.should.to.include('reserved')
      done()
