From: Dan van der Ster <daniel.vanderster@cern.ch>
Subject: Scrub / SnapTrim IO Prioritization and Latency
Date: Thu, 30 Oct 2014 10:59:42 +0000
Message-ID: <5d451bfe7cfaf298e6cd3fccd2910f2d@webmail.vanderster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:11836 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932744AbaJ3K7o convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Oct 2014 06:59:44 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>, ceph-devel@vger.kernel.org

Hi Sam,
Sorry I missed the discussion last night about putting the trim/scrub operations in a priority opq alongside client ops. I had a question about the expected latency impact of this approach.

I understand that you've previously validated that your priority queue manages to fairly apportion bandwidth (i.e. time) according to the relative op priorities. But how are the latency of client ops going to be affected when the opq is full of scrub/trim ops? E.g. if we have 10000 scrub ops in the queue with priority 1, how much extra latency do you expect a single incoming client op with priority 63 to have?

We really need scrub and trim to be completely transparent (latency- and bandwidth-wise). I agree that your proposal sounds like a cleaner approach, but the current implementation is actually working transparently as far as I can tell.

It's just not obvious to me that the current out-of-band (and backgrounded with idle io priority) scrubber/trimmer is a less worthy approach than putting those ops in-band with the clients IOs. With your proposed change, at best, I'd expect that every client op is going to have to wait for at least one ongoing scrub op to complete. That could be 10's of ms's on an RBD cluster... bad news. So I think, at least, that we'll need to continue ionicing the scrub/trim ops so that the kernel will service the client IOs immediately instead of waiting.

Your overall goal here seems to put a more fine grained knob on the scrub/trim ops. But in practice we just want those to be invisible.

Thoughts?

Cheers, Dan
