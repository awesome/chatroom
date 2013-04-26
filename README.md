INSTALL
=======
	npm install
	cake app

PROBLEMS
========
On master branch, tag1.0 has all test passed. It use a not good solution on login feature.
On another_login_solution branch, tag2.0 has unpassed test(feature is worked). But it use a more better solution on login feature.
Why ?

CHANGELOG
=========
Branch another_login_solution validate register name on server, so the socket client design is different from master branch.
And tag2.0(2.0 < x < 3.0) was on branch another_login_solution, tag1.0(1.0< x <2.0) was on master

TODO
====
close the socket connect manully
Each Single Test(start from it or feature) should restart sockets data(Really Need?)
Stop Add more feature and take a more deep research on socket.io and how test of socket.io
