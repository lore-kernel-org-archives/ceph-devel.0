From: Muminul Islam Russell <misla011@fiu.edu>
Subject: Re: Ceph unit test help
Date: Fri, 24 Feb 2017 11:24:35 -0800
Message-ID: <CAK=B8yazK34m5WOU8RtzS1yp04FseKf9tf1egrsoxyO8OgM+fg@mail.gmail.com>
References: <CAK=B8ybPatezCJvb_5kYWKEQbPVyJAU12KP0rCkdjafC4+s6LA@mail.gmail.com>
 <alpine.DEB.2.11.1702241907090.7782@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33631 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdBXTYh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Feb 2017 14:24:37 -0500
Received: by mail-qk0-f171.google.com with SMTP id n127so27146600qkf.0
        for <ceph-devel@vger.kernel.org>; Fri, 24 Feb 2017 11:24:37 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1702241907090.7782@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks Sage,

Still having problem. Bellow is the output(sorry for large output,
wanted to clarify).
[  1%] keep civetweb.h up-to-date
[  1%] Built target civetweb_h
[  1%] Built target common_utf8
..
..
[ 29%] ceph-disk is being created
Running virtualenv with interpreter /bin/python2.7
New python executable in /tmp/ceph-disk-virtualenv/bin/python2.7
Also creating executable in /tmp/ceph-disk-virtualenv/bin/python
Installing Setuptools......................................................=
...........................................................................=
...........................................................................=
..................done.
Installing Pip.............................................................=
...........................................................................=
...........................................................................=
...........................................................................=
.......................................done.
Downloading/unpacking pip>=3D6.1
  Cannot fetch index base URL https://pypi.python.org/simple/
  Could not find any downloads that satisfy the requirement pip>=3D6.1
Cleaning up...
No distributions at all found for pip>=3D6.1
Storing complete log in /root/.pip/pip.log
Traceback (most recent call last):
  File "/tmp/ceph-disk-virtualenv/bin/pip", line 9, in <module>
    load_entry_point('pip=3D=3D1.4.1', 'console_scripts', 'pip')()
  File "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pip/__init__.=
py",
line 148, in main
    return command.main(args[1:], options)
  File "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pip/basecomma=
nd.py",
line 176, in main
    logger.fatal('Storing complete log in %s' % log_fn)
  File "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pip/log.py",
line 48, in fatal
    self.log(self.FATAL, msg, *args, **kw)
  File "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pip/log.py",
line 75, in log
    backwardcompat.fwrite(consumer, rendered)
  File "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pip/backwardc=
ompat/__init__.py",
line 90, in fwrite
    f.write(s)
