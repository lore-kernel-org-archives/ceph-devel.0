From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: OSD crash
Date: Sat, 25 Aug 2012 12:30:48 +0400
Message-ID: <CABYiri_d1tRmiPfpc6wO3Kg6=wQ90xd1feBKT3mO0iYjEjk6KA@mail.gmail.com>
References: <CABYiri_Fi4uMSqLnoFLp4_2kQ8FSXv=jjSSQiER=DwCOG0hqkA@mail.gmail.com>
 <alpine.DEB.2.00.1208221532350.29719@cobra.newdream.net> <CABYiri_y+GeKWoxNpmxMDbWThqb-9JmazohN2Zeroq9KNOZFTg@mail.gmail.com>
 <CAPYLRzgUviKbU5i7XDDkcTdHKS6JGYxwEoEXbDRUB8rHeAN5Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35616 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab2HYIbM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 Aug 2012 04:31:12 -0400
Received: by wgbdr13 with SMTP id dr13so2121060wgb.1
        for <ceph-devel@vger.kernel.org>; Sat, 25 Aug 2012 01:31:08 -0700 (PDT)
In-Reply-To: <CAPYLRzgUviKbU5i7XDDkcTdHKS6JGYxwEoEXbDRUB8rHeAN5Bg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

On Thu, Aug 23, 2012 at 4:09 AM, Gregory Farnum <greg@inktank.com> wrote:
> The tcmalloc backtrace on the OSD suggests this may be unrelated, but
> what's the fd limit on your monitor process? You may be approaching
> that limit if you've got 500 OSDs and a similar number of clients.
>

