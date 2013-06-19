From: Alex Elsayed <eternaleye@gmail.com>
Subject: Re: Erasure code library summary
Date: Wed, 19 Jun 2013 02:09:11 -0700
Message-ID: <kprsfk$7ag$1@ger.gmane.org>
References: <51C05123.8000002@dachary.org> <kpr0dn$3cr$1@ger.gmane.org> <kpr0ld$3cr$2@ger.gmane.org> <51C156FA.2000509@dachary.org> <kprnn8$l72$1@ger.gmane.org> <51C16CE3.9020004@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:38801 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934011Ab3FSJJb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 19 Jun 2013 05:09:31 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1UpEON-0006Ky-LG
	for ceph-devel@vger.kernel.org; Wed, 19 Jun 2013 11:09:27 +0200
Received: from c-50-132-41-203.hsd1.wa.comcast.net ([50.132.41.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 11:09:27 +0200
Received: from eternaleye by c-50-132-41-203.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 11:09:27 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Loic Dachary wrote:

> Hi Alex,
> 
> If I understand correctly, part of what you propose is to make use of
> fountain codes to optimize replicas transmissions. It could even be used
> to speed up replication by allowing existing copies to contribute to the
> completion of the others. Although this is very appealing, it may be
> outside of the scope of my current work. Unless you tell me that both
> topics are intimately linked and should be handled simultaneously for some
> reason :-)

No, just an idea that hit while I was thinking about Raptor codes with 
regard to Ceph. I'd read up on them a bit ago and had seen a few papers 
describing video distribution systems that made use of that.

> The erasure coded placement group could work as follows:
> 
> * Placement group is using K+M OSDs
> 
> * An object is sent by a client to the primary OSD
> * The primary OSD code the object in K+M chunks
> * The primary OSD writes the chunks to the OSDs in order

Well, one thing to consider is whether you want the additional complexity of 
explicitly scheduling where they go, when it's been said before that a.) 
parity recovery is going to be a (somewhat) common operation and b.) we're 
unlikely to be CPU-bound on encode/decode, considering network and disk IO.

It might be a win to have some simple header denoting which chunk is which, 
toss them onto the appropriate OSDs in whatever order, and just let the 
read-side decode whichever K it gets. With Reed-Solomon being an optimal 
erasure code, K are guaranteed to be enough.

> * The primary OSD acknowledge the write
> 
> * An object is read by a client from the primary OSD
> * The primary OSD reads the K chunks from the K OSDs
> * The primary OSD concatenates the K chunks and returns the result

The other reason I suggested what I did above is that then you have exactly 
one code path here - fetch && decode. If the K you get are the input data, 
it's a nice degenerate case, but having a single codepath might help with 
reliability and maintainability.

Unless it's known to be a bottleneck, this just tweaks my 'premature 
optimization' meter a little.

If you want to add it later, it can be done without breaking compatibility - 
add a branch for if the chunks you got are the contiguous real data on the 
read side, preferentially fetch from certain OSDs, and do that location 
scheduling on the write side for new chunks.

Over time, chunks will be allocated in such a way that you get the behavior 
you propose above, and for older chunks it just decodes them like always.

> I'd be interested to know if you see a problem with this approach. I could
> elaborate on how it would behave when scrubbing, or when the OSDMap
> changes ( either because new OSDs becomes available or because an OSD
> fails ).

I'd like that, because those are exactly the cases I'd expect the explicit 
scheduling to be a burden rather than a help.

> Cheers
> 

<snip quotes>

