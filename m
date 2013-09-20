From: Alfredo Deza <alfredo.deza@inktank.com>
Subject: (guidelilines for) Unit Testing in Python
Date: Fri, 20 Sep 2013 12:02:59 -0400
Message-ID: <CANtztVzfHP0EuQLN1KhZ2WQ+KsZ0v2CWCCJ=Bmp-ZkMpho6rSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33840 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab3ITQDA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Sep 2013 12:03:00 -0400
Received: by mail-ob0-f172.google.com with SMTP id gq1so793556obb.31
        for <ceph-devel@vger.kernel.org>; Fri, 20 Sep 2013 09:03:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,

Below was a summary for some general guidelines we are going to be
following for unit testing the teuthology code with Python, hopefully
it might be a good read as well :)

This should be used as a general guideline as to what are the
expectations when writing unit tests.

Before Writing Anything
---------------------------------
Make sure you have installed a test runner which you will be using to
run the tests (making sure they pass). We are going to be using
py.test for this and that is the same tool Jenkins will be using when
running unit tests for teuthology (it does the same for ceph-deploy).

To install py.test, as with any library in Python, make sure you have
a virtualenv created for your work on teuthology and have activated
it, there are tools that help you manage virtualenvs (and you can
certainly use those) but for now, this will assume you are creating
one in your home directory:

    mkdir venvs
    virtualenv venvs/teuthology

And now "activate" it:

    source ~/venvs/teuthology/bin/activate

This is more or less what the bootstrap script does, making sure you
have all dependencies installed.

Now that you have your virtualenv created and activated, install py.test:

    pip install pytest

Note there is no dot in the name for the package, but there is one for
calling the tool:

    py.test --version

That should work and tell you it is installed.

How it works
------------------
With everything installed and ready to go, change directories to
teuthology/teuthology/test and run
py.test:

    py.test

You should see output similar to this:

    collected 19 items

    test_get_distro.py ....
    test_misc.py ..
    test_safepath.py .............


19 tests! The dots signal a pass, when there is a fail you would see
an "F" instead of a dot and the tracebacks for each failed test.


Writing your first test
----------------------------
Python conventions for naming test files is to prefix them with
`test_`. The test runner will be able to collect them automatically if
so.

If there is a file not prefixed with `test_` it will not be considered a test.

Similarly, in test files, everything that is a test (a class, method
or function) should be prefixed with `test`.

This is the general convention if you are testing "foo":

Functions:    def test_foo():

Classes:    class TestFoo(object):

Methods:   def test_foo(self):

Lets assume you have a small function that does some path alterations
(so very common in teuthology) and this function is called
`get_absolute_path` that will return an absolute path from 2
arguments: base_path and trailing_dir.

This is the function:

    def get_asbolute_path(base_path, trailing_dir=None):
        """
        given a base_path, try to join it with trailing_dir (if any)
        and return an absolute path
        """"
        absolute_base_path = os.path.abspath(base_path)
        if trailing_dir:
            trailing_dir = trailing_dir.lstrip('/')  # make sure we
don't have trailing slashes
            return os.path.join(absolute_base_path, trailing_dir)
        return absolute_base_path

Pretty simple function, now lets go ahead and test it.

Create a test file for it that tells you the location/module you are
testing, lets assume that our function lives in safepath.py in
teuthology. So we are going to call this new file `test_safepath.py`
and will create a class for it.

This is how the most basic test would look:

    from teuthology import safepath

    class TestGetAbsolutePath(object):

        def test_trailing_dir_gets_joined(self):
            absolute_path = safepath.get_absolute_path('/foo', 'bar')
            assert absolute_path == '/foo/bar'


We imported our module for testing, created a test class and added a
single test method. If we run py.test against it (using the test file
name as the first argument) we would get a pass!

With py.test you can get very nice readability with plain assertions
like the test method.

The goal is to have test methods that are *meaningful* and concise.
When that test method fails it will be apparent that something about
the trailing dir is failing.

Avoid *like the plague* generic testing names. Just as an example,
this is something you should not do:

    class TestSimple(object):

        def test_path(self):
            absolute_path = safepath.get_absolute_path('/foo', 'bar')
            assert absolute_path == '/foo/bar'

"TestSimple" doesn't tell us what you are testing, and "test_path" is
misleading. By properly naming your tests, you can get meaningful
failures!

Also important to note is that you should keep your test methods as
short and concise as possible.

If you test method is huge, that is a tell that something is not right
and it will be very hard to attempt to fix it when it fails.

By making test methods short and concise you are making the intent
clear. The same goes for assertions, try not to "compound" tests by
making a bunch of calls and assertions in the same test method.

If it looks like more than one test, create another test method.

If there is a lot of boilerplate code before each test, try using the
helper methods "setup" and "teardown".

"setup" and "teardown" methods are called before and after
(respectively) each test so you can reuse values from that instead of
adding the same boilerplate everywhere.

*Do not* add `__init__` methods to test classes as they conflict with
testing tools (unless you are doing something very very advanced which
we are currently not!)

If there are any questions, let me know and I can help.

Remember, if it is hard to test it is because the code is not modular
enough. By thinking about testing you are making your code better. If
it is testable it is better!
