From: Sage Weil <sage@newdream.net>
Subject: Re: mds crash in testing: e90a3b623
Date: Tue, 9 Nov 2010 09:47:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011090942570.14309@cobra.newdream.net>
References: <E1PFrzm-0001ZT-CV@tytso-glaptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43121 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab0KIRng (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Nov 2010 12:43:36 -0500
In-Reply-To: <E1PFrzm-0001ZT-CV@tytso-glaptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: ceph-devel@vger.kernel.org

On Tue, 9 Nov 2010, Theodore Ts'o wrote:
> 
> Hi there.  I tried building the latest in the testing branch (commit id
> e90a3b623), and things didn't go all that well.  Using a 2.6.36 client
> with commit d91f2438 reverted and the "ceph: fix small seq message
> skipping" comimt added, I was able to mount the test file system, but
> when I tried to list a directory in the ceph file system, the ls command
> hung forever.  Dmesg show that it was a problem communicating with
> mds0.  When I looked on that machine's log, I found the attached stack
> dump.

Was it a fresh file system, or something with data from before?

> I'm going to back off to 0.22.2, which worked much better for me, but I
> figured you'd probably be interested in the heads up.
> 
> Regards,
> 
> 					- Ted
> 
> mds/CInode.cc: In function 'void CInode::finish_scatter_gather_update(int)':
> mds/CInode.cc:1479: FAILED assert(pi->dirstat.size() >= 0)

I don't think think this code was touched in that branch since 0.22.2.  
However, it was heavily revised for 0.23, and all those changes are in the 
'rc' branch.  I think you'll have better luck there.

sage


>  ceph version 0.22.2 (commit:652417c19f5d18c70d5928e67f72c3770c3c57c5)
>  1: (CInode::finish_scatter_gather_update(int)+0x839) [0x8ee20d]
>  2: (Locker::scatter_writebehind(ScatterLock*)+0x237) [0x88b2f1]
>  3: (Locker::simple_sync(SimpleLock*, bool*)+0x350) [0x88a44e]
>  4: (Locker::_rdlock_kick(SimpleLock*)+0xc2) [0x87e30c]
>  5: (Locker::rdlock_start(SimpleLock*, MDRequest*, bool)+0x1dc) [0x87e778]
>  6: (Locker::acquire_locks(MDRequest*, std::set<SimpleLock*, std::less<SimpleLock*>, std::allocator<SimpleLock*> >&, std::set<SimpleLock*, std::less<SimpleLock*>, std::allocator<SimpleLock*> >&, std::set<SimpleLock*, std::less<SimpleLock*>, std::allocator<SimpleLock*> >&)+0x1b3d) [0x87be7f]
>  7: (Server::handle_client_stat(MDRequest*)+0x33b) [0x76d2a7]
>  8: (Server::dispatch_client_request(MDRequest*)+0x2a5) [0x767caf]
>  9: (Server::handle_client_request(MClientRequest*)+0x938) [0x7679f4]
>  10: (Server::dispatch(Message*)+0x358) [0x760680]
>  11: (MDS::_dispatch(Message*)+0x137a) [0x72c97e]
>  12: (MDS::ms_dispatch(Message*)+0x38) [0x72b48a]
>  13: (Messenger::ms_deliver_dispatch(Message*)+0x63) [0x716a2d]
>  14: (SimpleMessenger::dispatch_entry()+0x5d4) [0x707d46]
>  15: (SimpleMessenger::DispatchThread::entry()+0x2c) [0x6fcd40]
>  16: (Thread::_entry_func(void*)+0x23) [0x715935]
>  17: (()+0x6b9a) [0x2b1c972ccb9a]
>  18: (clone()+0x6d) [0x2b1c97cb253d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed to interpret this.
> *** Caught signal (ABRT) ***
>  ceph version 0.22.2 (commit:652417c19f5d18c70d5928e67f72c3770c3c57c5)
>  1: (ceph::BackTrace::BackTrace(int)+0x2d) [0x9d8e93]
>  2: (sigabrt_handler(int)+0x49) [0x9e8ffd]
>  3: (()+0x1e9e0) [0x2b1c97cab9e0]
>  4: (gsignal()+0x35) [0x2b1c97cc89f5]
>  5: (abort()+0x183) [0x2b1c97ccc413]
>  6: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x2b1c975a5275]
>  7: (()+0xbf696) [0x2b1c975a3696]
>  8: (()+0xbf6c3) [0x2b1c975a36c3]
>  9: (()+0xbf7c6) [0x2b1c975a37c6]
>  10: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x24f) [0x9d8ca4]
>  11: (CInode::finish_scatter_gather_update(int)+0x839) [0x8ee20d]
>  12: (Locker::scatter_writebehind(ScatterLock*)+0x237) [0x88b2f1]
>  13: (Locker::simple_sync(SimpleLock*, bool*)+0x350) [0x88a44e]
>  14: (Locker::_rdlock_kick(SimpleLock*)+0xc2) [0x87e30c]
>  15: (Locker::rdlock_start(SimpleLock*, MDRequest*, bool)+0x1dc) [0x87e778]
>  16: (Locker::acquire_locks(MDRequest*, std::set<SimpleLock*, std::less<SimpleLock*>, std::allocator<SimpleLock*> >&, std::set<SimpleLock*, std::less<SimpleLock*>, std::allocator<SimpleLock*> >&, std::set<SimpleLock*, std::less<SimpleLock*>, std::allocator<SimpleLock*> >&)+0x1b3d) [0x87be7f]
>  17: (Server::handle_client_stat(MDRequest*)+0x33b) [0x76d2a7]
>  18: (Server::dispatch_client_request(MDRequest*)+0x2a5) [0x767caf]
>  19: (Server::handle_client_request(MClientRequest*)+0x938) [0x7679f4]
>  20: (Server::dispatch(Message*)+0x358) [0x760680]
>  21: (MDS::_dispatch(Message*)+0x137a) [0x72c97e]
>  22: (MDS::ms_dispatch(Message*)+0x38) [0x72b48a]
>  23: (Messenger::ms_deliver_dispatch(Message*)+0x63) [0x716a2d]
>  24: (SimpleMessenger::dispatch_entry()+0x5d4) [0x707d46]
>  25: (SimpleMessenger::DispatchThread::entry()+0x2c) [0x6fcd40]
>  26: (Thread::_entry_func(void*)+0x23) [0x715935]
>  27: (()+0x6b9a) [0x2b1c972ccb9a]
>  28: (clone()+0x6d) [0x2b1c97cb253d]
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
