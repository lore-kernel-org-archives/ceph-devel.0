From: Emil Renner Berthing <ceph@esmil.dk>
Subject: Re: Segmentation faults in ceph-osd
Date: Tue, 21 May 2013 18:32:53 +0200
Message-ID: <CANBLGcxhPTjpZhVetPACiwWY4L67LLdC2yT=JYN+o4rKQBV1ig@mail.gmail.com>
References: <CANBLGcybBofQqpP2wetuN+QDPO_QaX2s8AhM2WebcvW7njBd4Q@mail.gmail.com>
 <CAPYLRziXri6RYPZGCqQbnVS87XrnH1Bq2deX3yY4A8G5g3Yk5Q@mail.gmail.com>
 <CANBLGcwPMCSpXDgsXKBDQ2p-FhQNYg-FqagrUCrpa=BMTcogEg@mail.gmail.com>
 <CAPYLRzjiBJ7dBTibfLhPwRhCu+vEVcBCB_1dQpOKL+VT_TY2bw@mail.gmail.com>
 <CANBLGcyp9htDc=qZYP6iga-oSC7cGV-68F8UgWvR3rRKQhCX9A@mail.gmail.com> <CAPYLRzgd7ikRn=MoQUgazHJYUMUbzRwoH6PYJMcaBckbvdMLgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48]:43527 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab3EUQdO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 12:33:14 -0400
Received: by mail-vb0-f48.google.com with SMTP id q16so564097vbe.21
        for <ceph-devel@vger.kernel.org>; Tue, 21 May 2013 09:33:13 -0700 (PDT)
In-Reply-To: <CAPYLRzgd7ikRn=MoQUgazHJYUMUbzRwoH6PYJMcaBckbvdMLgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

On 21 May 2013 18:19, Gregory Farnum <greg@inktank.com> wrote:
> On Tue, May 21, 2013 at 9:01 AM, Emil Renner Berthing <ceph@esmil.dk>=
 wrote:
>> On 21 May 2013 17:55, Gregory Farnum <greg@inktank.com> wrote:
>>> On Tue, May 21, 2013 at 8:44 AM, Emil Renner Berthing <ceph@esmil.d=
k> wrote:
>>>> Hi Greg,
>>>>
>>>> Here are some more stats on our servers:
>>>> - each server has 64GB ram,
>>>> - there are 12 OSDs pr. server,
>>>> - each OSD uses around 1.5 GB of memory,
>>>> - we have 18432 PGs,
>>>> - around 5 to 10 MB writes/s is written to each OSD and almost no =
reads (yet).
>>>
>>> What interface are you writing with? How many OSD servers are there=
?
>>
>> We're using librados and there are 132 OSDs so far.
>
> Okay, so the allocation is happening in the depths of LevelDB =E2=80=94=
 maybe
> the issue is there somewhere. Are you doing anything weird with omap,
> snapshots, or xattrs?

All the drives are 4TB large, have an xfs-formatted sdx1 and a 10GB
journal at sdx2.
The filesystems are mounted xfs (rw,noatime,attr2,noquota).

