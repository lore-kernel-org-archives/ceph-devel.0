From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: Reproducing allocator performance differences
Date: Fri, 2 Oct 2015 08:07:01 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB563EB271@ABGEX73E.FSC.NET>
References: <E011655B53F0CC41BB273E3A0B53F14409B749EC@G1W3777.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:20369 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbbJBGHF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Oct 2015 02:07:05 -0400
In-Reply-To: <E011655B53F0CC41BB273E3A0B53F14409B749EC@G1W3777.americas.hpqcorp.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Curley, Matthew" <matthew.curley@hpe.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Curley, Matthew
> Sent: Thursday, October 01, 2015 5:33 PM
>=20
> We've been trying to reproduce the allocator performance impact on 4K
> random reads seen in the Hackathon (and more recent tests).  At this =
point
> though, we're not seeing any significant difference between tcmalloc =
and
> jemalloc so we're looking for thoughts on what we're doing wrong.  Or=
 at
> least some suggestions to try out.
>=20
> More detail here:
> https://drive.google.com/file/d/0B2kp18maR7axTmU5WG9WclNKQlU/view?
> usp=3Dsharing
>=20
> Thanks for any input!

This problem is more obvious on writes than reads (I noticed that CPU u=
sage on writes is way more erratic than on reads, where it's pretty muc=
h constant), also - more clients would be better (or worse, depending o=
n how you look at it).
And finally, this gets more serious with time, once tcmalloc caches get=
 filled, it starts to slow down.


With best regards / Pozdrawiam
Piotr Da=B3ek
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
