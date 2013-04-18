# feature "Index Page", (context, browser, $) ->
#   before (done) -> browser.visit '/', done

#   it "display an input and join button", (done) ->
#     wait.until $('input[ng-model="name"]').is.visible, ->
#       $(button: 'Join').visible.should.be.true
#       done()

#   it "display register's name after click Join", (done) ->
#     $("#chatters").visible.should.be.false
#     context.register('ray')
#     wait.until $(link: 'ray').is.present, ->
#       $(button: 'Join').visible.should.be.false
#       $("#public_msg_box").text.should.to.include('Welcome ray')
#       done()

feature "Two Chaters with the same name, One Chatter register, Another visit /", (context) ->
  ray = context.newContext()
  lee = context.newContext()

  before (done)->
    ray.browser.visit "/", ->
      lee.browser.visit '/', done

  # lee didnt visit / until ray(context) has registered 'ray'
  it "prevent user with the same name", (done) ->
    ray.register_ready ->
      ray.register('ray')
      wait.until ray.$(link: 'ray').is.present, ->
        lee.register_ready ->
          lee.register('ray') # yup, he should register lee, but he type error
          wait.until lee.$("#register_fail").is.visible, ->
            lee.$("#register_fail").text.should.to.include('Sorry, ray was existed')
            done()

feature "Two Chaters with the same name, Both visit /, then register one by one ", (context) ->
  john = context.newContext()
  tom = context.newContext()

  before (done)->
    john.browser.visit "/", ->
      tom.browser.visit '/', done

  # tom visit / before john(context) registered 'john'
  it "prevent user with the same name", (done) ->
    tom.register_ready ->
      john.register_ready ->
        tom.browser.page.render('tmp/tom.png')
        john.browser.page.render('tmp/john.png')
        john.register('john')
        wait.until john.$(link: 'john').is.present, ->
          tom.register('john') # yup, he should register tom, but he type error
          wait.until tom.$("#register_fail").is.visible, ->
            tom.$("#register_fail").text.should.to.include('Sorry, john was existed')
            done()

# feature "Three Chaters in Public Msg Box", (context)