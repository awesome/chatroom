// Generated by CoffeeScript 1.6.2
(function() {
  feature("Two Chaters with the same name, Both visit /, then register one by one ", function(context) {
    var john, tom;

    john = context.newContext();
    tom = context.newContext();
    before(function(done) {
      return john.browser.visit("/", function() {
        return tom.browser.visit('/', done);
      });
    });
    return it("prevent user with the same name", function(done) {
      return tom.register_ready(function() {
        return john.register_ready(function() {
          tom.browser.page.render('tmp/tom.png');
          john.browser.page.render('tmp/john.png');
          john.register('john');
          return wait.until(john.$({
            link: 'john'
          }).is.present, function() {
            tom.register('john');
            return wait.until(tom.$("#register_fail").is.visible, function() {
              tom.$("#register_fail").text.should.to.include('Sorry, john was existed');
              tom.browser.page.close();
              john.browser.page.close();
              return done();
            });
          });
        });
      });
    });
  });

}).call(this);