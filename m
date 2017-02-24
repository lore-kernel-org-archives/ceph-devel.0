From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Ceph unit test help
Date: Fri, 24 Feb 2017 22:28:05 +0100
Message-ID: <1d9082e7-4fae-c1a8-bc61-8ff13da20c75@digiware.nl>
References: <CAK=B8ybPatezCJvb_5kYWKEQbPVyJAU12KP0rCkdjafC4+s6LA@mail.gmail.com>
 <alpine.DEB.2.11.1702241907090.7782@piezo.novalocal>
 <CAK=B8yazK34m5WOU8RtzS1yp04FseKf9tf1egrsoxyO8OgM+fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:34123 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751219AbdBXV2z (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 24 Feb 2017 16:28:55 -0500
In-Reply-To: <CAK=B8yazK34m5WOU8RtzS1yp04FseKf9tf1egrsoxyO8OgM+fg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Muminul Islam Russell <misla011@fiu.edu>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 24-2-2017 20:24, Muminul Islam Russell wrote:
> Thanks Sage,
> 
> Still having problem. Bellow is the output(sorry for large output,
> wanted to clarify).
> [  1%] keep civetweb.h up-to-date
> [  1%] Built target civetweb_h
> [  1%] Built target common_utf8
> ..
> ..
> [ 29%] ceph-disk is being created
> Running virtualenv with interpreter /bin/python2.7
> New python executable in /tmp/ceph-disk-virtualenv/bin/python2.7
> Also creating executable in /tmp/ceph-disk-virtualenv/bin/python
> Installing Setuptools..............................................................................................................................................................................................................................done.
> Installing Pip.....................................................................................................................................................................................................................................................................................................................................done.
> Downloading/unpacking pip>=6.1
>   Cannot fetch index base URL https://pypi.python.org/simple/
>   Could not find any downloads that satisfy the requirement pip>=6.1
> Cleaning up...
> No distributions at all found for pip>=6.1
> Storing complete log in /root/.pip/pip.log
> Traceback (most recent call last):
>   File "/tmp/ceph-disk-virtualenv/bin/pip", line 9, in <module>
>     load_entry_point('pip==1.4.1', 'console_scripts', 'pip')()
>   File "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pip/__init__.py",
> line 148, in main
>     return command.main(args[1:], options)
>   File "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pip/basecommand.py",
> line 176, in main
>     logger.fatal('Storing complete log in %s' % log_fn)
>   File "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pip/log.py",
> line 48, in fatal
>     self.log(self.FATAL, msg, *args, **kw)
>   File "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pip/log.py",
> line 75, in log
>     backwardcompat.fwrite(consumer, rendered)
>   File "/tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/pip/backwardcompat/__init__.py",
> line 90, in fwrite
>     f.write(s)
> ValueError: I/O operation on closed file
> Ignoring indexes: https://pypi.python.org/simple/
> Downloading/unpacking tox>=1.9
> Downloading/unpacking pluggy>=0.3.0,<1.0 (from tox>=1.9)
> Downloading/unpacking virtualenv>=1.11.2 (from tox>=1.9)
> Downloading/unpacking py>=1.4.17 (from tox>=1.9)
> Installing collected packages: tox, pluggy, virtualenv, py
> Successfully installed tox pluggy virtualenv py
> Cleaning up...
> Ignoring indexes: https://pypi.python.org/simple/
> You must give at least one requirement to install (maybe you meant
> "pip install file:///home/muislam/ceph_upstream/ceph/src/ceph-disk/wheelhouse"?)
> Ignoring indexes: https://pypi.python.org/simple/
> Obtaining file:///home/muislam/ceph_upstream/ceph/src/ceph-disk
>   Running setup.py egg_info for package from
> file:///home/muislam/ceph_upstream/ceph/src/ceph-disk
> 
> Requirement already satisfied (use --upgrade to upgrade): setuptools
> in /tmp/ceph-disk-virtualenv/lib/python2.7/site-packages (from
> ceph-disk==1.0.0)
> Installing collected packages: ceph-disk
>   Running setup.py develop for ceph-disk
> 
>     Creating /tmp/ceph-disk-virtualenv/lib/python2.7/site-packages/ceph-disk.egg-link
> (link to .)
>     Adding ceph-disk 1.0.0 to easy-install.pth file
>     Installing ceph-disk script to /tmp/ceph-disk-virtualenv/bin
> 
>     Installed /home/muislam/ceph_upstream/ceph/src/ceph-disk
> Successfully installed ceph-disk
> Cleaning up...
> [ 29%] Built target ceph-disk
> ..
> ..
> [ 43%] ceph-detect-init is being created
> Running virtualenv with interpreter /bin/python2.7
> New python executable in /tmp/ceph-detect-init-virtualenv/bin/python2.7
> Also creating executable in /tmp/ceph-detect-init-virtualenv/bin/python
> Installing Setuptools..............................................................................................................................................................................................................................done.
> Installing Pip.....................................................................................................................................................................................................................................................................................................................................done.
> Downloading/unpacking pip>=6.1
>   Cannot fetch index base URL https://pypi.python.org/simple/
>   Could not find any downloads that satisfy the requirement pip>=6.1
> Cleaning up...
> No distributions at all found for pip>=6.1
> Storing complete log in /root/.pip/pip.log
> Traceback (most recent call last):
>   File "/tmp/ceph-detect-init-virtualenv/bin/pip", line 9, in <module>
>     load_entry_point('pip==1.4.1', 'console_scripts', 'pip')()
>   File "/tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages/pip/__init__.py",
> line 148, in main
>     return command.main(args[1:], options)
>   File "/tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages/pip/basecommand.py",
> line 176, in main
>     logger.fatal('Storing complete log in %s' % log_fn)
>   File "/tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages/pip/log.py",
> line 48, in fatal
>     self.log(self.FATAL, msg, *args, **kw)
>   File "/tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages/pip/log.py",
> line 75, in log
>     backwardcompat.fwrite(consumer, rendered)
>   File "/tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages/pip/backwardcompat/__init__.py",
> line 90, in fwrite
>     f.write(s)
> ValueError: I/O operation on closed file
> Ignoring indexes: https://pypi.python.org/simple/
> Downloading/unpacking tox>=1.9
> Downloading/unpacking pluggy>=0.3.0,<1.0 (from tox>=1.9)
> Downloading/unpacking virtualenv>=1.11.2 (from tox>=1.9)
> Downloading/unpacking py>=1.4.17 (from tox>=1.9)
> Installing collected packages: tox, pluggy, virtualenv, py
> Successfully installed tox pluggy virtualenv py
> Cleaning up...
> Ignoring indexes: https://pypi.python.org/simple/
> You must give at least one requirement to install (maybe you meant
> "pip install file:///home/muislam/ceph_upstream/ceph/src/ceph-detect-init/wheelhouse"?)
> Ignoring indexes: https://pypi.python.org/simple/
> Obtaining file:///home/muislam/ceph_upstream/ceph/src/ceph-detect-init
>   Running setup.py egg_info for package from
> file:///home/muislam/ceph_upstream/ceph/src/ceph-detect-init
> 
> Requirement already satisfied (use --upgrade to upgrade): setuptools
> in /tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages (from
> ceph-detect-init==1.0.1)
> Installing collected packages: ceph-detect-init
>   Running setup.py develop for ceph-detect-init
> 
>     Creating /tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages/ceph-detect-init.egg-link
> (link to .)
>     Adding ceph-detect-init 1.0.1 to easy-install.pth file
>     Installing ceph-detect-init script to /tmp/ceph-detect-init-virtualenv/bin
> 
>     Installed /home/muislam/ceph_upstream/ceph/src/ceph-detect-init
> Successfully installed ceph-detect-init
> Cleaning up...
> [ 43%] Built target ceph-detect-init
> 
> ....
> ....
> [100%] Building tests
> [100%] Built target tests
> 
> --
> ctest --output-on-failure -R run-tox-ceph-detect-init
> Test project /home/muislam/ceph_upstream/ceph/build
>     Start 15: run-tox-ceph-detect-init
> 1/1 Test #15: run-tox-ceph-detect-init .........***Failed    0.26 sec
> Traceback (most recent call last):
>   File "/bin/tox", line 9, in <module>
>     load_entry_point('tox==1.4.2', 'console_scripts', 'tox')()
>   File "/usr/lib/python2.7/site-packages/tox/_cmdline.py", line 24, in main
>     config = parseconfig(args, 'tox')
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 23, in
> parseconfig
>     parseini(config)
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 170, in __init__
>     config)
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 223, in
> _makeenvconfig
>     for depline in reader.getlist(section, "deps"):
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 296, in getlist
>     s = self.getdefault(section, name, None)
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 389, in
> getdefault
>     x = self._replace(x)
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 489, in _replace
>     return rexpattern.sub(self._sub, x)
>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 402, in _sub
>     (key, envkey))
> tox.ConfigError: ConfigError: substitution 'env:NO_INDEX:':
> 'NO_INDEX:' not found in environment
> 
> 
> 0% tests passed, 1 tests failed out of 1
> 
> Total Test time (real) =   0.30 sec
> 
> The following tests FAILED:
>      15 - run-tox-ceph-detect-init (Failed)
> Errors while running CTest
> 
> pip --version
> pip 7.1.0 from /usr/lib/python2.7/site-packages (python 2.7)
> 

