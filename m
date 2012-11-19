From: Samuel Just <sam.just@inktank.com>
Subject: Re: ceph-osd crashing (os/FileStore.cc: 4500: FAILED assert(replaying))
Date: Mon, 19 Nov 2012 15:43:40 -0800
Message-ID: <CA+4uBUZHfrDPf2Onx+EqA+LccoOugL1fKxR-ULc3LthT+Z0V6A@mail.gmail.com>
References: <50A559AF.7000009@profihost.ag>
	<CA+4uBUZj=za70Lnp=-0chnQ-2brN3sdrber+q5RM-H7E=Cy-NA@mail.gmail.com>
	<50AAC346.5090601@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37439 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab2KSXnl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 18:43:41 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so1808849vcm.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 15:43:40 -0800 (PST)
In-Reply-To: <50AAC346.5090601@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Can you restart one of the affected osds with debug osd = 20, debug
filestore = 20, debug ms = 1 and post the log?
-Sam

On Mon, Nov 19, 2012 at 3:39 PM, Stefan Priebe <s.priebe@profihost.ag> wrote:
> Am 20.11.2012 00:39, schrieb Samuel Just:
>
>> Seems to be a truncated log file...  That usually indicates filesystem
>> corruption.  Anything in dmesg?
>> -Sam
>
> No. Everything fine.
>
>
>
>> On Thu, Nov 15, 2012 at 1:07 PM, Stefan Priebe <s.priebe@profihost.ag>
>> wrote:
>>>
>>> Hello list,
>>>
>>> actual master incl. upstream/wip-fd-simple-cache results in this crash
>>> when
>>> i try to start some of my osds (others work fine) today on multiple
>>> nodes:
>>>
>>>      -2> 2012-11-15 22:04:09.226945 7f3af1c7a780  0 osd.52 pg_epoch: 657
>>> pg[3.3b( v 632'823 (632'823,632'823] n=5 ec=17 les/c 18/18 656/656/17) []
>>> r=0 lpr=0 pi=17-655/2 (info mismatch, log(632'823,0'0]) (log bound
>>> mismatch,
>>> empty) lcod 0'0 mlcod 0'0 inactive] Got exception 'read_log_error:
>>> read_log
>>> got 0 bytes, expected 126086-0=126086' while reading log. Moving
>>> corrupted
>>> log file to 'corrupt_log_2012-11-15_22:04_3.3b' for later analysis.
>>>      -1> 2012-11-15 22:04:09.233563 7f3af1c7a780  0 osd.52 pg_epoch: 657
>>> pg[3.557( v 632'753 (0'0,632'753] n=2 ec=17 les/c 18/18 656/656/17) []
>>> r=0
>>> lpr=0 pi=17-655/2 (info mismatch, log(0'0,0'0]) lcod 0'0 mlcod 0'0
>>> inactive]
>>> Got exception 'read_log_error: read_log got 0 bytes, expected
>>> 115488-0=115488' while reading log. Moving corrupted log file to
>>> 'corrupt_log_2012-11-15_22:04_3.557' for later analysis.
>>>       0> 2012-11-15 22:04:09.234536 7f3ae87d0700 -1 os/FileStore.cc: In
>>> function 'int FileStore::_collection_add(coll_t, coll_t, const
>>> hobject_t&,
>>> const SequencerPosition&)' thread 7f3ae87d0700 time 2012-11-15
>>> 22:04:09.233672
>>> os/FileStore.cc: 4500: FAILED assert(replaying)
>>>
>>>   ceph version 0.54-607-gf89e101
>>> (f89e1012bafabd6875a4a1e1832d76ffdf45b039)
>>>   1: (FileStore::_collection_add(coll_t, coll_t, hobject_t const&,
>>> SequencerPosition const&)+0x77d) [0x72ff0d]
>>>   2: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned
>>> long,
>>> int)+0x25fb) [0x73481b]
>>>   3: (FileStore::do_transactions(std::list<ObjectStore::Transaction*,
>>> std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x4c)
>>> [0x73952c]
>>>   4: (FileStore::_do_op(FileStore::OpSequencer*)+0x195) [0x705c45]
>>>   5: (ThreadPool::worker(ThreadPool::WorkThread*)+0x82b) [0x830f1b]
>>>   6: (ThreadPool::WorkThread::entry()+0x10) [0x833700]
>>>   7: (()+0x68ca) [0x7f3af16578ca]
>>>   8: (clone()+0x6d) [0x7f3aefac6bfd]
>>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>> needed to
>>> interpret this.
>>>
>>> --- logging levels ---
>>>     0/ 5 none
>>>     0/ 0 lockdep
>>>     0/ 0 context
>>>     0/ 0 crush
>>>     1/ 5 mds
>>>     1/ 5 mds_balancer
>>>     1/ 5 mds_locker
>>>     1/ 5 mds_log
>>>     1/ 5 mds_log_expire
>>>     1/ 5 mds_migrator
>>>     0/ 0 buffer
>>>     0/ 0 timer
>>>     0/ 1 filer
>>>     0/ 1 striper
>>>     0/ 1 objecter
>>>     0/ 5 rados
>>>     0/ 5 rbd
>>>     0/ 0 journaler
>>>     0/ 5 objectcacher
>>>     0/ 5 client
>>>     0/ 0 osd
>>>     0/ 0 optracker
>>>     0/ 0 objclass
>>>     0/ 0 filestore
>>>     0/ 0 journal
>>>     0/ 0 ms
>>>     1/ 5 mon
>>>     0/ 0 monc
>>>     0/ 5 paxos
>>>     0/ 0 tp
>>>     0/ 0 auth
>>>     1/ 5 crypto
>>>     0/ 0 finisher
>>>     0/ 0 heartbeatmap
>>>     0/ 0 perfcounter
>>>     1/ 5 rgw
>>>     1/ 5 hadoop
>>>     1/ 5 javaclient
>>>     0/ 0 asok
>>>     0/ 0 throttle
>>>    -2/-2 (syslog threshold)
>>>    -1/-1 (stderr threshold)
>>>    max_recent     10000
>>>    max_new      1000000
>>>    log_file /var/log/ceph/ceph-osd.52.log
>>> --- end dump of recent events ---
>>> 2012-11-15 22:04:09.235734 7f3ae87d0700 -1 *** Caught signal (Aborted) **
>>>   in thread 7f3ae87d0700
>>>
>>>   ceph version 0.54-607-gf89e101
>>> (f89e1012bafabd6875a4a1e1832d76ffdf45b039)
>>>   1: /usr/bin/ceph-osd() [0x799769]
>>>   2: (()+0xeff0) [0x7f3af165fff0]
>>>   3: (gsignal()+0x35) [0x7f3aefa29215]
>>>   4: (abort()+0x180) [0x7f3aefa2c020]
>>>   5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f3af02bddc5]
>>>   6: (()+0xcb166) [0x7f3af02bc166]
>>>   7: (()+0xcb193) [0x7f3af02bc193]
>>>   8: (()+0xcb28e) [0x7f3af02bc28e]
>>>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>> const*)+0x7c9) [0x7fd069]
>>>   10: (FileStore::_collection_add(coll_t, coll_t, hobject_t const&,
>>> SequencerPosition const&)+0x77d) [0x72ff0d]
>>>   11: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned
>>> long,
>>> int)+0x25fb) [0x73481b]
>>>   12: (FileStore::do_transactions(std::list<ObjectStore::Transaction*,
>>> std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x4c)
>>> [0x73952c]
>>>   13: (FileStore::_do_op(FileStore::OpSequencer*)+0x195) [0x705c45]
>>>   14: (ThreadPool::worker(ThreadPool::WorkThread*)+0x82b) [0x830f1b]
>>>   15: (ThreadPool::WorkThread::entry()+0x10) [0x833700]
>>>   16: (()+0x68ca) [0x7f3af16578ca]
>>>   17: (clone()+0x6d) [0x7f3aefac6bfd]
>>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>> needed to
>>> interpret this.
>>>
>>> --- begin dump of recent events ---
>>>       0> 2012-11-15 22:04:09.235734 7f3ae87d0700 -1 *** Caught signal
>>> (Aborted) **
>>>   in thread 7f3ae87d0700
>>>
>>>   ceph version 0.54-607-gf89e101
>>> (f89e1012bafabd6875a4a1e1832d76ffdf45b039)
>>>   1: /usr/bin/ceph-osd() [0x799769]
>>>   2: (()+0xeff0) [0x7f3af165fff0]
>>>   3: (gsignal()+0x35) [0x7f3aefa29215]
>>>   4: (abort()+0x180) [0x7f3aefa2c020]
>>>   5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f3af02bddc5]
>>>   6: (()+0xcb166) [0x7f3af02bc166]
>>>   7: (()+0xcb193) [0x7f3af02bc193]
>>>   8: (()+0xcb28e) [0x7f3af02bc28e]
>>>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>>> const*)+0x7c9) [0x7fd069]
>>>   10: (FileStore::_collection_add(coll_t, coll_t, hobject_t const&,
>>> SequencerPosition const&)+0x77d) [0x72ff0d]
>>>   11: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned
>>> long,
>>> int)+0x25fb) [0x73481b]
>>>   12: (FileStore::do_transactions(std::list<ObjectStore::Transaction*,
>>> std::allocator<ObjectStore::Transaction*> >&, unsigned long)+0x4c)
>>> [0x73952c]
>>>   13: (FileStore::_do_op(FileStore::OpSequencer*)+0x195) [0x705c45]
>>>   14: (ThreadPool::worker(ThreadPool::WorkThread*)+0x82b) [0x830f1b]
>>>   15: (ThreadPool::WorkThread::entry()+0x10) [0x833700]
>>>   16: (()+0x68ca) [0x7f3af16578ca]
>>>   17: (clone()+0x6d) [0x7f3aefac6bfd]
>>>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>>> needed to
>>> interpret this.
>>>
>>> --- logging levels ---
>>>     0/ 5 none
>>>     0/ 0 lockdep
>>>     0/ 0 context
>>>     0/ 0 crush
>>>     1/ 5 mds
>>>     1/ 5 mds_balancer
>>>     1/ 5 mds_locker
>>>     1/ 5 mds_log
>>>     1/ 5 mds_log_expire
>>>     1/ 5 mds_migrator
>>>     0/ 0 buffer
>>>     0/ 0 timer
>>>     0/ 1 filer
>>>     0/ 1 striper
>>>     0/ 1 objecter
>>>     0/ 5 rados
>>>     0/ 5 rbd
>>>     0/ 0 journaler
>>>     0/ 5 objectcacher
>>>     0/ 5 client
>>>     0/ 0 osd
>>>     0/ 0 optracker
>>>     0/ 0 objclass
>>>     0/ 0 filestore
>>>     0/ 0 journal
>>>     0/ 0 ms
>>>     1/ 5 mon
>>>     0/ 0 monc
>>>     0/ 5 paxos
>>>     0/ 0 tp
>>>     0/ 0 auth
>>>     1/ 5 crypto
>>>     0/ 0 finisher
>>>     0/ 0 heartbeatmap
>>>     0/ 0 perfcounter
>>>     1/ 5 rgw
>>>     1/ 5 hadoop
>>>     1/ 5 javaclient
>>>     0/ 0 asok
>>>     0/ 0 throttle
>>>    -2/-2 (syslog threshold)
>>>    -1/-1 (stderr threshold)
>>>    max_recent     10000
>>>    max_new      1000000
>>>    log_file /var/log/ceph/ceph-osd.52.log
>>> --- end dump of recent events ---
>>>
>>> Stefan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
