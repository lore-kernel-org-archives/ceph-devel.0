From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Fw:Assertion "needs_recovery" fails when balance_read reaches a
 replica OSD where the target object is not recovered yet.
Date: Mon, 28 Nov 2016 13:08:44 -0800
Message-ID: <CAJ4mKGbB--_Hfwze=JcA_6qyEqUQ7dS-PqduGPT8Y6D4SXo+uA@mail.gmail.com>
References: <4232dc21.6265.1589a3d146c.Coremail.xxhdx1985126@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35080 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753352AbcK1VIv (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Nov 2016 16:08:51 -0500
Received: by mail-io0-f172.google.com with SMTP id a124so253546909ioe.2
        for <ceph-devel@vger.kernel.org>; Mon, 28 Nov 2016 13:08:46 -0800 (PST)
In-Reply-To: <4232dc21.6265.1589a3d146c.Coremail.xxhdx1985126@163.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xxhdx1985126 <xxhdx1985126@163.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Nov 24, 2016 at 10:47 PM, xxhdx1985126 <xxhdx1985126@163.com> wrote:
> Hi, everyone.
>
> Can I bypass this problem by not using LIBRADOS_OPERATION_BALANCE_READS? Thank you:-)

Yes, I believe so. The balance reads option is not well-tested and
won't work for data which isn't already stable/persisted. It's really
intended for reading long-term immutable data like a Hadoop data
store.
-Greg

>
>
>
> -------- Forwarding messages --------
> From: "xxhdx1985126" <xxhdx1985126@163.com>
> Date: 2016-11-24 17:11:16
> To:  "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
> Subject: Assertion "needs_recovery" fails when balance_read reaches a replica OSD where the target object is not recovered yet.
> Hi, everyone.
>
> In our online system, some OSDs always fail due to the following error:
>
> 2016-10-25 19:00:00.626567 7f9a63bff700 -1 error_msg osd/ReplicatedPG.cc: In function 'void ReplicatedPG::wait_for_unreadable_object(const hobject_t&, OpRequestRef)' thread 7f9a63bff700 time 2016-10-25 19:00:00.624499
> osd/ReplicatedPG.cc: 387: FAILED assert(needs_recovery)
>
> ceph version 0.94.5-12-g83f56a1 (83f56a1c84e3dbd95a4c394335a7b1dc926dd1c4)
>  1: (ReplicatedPG::wait_for_unreadable_object(hobject_t const&, std::tr1::shared_ptr&lt;OpRequest&gt;)+0x3f5) [0x8b5a65]
>  2: (ReplicatedPG::do_op(std::tr1::shared_ptr&lt;OpRequest&gt;&)+0x5e9) [0x8f0c79]
>  3: (ReplicatedPG::do_request(std::tr1::shared_ptr&lt;OpRequest&gt;&, ThreadPool::TPHandle&)+0x4e3) [0x87fdc3]
>  4: (OSD::dequeue_op(boost::intrusive_ptr&lt;PG&gt;, std::tr1::shared_ptr&lt;OpRequest&gt;, ThreadPool::TPHandle&)+0x178) [0x66b3f8]
>  5: (OSD::ShardedOpWQ::_process(unsigned int, ceph::heartbeat_handle_d*)+0x59e) [0x66f8ee]
>  6: (ShardedThreadPool::shardedthreadpool_worker(unsigned int)+0x795) [0xa76d85]
>  7: (ShardedThreadPool::WorkThreadSharded::entry()+0x10) [0xa7a610]
>  8: /lib64/libpthread.so.0() [0x3471407a51]
>  9: (clone()+0x6d) [0x34710e893d]
>  NOTE: a copy of the executable, or `objdump -rdS &lt;executable&gt;` is needed to interpret this.
>
> Our verion of ceph is 0.94.5.
> After doing some reading of the source code and analysis of our online scenarios, we made some conjecture:
>        When encountering a large number of "balance_reads", the OSDs can be so busy that they can't send heartbeats in time, which could lead to monitors wrongly mark them down and triggers other OSDs to go through peering+recovery+process during which, on the replica OSDs, the assertion "needs_recovery" at ReplicatedPG.cc:387 has a large probability to fail.
>
> To confirm this guess, we did some designated test. If I write extra code to make the recovery of some object wait for those ops targeting that object with the type "CEPH_MSG_OSD_OP"  to finish, the assertion "needs_recovery" at ReplicatedPG.cc:387 will always fail. And on the other hand, if I make those ops targeting some object with the type "CEPH_MSG_OSD_OP" wait for the corresponding recovery to finish, the assertion won't be triggered.
>
> Can we come to the conclusion that the cause to the assertion failure is just as we thought? And, it seems that the purpose of the failed assertion is to make sure that the "missing_loc.needs_recovery_map" do contain the unreadable object. However, "missing_loc.needs_recovery_map" seems to be always empty on replica OSDs. Can we fix this problem simply by bypassing this assertion in some way like:
>               if ( is_primary() ){
>                       bool needs_recovery = missing_loc.needs_recovery(soid, &v);
>                       assert(needs_recovery);
>                }
>
> I've also submit a new issue: BUG #18021. Please help me. Thank you:-)
