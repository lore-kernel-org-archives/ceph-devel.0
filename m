From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FreeBSD Building and Testing
Date: Wed, 6 Jan 2016 11:16:12 +0100
Message-ID: <568CE96C.8040801@digiware.nl>
References: <5676D2D9.5010600@digiware.nl>
 <CANE=7sVw1zhxYzT9q6WKkUV5tCioLuO0J_ZKCkdKXR5jFDHsKg@mail.gmail.com>
 <56785D9A.2020701@digiware.nl> <568168F0.2060605@digiware.nl>
 <20160106075144.GA3402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:35915 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbcAFK0q (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Jan 2016 05:26:46 -0500
In-Reply-To: <20160106075144.GA3402@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>
Cc: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 6-1-2016 08:51, Mykola Golub wrote:
> On Mon, Dec 28, 2015 at 05:53:04PM +0100, Willem Jan Withagen wrote:
>> Hi,
>>
>> Can somebody try to help me and explain why
>>
>> in test: Func: test/mon/osd-crash
>> Func: TEST_crush_reject_empty started
>>
>> Fails with a python error which sort of startles me:
>> test/mon/osd-crush.sh:227: TEST_crush_reject_empty:  local
>> empty_map=testdir/osd-crush/empty_map
>> test/mon/osd-crush.sh:228: TEST_crush_reject_empty:  :
>> test/mon/osd-crush.sh:229: TEST_crush_reject_empty:  ./crushtool -c
>> testdir/osd-crush/empty_map.txt -o testdir/osd-crush/empty_map.m
>> ap
>> test/mon/osd-crush.sh:230: TEST_crush_reject_empty:  expect_failure
>> testdir/osd-crush 'Error EINVAL' ./ceph osd setcrushmap -i testd
>> ir/osd-crush/empty_map.map
>> ../qa/workunits/ceph-helpers.sh:1171: expect_failure:  local
>> dir=testdir/osd-crush
>> ../qa/workunits/ceph-helpers.sh:1172: expect_failure:  shift
>> ../qa/workunits/ceph-helpers.sh:1173: expect_failure:  local 'expected=Error
>> EINVAL'
>> ../qa/workunits/ceph-helpers.sh:1174: expect_failure:  shift
>> ../qa/workunits/ceph-helpers.sh:1175: expect_failure:  local success
>> ../qa/workunits/ceph-helpers.sh:1176: expect_failure:  pwd
>> ../qa/workunits/ceph-helpers.sh:1177: expect_failure:  printenv
>> ../qa/workunits/ceph-helpers.sh:1178: expect_failure:  echo ./ceph osd
>> setcrushmap -i testdir/osd-crush/empty_map.map
>> ../qa/workunits/ceph-helpers.sh:1180: expect_failure:  ./ceph osd
>> setcrushmap -i testdir/osd-crush/empty_map.map
>> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>> Traceback (most recent call last):
>>    File "./ceph", line 936, in <module>
>>      retval = main()
>>    File "./ceph", line 874, in main
>>      sigdict, inbuf, verbose)
>>    File "./ceph", line 457, in new_style_command
>>      inbuf=inbuf)
>>    File "/usr/srcs/Ceph/wip-freebsd-wjw/ceph/src/pybind/ceph_argparse.py",
>> line 1208, in json_command
>>      raise RuntimeError('"{0}": exception {1}'.format(argdict, e))
>> RuntimeError: "{'prefix': u'osd setcrushmap'}": exception "['{"prefix": "osd
>> setcrushmap"}']": exception 'utf8' codec can't decode b
>> yte 0x86 in position 56: invalid start byte
>>
>> Which is certainly not the type of error expected.
>> But it is hard to detect any 0x86 in the arguments.
>
> Are you able to reproduce this problem manually? I.e. in src dir, start the
> cluster using vstart.sh:
>
> ./vstart.sh -n
>
> Check it is running:
>
> ./ceph -s
>
> Repeat the test:
>
> truncate -s 0 empty_map.txt
> ./crushtool -c empty_map.txt -o empty_map.map
> ./ceph osd setcrushmap -i empty_map.map
>
> Expected output:
>
>   "Error EINVAL: Failed crushmap test: ./crushtool: exit status: 1"
>

Hi all,

I've spent the Xmas days trying to learn more about Python.
(And catching up with old friends :) )

My heritage is the days of assembler, shell script, C, Perl and likes.
So the pony had to learn a few new tricks. (aka language)
I'm now trying to get python nosetest to actually work

In the mean time I also found that FreeBSD has patches for Googletest
to actually  make most of the DEATH tests work.

I think this python stream pars error got resolved by upgrading
everything build, including  the complete package environment and
upgrading kernel and tools... :) Which I think cleaned out the python
environment which was a bit mixed up with different versions.

Now test/mon/osd-crush.sh return OKE, so I guess the setup of the 
environment
is relatively critical.

I also noted that some of the test get more tests done IF I run them under
root-priviledges

The last test run resulted in:
=====================================
    ceph 10.0.1: src/test-suite.log
=====================================

# TOTAL: 120
# PASS:  110
# SKIP:  0
# XFAIL: 0
# FAIL:  10
# XPASS: 0
# ERROR: 0

FAIL ceph-detect-init/run-tox.sh (exit status: 1)
FAIL test/run-rbd-unit-tests.sh (exit status: 138)
FAIL test/ceph_objectstore_tool.py (exit status: 1)
FAIL test/cephtool-test-mon.sh (exit status: 1)
FAIL test/cephtool-test-rados.sh (exit status: 1)
FAIL test/libradosstriper/rados-striper.sh (exit status: 1)
FAIL test/test_objectstore_memstore.sh (exit status: 127)
FAIL test/ceph-disk.sh (exit status: 1)
FAIL test/pybind/test_ceph_argparse.py (exit status: 127)
FAIL test/pybind/test_ceph_daemon.py (exit status: 127)

where the first and last 2 actually don't work because of python things
that are not working on FreeBSD and I have to sort out.
ceph_detect_init.exc.UnsupportedPlatform: Platform is not supported.:
../test-driver: ./test/pybind/test_ceph_argparse.py: not found
FAIL test/pybind/test_ceph_argparse.py (exit status: 127)

I also have:
./test/test_objectstore_memstore.sh: ./ceph_test_objectstore: not found
FAIL test/test_objectstore_memstore.sh (exit status: 127)

Which ia a weird one, that needs some TLC.

So I'm slowly getting there...

--WjW
