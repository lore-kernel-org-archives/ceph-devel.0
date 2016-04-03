From: Sage Weil <sage@newdream.net>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Sun, 3 Apr 2016 09:27:22 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604030921090.19675@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com> <CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com> <20160401035610.GA5671@onthe.net.au> <alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com>
 <20160401052838.GA8044@onthe.net.au> <alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com> <20160401194912.GA18636@onthe.net.au> <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com> <3E46E6C9-EFD2-49BD-9862-4C46D053A8D6@sandisk.com>
 <CAJ4mKGaNPfpPbbNY+YVu1NDuVQ-gaS5fi2Pww7DSjsbGt-sbXg@mail.gmail.com> <20160402050505.GA23763@onthe.net.au> <CAJ4mKGYPyqy9tUJH8eUEHFAt25Sqm6uKQpr84ckwDERqsRxUKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-762399859-1459690044=:19675"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33119 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbcDCN1a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Apr 2016 09:27:30 -0400
In-Reply-To: <CAJ4mKGYPyqy9tUJH8eUEHFAt25Sqm6uKQpr84ckwDERqsRxUKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Chris Dunlop <chris@onthe.net.au>, Allen Samuels <Allen.Samuels@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-762399859-1459690044=:19675
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 1 Apr 2016, Gregory Farnum wrote:
> On Fri, Apr 1, 2016 at 10:05 PM, Chris Dunlop <chris@onthe.net.au> wrote:
> > On Fri, Apr 01, 2016 at 07:51:07PM -0700, Gregory Farnum wrote:
> >> On Fri, Apr 1, 2016 at 7:23 PM, Allen Samuels <Allen.Samuels@sandisk.com> wrote:
> >>> Talk about mental failures. The first statement is correct. It's about the ratio of checksum to data bits. After that please ignore. If you double the data you need to double the checksum bit to maintain the ber.
> >>
> >> Forgive me if I'm wrong here — I haven't done anything with
> >> checksumming since I graduated college — but good checksumming is
> >> about probabilities and people suck at evaluating probability: I'm
> >> really not sure any of the explanations given in this thread are
> >> right. Bit errors aren't random and in general it requires a lot more
> >> than one bit flip to collide a checksum, so I don't think it's a
> >> linear relationship between block size and chance of error. Finding
> >
> > A single bit flip can certainly result in a checksum collision, with the
> > same chance as any other error, i.e. 1 in 2^number_of_checksum_bits.
> 
> That's just not true. I'll quote from
> https://en.m.wikipedia.org/wiki/Cyclic_redundancy_check#Introduction
> 
> > Typically an n-bit CRC applied to a data block of arbitrary length will detect any single error burst not longer than n bits and will detect a fraction 1 − 2^(−n) of all longer error bursts.
> 
> And over (at least) the ranges they're designed for, it's even better:
> they provide guarantees about how many bits (in any combination or
> arrangement) must be flipped before they can have a false match. (It
> says "typically" because CRCs are a wide family and yes, you do have
> to select the right ones in the right ways in order to get the desired
> effects.)

That's pretty cool.  I have a new respect for CRCs.  :)
 
> As Allen says, flash may require something different, but it will be
> similar. Getting the people who actually understand this is definitely
> the way to go — it's an active research field but I think over the
> ranges we're interested in it's a solved problem. And certainly if we
> try and guess about things based on our intuition, we *will* get it
> wrong. So somebody interested in this feature set needs to go out and
> do the reading or talk to the right people, please! :)

Yep.  I was halfway through responding to Chris's last message when I 
convinced myself that actually he was right (block size doesn't matter). 
But I don't trust my intuition here anymore.  :/

In any case, it seems like the way to proceed is to have a variable length 
checksum_block_size, since we need that anyway for other reasons (e.g., 
balancing minimum read size and read amplification for small IOs vs 
metadata overhead).

sage
--8323329-762399859-1459690044=:19675--
