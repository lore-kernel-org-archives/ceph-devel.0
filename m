From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: How best to integrate dmClock QoS library into ceph codebase
Date: Tue, 27 Jun 2017 14:21:01 -0700
Message-ID: <CAB7xdimrWXD7CnEM_yqzO9BzTrwXBq-FyZ2aLcXZL+3m2Z9_Rw@mail.gmail.com>
References: <6D8EA95A-572E-4C71-A6AF-6BB8A6E8B26C@redhat.com>
 <CAF1ivSaa=06CGGJRNQ_9QO_wy6Wc5yK4zbNFiHJLnoJJiqrCSg@mail.gmail.com>
 <f08daf3b-751a-6887-fce0-f5ab38097af4@redhat.com> <CAB7xdikG-Pc8DfX7VJv905ZdM8E8wXtfgw_4q693SeNnzDZ63g@mail.gmail.com>
 <cca365ed-5b79-9a56-f683-9db271b842ff@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33980 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753411AbdF0VVD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jun 2017 17:21:03 -0400
Received: by mail-qk0-f172.google.com with SMTP id d78so36257746qkb.1
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 14:21:02 -0700 (PDT)
In-Reply-To: <cca365ed-5b79-9a56-f683-9db271b842ff@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "J. Eric Ivancich" <ivancich@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Eric,

i am appreciated to your kind reply.

In our test, we set the following in the ceph.conf:

osd_op_queue = mclock_client
osd_op_queue_cut_off = high
osd_op_queue_mclock_client_op_lim = 100.0
osd_op_queue_mclock_client_op_res = 50.0
osd_op_num_shards = 1
osd_op_num_threads_per_shard = 1


in this setup, all io requests should go to one mclock_client queue
and using the mclock scheduling (osd_op_queue_cut_off = high).
we use fio for test, we set job=1, bs=4k, qd=1 or 16.

we are expecting the visible iops by fio should < 100, while we see a
much higher value.
Did we understand your work correctly? or did we miss anything?

Thanks,
Sheng



On Wed, Jun 21, 2017 at 2:04 PM, J. Eric Ivancich <ivancich@redhat.com> wrote:
> Hi Sheng,
>
> I'll interleave responses below.
>
> On 06/21/2017 01:38 PM, sheng qiu wrote:
>> hi Eric,
>>
>> we are pretty interested in your dmclock integration work with CEPH.
>> After reading your pull request, i am a little confusing.
>> May i ask if the setting in config such as
>> osd_op_queue_mclock_client_op_res functioning in your added dmclock's
>> queues and their enqueue and dequeue methods?
>
> Yes, that (and related) configuration option is used. You'll see it
> referenced in both src/osd/mClockOpClassQueue.cc and
> src/osd/mClockClientQueue.cc.
>
> Let me answer for mClockOpClassQueue, but the process is similar in
> mClockClientQueue.
>
> The configuration value is brought into an instance of
> mClockOpClassQueue::mclock_op_tags_t. The variables
> mClockOpClassQueue::mclock_op_tags holds a unique_ptr to a singleton of
> that type. And then when a new operation is enqueued, the function
> mClockOpClassQueue::op_class_client_info_f is called to determine its
> mclock parameters at which time the value is used.
>
>> the below enqueue function insert request into a map<priority,
>> subqueue>, i guess for mclock_opclass queue, you set high priority for
>> client op and lower for scrub, recovery, etc.
>> Within each subqueue of same priority, did you do FIFO?
>>
>> void enqueue_strict(K cl, unsigned priority, T item) override final {
>>     high_queue[priority].enqueue(cl, 0, item);
>> }
>
> Yes, higher priority operations use a strict queue and lower priority
> operations use mclock. That basic behavior was based on the two earlier
> op queue implementations (src/common/WeightedPriorityQueue.h and
> src/common/PrioritizedQueue.h). The priority value that's used as a
> cut-off is determined by the configuration option osd_op_queue_cut_off
> (which can be "low" or "high", which map to values CEPH_MSG_PRIO_LOW and
> CEPH_MSG_PRIO_HIGH (defined in src/include/msgr.h); see function
> OSD::get_io_prio_cut).
>
> And those operations that end up in the high queue are handled strictly
> -- higher priorities before lower priorities.
>
>> I am appreciated if you can provide some comments, especially if i
>> didn't understand correctly.
>
> I hope that's helpful. Please let me know if you have further questions.
>
> Eric