Thanks! I didn`t measured a # of connection because of bearing in mind
1 conn per client, raising limit did the thing. Previously mentioned
qemu-kvm zombie does not related to rbd itself - it can be created by
destroying libvirt domain which is in saving state or vice-versa, so
I`ll put a workaround on this. Right now I am faced different problem
- osds dying silently, e.g. not leaving a core, I`ll check logs on the
next testing phase.

> On Wed, Aug 22, 2012 at 6:55 PM, Andrey Korolyov <andrey@xdel.ru> wrote:
>> On Thu, Aug 23, 2012 at 2:33 AM, Sage Weil <sage@inktank.com> wrote:
>>> On Thu, 23 Aug 2012, Andrey Korolyov wrote:
>>>> Hi,
>>>>
>>>> today during heavy test a pair of osds and one mon died, resulting to
>>>> hard lockup of some kvm processes - they went unresponsible and was
>>>> killed leaving zombie processes ([kvm] <defunct>). Entire cluster
>>>> contain sixteen osd on eight nodes and three mons, on first and last
>>>> node and on vm outside cluster.
>>>>
>>>> osd bt:
>>>> #0  0x00007fc37d490be3 in
>>>> tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::FreeList*,
>>>> unsigned long, int) () from /usr/lib/libtcmalloc.so.4
>>>> (gdb) bt
>>>> #0  0x00007fc37d490be3 in
>>>> tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::FreeList*,
>>>> unsigned long, int) () from /usr/lib/libtcmalloc.so.4
>>>> #1  0x00007fc37d490eb4 in tcmalloc::ThreadCache::Scavenge() () from
>>>> /usr/lib/libtcmalloc.so.4
>>>> #2  0x00007fc37d4a2287 in tc_delete () from /usr/lib/libtcmalloc.so.4
>>>> #3  0x00000000008b1224 in _M_dispose (__a=..., this=0x6266d80) at
>>>> /usr/include/c++/4.7/bits/basic_string.h:246
>>>> #4  ~basic_string (this=0x7fc3736639d0, __in_chrg=<optimized out>) at
>>>> /usr/include/c++/4.7/bits/basic_string.h:536
>>>> #5  ~basic_stringbuf (this=0x7fc373663988, __in_chrg=<optimized out>)
>>>> at /usr/include/c++/4.7/sstream:60
>>>> #6  ~basic_ostringstream (this=0x7fc373663980, __in_chrg=<optimized
>>>> out>, __vtt_parm=<optimized out>) at /usr/include/c++/4.7/sstream:439
>>>> #7  pretty_version_to_str () at common/version.cc:40
>>>> #8  0x0000000000791630 in ceph::BackTrace::print (this=0x7fc373663d10,
>>>> out=...) at common/BackTrace.cc:19
>>>> #9  0x000000000078f450 in handle_fatal_signal (signum=11) at
>>>> global/signal_handler.cc:91
>>>> #10 <signal handler called>
>>>> #11 0x00007fc37d490be3 in
>>>> tcmalloc::ThreadCache::ReleaseToCentralCache(tcmalloc::ThreadCache::FreeList*,
>>>> unsigned long, int) () from /usr/lib/libtcmalloc.so.4
>>>> #12 0x00007fc37d490eb4 in tcmalloc::ThreadCache::Scavenge() () from
>>>> /usr/lib/libtcmalloc.so.4
>>>> #13 0x00007fc37d49eb97 in tc_free () from /usr/lib/libtcmalloc.so.4
>>>> #14 0x00007fc37d1c6670 in __gnu_cxx::__verbose_terminate_handler() ()
>>>> from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>>> #15 0x00007fc37d1c4796 in ?? () from /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>>> #16 0x00007fc37d1c47c3 in std::terminate() () from
>>>> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>>> #17 0x00007fc37d1c49ee in __cxa_throw () from
>>>> /usr/lib/x86_64-linux-gnu/libstdc++.so.6
>>>> #18 0x0000000000844e11 in ceph::__ceph_assert_fail (assertion=0x90c01c
>>>> "0 == \"unexpected error\"", file=<optimized out>, line=3007,
>>>>     func=0x90ef80 "unsigned int
>>>> FileStore::_do_transaction(ObjectStore::Transaction&, uint64_t, int)")
>>>> at common/assert.cc:77
>>>
>>> This means it got an unexpected error when talking to the file system.  If
>>> you look in the osd log, it may tell you what that was.  (It may
>>> not--there isn't usually the other tcmalloc stuff triggered from the
>>> assert handler.)
>>>
>>> What happens if you restart that ceph-osd daemon?
>>>
>>> sage
>>>
>>>
>>
>> Unfortunately I have completely disabled logs during test, so there
>> are no suggestion of assert_fail. The main problem was revealed -
>> created VMs was pointed to one monitor instead set of three, so there
>> may be some unusual things(btw, crashed mon isn`t one from above, but
>> a neighbor of crashed osds on first node). After IPMI reset node
>> returns back well and cluster behavior seems to be okay - stuck kvm
>> I/O somehow prevented even other module load|unload on this node, so I
>> finally decided to do hard reset. Despite I`m using almost generic
>> wheezy, glibc was updated to 2.15, may be because of this my trace
>> appears first time ever. I`m almost sure that fs does not triggered
>> this crash and mainly suspecting stuck kvm processes. I`ll rerun test
>> with same conditions tomorrow(~500 vms pointed to one mon and very
>> high I/O, but with osd logging).
>>
>>>> #19 0x000000000073148f in FileStore::_do_transaction
>>>> (this=this@entry=0x2cde000, t=..., op_seq=op_seq@entry=429545,
>>>> trans_num=trans_num@entry=0) at os/FileStore.cc:3007
>>>> #20 0x000000000073484e in FileStore::do_transactions (this=0x2cde000,
>>>> tls=..., op_seq=429545) at os/FileStore.cc:2436
>>>> #21 0x000000000070c680 in FileStore::_do_op (this=0x2cde000,
>>>> osr=<optimized out>) at os/FileStore.cc:2259
>>>> #22 0x000000000083ce01 in ThreadPool::worker (this=0x2cde828) at
>>>> common/WorkQueue.cc:54
>>>> #23 0x00000000006823ed in ThreadPool::WorkThread::entry
>>>> (this=<optimized out>) at ./common/WorkQueue.h:126
>>>> #24 0x00007fc37e3eee9a in start_thread () from
>>>> /lib/x86_64-linux-gnu/libpthread.so.0
>>>> #25 0x00007fc37c9864cd in clone () from /lib/x86_64-linux-gnu/libc.so.6
>>>> #26 0x0000000000000000 in ?? ()
>>>>
>>>> mon bt was exactly the same as in http://tracker.newdream.net/issues/2762
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
