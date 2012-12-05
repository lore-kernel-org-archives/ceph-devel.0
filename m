From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: OSD crashed today in os/JournalingObjectStore.cc
Date: Wed, 05 Dec 2012 23:29:15 +0100
Message-ID: <50BFCABB.6080207@profihost.ag>
References: <50BF1A43.4060605@profihost.ag> <alpine.DEB.2.00.1212050639480.17270@cobra.newdream.net> <BC8B71E3-1BE1-49ED-B578-34A0CBACAB98@profihost.ag> <50BFC9BF.9050302@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:42194 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270Ab2LEW3O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Dec 2012 17:29:14 -0500
In-Reply-To: <50BFC9BF.9050302@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

this seems to happens since:
85574a3

Stefan

Am 05.12.2012 23:25, schrieb Stefan Priebe:
> Hello,
>
> i had now 8 OSDs failing again with the same error.
>
>       0> 2012-12-05 23:10:41.213149 7f7fad109700 -1
> os/JournalingObjectStore.cc: In function 'uint64_t
> JournalingObjectStore::ApplyManager::op_apply_start(uint64_t)' thread
> 7f7fad109700 time 2012-12-05 23:10:41.212454
> os/JournalingObjectStore.cc: 134: FAILED assert(op > committed_seq)
>
>   ceph version 0.55-142-g22f794d (22f794da074dd1b3221c484a5ae05b2ff1bd0fa4)
>   1: (JournalingObjectStore::ApplyManager::op_apply_start(unsigned
> long)+0x816) [0x747626]
>   2: (FileStore::_do_op(FileStore::OpSequencer*)+0x52) [0x703c22]
>   3: (ThreadPool::worker(ThreadPool::WorkThread*)+0x82b) [0x82f81b]
>   4: (ThreadPool::WorkThread::entry()+0x10) [0x832000]
>   5: (()+0x68ca) [0x7f7fc17a78ca]
>   6: (clone()+0x6d) [0x7f7fbfc16bfd]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> --- logging levels ---
>     0/ 5 none
>     0/ 0 lockdep
>     0/ 0 context
>     0/ 0 crush
>     1/ 5 mds
>     1/ 5 mds_balancer
>     1/ 5 mds_locker
>     1/ 5 mds_log
>     1/ 5 mds_log_expire
>     1/ 5 mds_migrator
>     0/ 0 buffer
>     0/ 0 timer
>     0/ 1 filer
>     0/ 1 striper
>     0/ 1 objecter
>     0/ 5 rados
>     0/ 5 rbd
>     0/ 0 journaler
>     0/ 5 objectcacher
>    0/ 5 client
>     0/ 0 osd
>     0/ 0 optracker
>     0/ 0 objclass
>     0/ 0 filestore
>     0/ 0 journal
>     0/ 0 ms
>     1/ 5 mon
>     0/ 0 monc
>     0/ 5 paxos
>     0/ 0 tp
>     0/ 0 auth
>     1/ 5 crypto
>     0/ 0 finisher
>     0/ 0 heartbeatmap
>     0/ 0 perfcounter
>     1/ 5 rgw
>     1/ 5 hadoop
>     1/ 5 rgw
>     1/ 5 hadoop
>     1/ 5 javaclient
>     0/ 0 asok
>     0/ 0 throttle
>    -2/-2 (syslog threshold)
>    -1/-1 (stderr threshold)
>    max_recent    100000
>    max_new         1000
>    log_file /var/log/ceph/ceph-osd.13.log
> --- end dump of recent events ---
> 2012-12-05 23:10:41.216011 7f7fad109700 -1 *** Caught signal (Aborted) **
>   in thread 7f7fad109700
>
>   ceph version 0.55-142-g22f794d (22f794da074dd1b3221c484a5ae05b2ff1bd0fa4)
>   1: /usr/bin/ceph-osd() [0x797bd9]
>   2: (()+0xeff0) [0x7f7fc17afff0]
>   3: (gsignal()+0x35) [0x7f7fbfb79215]
>   4: (abort()+0x180) [0x7f7fbfb7c020]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f7fc040ddc5]
>   6: (()+0xcb166) [0x7f7fc040c166]
>   7: (()+0xcb193) [0x7f7fc040c193]
>   8: (()+0xcb28e) [0x7f7fc040c28e]
>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x7c9) [0x7fb939]
>   10: (JournalingObjectStore::ApplyManager::op_apply_start(unsigned
> long)+0x816) [0x747626]
>   11: (FileStore::_do_op(FileStore::OpSequencer*)+0x52) [0x703c22]
>   12: (ThreadPool::worker(ThreadPool::WorkThread*)+0x82b) [0x82f81b]
>   13: (ThreadPool::WorkThread::entry()+0x10) [0x832000]
>   14: (()+0x68ca) [0x7f7fc17a78ca]
>   15: (clone()+0x6d) [0x7f7fbfc16bfd]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> --- begin dump of recent events ---
>       0> 2012-12-05 23:10:41.216011 7f7fad109700 -1 *** Caught signal
> (Aborted) **
>   in thread 7f7fad109700
>
>   ceph version 0.55-142-g22f794d (22f794da074dd1b3221c484a5ae05b2ff1bd0fa4)
>   1: /usr/bin/ceph-osd() [0x797bd9]
>   2: (()+0xeff0) [0x7f7fc17afff0]
>   3: (gsignal()+0x35) [0x7f7fbfb79215]
>   4: (abort()+0x180) [0x7f7fbfb7c020]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f7fc040ddc5]
>   6: (()+0xcb166) [0x7f7fc040c166]
>   7: (()+0xcb193) [0x7f7fc040c193]
>   8: (()+0xcb28e) [0x7f7fc040c28e]
>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x7c9) [0x7fb939]
>   10: (JournalingObjectStore::ApplyManager::op_apply_start(unsigned
> long)+0x816) [0x747626]
>   11: (FileStore::_do_op(FileStore::OpSequencer*)+0x52) [0x703c22]
>   12: (ThreadPool::worker(ThreadPool::WorkThread*)+0x82b) [0x82f81b]
>   13: (ThreadPool::WorkThread::entry()+0x10) [0x832000]
>   14: (()+0x68ca) [0x7f7fc17a78ca]
>   15: (clone()+0x6d) [0x7f7fbfc16bfd]
>   NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>
> --- logging levels ---
>     0/ 5 none
>     0/ 0 lockdep
>     0/ 0 context
>     0/ 0 crush
>     1/ 5 mds
>     1/ 5 mds_balancer
>     1/ 5 mds_locker
>     1/ 5 mds_log
>     1/ 5 mds_log_expire
>     1/ 5 mds_migrator
>     0/ 0 buffer
>     0/ 0 timer
>     0/ 1 filer
>     0/ 1 striper
>     0/ 1 objecter
>     0/ 5 rados
>     0/ 5 rbd
>     0/ 0 journaler
>     0/ 5 objectcacher
>     0/ 5 client
>     0/ 0 osd
>     0/ 0 optracker
>     0/ 0 objclass
>     0/ 0 filestore
>     0/ 0 journal
>     0/ 0 ms
>     1/ 5 mon
>     0/ 0 monc
>     0/ 5 paxos
>     0/ 0 tp
>     0/ 0 auth
>     1/ 5 crypto
>     0/ 0 finisher
>     0/ 0 heartbeatmap
>     0/ 0 perfcounter
>     1/ 5 rgw
>     1/ 5 hadoop
>     1/ 5 javaclient
>     0/ 0 asok
>     0/ 0 throttle
>    -2/-2 (syslog threshold)
>    -1/-1 (stderr threshold)
>    max_recent    100000
>    max_new         1000
>    log_file /var/log/ceph/ceph-osd.13.log
> --- end dump of recent events ---
>
> Stefan
> Am 05.12.2012 17:05, schrieb Stefan Priebe - Profihost AG:
>> There was a dump in the attached log.
>>
>> Stefan
>>
>> Am 05.12.2012 um 15:41 schrieb Sage Weil <sage@inktank.com>:
>>
>>> On Wed, 5 Dec 2012, Stefan Priebe - Profihost AG wrote:
>>>> Hello list,
>>>>
>>>> i updated to latest next from today and then after 20 minutes an OSD
>>>> was
>>>> crashing in os/JournalingObjectStore.cc.
>>>>
>>>> Attached is the log.
>>>
>>> Hmm, this is perplexing.  It might just be a bad assert, but I can't see
>>> how it could happen.  Any chance you can reproduce with
>>>
>>>     debug journal = 0/10
>>>
>>> in the [osd] section?  That will give us a dump if it fails the assert.
>>>
>>> Thanks!
>>> s
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
