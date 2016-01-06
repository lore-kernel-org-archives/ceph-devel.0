From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FreeBSD Building and Testing
Date: Wed, 6 Jan 2016 11:21:30 +0100
Message-ID: <568CEAAA.9080602@digiware.nl>
References: <5676D2D9.5010600@digiware.nl>
 <CANE=7sVw1zhxYzT9q6WKkUV5tCioLuO0J_ZKCkdKXR5jFDHsKg@mail.gmail.com>
 <56785D9A.2020701@digiware.nl> <568168F0.2060605@digiware.nl>
 <CAJ4mKGYgFw1Xx4SFbSpg0EYU-Suk8PG2exkVRDtDZ8fzjU1H9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:35525 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425AbcAFKV7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 Jan 2016 05:21:59 -0500
In-Reply-To: <CAJ4mKGYgFw1Xx4SFbSpg0EYU-Suk8PG2exkVRDtDZ8fzjU1H9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 5-1-2016 19:23, Gregory Farnum wrote:
> On Mon, Dec 28, 2015 at 8:53 AM, Willem Jan Withagen <wjw@digiware.nl> wrote:
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
>>
>> And yes python is right, there are no UTF8 sequences that start with 0x86.
>> Question is:
>>          Why does it want to parse with UTF8?
>>          And how do I switch it off?
>>          Or how to I fix this error?
>
> I've not handled this myself but we've seen this a few times. The
> latest example in a quick email search was
> http://tracker.ceph.com/issues/9405, and it was apparently having a
> string which wasn't null-terminated.


Looks like in my case it was due to too large a mess in the python 
environment.
But I'll keep this in my mind, IFF it comes back to haunt me more.

Thanx,
--WjW