Perhaps I'm reading things wrong, but it looks like you are
getting/using tox version 1.4.2 and the script suggests that you should
be using tox >= 1.9.

The other thing is that in my environment it uses:
# /tmp/ceph-detect-init-virtualenv/bin/tox --version
2.5.0 imported from
/tmp/ceph-detect-init-virtualenv/lib/python2.7/site-packages/tox/__init__.pyc

Now this is on FreeBSD, but you might want to check if you have tox in
/tmp/ceph-detect-init-virtualenv/bin/tox and what its version is.

And then it could be that you/the script are using the wrong version.

--WjW


> On Fri, Feb 24, 2017 at 11:07 AM, Sage Weil <sage@newdream.net> wrote:
>> On Fri, 24 Feb 2017, Muminul Islam Russell wrote:
>>> Hello cephers,
>>>
>>>
>>> I am new this ceph development although have been using it for long
>>> time. At first I started building and followed the same steps
>>> described the the github.
>>>
>>> ./do_cmake.sh
>>> cd build
>>> make
>>>
>>> I changed some code in ceph-detect init and added proper test cases as
>>> well but the test cased failed.
>>>
>>> Could you please suggest me what is going wrong here?
>>
>> I think the python pieces are somewhat special.  You might try 'make
>> tests' and then try it again?
>>
>> sage
>>
>>
>>>
>>> sudo ctest --output-on-failure -R run-tox-ceph-detect-init
>>> Test project /home/muislam/ceph_upstream/ceph/build
>>>     Start 15: run-tox-ceph-detect-init
>>> 1/1 Test #15: run-tox-ceph-detect-init .........***Failed    0.25 sec
>>> /home/muislam/ceph_upstream/ceph/src/ceph-detect-init/run-tox.sh: line
>>> 30: /tmp/ceph-detect-init-virtualenv/bin/activate: No such file or
>>> directory
>>> Traceback (most recent call last):
>>>   File "/bin/tox", line 9, in <module>
>>>     load_entry_point('tox==1.4.2', 'console_scripts', 'tox')()
>>>   File "/usr/lib/python2.7/site-packages/tox/_cmdline.py", line 24, in main
>>>     config = parseconfig(args, 'tox')
>>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 23, in
>>> parseconfig
>>>     parseini(config)
>>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 170, in __init__
>>>     config)
>>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 223, in
>>> _makeenvconfig
>>>     for depline in reader.getlist(section, "deps"):
>>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 296, in getlist
>>>     s = self.getdefault(section, name, None)
>>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 389, in
>>> getdefault
>>>     x = self._replace(x)
>>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 489, in _replace
>>>     return rexpattern.sub(self._sub, x)
>>>   File "/usr/lib/python2.7/site-packages/tox/_config.py", line 402, in _sub
>>>     (key, envkey))
>>> tox.ConfigError: ConfigError: substitution 'env:NO_INDEX:':
>>> 'NO_INDEX:' not found in environment
>>>
>>>
>>> 0% tests passed, 1 tests failed out of 1
>>>
>>> Total Test time (real) =   0.31 sec
>>>
>>> The following tests FAILED:
>>>      15 - run-tox-ceph-detect-init (Failed)
>>> Errors while running CTest
>>>
>>> Thanks in advance.
>>>
>>> Best,
>>> Muminul
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

