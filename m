From: Dan van der Ster <daniel.vanderster@cern.ch>
Subject: Re: Scrub / SnapTrim IO Prioritization and Latency
Date: Thu, 30 Oct 2014 18:25:20 +0000
Message-ID: <270a47c4d1bb9e0e716cdda6347b70b0@webmail.vanderster.com>
References: <CA+4uBUZJG12_YWXrVA6eQkKnFG=+ovfptTKwAg7fDZeMrWhQdw@mail.gmail.com>
 <5d451bfe7cfaf298e6cd3fccd2910f2d@webmail.vanderster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:20821 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758773AbaJ3SZX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 14:25:23 -0400
In-Reply-To: <CA+4uBUZJG12_YWXrVA6eQkKnFG=+ovfptTKwAg7fDZeMrWhQdw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sam,
A few comments.

1. My understanding is that your new approach would treat the scrub/trim ops similarly to (or even exactly like?) how we treat recovery ops today. Is that right? Currently even with recovery op priority=1 and client op priority=63, recoveries are not even close to being transparent. It's anecdotal, but in our cluster we regularly have 30 OSDs scrubbing (out of ~900) and it is latency transparent. But if we have 10 OSDs backfilling that increases our 4kB write latency from ~40ms to ~60-80ms.

2. I get the impression that you're worried that the idle IO priority class leaves us at a risk of starving the disk thread completely. Except in extreme situations of an OSD that is 100% saturated with client IO for a very long time, that shouldn't happen. Suppose the client IOs account for a 30% duty cycle of a disk, then scrubbing can use the other 70%. Regardless of which IO priority or queuing we do, the scrubber will get 70% of time on the disk. But the important thing is that the client IOs need to be handled as close to real time as possible, whereas the scrubs can happen at any time. I don't believe ceph-level op queuing (with a single queue!) is enough to ensure this -- we also need to tell the kernel the priority of those (concurrent) IOs so it can preempt the unimportant scrub 
 reads with the urgent client IOs. My main point here is that (outside of the client IO saturation case), bytes scrubbed per second is more or less independent of IO priority!!!

3. Re: locks -- OK, I can't comment there. Perhaps those locks are the reason that scrubs are ever so slightly noticeable even when the IO priority of the disk thread is idle. But I contend that using separate threads -- or at least separate queues -- for the scrubs vs client ops is still a good idea. We can learn from how cfq prioritizes IOs, for example -- each of real time, best effort, and idle are implemented as a separate queue, and the be/idle queues are only processed if the rt/be queues are empty. (in testing I noticed that putting scrubs in be/7 (with client IOs left in be/4) is not nearly as effective as putting scrubs in the idle class -- what I conclude is using a single queue for both scrub/client IOs is not effective at reducing latency).

BTW, is the current whole-PG lock a necessary result of separating the client and disk queues/threads? Perhaps that can be improved another way...

4. Lastly, are you designing mainly for the 24/7 saturation scenario? I'm not sure that's a good idea -- IMHO long term saturation is a sign of a poorly dimensioned cluster. If OTOH a cluster is saturated for only 12 hours a day, I honestly don't want scrubs during those 12 hours; I'd rather they happen at night or whatever. I guess that is debatable, so you better have a configurable priority (which you have now!). For reference, btrfs scrub is idle by default [1], and zfs [2] operates similarly. (I can't confirm md raid scrubs with idle priority, but based on experience it is transparent). They all have knobs to increase the priority for admins with saturated servers. So I don't see why the Ceph default should not be idle (and I worry that you'd even remove the idle scrub capability).

In any case, I just wanted raise this issue so that you might consider them in your implementation. If I can be of any help at all in testing or giving feedback please don't hesitate to let me know.

Best Regards,
Dan

[1] https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs-scrub
[2] http://serverfault.com/questions/499739/tuning-zfs-scrubbing-141kb-s-running-for-15-days


October 30 2014 5:57 PM, "Samuel Just" <sam.just@inktank.com> wrote: 
> I think my main concern with the thread io priority approach is that
> we hold locks while performing those operations. Slowing them down
> will block any client operation on the same pg until the operation
> completes -- probably not quite what we want. The number of scrub ops
> in the queue should not have an impact, the intention is that we do 63
> "cost" of items out of the 63 queue for every 1 "cost" we do out of
> the 1 priority queue. It's probably the case that 1-63 isn't enough
> range, might make sense to make the priority range finer (x10 or
> something). You seem to be arguing for a priority of 0, but that
> would not guarantee progress for snap removal or scrub which would, I
> think, not be acceptable. We do want snap trims and scrub to slow
> down client IO (when the cluster is actually saturated) a little.
> -Sam
> 
> On Thu, Oct 30, 2014 at 3:59 AM, Dan van der Ster
> <daniel.vanderster@cern.ch> wrote:
> 
>> Hi Sam,
>> Sorry I missed the discussion last night about putting the trim/scrub operations in a priority
> opq
>> alongside client ops. I had a question about the expected latency impact of this approach.
>> 
>> I understand that you've previously validated that your priority queue manages to fairly
> apportion
>> bandwidth (i.e. time) according to the relative op priorities. But how are the latency of client
>> ops going to be affected when the opq is full of scrub/trim ops? E.g. if we have 10000 scrub ops
> in
>> the queue with priority 1, how much extra latency do you expect a single incoming client op with
>> priority 63 to have?
>> 
>> We really need scrub and trim to be completely transparent (latency- and bandwidth-wise). I agree
>> that your proposal sounds like a cleaner approach, but the current implementation is actually
>> working transparently as far as I can tell.
>> 
>> It's just not obvious to me that the current out-of-band (and backgrounded with idle io priority)
>> scrubber/trimmer is a less worthy approach than putting those ops in-band with the clients IOs.
>> With your proposed change, at best, I'd expect that every client op is going to have to wait for
> at
>> least one ongoing scrub op to complete. That could be 10's of ms's on an RBD cluster... bad news.
>> So I think, at least, that we'll need to continue ionicing the scrub/trim ops so that the kernel
>> will service the client IOs immediately instead of waiting.
>> 
>> Your overall goal here seems to put a more fine grained knob on the scrub/trim ops. But in
> practice
>> we just want those to be invisible.
>> 
>> Thoughts?
>> 
>> Cheers, Dan
