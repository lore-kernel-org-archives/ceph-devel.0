From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: Memory Pooling and Containers
Date: Wed, 28 Sep 2016 21:31:40 +0000
Message-ID: <BLUPR0201MB152427C4BD08DEDB9178C89AE8CF0@BLUPR0201MB1524.namprd02.prod.outlook.com>
References: <BLUPR0201MB1524456C8A99C6ABA036CBB9E8CC0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1609281316210.19847@piezo.us.to>
 <alpine.LSU.2.20.1609281413450.13361@ancalagon.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-dm3nam03on0053.outbound.protection.outlook.com ([104.47.41.53]:43875
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752857AbcI1Vbm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 28 Sep 2016 17:31:42 -0400
In-Reply-To: <alpine.LSU.2.20.1609281413450.13361@ancalagon.suse.de>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jesse Williamson <jwilliamson@suse.de>, Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Boost::pool works very well when you're allocated "same" sized objects. Tha=
t's not our situation, we're allocating lots of different sized objects -- =
some small, some large. The only way that Boost::pool supports that situati=
on is to use the "ordered_free" operation to keep the freelist sorted (if y=
ou don't use it then you'll get fragmentation that'll prevent allocation of=
 large objects -- even though there's plenty of free memory). The implement=
ation of the sorted freelist is O(N). Which should work well for small pool=
s, but that's the exact opposite of the desired use for Ceph, we're targeti=
ng large pools (think 1GB).

I didn't word it very well, but my proposal doesn't actually change the und=
erlying malloc/free algorithm, rather it's intended to put some statistics =
around memory usage so that we can self-trim our memory pools.

Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, San Jose, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com

> -----Original Message-----
> From: Jesse Williamson [mailto:jwilliamson@suse.de]
> Sent: Wednesday, September 28, 2016 11:17 PM
> To: Sage Weil <sage@newdream.net>
> Cc: Allen Samuels <Allen.Samuels@sandisk.com>; Ceph Development
> <ceph-devel@vger.kernel.org>
> Subject: Re: Memory Pooling and Containers
>=20
> On Wed, 28 Sep 2016, Sage Weil wrote:
>=20
> > It would be nice to build this on top of existing allocator libraries
> > if we can.  For example, something in boost.  I took a quick peek the
> > other day and didn't find something that allowed simple interrogation
> > about utilization, though, which was surprising.
>=20
> Boost::pool look to me like it should fufill most of the requirements, bu=
t I
> haven't used it in production:
> http://www.boost.org/doc/libs/1_62_0/libs/pool/doc/html/index.html
>=20
> By "iterrogation about utilization", do you mean statistics about the all=
ocator
> activity?
>=20
> -Jesse
