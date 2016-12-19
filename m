From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: BlueStore in-memory Onode footprint
Date: Mon, 19 Dec 2016 16:16:21 +0000
Message-ID: <EB02EE10422E4A40A1EE787A4AC27FBE040861@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
References: <34ee2613-8db3-646e-4470-b3e8fa8855e0@mirantis.com>
 <alpine.DEB.2.11.1612161518570.10615@piezo.novalocal>
 <EB02EE10422E4A40A1EE787A4AC27FBE0321CB@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <b0c715a3-9577-93cf-d634-499eb52cb87c@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2nam01on0050.outbound.protection.outlook.com ([104.47.34.50]:52096
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755380AbcLSQca (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 19 Dec 2016 11:32:30 -0500
In-Reply-To: <b0c715a3-9577-93cf-d634-499eb52cb87c@mirantis.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

FWIW, the actual memory cost is higher than the numbers we've quoted -- pos=
sibly considerably higher. That's because it principally consists of a larg=
e number of small allocations and there's been no attempt to adjust for the=
 allocator overhead itself.

I'm not that concerned with the amount of memory consumed by a decoded oNod=
e/Shard. That's because I don't expect to have a lot of them around. Realis=
tically, I only see a benefit in caching decoded oNode/Shards that are bein=
g sequentially used. I doubt that we need more than 2 or 3 of these per cli=
ent connection (hundreds in total?). For random accessed oNode/Shards, you'=
ll be better off trying to cache them in the encoded format within the KV s=
ubsystem itself.

Hence I care A LOT about the time needed to serialize/deserialize the oNode=
/Shard. We should be focused on that part of the problem.

I believe that as we optimize the TIME required to serialize/deserialize we=
 will end up also shrinking the SPACE required as an unintended consequence=
.

Allen Samuels
SanDisk |a Western Digital brand
2880 Junction Avenue, Milpitas, CA 95134
T: +1 408 801 7030| M: +1 408 780 6416
allen.samuels@SanDisk.com

> -----Original Message-----
> From: Igor Fedotov [mailto:ifedotov@mirantis.com]
> Sent: Monday, December 19, 2016 6:46 AM
> To: Allen Samuels <Allen.Samuels@sandisk.com>; Sage Weil
> <sage@newdream.net>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> Subject: Re: BlueStore in-memory Onode footprint
>=20
>=20
>=20
> On 17.12.2016 1:08, Allen Samuels wrote:
> > I'm not sure what the conclusion from this is.
> IMHO the numbers I shared are pretty high and we should consider some
> ways to reduce them.
> >
> > The point of the sharding exercise was to eliminate the need to
> serialize/deserialize all 1024 Extents/Blobs/SharedBlobs on each I/O
> transaction.
> >
> > This shows that a fully populated oNode with ALL of the shards present =
is a
> large number. But that ought to be a rare occurrence.
> Actually we have pretty high number for each Blob entry. And this means
> that  cache effectiveness is badly affected in general case since we're a=
ble to
> cache less entries in total.
> >
> > This test shows that each Blob is 248 bytes and that each SharedBlob is=
 216
> bytes. That matches the sizeof(...), so the MemPool logic got the right
> answer! Yay!
> >
> > Looking at the Blob I see:
> >
> > Bluestore_blob_t 72 bytes
> > Bufferlist 88 bytes
> > Extentrefmap 64 bytes
> >
> > That's most the 248. I suspect that trying to fix this will require a n=
ew
> strategy, etc.
> >
> > Allen Samuels
> > SanDisk |a Western Digital brand
> > 2880 Junction Avenue, San Jose, CA 95134
> > T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
> >
> >
> >> -----Original Message-----
> >> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> >> owner@vger.kernel.org] On Behalf Of Sage Weil
> >> Sent: Friday, December 16, 2016 7:20 AM
> >> To: Igor Fedotov <ifedotov@mirantis.com>
> >> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> >> Subject: Re: BlueStore in-memory Onode footprint
> >>
> >> On Fri, 16 Dec 2016, Igor Fedotov wrote:
> >>> Hey All!
> >>>
> >>> Recently I realized that I'm unable to fit all my onodes ( 32768
> >>> objects/4Mb each/4K alloc unit/no csum) in 15G RAM cache.
> >>>
> >>> Hence decided to estimate Onode in-memory size.
> >>>
> >>> At first I filled 4Mb object with a single 4M write - mempools
> >>> indicate ~5K mem usage for total onode metadata. Good enough.
> >>>
> >>> Secondly I refill that object with 4K writes. Resulting memusage =3D =
574K!!!
> >>> Onode itself 704 bytes in 1 object.  And 4120 other metadata items
> >>> occupies all other space.
> >>>
> >>> Then I removed SharedBlob from mempools. Resulting mem usage =3D
> 355K.
> >>> The same Onode size. And 3096 other metadata objects. Hence we had
> >>> 1024 SharedBlob instances thata took ~ 220K.
> >>>
> >>>
> >>> And finally I removed Blob instances from measurements. Resulting
> mem
> >>> usage =3D 99K. And 2072 other objects. Hence Blob instances take anot=
her
> >>> ~250K
> >> Yikes!
> >>
> >> BTW you can get a full breakdown by type with 'mempool debug =3D true'=
 in
> >> ceph.conf (-o 'mempool debug =3D true' on vstart.sh command line)
> without
> >> having to recompile.  Do you mind repeating the test and including the=
 full
> >> breakdown?
> >>
> >>> Yeah, that's the worst case( actually csum enable will give even more
> >>> mem use) but shouldn't we revisit some Onode internals due to such
> >> numbers?
> >>
> >> Yep!
> >>
> >> sage
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the
> >> body of a message to majordomo@vger.kernel.org More majordomo info
> at
> >> http://vger.kernel.org/majordomo-info.html

