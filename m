From: Samuel Just <sam.just@inktank.com>
Subject: Re: Scrub / SnapTrim IO Prioritization and Latency
Date: Thu, 30 Oct 2014 09:57:44 -0700
Message-ID: <CA+4uBUZJG12_YWXrVA6eQkKnFG=+ovfptTKwAg7fDZeMrWhQdw@mail.gmail.com>
References: <5d451bfe7cfaf298e6cd3fccd2910f2d@webmail.vanderster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:51377 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759469AbaJ3Q5q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 12:57:46 -0400
Received: by mail-la0-f49.google.com with SMTP id ge10so4832822lab.36
        for <ceph-devel@vger.kernel.org>; Thu, 30 Oct 2014 09:57:44 -0700 (PDT)
In-Reply-To: <5d451bfe7cfaf298e6cd3fccd2910f2d@webmail.vanderster.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <daniel.vanderster@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I think my main concern with the thread io priority approach is that
we hold locks while performing those operations.  Slowing them down
will block any client operation on the same pg until the operation
completes -- probably not quite what we want.  The number of scrub ops
in the queue should not have an impact, the intention is that we do 63
"cost" of items out of the 63 queue for every 1 "cost" we do out of
the 1 priority queue.  It's probably the case that 1-63 isn't enough
range, might make sense to make the priority range finer (x10 or
something).  You seem to be arguing for a priority of 0, but that
would not guarantee progress for snap removal or scrub which would, I
think, not be acceptable.  We do want snap trims and scrub to slow
down client IO (when the cluster is actually saturated) a little.
-Sam

On Thu, Oct 30, 2014 at 3:59 AM, Dan van der Ster
<daniel.vanderster@cern.ch> wrote:
> Hi Sam,
> Sorry I missed the discussion last night about putting the trim/scrub operations in a priority opq alongside client ops. I had a question about the expected latency impact of this approach.
>
> I understand that you've previously validated that your priority queue manages to fairly apportion bandwidth (i.e. time) according to the relative op priorities. But how are the latency of client ops going to be affected when the opq is full of scrub/trim ops? E.g. if we have 10000 scrub ops in the queue with priority 1, how much extra latency do you expect a single incoming client op with priority 63 to have?
>
> We really need scrub and trim to be completely transparent (latency- and bandwidth-wise). I agree that your proposal sounds like a cleaner approach, but the current implementation is actually working transparently as far as I can tell.
>
> It's just not obvious to me that the current out-of-band (and backgrounded with idle io priority) scrubber/trimmer is a less worthy approach than putting those ops in-band with the clients IOs. With your proposed change, at best, I'd expect that every client op is going to have to wait for at least one ongoing scrub op to complete. That could be 10's of ms's on an RBD cluster... bad news. So I think, at least, that we'll need to continue ionicing the scrub/trim ops so that the kernel will service the client IOs immediately instead of waiting.
>
> Your overall goal here seems to put a more fine grained knob on the scrub/trim ops. But in practice we just want those to be invisible.
>
> Thoughts?
>
> Cheers, Dan
