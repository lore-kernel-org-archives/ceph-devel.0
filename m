From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Adding compression/checksum support for bluestore.
Date: Sat, 2 Apr 2016 05:38:23 +0000
Message-ID: <CY1PR0201MB1897416E6B245E1FC2B9CEBEE89B0@CY1PR0201MB1897.namprd02.prod.outlook.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
 <CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160401035610.GA5671@onthe.net.au>
 <alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com>
 <20160401052838.GA8044@onthe.net.au>
 <alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com>
 <20160401194912.GA18636@onthe.net.au>
 <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160402040736.GA22721@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0065.outbound.protection.outlook.com ([157.56.111.65]:54848
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751002AbcDBFi0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Apr 2016 01:38:26 -0400
In-Reply-To: <20160402040736.GA22721@onthe.net.au>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Chris Dunlop [mailto:chris@onthe.net.au]
> Sent: Friday, April 01, 2016 9:08 PM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: Sage Weil <sage@newdream.net>; Igor Fedotov
> <ifedotov@mirantis.com>; ceph-devel <ceph-devel@vger.kernel.org>
> Subject: Re: Adding compression/checksum support for bluestore.
> 
> On Fri, Apr 01, 2016 at 11:08:35PM +0000, Allen Samuels wrote:
> >> -----Original Message-----
> >> From: Chris Dunlop [mailto:chris@onthe.net.au]
> >> Sent: Friday, April 01, 2016 12:49 PM
> >> To: Sage Weil <sage@newdream.net>
> >> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; Igor Fedotov
> >> <ifedotov@mirantis.com>; ceph-devel <ceph-devel@vger.kernel.org>
> >> Subject: Re: Adding compression/checksum support for bluestore.
> >>
> >> On Fri, Apr 01, 2016 at 10:58:17AM -0400, Sage Weil wrote:
> >>> On Fri, 1 Apr 2016, Chris Dunlop wrote:
> >>>> On Fri, Apr 01, 2016 at 12:56:48AM -0400, Sage Weil wrote:
> >>>>> On Fri, 1 Apr 2016, Chris Dunlop wrote:
> >>>>>> On Wed, Mar 30, 2016 at 10:52:37PM +0000, Allen Samuels wrote:
> >>>>>>> One thing to also factor in is that if you increase the span of
> >>>>>>> a checksum, you degrade the quality of the checksum. So if you
> >>>>>>> go with 128K chunks of data you'll likely want to increase the
> >>>>>>> checksum itself from something beyond a CRC-32. Maybe
> somebody
> >>>>>>> out there has a good way of describing this quanitatively.
> >>>>>>
> >>>>>> I would have thought the "quality" of a checksum would be a
> >>>>>> function of how many bits it is, and how evenly and randomly it's
> >>>>>> distributed, and unrelated to the amount of data being
> checksummed.
> >>>>>>
> >>>>>> I.e. if you have any amount of data covered by an N-bit evenly
> >>>>>> randomly distributed checksum, and "something" goes wrong with
> >>>>>> the data (or the checksum), the chance of the checksum still
> >>>>>> matching the data is 1 in 2^n.
> >>>>>
> >>>>> Say there is some bit error rate per bit. If you double the amount
> >>>>> of data you're checksumming, then you'll see twice as many errors.
> >>>>> That means that even though your 32-bit checksum is right 2^32-1
> >>>>> times out of 2^32, you're twice as likely to hit that 1 in 2^32
> >>>>> chance of getting a correct checksum on wrong data.
> >>>>
> >>>> It seems to me, if we're talking about a single block of data
> >>>> protected by a 32-bit checksum, it doesn't matter how many errors
> >>>> there are within the block, the chance of a false checksum match is
> >>>> still only 1 in 2^32.
> >>>
> >>> It's not a question of how many errors are in the block, it's a
> >>> question of whether there are more than 0 errors. If the bit error
> >>> rate is so low it's 0, our probability of a false positive is 0, no
> >>> matter how many blocks there are. So for a bit error rate of 10e-15,
> >>> then it's 10e-15 * 1^-32. But if there are 1000 bits in a block, it
> >>> becomes 10e-12 * 1^-32.
> >>>
> >>> In other words, we're only rolling the checksum dice when there is
> >>> actually an error, and larger blocks are more likely to have errors.
> >>> If your blocks were so large you were effectively guaranteed to have
> >>> an error in every one, then the effective false positive rate would
> >>> be exactly the checksum false positive rate (2^-32).
> >>
> >> Good point, I hadn't thought about it like that. But that's the
> >> "single block" case. On the other hand, a large storage system is the
> >> same case as the stream of blocks: for a given storage (stream) size,
> >> your chance of hitting an error is constant, regardless of the size
> >> of the individual blocks within the storage. Then, if/when you hit an
> >> error, the chance of getting a false positive on the checksum is a
> >> function of the checksum bits and independent of the block size.
> >
> > I think we're getting confused about terminology. What matters isn't
> > "blocks" but the ratio of bits of checksum to bits of data covered by
> > that checksum. That ratio determines the BER of reading that data and
> > hence the overall system. If you double the amount of data you need to
> > add 1 bit of checksum to maintain the same BER.
> 
> The "blocks" we're talking about in this context are the data bits covered by
> the checksum bits. I.e. we're talking about the same thing there.
> 
> But perhaps you're correct about confusion of terminology... we're talking
> about checksums, not error correcting codes, right?
> 
> An ECC can fix errors and thus reduce the observable BER, and indeed the
> more ECC bits you have, the lower the observable BER because a greater
> range of errors can be fixed.
> 
> But checksums no effect on the BER. If you have an error, the checksum tells
> you (hopefully!) "you have an error".
> 
> What I think we're talking about is, if you have an error, the probability of the
> checksum unfortunately still matching, i.e. a false positive: you think you
> have good data but it's actually crap. And that's a function of the number of
> checksum bits, and unrelated to the number of data bits. Taken to extremes,
> you could have a 5PB data system covered by a single 32 bit checksum, and
> that's no more or less likely to give you a false positive than a 32 bit checksum
> on a 4K block, and it doesn't change the BER at all.
> 
> That said, if you have to throw away 5PB of data and read it again because of
> a checksum mismatch, your chances of getting another error during the
> subsequent 5PB read are obviously much higher than your chances of getting
> another error during a subsequent 4KB read.
> 
> Perhaps this is the effect you're thinking about? However this effect is a
> function of the block size (== data bits) and is independent of the checksum
> size.

Here's how I'm thinking about it -- for better or for worse.

The goal of the checksumming system is to be able to complete a read operation and to be able to make a statement about of the odds of the entire read chunk of data being actually correct, i.e., the odds of having zero undetectable uncorrected bit errors for each bit of data in the read operation (UUBER).

A fixed size checksum reduces the odds for the entire operation by a fixed amount (i.e., 2^checksum-size assuming a good checksum algorithm). However, the HW UUBER is a per-bit quotation. Thus as you read more bits the odds of a UUBER go UP by the number of bits that you're reading. If we hold the number of checksum bits constant then this increased HW UUBER is only decreased by a fixed amount, Hence the net UUBER is degraded for larger reads as opposed to smaller reads (again for a fixed-size checksum).

As you point out the odds of a UUBER for a 5PB read are much higher than the odds of a UUBER for a 4K read. My goal is to level that so that ANY read (i.e., EVERY read) has a UUBER that's below a fixed limit.

That's why I believe that you have to design for a specific checksum-bit / data bit ratio.

Does this make sense to you?


> 
> > I started this discussion in reaction to Sage's observation that we
> > could reduce the checksum storage overhead by checksuming larger
> > blocks. My point is that this will degrade the BER of system
> > accordingly. That's neither good nor bad, but it's something that will
> > matter to people. If you go from a 4K chunk of data with, say a 32-bit
> > checksum to a 128K chunk of data with the same 32-bit checksum, then
> > you simply have to accept that the BER is reduced by that ratio (4K /
> > 128K) OR you have to move to checksum value that has 32 more bits in
> > it (128K/4K). Whether that's acceptable is a user choice.
> >
> > I think it's good to parameterize the checksum algorithms and
> > checksumming block size. All we need to do is to document the system
> > level effects, etc., and give people guidance on how to connect these
> > settings with the magnitude of data under management (which matters)
> > and the HW UBER (which may vary A LOT from device to device).
> 
> I agree it's good to parametrize these aspects to provide people with choice.
> However I also think it's important that people correctly understand the
> choices being made.
> 
> Chris