ValueError: I/O operation on closed file
Ignoring indexes: https://pypi.python.org/simple/
Downloading/unpacking tox>=3D1.9
Downloading/unpacking pluggy>=3D0.3.0,<1.0 (from tox>=3D1.9)
Downloading/unpacking virtualenv>=3D1.11.2 (from tox>=3D1.9)
Downloading/unpacking py>=3D1.4.17 (from tox>=3D1.9)
Installing collected packages: tox, pluggy, virtualenv, py
Successfully installed tox pluggy virtualenv py
Cleaning up...
Ignoring indexes: https://pypi.python.org/simple/
You must give at least one requirement to install (maybe you meant
"pip install file:///home/muislam/ceph_upstream/ceph/src/ceph-disk/wheelhou=
se"?)
Ignoring indexes: https://pypi.python.org/simple/
Obtaining file:///home/muislam/ceph_upstream/ceph/src/ceph-disk
  Running setup.py egg_info for package from
file:///home/muislam/ceph_upstream/ceph/src/ceph-disk

Requirement already satisfied (use --upgrade to upgrade): setuptools
in /tmp/ceph-disk-virtualenv/lib/python2.7/site-packages (from
ceph-disk=3D=3D1.0.0)
Installing collected packages: ceph-disk
  Running setup.py develop for ceph-disk

    Creating /tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/ceph-dis=
k.egg-link
(link to .)
    Adding ceph-disk 1.0.0 to easy-install.pth file
    Installing ceph-disk script to /tmp/ceph-disk-virtualenv/bin

    Installed /home/muislam/ceph_upstream/ceph/src/ceph-disk
Successfully installed ceph-disk
Cleaning up...
[ 29%] Built target ceph-disk
..
..
[ 43%] ceph-detect-init is being created
Running virtualenv with interpreter /bin/python2.7
New python executable in /tmp/ceph-detect-init-virtualenv/bin/python2.7
Also creating executable in /tmp/ceph-detect-init-virtualenv/bin/python
Installing Setuptools......................................................=
...........................................................................=
...........................................................................=
..................done.
Installing Pip.............................................................=
...........................................................................=
...........................................................................=
...........................................................................=
.......................................done.
Downloading/unpacking pip>=3D6.1
  Cannot fetch index base URL https://pypi.python.org/simple/
  Could not find any downloads that satisfy the requirement pip>=3D6.1
Cleaning up...
No distributions at all found for pip>=3D6.1
Storing complete log in /root/.pip/pip.log
Traceback (most recent call last):
  File "/tmp/ceph-detect-init-virtualenv/bin/pip", line 9, in <module>
    load_entry_point('pip=3D=3D1.4.1', 'console_scripts', 'pip')()
  File "/tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages/pip/__=
init__.py",
line 148, in main
    return command.main(args[1:], options)
  File "/tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages/pip/ba=
secommand.py",
line 176, in main
    logger.fatal('Storing complete log in %s' % log_fn)
  File "/tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages/pip/lo=
g.py",
line 48, in fatal
    self.log(self.FATAL, msg, *args, **kw)
  File "/tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages/pip/lo=
g.py",
line 75, in log
    backwardcompat.fwrite(consumer, rendered)
  File "/tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages/pip/ba=
ckwardcompat/__init__.py",
line 90, in fwrite
    f.write(s)
ValueError: I/O operation on closed file
Ignoring indexes: https://pypi.python.org/simple/
Downloading/unpacking tox>=3D1.9
Downloading/unpacking pluggy>=3D0.3.0,<1.0 (from tox>=3D1.9)
Downloading/unpacking virtualenv>=3D1.11.2 (from tox>=3D1.9)
Downloading/unpacking py>=3D1.4.17 (from tox>=3D1.9)
Installing collected packages: tox, pluggy, virtualenv, py
Successfully installed tox pluggy virtualenv py
Cleaning up...
Ignoring indexes: https://pypi.python.org/simple/
You must give at least one requirement to install (maybe you meant
"pip install file:///home/muislam/ceph_upstream/ceph/src/ceph-detect-init/w=
heelhouse"?)
Ignoring indexes: https://pypi.python.org/simple/
Obtaining file:///home/muislam/ceph_upstream/ceph/src/ceph-detect-init
  Running setup.py egg_info for package from
file:///home/muislam/ceph_upstream/ceph/src/ceph-detect-init

Requirement already satisfied (use --upgrade to upgrade): setuptools
in /tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages (from
ceph-detect-init=3D=3D1.0.1)
Installing collected packages: ceph-detect-init
  Running setup.py develop for ceph-detect-init

    Creating /tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages/c=
eph-detect-init.egg-link
(link to .)
    Adding ceph-detect-init 1.0.1 to easy-install.pth file
    Installing ceph-detect-init script to /tmp/ceph-detect-init-virtualenv/=
bin

    Installed /home/muislam/ceph_upstream/ceph/src/ceph-detect-init
Successfully installed ceph-detect-init
Cleaning up...
[ 43%] Built target ceph-detect-init

....
....
[100%] Building tests
[100%] Built target tests

--
ctest --output-on-failure -R run-tox-ceph-detect-init
Test project /home/muislam/ceph_upstream/ceph/build
    Start 15: run-tox-ceph-detect-init
1/1 Test #15: run-tox-ceph-detect-init .........***Failed    0.26 sec
Traceback (most recent call last):
  File "/bin/tox", line 9, in <module>
    load_entry_point('tox=3D=3D1.4.2', 'console_scripts', 'tox')()
  File "/usr/lib/python2.7/site-packages/tox/_cmdline.py", line 24, in main
    config =3D parseconfig(args, 'tox')
  File "/usr/lib/python2.7/site-packages/tox/_config.py", line 23, in
parseconfig
    parseini(config)
  File "/usr/lib/python2.7/site-packages/tox/_config.py", line 170, in __in=
it__
    config)
  File "/usr/lib/python2.7/site-packages/tox/_config.py", line 223, in
_makeenvconfig
    for depline in reader.getlist(section, "deps"):
  File "/usr/lib/python2.7/site-packages/tox/_config.py", line 296, in getl=
ist
    s =3D self.getdefault(section, name, None)
  File "/usr/lib/python2.7/site-packages/tox/_config.py", line 389, in
getdefault
    x =3D self._replace(x)
  File "/usr/lib/python2.7/site-packages/tox/_config.py", line 489, in _rep=
lace
    return rexpattern.sub(self._sub, x)
  File "/usr/lib/python2.7/site-packages/tox/_config.py", line 402, in _sub
    (key, envkey))
