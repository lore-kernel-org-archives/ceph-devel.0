From: Sage Weil <sage@newdream.net>
Subject: Re: osd aborts, sync entry timeout and suicide timeout
Date: Mon, 6 Jul 2015 13:06:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507061304330.13991@cobra.newdream.net>
References: <BC97738F8E7C8742BABED7F06FB9DF91669B13F5@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36300 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbbGFUGW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Jul 2015 16:06:22 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91669B13F5@SATLEXDAG01.amd.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 6 Jul 2015, Deneau, Tom wrote:
> I had a small (4 nodes, 19 OSDs) cluster that I was running a sort of
> stress test on over the weekend.  Let's call the 4 nodes, A, B, C and
> D.  (Node A had the monitor running on it).
> 
> Anyway, node C died with a hardware problem, and, I think at about
> that same time two of the 5 osds on node B aborted with asserts.  The
> other 3 OSDS on node B carried on without problem as did the OSDS on
> nodes A and D.  And the client tests continued to run without error.
> 
> I attached the stack traces below from the aborting OSDs below.  If
> necessary, I can send the full osd logs (which include the dump of the
> 10000 most recent events).
> 
> I don't know enough about the ceph internals to know what these aborts
> really mean.  Have others seen these kinds of aborts before?  (I would
> assume these kinds of aborts are not normal).  Are they an indication
> of some kind of ceph configuration problem or build problem?  As can
> be seen I am running 9.0.1 which I built from sources for the aarch64
> platform.
> 
> -- Tom Deneau, AMD
> 
> 
> Aborting OSD #1
> ----------------
> 2015-07-03 20:27:47.013337 3ff7255efd0 -1 FileStore: sync_entry timed out after 600 seconds.
>  ceph version 9.0.1 (997b3f998d565a744bfefaaf34b08b891f8dbf64)
>  1: (Context::complete(int)+0x1c) [0x6cdbe4]
>  2: (SafeTimer::timer_thread()+0x320) [0xbfed58]
>  3: (SafeTimerThread::entry()+0x10) [0xc00af8]
>  4: (()+0x6ed4) [0x3ff7f456ed4]
>  5: (()+0xe08b0) [0x3ff7f0408b0]

There was a timeout when calling syncfs(2).  Looks like the disk 
connection or some other part of the IO subsystem gave out.  Check dmesg?

> 2015-07-03 20:27:47.022743 3ff7255efd0 -1 os/FileStore.cc: In function 'virtual void SyncEntryTimeout::finish(int)' thread 3ff7255efd0 time 2015-07-03 20:27:47.013404
> os/FileStore.cc: 3524: FAILED assert(0)
> 
>  ceph version 9.0.1 (997b3f998d565a744bfefaaf34b08b891f8dbf64)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8c) [0xc14b9c]
>  2: (SyncEntryTimeout::finish(int)+0xc4) [0x91552c]
>  3: (Context::complete(int)+0x1c) [0x6cdbe4]
>  4: (SafeTimer::timer_thread()+0x320) [0xbfed58]
>  5: (SafeTimerThread::entry()+0x10) [0xc00af8]
>  6: (()+0x6ed4) [0x3ff7f456ed4]
>  7: (()+0xe08b0) [0x3ff7f0408b0]
> 
> 
> Aborting OSD #2
> ----------------
> 2015-07-03 20:28:14.693496 3ff6d2eefd0 -1 common/HeartbeatMap.cc: In function 'bool ceph::HeartbeatMap::_check(const ceph::heartbeat_handle_d*, const char*, time_t)' thread 3ff6d2eefd0 time 2015-07-03 20:28:14.665989
> common/HeartbeatMapX.cc: 79: FAILED assert(0 == "hit suicide timeout")
> 
>  ceph version 9.0.1 (997b3f998d565a744bfefaaf34b08b891f8dbf64)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8c) [0xc14b9c]
>  2: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d const*, char const*, long)+0x328) [0xb5afc0]
>  3: (ceph::HeartbeatMap::reset_timeout(ceph::heartbeat_handle_d*, long, long)+0x19c) [0xb5b2b4]
>  4: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x6fc) [0xc06fdc]
>  5: (ShardedThreadPool::WorkThreadSharded::entry()+0x18) [0xc07a98]
>  6: (()+0x6ed4) [0x3ff85696ed4]
>  7: (()+0xe08b0) [0x3ff852808b0]

This is as similar stall/timeout: the worker thread got stuck doing 
something and didn't make any progress.  If you look at the core file 
you'll probably find it is blocked on a write(2) or fsync(2).  Again, 
check dmesg for block layer errors...

sage

