From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FreeBSD Building and Testing
Date: Mon, 28 Dec 2015 17:53:04 +0100
Message-ID: <568168F0.2060605@digiware.nl>
References: <5676D2D9.5010600@digiware.nl>
 <CANE=7sVw1zhxYzT9q6WKkUV5tCioLuO0J_ZKCkdKXR5jFDHsKg@mail.gmail.com>
 <56785D9A.2020701@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:53664 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043AbbL1QxI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Dec 2015 11:53:08 -0500
In-Reply-To: <56785D9A.2020701@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Can somebody try to help me and explain why

in test: Func: test/mon/osd-crash
Func: TEST_crush_reject_empty started

Fails with a python error which sort of startles me:
test/mon/osd-crush.sh:227: TEST_crush_reject_empty:  local 
empty_map=testdir/osd-crush/empty_map
test/mon/osd-crush.sh:228: TEST_crush_reject_empty:  :
test/mon/osd-crush.sh:229: TEST_crush_reject_empty:  ./crushtool -c 
testdir/osd-crush/empty_map.txt -o testdir/osd-crush/empty_map.m
ap
test/mon/osd-crush.sh:230: TEST_crush_reject_empty:  expect_failure 
testdir/osd-crush 'Error EINVAL' ./ceph osd setcrushmap -i testd
ir/osd-crush/empty_map.map
../qa/workunits/ceph-helpers.sh:1171: expect_failure:  local 
dir=testdir/osd-crush
../qa/workunits/ceph-helpers.sh:1172: expect_failure:  shift
../qa/workunits/ceph-helpers.sh:1173: expect_failure:  local 
'expected=Error EINVAL'
../qa/workunits/ceph-helpers.sh:1174: expect_failure:  shift
../qa/workunits/ceph-helpers.sh:1175: expect_failure:  local success
../qa/workunits/ceph-helpers.sh:1176: expect_failure:  pwd
../qa/workunits/ceph-helpers.sh:1177: expect_failure:  printenv
../qa/workunits/ceph-helpers.sh:1178: expect_failure:  echo ./ceph osd 
setcrushmap -i testdir/osd-crush/empty_map.map
../qa/workunits/ceph-helpers.sh:1180: expect_failure:  ./ceph osd 
setcrushmap -i testdir/osd-crush/empty_map.map
*** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
Traceback (most recent call last):
   File "./ceph", line 936, in <module>
     retval = main()
   File "./ceph", line 874, in main
     sigdict, inbuf, verbose)
   File "./ceph", line 457, in new_style_command
     inbuf=inbuf)
   File 
"/usr/srcs/Ceph/wip-freebsd-wjw/ceph/src/pybind/ceph_argparse.py", line 
1208, in json_command
     raise RuntimeError('"{0}": exception {1}'.format(argdict, e))
RuntimeError: "{'prefix': u'osd setcrushmap'}": exception "['{"prefix": 
"osd setcrushmap"}']": exception 'utf8' codec can't decode b
yte 0x86 in position 56: invalid start byte

Which is certainly not the type of error expected.
But it is hard to detect any 0x86 in the arguments.

And yes python is right, there are no UTF8 sequences that start with 0x86.
Question is:
	Why does it want to parse with UTF8?
	And how do I switch it off?
	Or how to I fix this error?

Thanx,
--WjW