tox.ConfigError: ConfigError: substitution 'env:NO_INDEX:':
'NO_INDEX:' not found in environment


0% tests passed, 1 tests failed out of 1

Total Test time (real) =3D   0.30 sec

The following tests FAILED:
     15 - run-tox-ceph-detect-init (Failed)
Errors while running CTest

pip --version
pip 7.1.0 from /usr/lib/python2.7/site-packages (python 2.7)

On Fri, Feb 24, 2017 at 11:07 AM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 24 Feb 2017, Muminul Islam Russell wrote:
>> Hello cephers,
>>
>>
>> I am new this ceph development although have been using it for long
>> time. At first I started building and followed the same steps
>> described the the github.
>>
>> ./do_cmake.sh
>> cd build
>> make
>>
>> I changed some code in ceph-detect init and added proper test cases as
>> well but the test cased failed.
>>
>> Could you please suggest me what is going wrong here?
>
> I think the python pieces are somewhat special.  You might try 'make
> tests' and then try it again?
>
> sage
>
>
>>
>> sudo ctest --output-on-failure -R run-tox-ceph-detect-init
>> Test project /home/muislam/ceph_upstream/ceph/build
>>     Start 15: run-tox-ceph-detect-init
>> 1/1 Test #15: run-tox-ceph-detect-init .........***Failed    0.25 sec
>> /home/muislam/ceph_upstream/ceph/src/ceph-detect-init/run-tox.sh: line
>> 30: /tmp/ceph-detect-init-virtualenv/bin/activate: No such file or
>> directory
>> Traceback (most recent call last):
>>   File "/bin/tox", line 9, in <module>
>>     load_entry_point('tox=3D=3D1.4.2', 'console_scripts', 'tox')()
>>   File "/usr/lib/python2.7/site-packages/tox/_cmdline.py", line 24, in m=
ain
>>     config =3D parseconfig(args, 'tox')
>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 23, in
>> parseconfig
>>     parseini(config)
>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 170, in _=
_init__
>>     config)
>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 223, in
>> _makeenvconfig
>>     for depline in reader.getlist(section, "deps"):
>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 296, in g=
etlist
>>     s =3D self.getdefault(section, name, None)
>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 389, in
>> getdefault
>>     x =3D self._replace(x)
>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 489, in _=
replace
>>     return rexpattern.sub(self._sub, x)
>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 402, in _=
sub
>>     (key, envkey))
>> tox.ConfigError: ConfigError: substitution 'env:NO_INDEX:':
>> 'NO_INDEX:' not found in environment
>>
>>
>> 0% tests passed, 1 tests failed out of 1
>>
>> Total Test time (real) =3D   0.31 sec
>>
>> The following tests FAILED:
>>      15 - run-tox-ceph-detect-init (Failed)
>> Errors while running CTest
>>
>> Thanks in advance.
>>
>> Best,
>> Muminul
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
