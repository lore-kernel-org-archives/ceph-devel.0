From: Sage Weil <sweil@redhat.com>
Subject: ObjectStore::Transaction::append()
Date: Mon, 12 Jan 2015 17:54:44 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1501121752440.17428@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37132 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbbAMByr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 12 Jan 2015 20:54:47 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: yuandong1222@gmail.com
Cc: ceph-devel@vger.kernel.org

Hi Dong,

We hit a failed assert in Transaction::append():

	http://tracker.ceph.com/issues/10517

    2> 2015-01-08 00:48:19.737753 7f6a6a4b0700  0 - 10.214.132.32:6801/6381 >> 10.214.134.104:6801/5896 pipe(0x415a000 sd=116 :6801 s=2 pgs=1750 cs=642 l=0 c=0x40fd020).injecting socket failure
    1> 2015-01-08 00:48:19.737804 7f6a6a4b0700  0 - 10.214.132.32:6801/6381 >> 10.214.134.104:6801/5896 pipe(0x415a000 sd=116 :6801 s=2 pgs=1750 cs=642 l=0 c=0x40fd020).fault with nothing to send, going to standby
    0> 2015-01-08 00:48:19.738557 7f6a719ca700 1 ./os/ObjectStore.h: In function 'void ObjectStore::Transaction::_update_op(ObjectStore::Transaction::Op*, std::vector&lt;unsigned int&gt;&, std::vector&lt;unsigned int&gt;&)' 
thread 7f6a719ca700 time 2015-01-08 00:48:19.732855
./os/ObjectStore.h: 598: FAILED assert(op>oid < om.size())
ceph version 0.90-793-g5f48d50 (5f48d505ab8a08832a65f449c7b927047c910cf9)
 1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b) [0xba5f3b]
 2: (ObjectStore::Transaction::append(ObjectStore::Transaction&)+0x772) [0x8ca2f2]
 3: (ECBackend::handle_sub_write(pg_shard_t, std::tr1::shared_ptr&lt;OpRequest&gt;, ECSubWrite&, Context*)+0x480) [0xa1fae0]
 4: (ECBackend::handle_message(std::tr1::shared_ptr&lt;OpRequest&gt;)+0x2ba) [0xa2a59a]
 5: (ReplicatedPG::do_request(std::tr1::shared_ptr&lt;OpRequest&gt;&, ThreadPool::TPHandle&)+0x23b) [0x8320bb]
 6: (OSD::dequeue_op(boost::intrusive_ptr&lt;PG&gt;, std::tr1::shared_ptr&lt;OpRequest&gt;, ThreadPool::TPHandle&)+0x3d5) [0x6955b5]
 7: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)+0x37b) [0x695b4b]
 8: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x821) [0xb96061]
 9: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0xb98170]
 10: (()+0x8182) [0x7f6a90246182]

Do you mind taking a look?

Thanks!
sage
