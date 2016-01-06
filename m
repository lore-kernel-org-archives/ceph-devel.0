From: Mykola Golub <mgolub@mirantis.com>
Subject: Re: FreeBSD Building and Testing
Date: Wed, 6 Jan 2016 09:51:46 +0200
Message-ID: <20160106075144.GA3402@gmail.com>
References: <5676D2D9.5010600@digiware.nl>
 <CANE=7sVw1zhxYzT9q6WKkUV5tCioLuO0J_ZKCkdKXR5jFDHsKg@mail.gmail.com>
 <56785D9A.2020701@digiware.nl>
 <568168F0.2060605@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36195 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188AbcAFHvt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jan 2016 02:51:49 -0500
Received: by mail-lf0-f41.google.com with SMTP id z124so303227589lfa.3
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jan 2016 23:51:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <568168F0.2060605@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Xinze Chi =?utf-8?B?KOS/oeazvSk=?= <xmdxcxz@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Dec 28, 2015 at 05:53:04PM +0100, Willem Jan Withagen wrote:
> Hi,
> 
> Can somebody try to help me and explain why
> 
> in test: Func: test/mon/osd-crash
> Func: TEST_crush_reject_empty started
> 
> Fails with a python error which sort of startles me:
> test/mon/osd-crush.sh:227: TEST_crush_reject_empty:  local
> empty_map=testdir/osd-crush/empty_map
> test/mon/osd-crush.sh:228: TEST_crush_reject_empty:  :
> test/mon/osd-crush.sh:229: TEST_crush_reject_empty:  ./crushtool -c
> testdir/osd-crush/empty_map.txt -o testdir/osd-crush/empty_map.m
> ap
> test/mon/osd-crush.sh:230: TEST_crush_reject_empty:  expect_failure
> testdir/osd-crush 'Error EINVAL' ./ceph osd setcrushmap -i testd
> ir/osd-crush/empty_map.map
> ../qa/workunits/ceph-helpers.sh:1171: expect_failure:  local
> dir=testdir/osd-crush
> ../qa/workunits/ceph-helpers.sh:1172: expect_failure:  shift
> ../qa/workunits/ceph-helpers.sh:1173: expect_failure:  local 'expected=Error
> EINVAL'
> ../qa/workunits/ceph-helpers.sh:1174: expect_failure:  shift
> ../qa/workunits/ceph-helpers.sh:1175: expect_failure:  local success
> ../qa/workunits/ceph-helpers.sh:1176: expect_failure:  pwd
> ../qa/workunits/ceph-helpers.sh:1177: expect_failure:  printenv
> ../qa/workunits/ceph-helpers.sh:1178: expect_failure:  echo ./ceph osd
> setcrushmap -i testdir/osd-crush/empty_map.map
> ../qa/workunits/ceph-helpers.sh:1180: expect_failure:  ./ceph osd
> setcrushmap -i testdir/osd-crush/empty_map.map
> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
> Traceback (most recent call last):
>   File "./ceph", line 936, in <module>
>     retval = main()
>   File "./ceph", line 874, in main
>     sigdict, inbuf, verbose)
>   File "./ceph", line 457, in new_style_command
>     inbuf=inbuf)
>   File "/usr/srcs/Ceph/wip-freebsd-wjw/ceph/src/pybind/ceph_argparse.py",
> line 1208, in json_command
>     raise RuntimeError('"{0}": exception {1}'.format(argdict, e))
> RuntimeError: "{'prefix': u'osd setcrushmap'}": exception "['{"prefix": "osd
> setcrushmap"}']": exception 'utf8' codec can't decode b
> yte 0x86 in position 56: invalid start byte
> 
> Which is certainly not the type of error expected.
> But it is hard to detect any 0x86 in the arguments.

Are you able to reproduce this problem manually? I.e. in src dir, start the
cluster using vstart.sh:

./vstart.sh -n

Check it is running:

./ceph -s

Repeat the test:

truncate -s 0 empty_map.txt
./crushtool -c empty_map.txt -o empty_map.map
./ceph osd setcrushmap -i empty_map.map

Expected output:

 "Error EINVAL: Failed crushmap test: ./crushtool: exit status: 1"

-- 
Mykola Golub
