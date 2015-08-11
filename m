From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: bufferlist allocation optimization ideas
Date: Tue, 11 Aug 2015 23:48:46 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB53561F31@ABGEX73E.FSC.NET>
References: <alpine.DEB.2.00.1508101208510.26854@cobra.newdream.net>
 <alpine.DEB.2.00.1508111307540.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:24925 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753907AbbHKVsv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Aug 2015 17:48:51 -0400
In-Reply-To: <alpine.DEB.2.00.1508111307540.22099@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Tuesday, August 11, 2015 10:11 PM
>=20
> I went ahead and implemented both of these pieces.  See
>=20
> 	https://github.com/ceph/ceph/pull/5534
>=20
> My benchmark numbers are highly suspect, but the approximate takeaway=
 is
> that it's 2x faster for the simple microbenchmarks and does 1/3rd the
> allocations.  But there is some weird interaction with the allocator =
going on
> for 16k allocations that I saw, so it needs some more careful benchma=
rking.

16k allocations aren't that common, actually.
Some time ago I took an alloc profile for raw_char and posix_aligned bu=
ffers, and...=20

[root@storage1 /]# sort buffer::raw_char-2143984.dat | uniq -c | sort -=
g=20
      1 12                                                             =
 =20
      1 33                                                             =
 =20
      1 393                                                            =
 =20
      1 41                                                             =
 =20
      2 473                                                            =
 =20
      2 66447                                                          =
 =20
      3 190                                                            =
 =20
      3 20                                                             =
 =20
      3 64                                                             =
 =20
      4 16                                                             =
 =20
     36 206                                                            =
 =20
     88 174                                                            =
 =20
     88 48                                                             =
 =20
     89 272                                                            =
 =20
     89 36                                                             =
 =20
     90 34                                                             =
 =20
    312 207                                                            =
 =20
   3238 208                                                            =
 =20
  32403 209                                                            =
 =20
 196300 210                                                            =
 =20
 360164 45                                                             =
 =20

[root@storage1 /]# sort buffer::posix_aligned-2081990.dat | uniq -c | s=
ort -g
     36 36864                                                          =
     =20
 433635 4096=20

So most common are very small (<255 bytes) allocs and CEPH_PAGE_SIZE al=
locs.

> The other interesting thing is that either of these pieces in isolati=
on seems to
> have a pretty decent benefit, but when combined the benefits are full=
y
> additive.
>=20
> It seems to be reasonably stable, though!

I'm going to test them in my environment, because allocations and deall=
ocations alone, when done in "best-case pattern" (series of allocations=
 followed by series of frees not interleaved by frees/allocs), aren't a=
 good benchmark for memory allocators (actually, most allocators are sp=
ecially optimized for this case).=20


With best regards / Pozdrawiam
Piotr Da=B3ek

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