We don't use snapshots.
/Emil

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
>
>>
>> /Emil
>>
>>> -Greg
>>>
>>>
>>>>
>>>> /Emil
>>>>
>>>> On 21 May 2013 17:10, Gregory Farnum <greg@inktank.com> wrote:
>>>>> That looks like an attempt at a 370MB memory allocation. :? What'=
s the
>>>>> memory use like on those nodes, and what's your workload?
>>>>> -Greg
>>>>>
>>>>>
>>>>> On Tuesday, May 21, 2013, Emil Renner Berthing wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> We're experiencing random segmentation faults in the osd daemon =
from
>>>>>> the 0.61.2-1~bpo70+1 debian packages. It happens across all our
>>>>>> servers and we've seen around 40 crashes in the last week.
>>>>>>
>>>>>> It seems to happen more often on loaded servers, but at least th=
ey all
>>>>>> return the same error in the logs. An example can be found here:
>>>>>> http://esmil.dk/osdcrash.txt
>>>>>>
>>>>>> Here is the backtrace from the core dump:
>>>>>>
>>>>>> #0  0x00007f87b148eefb in raise () from
>>>>>> /lib/x86_64-linux-gnu/libpthread.so.0
>>>>>> #1  0x0000000000853a89 in reraise_fatal (signum=3D11) at
>>>>>> global/signal_handler.cc:58
>>>>>> #2  handle_fatal_signal (signum=3D11) at global/signal_handler.c=
c:104
>>>>>> #3  <signal handler called>
>>>>>> #4  0x00007f87b06a96f3 in do_malloc (size=3D388987616) at
>>>>>> src/tcmalloc.cc:1059
>>>>>> #5  cpp_alloc (nothrow=3Dfalse, size=3D388987616) at src/tcmallo=
c.cc:1354
>>>>>> #6  tc_new (size=3D388987616) at src/tcmalloc.cc:1530
>>>>>> #7  0x00007f87a60c89b0 in ?? ()
>>>>>> #8  0x00000000172f7ae0 in ?? ()
>>>>>> #9  0x00007f87b0459b21 in ?? () from
>>>>>> /usr/lib/x86_64-linux-gnu/libleveldb.so.1
>>>>>> #10 0x00007f87b0456ba8 in ?? () from
>>>>>> /usr/lib/x86_64-linux-gnu/libleveldb.so.1
>>>>>> #11 0x00007f87b04424d4 in ?? () from
>>>>>> /usr/lib/x86_64-linux-gnu/libleveldb.so.1
>>>>>> #12 0x0000000000840977 in
>>>>>> LevelDBStore::LevelDBWholeSpaceIteratorImpl::lower_bound
>>>>>> (this=3D0x20910a20, prefix=3D..., to=3D...) at os/LevelDBStore.h=
:204
>>>>>> #13 0x000000000083f351 in LevelDBStore::get (this=3D<optimized o=
ut>,
>>>>>> prefix=3D..., keys=3D..., out=3D0x7f87a60c8d00) at os/LevelDBSto=
re.cc:106
>>>>>> #14 0x0000000000838449 in DBObjectMap::_lookup_map_header
>>>>>> (this=3Dthis@entry=3D0x316d4a0, hoid=3D...) at os/DBObjectMap.cc=
:1080
>>>>>> #15 0x000000000083e4a9 in DBObjectMap::lookup_map_header
>>>>>> (this=3Dthis@entry=3D0x316d4a0, hoid=3D...) at os/DBObjectMap.h:=
404
>>>>>> #16 0x0000000000839e06 in DBObjectMap::rm_keys (this=3D0x316d4a0=
,
>>>>>> hoid=3D..., to_clear=3D..., spos=3D0x7f87a60c9400) at os/DBObjec=
tMap.cc:696
>>>>>> #17 0x00000000007f40c1 in FileStore::_omap_rmkeys
>>>>>> (this=3Dthis@entry=3D0x3188000, cid=3D..., hoid=3D..., keys=3D..=
=2E, spos=3D...) at
>>>>>> os/FileStore.cc:4765
>>>>>> #18 0x000000000080f610 in FileStore::_do_transaction
>>>>>> (this=3Dthis@entry=3D0x3188000, t=3D..., op_seq=3Dop_seq@entry=3D=
4760123,
>>>>>> trans_num=3Dtrans_num@entry=3D0) at os/FileStore.cc:2595
>>>>>> #19 0x0000000000812999 in FileStore::_do_transactions
>>>>>> (this=3Dthis@entry=3D0x3188000, tls=3D..., op_seq=3D4760123,
>>>>>> handle=3Dhandle@entry=3D0x7f87a60c9b80) at os/FileStore.cc:2151
>>>>>> #20 0x0000000000812b2e in FileStore::_do_op (this=3D0x3188000,
>>>>>> osr=3D<optimized out>, handle=3D...) at os/FileStore.cc:1985
>>>>>> #21 0x00000000008f52ea in ThreadPool::worker (this=3D0x3188a08,
>>>>>> wt=3D0x319c3e0) at common/WorkQueue.cc:119
>>>>>> #22 0x00000000008f6590 in ThreadPool::WorkThread::entry
>>>>>> (this=3D<optimized out>) at common/WorkQueue.h:316
>>>>>> #23 0x00007f87b1486b50 in start_thread () from
>>>>>> /lib/x86_64-linux-gnu/libpthread.so.0
>>>>>> #24 0x00007f87af9c2a7d in clone () from /lib/x86_64-linux-gnu/li=
bc.so.6
>>>>>> #25 0x0000000000000000 in ?? ()
>>>>>>
>>>>>> Please let me know if can provide any other info to help find th=
is bug.
>>>>>> /Emil
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Software Engineer #42 @ http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
