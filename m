From: Emil Renner Berthing <ceph@esmil.dk>
Subject: Segmentation faults in ceph-osd
Date: Tue, 21 May 2013 13:21:56 +0200
Message-ID: <CANBLGcybBofQqpP2wetuN+QDPO_QaX2s8AhM2WebcvW7njBd4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:34023 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab3EULWR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 07:22:17 -0400
Received: by mail-vc0-f182.google.com with SMTP id gf12so317980vcb.27
        for <ceph-devel@vger.kernel.org>; Tue, 21 May 2013 04:22:16 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

We're experiencing random segmentation faults in the osd daemon from
the 0.61.2-1~bpo70+1 debian packages. It happens across all our
servers and we've seen around 40 crashes in the last week.

It seems to happen more often on loaded servers, but at least they all
return the same error in the logs. An example can be found here:
http://esmil.dk/osdcrash.txt

Here is the backtrace from the core dump:

#0  0x00007f87b148eefb in raise () from /lib/x86_64-linux-gnu/libpthread.so.0
#1  0x0000000000853a89 in reraise_fatal (signum=11) at
global/signal_handler.cc:58
#2  handle_fatal_signal (signum=11) at global/signal_handler.cc:104
#3  <signal handler called>
#4  0x00007f87b06a96f3 in do_malloc (size=388987616) at src/tcmalloc.cc:1059
#5  cpp_alloc (nothrow=false, size=388987616) at src/tcmalloc.cc:1354
#6  tc_new (size=388987616) at src/tcmalloc.cc:1530
#7  0x00007f87a60c89b0 in ?? ()
#8  0x00000000172f7ae0 in ?? ()
#9  0x00007f87b0459b21 in ?? () from /usr/lib/x86_64-linux-gnu/libleveldb.so.1
#10 0x00007f87b0456ba8 in ?? () from /usr/lib/x86_64-linux-gnu/libleveldb.so.1
#11 0x00007f87b04424d4 in ?? () from /usr/lib/x86_64-linux-gnu/libleveldb.so.1
#12 0x0000000000840977 in
LevelDBStore::LevelDBWholeSpaceIteratorImpl::lower_bound
(this=0x20910a20, prefix=..., to=...) at os/LevelDBStore.h:204
#13 0x000000000083f351 in LevelDBStore::get (this=<optimized out>,
prefix=..., keys=..., out=0x7f87a60c8d00) at os/LevelDBStore.cc:106
#14 0x0000000000838449 in DBObjectMap::_lookup_map_header
(this=this@entry=0x316d4a0, hoid=...) at os/DBObjectMap.cc:1080
#15 0x000000000083e4a9 in DBObjectMap::lookup_map_header
(this=this@entry=0x316d4a0, hoid=...) at os/DBObjectMap.h:404
#16 0x0000000000839e06 in DBObjectMap::rm_keys (this=0x316d4a0,
hoid=..., to_clear=..., spos=0x7f87a60c9400) at os/DBObjectMap.cc:696
#17 0x00000000007f40c1 in FileStore::_omap_rmkeys
(this=this@entry=0x3188000, cid=..., hoid=..., keys=..., spos=...) at
os/FileStore.cc:4765
#18 0x000000000080f610 in FileStore::_do_transaction
(this=this@entry=0x3188000, t=..., op_seq=op_seq@entry=4760123,
trans_num=trans_num@entry=0) at os/FileStore.cc:2595
#19 0x0000000000812999 in FileStore::_do_transactions
(this=this@entry=0x3188000, tls=..., op_seq=4760123,
handle=handle@entry=0x7f87a60c9b80) at os/FileStore.cc:2151
#20 0x0000000000812b2e in FileStore::_do_op (this=0x3188000,
osr=<optimized out>, handle=...) at os/FileStore.cc:1985
#21 0x00000000008f52ea in ThreadPool::worker (this=0x3188a08,
wt=0x319c3e0) at common/WorkQueue.cc:119
#22 0x00000000008f6590 in ThreadPool::WorkThread::entry
(this=<optimized out>) at common/WorkQueue.h:316
#23 0x00007f87b1486b50 in start_thread () from
/lib/x86_64-linux-gnu/libpthread.so.0
#24 0x00007f87af9c2a7d in clone () from /lib/x86_64-linux-gnu/libc.so.6
#25 0x0000000000000000 in ?? ()

Please let me know if can provide any other info to help find this bug.
/Emil
