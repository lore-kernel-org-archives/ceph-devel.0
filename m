From: Emil Renner Berthing <ceph@esmil.dk>
Subject: Re: Segmentation faults in ceph-osd
Date: Tue, 21 May 2013 17:44:04 +0200
Message-ID: <CANBLGcwPMCSpXDgsXKBDQ2p-FhQNYg-FqagrUCrpa=BMTcogEg@mail.gmail.com>
References: <CANBLGcybBofQqpP2wetuN+QDPO_QaX2s8AhM2WebcvW7njBd4Q@mail.gmail.com>
 <CAPYLRziXri6RYPZGCqQbnVS87XrnH1Bq2deX3yY4A8G5g3Yk5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:55812 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab3EUPoZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 11:44:25 -0400
Received: by mail-vb0-f51.google.com with SMTP id x16so520251vbf.38
        for <ceph-devel@vger.kernel.org>; Tue, 21 May 2013 08:44:24 -0700 (PDT)
In-Reply-To: <CAPYLRziXri6RYPZGCqQbnVS87XrnH1Bq2deX3yY4A8G5g3Yk5Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Greg,

Here are some more stats on our servers:
- each server has 64GB ram,
- there are 12 OSDs pr. server,
- each OSD uses around 1.5 GB of memory,
- we have 18432 PGs,
- around 5 to 10 MB writes/s is written to each OSD and almost no reads (yet).

/Emil

On 21 May 2013 17:10, Gregory Farnum <greg@inktank.com> wrote:
> That looks like an attempt at a 370MB memory allocation. :? What's the
> memory use like on those nodes, and what's your workload?
> -Greg
>
>
> On Tuesday, May 21, 2013, Emil Renner Berthing wrote:
>>
>> Hi,
>>
>> We're experiencing random segmentation faults in the osd daemon from
>> the 0.61.2-1~bpo70+1 debian packages. It happens across all our
>> servers and we've seen around 40 crashes in the last week.
>>
>> It seems to happen more often on loaded servers, but at least they all
>> return the same error in the logs. An example can be found here:
>> http://esmil.dk/osdcrash.txt
>>
>> Here is the backtrace from the core dump:
>>
>> #0  0x00007f87b148eefb in raise () from
>> /lib/x86_64-linux-gnu/libpthread.so.0
>> #1  0x0000000000853a89 in reraise_fatal (signum=11) at
>> global/signal_handler.cc:58
>> #2  handle_fatal_signal (signum=11) at global/signal_handler.cc:104
>> #3  <signal handler called>
>> #4  0x00007f87b06a96f3 in do_malloc (size=388987616) at
>> src/tcmalloc.cc:1059
>> #5  cpp_alloc (nothrow=false, size=388987616) at src/tcmalloc.cc:1354
>> #6  tc_new (size=388987616) at src/tcmalloc.cc:1530
>> #7  0x00007f87a60c89b0 in ?? ()
>> #8  0x00000000172f7ae0 in ?? ()
>> #9  0x00007f87b0459b21 in ?? () from
>> /usr/lib/x86_64-linux-gnu/libleveldb.so.1
>> #10 0x00007f87b0456ba8 in ?? () from
>> /usr/lib/x86_64-linux-gnu/libleveldb.so.1
>> #11 0x00007f87b04424d4 in ?? () from
>> /usr/lib/x86_64-linux-gnu/libleveldb.so.1
>> #12 0x0000000000840977 in
>> LevelDBStore::LevelDBWholeSpaceIteratorImpl::lower_bound
>> (this=0x20910a20, prefix=..., to=...) at os/LevelDBStore.h:204
>> #13 0x000000000083f351 in LevelDBStore::get (this=<optimized out>,
>> prefix=..., keys=..., out=0x7f87a60c8d00) at os/LevelDBStore.cc:106
>> #14 0x0000000000838449 in DBObjectMap::_lookup_map_header
>> (this=this@entry=0x316d4a0, hoid=...) at os/DBObjectMap.cc:1080
>> #15 0x000000000083e4a9 in DBObjectMap::lookup_map_header
>> (this=this@entry=0x316d4a0, hoid=...) at os/DBObjectMap.h:404
>> #16 0x0000000000839e06 in DBObjectMap::rm_keys (this=0x316d4a0,
>> hoid=..., to_clear=..., spos=0x7f87a60c9400) at os/DBObjectMap.cc:696
>> #17 0x00000000007f40c1 in FileStore::_omap_rmkeys
>> (this=this@entry=0x3188000, cid=..., hoid=..., keys=..., spos=...) at
>> os/FileStore.cc:4765
>> #18 0x000000000080f610 in FileStore::_do_transaction
>> (this=this@entry=0x3188000, t=..., op_seq=op_seq@entry=4760123,
>> trans_num=trans_num@entry=0) at os/FileStore.cc:2595
>> #19 0x0000000000812999 in FileStore::_do_transactions
>> (this=this@entry=0x3188000, tls=..., op_seq=4760123,
>> handle=handle@entry=0x7f87a60c9b80) at os/FileStore.cc:2151
>> #20 0x0000000000812b2e in FileStore::_do_op (this=0x3188000,
>> osr=<optimized out>, handle=...) at os/FileStore.cc:1985
>> #21 0x00000000008f52ea in ThreadPool::worker (this=0x3188a08,
>> wt=0x319c3e0) at common/WorkQueue.cc:119
>> #22 0x00000000008f6590 in ThreadPool::WorkThread::entry
>> (this=<optimized out>) at common/WorkQueue.h:316
>> #23 0x00007f87b1486b50 in start_thread () from
>> /lib/x86_64-linux-gnu/libpthread.so.0
>> #24 0x00007f87af9c2a7d in clone () from /lib/x86_64-linux-gnu/libc.so.6
>> #25 0x0000000000000000 in ?? ()
>>
>> Please let me know if can provide any other info to help find this bug.
>> /Emil
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Software Engineer #42 @ http://inktank.com | http://ceph.com
