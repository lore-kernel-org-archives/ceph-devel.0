From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression/checksum support for bluestore.
Date: Mon, 4 Apr 2016 23:58:17 +0000
Message-ID: <CY1PR0201MB18973631BB493B8DCE1A5C4AE89D0@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
 <CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160401035610.GA5671@onthe.net.au>
 <alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com>
 <20160401052838.GA8044@onthe.net.au>
 <alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com>
 <20160401194912.GA18636@onthe.net.au>
 <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160402040736.GA22721@onthe.net.au>
 <CY1PR0201MB1897416E6B245E1FC2B9CEBEE89B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160404150042.GA25465@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2on0063.outbound.protection.outlook.com ([65.55.169.63]:55295
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752250AbcDDX6U convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2016 19:58:20 -0400
In-Reply-To: <20160404150042.GA25465@onthe.net.au>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Chris Dunlop [mailto:chris@onthe.net.au]
> Sent: Monday, April 04, 2016 8:01 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: Sage Weil <sage@newdream.net>; Igor Fedotov
> <ifedotov@mirantis.com>; ceph-devel <ceph-devel@vger.kernel.org>
> Subject: Re: Adding compression/checksum support for bluestore.
> 
> [ Apologies for the tardy continuation of this... ]
> 
> On Sat, Apr 02, 2016 at 05:38:23AM +0000, Allen Samuels wrote:
> >> -----Original Message-----
> >> From: Chris Dunlop [mailto:chris@onthe.net.au]
> >>
> >> What I think we're talking about is, if you have an error, the
> >> probability of the checksum unfortunately still matching, i.e. a
> >> false positive: you think you have good data but it's actually crap.
> >> And that's a function of the number of checksum bits, and unrelated
> >> to the number of data bits. Taken to extremes, you could have a 5PB
> >> data system covered by a single 32 bit checksum, and that's no more
> >> or less likely to give you a false positive than a 32 bit checksum on a 4K
> block, and it doesn't change the BER at all.
> >>
> >> That said, if you have to throw away 5PB of data and read it again
> >> because of a checksum mismatch, your chances of getting another error
> >> during the subsequent 5PB read are obviously much higher than your
> >> chances of getting another error during a subsequent 4KB read.
> >>
> >> Perhaps this is the effect you're thinking about? However this effect
> >> is a function of the block size (== data bits) and is independent of
> >> the checksum size.
> >
> > Here's how I'm thinking about it -- for better or for worse.
> >
> > The goal of the checksumming system is to be able to complete a read
> operation and to be able to make a statement about of the odds of the
> entire read chunk of data being actually correct, i.e., the odds of having zero
> undetectable uncorrected bit errors for each bit of data in the read operation
> (UUBER).
> 
> Agree.
> 
> > A fixed size checksum reduces the odds for the entire operation by a fixed
> amount (i.e., 2^checksum-size assuming a good checksum algorithm).
> 
> Agree.
> 
> > However, the HW UUBER is a per-bit quotation.
> 
> Agree.
> 
> > Thus as you read more bits the odds of a UUBER go UP by the number of
> bits that you're reading.
> 
> Disagree. The UUBER stays the same: it's a _rate_. The odds of an error
> certainly go up, but the error rate is still the same.

So I talked to some HW people that understand this stuff better than me. Here's what we worked out:

Before I start, I want to again point out that real-world errors are non-random. Errors in the media are subjected to error correcting algorithms that have distinct modes of operation and correction. It will absolutely NOT be the case that silent errors will be evenly distributed amongst the data words (this is a consequence of the ECC algorithms themselves, RS, BCH, LDPC, etc.). However, I'm going to assume that silent errors are random -- because we simply don't know what the right patterns are. Realistically, if you have a HW device with a UBER that's in the typical enterprise range -- say 10^-15, then the UUBER will be several orders of magnitude less than that. So if we use the HW UBER as the UUBER rate, we're more than safely guardbanding the non-random nature of the HW ECC algorithm
 s.

So, under the assumption that we are reading a block data of size "D", with a HW UBER of "U", then the odds of an UUBER in that block are:

1 - (1 - U)^D).

