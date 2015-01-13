From: Dong Yuan <yuandong1222@gmail.com>
Subject: Re: ObjectStore::Transaction::append()
Date: Tue, 13 Jan 2015 10:34:48 +0800
Message-ID: <CAMm-wcLdKHF23OhZxogR6m+f-eao2nFKaTTs3AUZG4rKKZ4uCQ@mail.gmail.com>
References: <alpine.DEB.2.00.1501121752440.17428@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:55265 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938AbbAMCet (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jan 2015 21:34:49 -0500
Received: by mail-vc0-f182.google.com with SMTP id hq12so140792vcb.13
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jan 2015 18:34:48 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501121752440.17428@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

OK.

I roughly checked the problem, it seems to be the same problem which I
met in RPGBackend, and that is why use op_t.append(local_t) instead of
local_t.append(op_t).

Is there any way to reproduce the problem? So I make a patch for the problem.

On 13 January 2015 at 09:54, Sage Weil <sweil@redhat.com> wrote:
> Hi Dong,
>
> We hit a failed assert in Transaction::append():
>
>         http://tracker.ceph.com/issues/10517
>
>     2> 2015-01-08 00:48:19.737753 7f6a6a4b0700  0 - 10.214.132.32:6801/6381 >> 10.214.134.104:6801/5896 pipe(0x415a000 sd=116 :6801 s=2 pgs=1750 cs=642 l=0 c=0x40fd020).injecting socket failure
>     1> 2015-01-08 00:48:19.737804 7f6a6a4b0700  0 - 10.214.132.32:6801/6381 >> 10.214.134.104:6801/5896 pipe(0x415a000 sd=116 :6801 s=2 pgs=1750 cs=642 l=0 c=0x40fd020).fault with nothing to send, going to standby
>     0> 2015-01-08 00:48:19.738557 7f6a719ca700 1 ./os/ObjectStore.h: In function 'void ObjectStore::Transaction::_update_op(ObjectStore::Transaction::Op*, std::vector&lt;unsigned int&gt;&, std::vector&lt;unsigned int&gt;&)'
> thread 7f6a719ca700 time 2015-01-08 00:48:19.732855
> ./os/ObjectStore.h: 598: FAILED assert(op>oid < om.size())
> ceph version 0.90-793-g5f48d50 (5f48d505ab8a08832a65f449c7b927047c910cf9)
>  1: (ceph::__ceph_assert_fail(char const*, char const*, int, char const*)+0x8b) [0xba5f3b]
>  2: (ObjectStore::Transaction::append(ObjectStore::Transaction&)+0x772) [0x8ca2f2]
>  3: (ECBackend::handle_sub_write(pg_shard_t, std::tr1::shared_ptr&lt;OpRequest&gt;, ECSubWrite&, Context*)+0x480) [0xa1fae0]
>  4: (ECBackend::handle_message(std::tr1::shared_ptr&lt;OpRequest&gt;)+0x2ba) [0xa2a59a]
>  5: (ReplicatedPG::do_request(std::tr1::shared_ptr&lt;OpRequest&gt;&, ThreadPool::TPHandle&)+0x23b) [0x8320bb]
>  6: (OSD::dequeue_op(boost::intrusive_ptr&lt;PG&gt;, std::tr1::shared_ptr&lt;OpRequest&gt;, ThreadPool::TPHandle&)+0x3d5) [0x6955b5]
>  7: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)+0x37b) [0x695b4b]
>  8: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x821) [0xb96061]
>  9: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0xb98170]
>  10: (()+0x8182) [0x7f6a90246182]
>
> Do you mind taking a look?
>
> Thanks!
> sage



-- 
Dong Yuan
Email:yuandong1222@gmail.com
