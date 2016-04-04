From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Tue, 5 Apr 2016 01:26:57 +1000
Message-ID: <20160404152657.GA25148@onthe.net.au>
References: <20160401035610.GA5671@onthe.net.au>
 <alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com>
 <20160401052838.GA8044@onthe.net.au>
 <alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com>
 <20160401194912.GA18636@onthe.net.au>
 <CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
 <3E46E6C9-EFD2-49BD-9862-4C46D053A8D6@sandisk.com>
 <CAJ4mKGaNPfpPbbNY+YVu1NDuVQ-gaS5fi2Pww7DSjsbGt-sbXg@mail.gmail.com>
 <20160402050505.GA23763@onthe.net.au>
 <CAJ4mKGYPyqy9tUJH8eUEHFAt25Sqm6uKQpr84ckwDERqsRxUKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:50047 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755447AbcDDP1F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Apr 2016 11:27:05 -0400
Content-Disposition: inline
In-Reply-To: <CAJ4mKGYPyqy9tUJH8eUEHFAt25Sqm6uKQpr84ckwDERqsRxUKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Apr 01, 2016 at 11:18:05PM -0700, Gregory Farnum wrote:
> On Fri, Apr 1, 2016 at 10:05 PM, Chris Dunlop <chris@onthe.net.au> wr=
ote:
>> On Fri, Apr 01, 2016 at 07:51:07PM -0700, Gregory Farnum wrote:
>>> Forgive me if I'm wrong here =E2=80=94 I haven't done anything with
>>> checksumming since I graduated college =E2=80=94 but good checksumm=
ing is
>>> about probabilities and people suck at evaluating probability: I'm
>>> really not sure any of the explanations given in this thread are
>>> right. Bit errors aren't random and in general it requires a lot mo=
re
>>> than one bit flip to collide a checksum, so I don't think it's a
>>> linear relationship between block size and chance of error. Finding
>>
>> A single bit flip can certainly result in a checksum collision, with=
 the
>> same chance as any other error, i.e. 1 in 2^number_of_checksum_bits.
>=20
> That's just not true. I'll quote from
> https://en.m.wikipedia.org/wiki/Cyclic_redundancy_check#Introduction
>=20
>> Typically an n-bit CRC applied to a data block of arbitrary length w=
ill detect any single error burst not longer than n bits and will detec=
t a fraction 1 =E2=88=92 2^(=E2=88=92n) of all longer error bursts.

Ouch, got me! :-)

In my defense, I was talking about checksums in general rather
than specifically CRC. But no, I wasn't actually aware that CRCs
provide guaranteed detection of single n-bit error bursts.

That changes my contention that block size doesn't matter. My
contention was based on a (generic, good) checksum being equally
good at picking up multiple errors as single errors. However
this property of CRCs means that, if you have multiple errors
further apart than the n-bits of a CRC checksum, you lose your
guarantee of detection (although you still have a very, very
good chance of detection). So in a larger block you're more
likely to see another error further away, and thus more likely
to get an undetected error.

Well, I've learnt something!

Thanks all, for your patience.

Chris

> And over (at least) the ranges they're designed for, it's even better=
:
> they provide guarantees about how many bits (in any combination or
> arrangement) must be flipped before they can have a false match. (It
> says "typically" because CRCs are a wide family and yes, you do have
> to select the right ones in the right ways in order to get the desire=
d
> effects.)
>=20
> As Allen says, flash may require something different, but it will be
> similar. Getting the people who actually understand this is definitel=
y
> the way to go =E2=80=94 it's an active research field but I think ove=
r the
> ranges we're interested in it's a solved problem. And certainly if we
> try and guess about things based on our intuition, we *will* get it
> wrong. So somebody interested in this feature set needs to go out and
> do the reading or talk to the right people, please! :)
> -Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
