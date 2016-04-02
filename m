From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Fri, 1 Apr 2016 23:18:05 -0700
Message-ID: <CAJ4mKGYPyqy9tUJH8eUEHFAt25Sqm6uKQpr84ckwDERqsRxUKA@mail.gmail.com>
References: <alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
	<CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<20160401035610.GA5671@onthe.net.au>
	<alpine.DEB.2.11.1604010055050.22014@cpach.fuggernut.com>
	<20160401052838.GA8044@onthe.net.au>
	<alpine.DEB.2.11.1604011051480.22014@cpach.fuggernut.com>
	<20160401194912.GA18636@onthe.net.au>
	<CY1PR0201MB1897EE2E58FFF2FF3DFFFB55E89A0@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<3E46E6C9-EFD2-49BD-9862-4C46D053A8D6@sandisk.com>
	<CAJ4mKGaNPfpPbbNY+YVu1NDuVQ-gaS5fi2Pww7DSjsbGt-sbXg@mail.gmail.com>
	<20160402050505.GA23763@onthe.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35147 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbcDBGSH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Apr 2016 02:18:07 -0400
Received: by mail-vk0-f51.google.com with SMTP id e6so127536675vkh.2
        for <ceph-devel@vger.kernel.org>; Fri, 01 Apr 2016 23:18:06 -0700 (PDT)
In-Reply-To: <20160402050505.GA23763@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Apr 1, 2016 at 10:05 PM, Chris Dunlop <chris@onthe.net.au> wrot=
e:
> On Fri, Apr 01, 2016 at 07:51:07PM -0700, Gregory Farnum wrote:
>> On Fri, Apr 1, 2016 at 7:23 PM, Allen Samuels <Allen.Samuels@sandisk=
=2Ecom> wrote:
>>> Talk about mental failures. The first statement is correct. It's ab=
out the ratio of checksum to data bits. After that please ignore. If yo=
u double the data you need to double the checksum bit to maintain the b=
er.
>>
>> Forgive me if I'm wrong here =E2=80=94 I haven't done anything with
>> checksumming since I graduated college =E2=80=94 but good checksummi=
ng is
>> about probabilities and people suck at evaluating probability: I'm
>> really not sure any of the explanations given in this thread are
>> right. Bit errors aren't random and in general it requires a lot mor=
e
>> than one bit flip to collide a checksum, so I don't think it's a
>> linear relationship between block size and chance of error. Finding
>
> A single bit flip can certainly result in a checksum collision, with =
the
> same chance as any other error, i.e. 1 in 2^number_of_checksum_bits.

That's just not true. I'll quote from
https://en.m.wikipedia.org/wiki/Cyclic_redundancy_check#Introduction

> Typically an n-bit CRC applied to a data block of arbitrary length wi=
ll detect any single error burst not longer than n bits and will detect=
 a fraction 1 =E2=88=92 2^(=E2=88=92n) of all longer error bursts.

And over (at least) the ranges they're designed for, it's even better:
they provide guarantees about how many bits (in any combination or
arrangement) must be flipped before they can have a false match. (It
says "typically" because CRCs are a wide family and yes, you do have
to select the right ones in the right ways in order to get the desired
effects.)

As Allen says, flash may require something different, but it will be
similar. Getting the people who actually understand this is definitely
the way to go =E2=80=94 it's an active research field but I think over =
the
ranges we're interested in it's a solved problem. And certainly if we
try and guess about things based on our intuition, we *will* get it
wrong. So somebody interested in this feature set needs to go out and
do the reading or talk to the right people, please! :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
