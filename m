From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: OSD is crashing during delete operation
Date: Wed, 17 Sep 2014 02:16:53 +0000
Message-ID: <755F6B91B3BE364F9BCA11EA3F9E0C6F27844D48@SACMBXIP02.sdcorp.global.sandisk.com>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2783E50B@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0081.outbound.protection.outlook.com ([157.56.111.81]:55057
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752801AbaIQCQ5 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Sep 2014 22:16:57 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Sage Weil	(sweil@redhat.com)" <sweil@redhat.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Created the following pull request for the fix.

https://github.com/ceph/ceph/pull/2510

Thanks & Regards
Somnath

-----Original Message-----
From: Somnath Roy 
Sent: Monday, September 15, 2014 3:26 PM
To: Sage Weil (sweil@redhat.com); Samuel Just (sam.just@inktank.com)
Cc: ceph-devel@vger.kernel.org
Subject: RE: OSD is crashing during delete operation

Sage/Sam,

I am able to reproduce this crash even with rados bench while deleting objects. I have raised the following tracker.

http://tracker.ceph.com/issues/9480

I have root caused it, it seems to be happening because one of my earlier changes :-( .. Here is the rot cause.

1. The FDCache.clear() and thus SharedLRU::clear() is not able to remove the object from SharedLRU::weak_refs since the FDCache ref is hold by some other threads. Assert is preventing the FD leak.

2. Now, only lfn_open() other than lfn_unlink() works with fdcache and fdcache.lookup() I removed earlier from the scope of Index lock as part of optimization. We thought in cache of Cache hit there is no need to call get_index() and lock it.

3. Moving fdcache.lookup within index lock seems to be fixing the issue.

4. Now, the logic is matching Firefly.

But, I am not sure whether this should prevent the FD leak in all scenarios. What about the following scenario.

1. Thread A, got the index write lock and got a hit in the fdcache. The FD is returned to the caller. The shared_ptr ref will be still 1.

2. By that time, Thread B tries to remove it from lfn_unlink(). Got the index write lock successfully and called fdcache.clear().

3. At this point, FDRef will not be deleted since thread A is working with it (ref = 1). This will result an assert if the FD is not removed before assert is checking for lookup. A valid race condition.

Somehow, I am not able to hit this scenario and I believe similar race condition are there in Firefly as well.

So, my question is, will the fix on lfn_open() be sufficient ?

Thanks & Regards
Somnath

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On Behalf Of Somnath Roy
Sent: Friday, September 12, 2014 2:02 PM
To: ceph-users@lists.ceph.com; Sage Weil (sweil@redhat.com)
Cc: ceph-devel@vger.kernel.org
Subject: [ceph-users] OSD is crashing during delete operation

Hi,

We are facing a crash while deleting large number of objects. Here is the trace.

2014-09-12 13:48:06.820524 7fb56596d700 -1 os/FDCache.h: In function 'void FDCache::clear(const ghobject_t&)' thread 7fb56596d700 time 2014-09-12 13:48:06.815407
os/FDCache.h: 89: FAILED assert(!registry[registry_id].lookup(hoid))

ceph version 0.84-998-gfcf8059 (fcf805972124dac1eae18b1cfd286790462b8ec8)
1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b) [0xa82a0b]
2: (FileStore::lfn_unlink(coll_t, ghobject_t const&, SequencerPosition const&, bool)+0x54b) [0x8918eb]
3: (FileStore::_remove(coll_t, ghobject_t const&, SequencerPosition const&)+0x8b) [0x891d8b]
4: (FileStore::_do_transaction(ObjectStore::Transaction&, unsigned long, int, ThreadPool::TPHandle*)+0x25ce) [0x8a0fae]
5: (FileStore::_do_transactions(std::list<ObjectStore::Transaction*, std::allocator<ObjectStore::Transaction*> >&, unsigned long, ThreadPool::TPHandle*)+0x44) [0x8a32a4]
6: (FileStore::_do_op(FileStore::OpSequencer*, ThreadPool::TPHandle&)+0x169) [0x8a3479]
7: (ThreadPool::worker(ThreadPool::WorkThread*)+0xac0) [0xa707b0]
8: (ThreadPool::WorkThread::entry()+0x10) [0xa72b30]
9: (()+0x7f6e) [0x7fb570cd7f6e]
10: (clone()+0x6d) [0x7fb56f2c59cd]

Is this a known issue ?

Thanks & Regards
Somnath


________________________________________

PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
