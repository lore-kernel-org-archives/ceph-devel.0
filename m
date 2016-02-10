From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: FreeBSD crushtool crashing while checking a crushmap
Date: Wed, 10 Feb 2016 13:19:16 +0100
Message-ID: <56BB2AC4.8030100@digiware.nl>
References: <56B66FC0.70409@digiware.nl>
 <CAJE9aOOj3kak2p90RUcD8ps+M_j05NwA-KfYGxZyb3-u1zHkYw@mail.gmail.com>
 <CAJE9aONwRb7pfG=K+GdJ1mg8ePd9FQ0iy-fnwWcF7qQ5jarbbQ@mail.gmail.com>
 <56B87576.5010200@digiware.nl>
 <CAJE9aOMDdHBm6qKbZeWn6ySAdeH92EkbM0+z5ZxemowOo2irFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:49557 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbcBJMTY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Feb 2016 07:19:24 -0500
In-Reply-To: <CAJE9aOMDdHBm6qKbZeWn6ySAdeH92EkbM0+z5ZxemowOo2irFA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 10-2-2016 13:13, kefu chai wrote:
> On Mon, Feb 8, 2016 at 7:01 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 8-2-2016 06:53, kefu chai wrote:
>>>
>>> sorry, just sent an out-dated reply.
>>>
>>> On Sun, Feb 7, 2016 at 6:12 AM, Willem Jan Withagen <wjw@digiware.nl>
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>> While running run-cli-tests one of the tests dumps while checking if the
>>>> previous command has build the correct crushmap.
>>>> I've verified the actual crushmap against one build on CentOS, and they
>>>> are byte for byte equal.
>>>>
>>>> Before I rebased (from beginning of januari) all these tests completed
>>>> just fine.
>>>>
>>>> During checking I get the following dump:
>>>>
>>>> # src/crushtool -i
>>>> src/tes/cli/crushtool/check-overlapped-rules.crushmap.ref --check
>>>> Assertion failed: (this->_map.find(inter_val) == this->_map.end()),
>>>> function gap_insert, file
>>>> /usr/local/include/boost/icl/interval_base_map.hpp, line 555.
>>>> *** Caught signal (Abort trap) **
>>>>    in thread 803e15000
>>>>    ceph version Development (no_version)
>>>>    1: 0x86f865 <_ZN4ceph9BackTraceC2Ei+0x35> at
>>>> /usr/srcs/Ceph/work/ceph/src/crushtool
>>>>    2: 0x86e5f9 <_ZL19handle_fatal_signali+0xa9> at
>>>> /usr/srcs/Ceph/work/ceph/src/crushtool
>>>>    3: 0x801811c7d <pthread_sigmask+0x50d> at /lib/libthr.so.3
>>>>    4: 0x8018112b2 <pthread_getspecific+0xe22> at /lib/libthr.so.3
>>>> 2016-02-06 22:55:09.075189 803e15000 -1
>>>>
>>>> Deleted remainder of the output....
>>>>
>>>> And I appreciate any pointers in helping me debugging this.
>>>
>>>
>>> hey Willem, thanks for looking into this. turns out this is a known issue
>>> of
>>> boost 1.55. just posted a pull request to workaround it at
>>> https://github.com/ceph/ceph/pull/7560.
>>>
>>> also did i create a minimal reproducer, it can help with reproducing this
>>> issue and verify the fix.
>>>
>>> you can compile it using:
>>>
>>> $ clang++ -std=c++11 -O0 -g test.cc -lm -o test
>>>
>>
>> pffh,
>>
>> That's a relieve, since I would otherwise be quite a chase....
>> and yes, I'm still at boost 1.55.
>>
>> Perhaps in the test check-overlapped-rules.t an extra test:
>>          cmp "$TESTDIR/check-overlapped-rules.crushmap"
>> "$TESTDIR/check-overlapped-rules.crushmap.ref"
>
> we have compile-decompile-recompile.t for testing this.

But then still you do not know where the error is:
	upon generation
	or on decompile
But then it requires debugging anyways, and you'll find out soon enough.

>> Which will at least tell you that the output was consistent with what sould
>> be there.
>> And it'll pin-point the source of the error perhaps a bit better.
>>
>> Can I just "accept" a pull request in my fork without running into trouble
>> when I rebase?
>
> i don't think you can. rebase against the master is the way to go, i guess.

Yup, rebase will be the way to get it in.

--WjW
