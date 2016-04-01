From: Sage Weil <sage@newdream.net>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Fri, 1 Apr 2016 10:58:17 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com> <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com> <CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <20160401035610.GA5671@onthe.net.au> <alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com> <20160401052838.GA8044@onthe.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47708 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbcDAO61 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Apr 2016 10:58:27 -0400
In-Reply-To: <20160401052838.GA8044@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 1 Apr 2016, Chris Dunlop wrote:
> On Fri, Apr 01, 2016 at 12:56:48AM -0400, Sage Weil wrote:
> > On Fri, 1 Apr 2016, Chris Dunlop wrote:
> >> On Wed, Mar 30, 2016 at 10:52:37PM +0000, Allen Samuels wrote:
> >>> One thing to also factor in is that if you increase the span of a
> >>> checksum, you degrade the quality of the checksum. So if you go with 128K
> >>> chunks of data you'll likely want to increase the checksum itself from
> >>> something beyond a CRC-32. Maybe somebody out there has a good way of
> >>> describing this quanitatively.
> >> 
> >> I would have thought the "quality" of a checksum would be a function of how
> >> many bits it is, and how evenly and randomly it's distributed, and unrelated
> >> to the amount of data being checksummed.
> >> 
> >> I.e. if you have any amount of data covered by an N-bit evenly randomly
> >> distributed checksum, and "something" goes wrong with the data (or the
> >> checksum), the chance of the checksum still matching the data is 1 in 2^n.
> > 
> > Say there is some bit error rate per bit.  If you double the amount of 
> > data you're checksumming, then you'll see twice as many errors.  That 
> > means that even though your 32-bit checksum is right 2^32-1 times out of 
> > 2^32, you're twice as likely to hit that 1 in 2^32 chance of getting a 
> > correct checksum on wrong data.
> 
> It seems to me, if we're talking about a single block of data protected by a
> 32-bit checksum, it doesn't matter how many errors there are within the
> block, the chance of a false checksum match is still only 1 in 2^32.

It's not a question of how many errors are in the block, it's a question 
of whether there are more than 0 errors.  If the bit error rate is so low 
it's 0, our probability of a false positive is 0, no matter how many 
blocks there are.  So for a bit error rate of 10e-15, then it's 10e-15 * 
1^-32.  But if there are 1000 bits in a block, it becomes 10e-12 * 1^-32.  

In other words, we're only rolling the checksum dice when there is 
actually an error, and larger blocks are more likely to have errors.  If 
your blocks were so large you were effectively guaranteed to have an error 
in every one, then the effective false positive rate would be exactly the 
checksum false positive rate (2^-32).
 
> If we're talking about a stream of checksummed blocks, where the stream is
> subject to some BER, then, yes, your chances of getting a false match go up.
> But that's still independent of the block size, rather it's a function of
> the number of possibly corrupt blocks.
> 
> In fact, if you have a stream of data subject to some BER and split into
> checksummed blocks, the larger the blocks and thereby the lower the number
> of blocks, the lower the chance of a false match.


sage
