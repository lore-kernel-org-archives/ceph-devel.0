From: "J. Eric Ivancich" <ivancich@redhat.com>
Subject: Re: How best to integrate dmClock QoS library into ceph codebase
Date: Wed, 21 Jun 2017 17:04:36 -0400
Message-ID: <cca365ed-5b79-9a56-f683-9db271b842ff@redhat.com>
References: <6D8EA95A-572E-4C71-A6AF-6BB8A6E8B26C@redhat.com>
 <CAF1ivSaa=06CGGJRNQ_9QO_wy6Wc5yK4zbNFiHJLnoJJiqrCSg@mail.gmail.com>
 <f08daf3b-751a-6887-fce0-f5ab38097af4@redhat.com>
 <CAB7xdikG-Pc8DfX7VJv905ZdM8E8wXtfgw_4q693SeNnzDZ63g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:34407 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751130AbdFUVEi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jun 2017 17:04:38 -0400
Received: by mail-qt0-f172.google.com with SMTP id v20so51276381qtg.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jun 2017 14:04:38 -0700 (PDT)
In-Reply-To: <CAB7xdikG-Pc8DfX7VJv905ZdM8E8wXtfgw_4q693SeNnzDZ63g@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sheng,

I'll interleave responses below.

On 06/21/2017 01:38 PM, sheng qiu wrote:
> hi Eric,
> 
> we are pretty interested in your dmclock integration work with CEPH.
> After reading your pull request, i am a little confusing.
> May i ask if the setting in config such as
> osd_op_queue_mclock_client_op_res functioning in your added dmclock's
> queues and their enqueue and dequeue methods?

Yes, that (and related) configuration option is used. You'll see it
referenced in both src/osd/mClockOpClassQueue.cc and
src/osd/mClockClientQueue.cc.

Let me answer for mClockOpClassQueue, but the process is similar in
mClockClientQueue.

The configuration value is brought into an instance of
mClockOpClassQueue::mclock_op_tags_t. The variables
mClockOpClassQueue::mclock_op_tags holds a unique_ptr to a singleton of
that type. And then when a new operation is enqueued, the function
mClockOpClassQueue::op_class_client_info_f is called to determine its
mclock parameters at which time the value is used.

> the below enqueue function insert request into a map<priority,
> subqueue>, i guess for mclock_opclass queue, you set high priority for
> client op and lower for scrub, recovery, etc.
> Within each subqueue of same priority, did you do FIFO?
> 
> void enqueue_strict(K cl, unsigned priority, T item) override final {
>     high_queue[priority].enqueue(cl, 0, item);
> }

Yes, higher priority operations use a strict queue and lower priority
operations use mclock. That basic behavior was based on the two earlier
op queue implementations (src/common/WeightedPriorityQueue.h and
src/common/PrioritizedQueue.h). The priority value that's used as a
cut-off is determined by the configuration option osd_op_queue_cut_off
(which can be "low" or "high", which map to values CEPH_MSG_PRIO_LOW and
CEPH_MSG_PRIO_HIGH (defined in src/include/msgr.h); see function
OSD::get_io_prio_cut).

And those operations that end up in the high queue are handled strictly
-- higher priorities before lower priorities.

> I am appreciated if you can provide some comments, especially if i
> didn't understand correctly.

I hope that's helpful. Please let me know if you have further questions.

Eric
