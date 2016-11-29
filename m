From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: FW: Ceph dmClock
Date: Tue, 29 Nov 2016 13:59:54 -0500
Message-ID: <e2b99c22-ad7c-d0ae-6f9d-63c8d0322f20@redhat.com>
References: <116d5b63f1dc428998675dbe6e8c56eb@skt-tnetpmx1.SKT.AD>
 <38265764-574c-368c-6427-23330ac5dc66@redhat.com>
 <df8d1c8d93754dbcb30a01e4e6b00129@skt-tnetpmx1.SKT.AD>
 <0e9bcc68-cf57-ca5c-a0b9-26c635b78a59@redhat.com>
 <3f6258a2100e4218a15023b82b9a156a@skt-tnetpmx1.SKT.AD>
 <e3321edabb3d42f2881c3e1ca30ad5b2@skt-tnetpmx1.SKT.AD>
 <CAKk8r1BnqHJt-EtP+9xBUE=oA8taO9ak+CdJk6BrjdhzHT3Ukw@mail.gmail.com>
 <d3e52b41-47b9-c660-1c96-6383609719ca@redhat.com>
 <CAKk8r1BadDo7KCVL0eA09TBxYLTXmtHLqzH=Tc6m8zZAVebFfw@mail.gmail.com>
 <CAKk8r1Dw1MACKhOUfyhzv5dQX5Ae+9S1B9T99qXUOGmQ4HyzWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752844AbcK2S75 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 29 Nov 2016 13:59:57 -0500
In-Reply-To: <CAKk8r1Dw1MACKhOUfyhzv5dQX5Ae+9S1B9T99qXUOGmQ4HyzWA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Byung Su Park <pbs1108@gmail.com>
Cc: =?UTF-8?B?67CV67OR7IiY?= <bspark8@sk.com>, =?UTF-8?B?6rmA7YOc7JuFL1NEUyBUZWNoLiBMYWI=?= <taewoong.kim@sk.com>, =?UTF-8?B?7JeE7KO86rSAL1NEUyBUZWNoLiBMYWI=?= <jugwan.eom@sk.com>, =?UTF-8?B?6rmA7Iq566+8L1NEUyBUZWNoLiBMYWI=?= <seungminkim@sk.com>, Sage Weil <sweil@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Samuel Just <sjust@redhat.com>, ceph-devel@vger.kernel.org

Hi Byungsu,

That's great news. I will interleave responses and comments below.

On 11/27/2016 04:50 AM, Byung Su Park wrote:
> Dear Eric,
>
> Below is what we have done with Ceph QoS for the last several weeks.
>
> P1. (Completed & Pull Requesting) The integration of client service
> tracker & distributed environment factor Delta, Rho into the client
> LibRADOS and OSD.
> P2. (Tentative) The mapping & application of QoS parameter per Pool
> (LibRADOS) unit when running Ceph OSD upon the mclock operation queue.
> P3. (Tentative) The support of mclock hard limit functionality in Ceph
> OSD.
> P4. The simple test and result of QoS quality in Ceph upon the pool
> (LibRADOS) unit based mclock operation queue. (P1,P2,P3 were included).
>
> P1:
> We have completed P1 which was recommended by you and have been
> requesting Pull Request # 12193 at ceph dmclock integration branch.
> (https://github.com/ceph/ceph/tree/wip_dmclock2),
> (https://github.com/ceph/ceph/pull/12193).

I will spend time looking at the PR. I noticed that there were a couple
of Jenkins build issues.

> First, we have handled client_op (CEPH_MSG_OSD_OP (MOSDOp &
> MOSDOpReply)) to guarantee QoS between Ceph clients in the distributed
> environment.
> it would be great if we could get advice from you. And there are some
> topics related to P1.
>
> 1. Shard based QoS control
> : As we have talked about before, if we use the shard based QoS control,
> there are some considerations.
> The each OSD will have multiple dmClock queues, because current the
> default number of shard is 5.
> If the client doesn’t recognize shard’s presence, the problems will
> occur when handling constraint-based scheduling due to its real-time tag
> calculation method.
> Thus, once we adjusted ServiceTracker's server identifier type to a pair
> of (OSD ID, Shard index) in order to keep each dmClock queue’s real-time
> tag.
> But, this is not the complete solution. Because the each OSD can have a
> different number of shards, so the client should know the whole of each
> OSD’s the number of shards.
> (Or alternatively, multi-level queue: One dmClock queue is present
> before the shard based Op queues in OSD).
> (currently, the number of shards is derived from client’s configuration,
> osd_op_num_shards).

In the short-term as you validate this code Sam Just thinks you should
just configure the number of shards in each OSD to 1 (osd_op_num_shards).

For the longer-term there may be alternate solutions we can consider.
I'm guessing you're independently calculating the shard index on the
client side, which is why the client would have to know the number of
shards for each server. One possibility is to send in the response, in
addition to the phase in which scheduling took place, a sub-server index
(in our case a shard index, but we can make it more general). The
clients could combine that with the server to thus treat each shard as a
separate server. And I suspect with judicious use of C++ templates, we
can do this without incurring a cost when a sub-server index is not
necessary. So a client would only have to track shards that it actually
encounters and would not have to know details of each server.

> 2. The location of client service tracker (class ServiceTracker)
> : In this PR, we put the client service tracker class into Objecter
> class to minimize current code change.
> But, depending on the abstraction concept, it can be placed elsewhere
> such as IoCtxImpl class.

I will need to delve deeper to understand the implications of each.

> P2 & P3:
> : To guarantee QoS between Ceph clients, first we have focused on the
> pool (LibRADOS) unit based dmClock Ceph QoS.
> The information of cluster pool is saved at OSDMap and OSDMap is
> naturally managed by ceph cluster with its epoch.
> Thus we added pool related to QoS command such as “ceph osd pool set
> rbd0 mclock_res 4000.0” and added pool related to handling dmClock queue
> such as “mClockPoolQueue”.
> If you don’t mind, we want to share and discuss our concept and current
> implementation in the next time.

I would welcome the discussion.

> And also, we added dmClock hard limit functionality to Ceph cluster.
> Current pull based dmClock queue doesn’t support hard limit, thus to see
> dmClock based Ceph QoS quality easily, we have changed some codes.

This is something I've been thinking about. I look forward to examining
your solution.

> P4
> : To see current QoS quality between clients in the Ceph cluster with
> the pool (LibRADOS) unit based mclock operation queue, we did some tests.
> Although each the client’s moment IO variation was present, under some
> test conditions, a satisfactory QoS result came out in terms of the
> average value.
> (Note that, currently the some IO variation also appears at the default
> WPQ operation queue).
> (Also, additional experimentation and analysis is required with various
> test conditions and issues).
> The specific test environment and result are attached in additional pdf
> file.

The results look very impressive. I've seen the IO variation in my tests
as well, and it seems unlikely to be due to operation queuing.

> Thanks,
> Byungsu.

I look forward to going through your PR. Thank you for the work and for
the update.

Eric