Parsing this: 1-U is the odds of each bit being correct.
Raising that to the power of D is what you get for a block of size "D" when the errors are uncorrelated (i.e., random). That's the equivalent of "D" independent trials of probability 1-U.
The outer "1-" is to covert the odds of success back into the odds of failure.

Now if we add a checksum of size "C", then we decrease the odds of failure by 2^C.

So the overall probability of a failure for this read is:

(1 - (1-U)^D) / (2^C).

Now, if we double the data size, it's clear that this expression gets larger, i.e., there's an increase in the odds of a failure.

So the design question becomes: How much larger do I need to make C in order to guarantee that the new odds of failure are no greater than before we doubled the data size, i.e.,

(1 - (1-U)^D) / (2^C) >= (1-(1-U)^2D) / (2^(C+Y))

Sadly there's no closed form solution of this that's simple. (Plug it into Wolfram alpha if you want!)

But there's an approximation that gets the job done for us.

When U is VERY SMALL (this will always be true for us :)).

The you can approximate 1-(1-U)^D as D * U.  (for even modest values of U (say 10-5), this is a very good approximation).

Now the math is easy.

The odds of failure for reading a block of size D is now D * U, with checksum correction it becomes (D * U) / (2^C).

It's now clear that if you double the data size, you need to add one bit to your checksum to compensate.

(Again, the actual math is less than 1 bit, but in the range we care about 1 bit will always do it).

Anyways, that's what we worked out.
 

> 
> So then:
> 
> > If we hold the number of checksum bits constant then this increased HW
> UUBER is only decreased by a fixed amount, Hence the net UUBER is
> degraded for larger reads as opposed to smaller reads (again for a fixed-size
> checksum).
> >
> > As you point out the odds of a UUBER for a 5PB read are much higher than
> the odds of a UUBER for a 4K read. My goal is to level that so that ANY read
> (i.e., EVERY read) has a UUBER that's below a fixed limit.
> >
> > That's why I believe that you have to design for a specific checksum-bit /
> data bit ratio.
> >
> > Does this make sense to you?
> 
> Sorry, no, it doesn't :-(
> 
> On Sat, Apr 02, 2016 at 05:48:01AM +0000, Allen Samuels wrote:
> > I think you're defining BER as the odds of a read operation silently
> > delivering wrong data. Whereas I'm defining BER as the odds of an
> > individual bit being read incorrectly. When we have a false positive
> > you count "1" failure but I count "Block" number of failures.
> >
> > I'm not claiming that either of us is "correct". I'm just trying
> > understand our positions.
> >
> > Do you agree with this?
> 
> I agree BER is the odds of an individual bit being read incorrectly (actually, for
> our purposes "delivered" rather than "read", taking into account potential
> errors in the transmission path). So, yes, the more bits in a block of data, the
> more likely you'll see one or more errors. (But the size of the block still
> doesn't change the BER, i.e. the chance of any specific bit being flipped.)
> 
> However, my point is, given one or more errors in a block of data, the chance
> of a checksum returning a false positive is a function of the size of the
> checksum and independent of the size of the data (and independent of the
> BER).
> 
> Sure, as Sage said, the larger the block of data (and/or the larger the BER),
> the more likely you are to see an error, so the more likely you are to get
> unlucky and get a false positive in that block.
> 
> However, for a given amount of data you have the same overall chance of
> getting errors (e.g. 5PB @ BER 1x10^-15 == 5 * 8 * 10^15 * 1 * 10^-15 == 40
> bit errors, on average) whether you're reading in small or large blocks, so
> once again we're back to the size of the checksum and not the size of the
> block telling us how likely it is we'll get a false positive when we get those
> errors.
> 
> Chris

