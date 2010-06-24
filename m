From: Sage Weil <sage@newdream.net>
Subject: Re: mds: assertion failed - CEPH_LOCK_DVERSION is not handled in
 SimpleLock::get_wait_shift()
Date: Thu, 24 Jun 2010 10:59:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006241059440.30180@cobra.newdream.net>
References: <AANLkTimpDBwpYFRPv7t-1PmCmIuUkFOqm5I8zNEDhVq1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53526 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341Ab0FXR6o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jun 2010 13:58:44 -0400
In-Reply-To: <AANLkTimpDBwpYFRPv7t-1PmCmIuUkFOqm5I8zNEDhVq1@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

Hi Henry,

I just pushed a fix for this.  Thanks!

sage


On Thu, 24 Jun 2010, Henry C Chang wrote:

> Hello,
> 
> I got the assertion failure today.
> CEPH_LOCK_DVERSION is not handled in SimpleLock::get_wait_shift().
> See below.
> 
> Henry C Chang
> 
> ===============================================
> 10.06.24_17:31:20.240843 7fb72ba4b710 mds0.locker local_xlock_start
> on (dversion lock w=1 last_client=4105) on [dentry
> #1/ceph-0.19.1/conftest.o.wygclK [2,head] auth NULL (dn xlockdone x=1)
> (dversion lock w=1 last_client=4105) pv=6467 v=6464 inode=0 | request
> lock authpin 0x7fb7251fb610]
> mds/SimpleLock.h: In function 'int SimpleLock::get_wait_shift()':
> mds/SimpleLock.h:236: FAILED assert(0)
>  1: (SimpleLock::get_wait_shift()+0xc2) [0x7707e8]
>  2: (SimpleLock::add_waiter(unsigned long, Context*)+0x33) [0x77094b]
>  3: (Locker::local_xlock_start(LocalLock*, MDRequest*)+0xf1) [0x866ab9]
>  4: (Locker::xlock_start(SimpleLock*, MDRequest*)+0x80) [0x85ac10]
>  5: (Locker::acquire_locks(MDRequest*, std::set<SimpleLock*,
> std::less<SimpleLock*>, std::allocator<SimpleLock*> >&,
> std::set<SimpleLock*, std::less<SimpleLock*>,
> std::allocator<SimpleLock*> >&, std::set<SimpleLock*,
> std::less<SimpleLock*>, std::allocator<SimpleLock*> >&)+0x1961)
> [0x857b8f]
>  6: (Server::handle_client_rename(MDRequest*)+0x17f2) [0x7619fe]
>  7: (Server::dispatch_client_request(MDRequest*)+0x40d) [0x74dce5]
>  8: (MDCache::dispatch_request(MDRequest*)+0xb9) [0x7db1db]
>  9: (C_MDS_RetryRequest::finish(int)+0x2a) [0x778c58]
>  10: (finish_contexts(std::list<Context*, std::allocator<Context*> >&,
> int)+0x1b5) [0x71762b]
>  11: (MDSCacheObject::finish_waiting(unsigned long, int)+0x55) [0x76f1d3]
>  12: (SimpleLock::finish_waiters(unsigned long, int)+0x47) [0x770911]
>  13: (Locker::eval_gather(SimpleLock*, bool, bool*)+0xf95) [0x8592c5]
>  14: (Locker::handle_simple_lock(SimpleLock*, MLock*)+0x589) [0x863d71]
>  15: (Locker::handle_lock(MLock*)+0x193) [0x863759]
>  16: (Locker::dispatch(Message*)+0x45) [0x855e75]
>  17: (MDS::_dispatch(Message*)+0x1aa4) [0x714622]
>  18: (MDS::ms_dispatch(Message*)+0x38) [0x712a04]
>  19: (Messenger::ms_deliver_dispatch(Message*)+0x63) [0x6fe003]
>  20: (SimpleMessenger::dispatch_entry()+0x5fd) [0x6ef3fb]
>  21: (SimpleMessenger::DispatchThread::entry()+0x2c) [0x6e41be]
>  22: (Thread::_entry_func(void*)+0x23) [0x6fc88d]
>  23: /lib64/libpthread.so.0() [0x3552e06a3a]
>  24: (clone()+0x6d) [0x35526ddf3d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
