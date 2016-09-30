From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: Re: Memory Pooling and Containers
Date: Fri, 30 Sep 2016 14:30:10 +0000
Message-ID: <0AA35578-9667-4B81-BE6A-71C8326B76F1@sandisk.com>
References: <BLUPR0201MB1524456C8A99C6ABA036CBB9E8CC0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1609281316210.19847@piezo.us.to>
 <alpine.LSU.2.20.1609281413450.13361@ancalagon.suse.de>
 <BLUPR0201MB152427C4BD08DEDB9178C89AE8CF0@BLUPR0201MB1524.namprd02.prod.outlook.com>,<alpine.DEB.2.11.1609301416270.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:36112
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932707AbcI3OoZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 30 Sep 2016 10:44:25 -0400
In-Reply-To: <alpine.DEB.2.11.1609301416270.19850@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Jesse Williamson <jwilliamson@suse.de>, Ceph Development <ceph-devel@vger.kernel.org>

I'm expecting the "in-object" capabilities of the slab_xxxxx containers to =
dramatically reduce malloc/free calls. Also having some visibility into whe=
re the memory is actually going will also spur a bit more development that =
will likely have more significant positive effects.=20

Sent from my iPhone. Please excuse all typos and autocorrects.

> On Sep 30, 2016, at 4:22 PM, Sage Weil <sage@newdream.net> wrote:
>=20
>> On Wed, 28 Sep 2016, Allen Samuels wrote:
>> Boost::pool works very well when you're allocated "same" sized objects.=
=20
>> That's not our situation, we're allocating lots of different sized=20
>> objects -- some small, some large. The only way that Boost::pool=20
>> supports that situation is to use the "ordered_free" operation to keep=20
>> the freelist sorted (if you don't use it then you'll get fragmentation=20
>> that'll prevent allocation of large objects -- even though there's=20
>> plenty of free memory). The implementation of the sorted freelist is=20
>> O(N). Which should work well for small pools, but that's the exact=20
>> opposite of the desired use for Ceph, we're targeting large pools (think=
=20
>> 1GB).
>>=20
>> I didn't word it very well, but my proposal doesn't actually change the=
=20
>> underlying malloc/free algorithm, rather it's intended to put some=20
>> statistics around memory usage so that we can self-trim our memory=20
>> pools.
>=20
> We were doing some heap profiling yesterday and one interesting thing is=
=20
> that the utilized heap reported by tcmalloc is about 1/2 the RSS.  We=20
> probably want to consider creating separate pools for the handful of=20
> objects that are consuming the bulk of the heap.
>=20
> We did this a few years back in the MDS and IIRC it helped significantly=
=20
> with memory utilization there.
>=20
> sage
