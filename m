From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: RE: BlueStore in-memory Onode footprint
Date: Sat, 17 Dec 2016 00:34:54 +0000
Message-ID: <EB02EE10422E4A40A1EE787A4AC27FBE0324D5@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
References: <34ee2613-8db3-646e-4470-b3e8fa8855e0@mirantis.com>
 <alpine.DEB.2.11.1612161518570.10615@piezo.novalocal>
 <EB02EE10422E4A40A1EE787A4AC27FBE0321CB@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.11.1612162231370.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:34859
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932929AbcLQAu4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 16 Dec 2016 19:50:56 -0500
In-Reply-To: <alpine.DEB.2.11.1612162231370.10615@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Friday, December 16, 2016 2:33 PM
> To: Allen Samuels <Allen.Samuels@sandisk.com>
> Cc: Igor Fedotov <ifedotov@mirantis.com>; ceph-devel <ceph-
> devel@vger.kernel.org>
> Subject: RE: BlueStore in-memory Onode footprint
>=20
> On Fri, 16 Dec 2016, Allen Samuels wrote:
> > I'm not sure what the conclusion from this is.
> >
> > The point of the sharding exercise was to eliminate the need to
> > serialize/deserialize all 1024 Extents/Blobs/SharedBlobs on each I/O
> > transaction.
> >
> > This shows that a fully populated oNode with ALL of the shards present
> > is a large number. But that ought to be a rare occurrence.
> >
> > This test shows that each Blob is 248 bytes and that each SharedBlob
> > is
> > 216 bytes. That matches the sizeof(...), so the MemPool logic got the
> > right answer! Yay!
> >
> > Looking at the Blob I see:
> >
> > Bluestore_blob_t 72 bytes
> > Bufferlist 88 bytes
> > Extentrefmap 64 bytes
> >
> > That's most the 248. I suspect that trying to fix this will require a
> > new strategy, etc.
>=20
> Well, one thing we might consider: right now the prune cache content at t=
he
> granularity of onode.  We might want to put the shards in an LRU too and
> prune old shards...

Not sure I really see the value of that. Seems to me that Igor's test case =
is pretty rare.=20

I think in this case, you don't need to work well -- you just need to work.

As long as the pruning is based on the actual memory consumption rather tha=
n the oNode count I think we're fine.

Realistically, retaining deserialized oNodes is only valuable for sequentia=
l read/write cases. In which case you don't need=20
A large number of oNodes, just a few per client connection ought to do it.

>=20
> sage
>=20
>  >
> > Allen Samuels
> > SanDisk |a Western Digital brand
> > 2880 Junction Avenue, San Jose, CA 95134
> > T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
> >
> >
> > > -----Original Message-----
> > > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > > owner@vger.kernel.org] On Behalf Of Sage Weil
> > > Sent: Friday, December 16, 2016 7:20 AM
> > > To: Igor Fedotov <ifedotov@mirantis.com>
> > > Cc: ceph-devel <ceph-devel@vger.kernel.org>
> > > Subject: Re: BlueStore in-memory Onode footprint
> > >
> > > On Fri, 16 Dec 2016, Igor Fedotov wrote:
> > > > Hey All!
> > > >
> > > > Recently I realized that I'm unable to fit all my onodes ( 32768
> > > > objects/4Mb each/4K alloc unit/no csum) in 15G RAM cache.
> > > >
> > > > Hence decided to estimate Onode in-memory size.
> > > >
> > > > At first I filled 4Mb object with a single 4M write - mempools
> > > > indicate ~5K mem usage for total onode metadata. Good enough.
> > > >
> > > > Secondly I refill that object with 4K writes. Resulting memusage =
=3D
> 574K!!!
> > > > Onode itself 704 bytes in 1 object.  And 4120 other metadata items
> > > > occupies all other space.
> > > >
> > > > Then I removed SharedBlob from mempools. Resulting mem usage =3D
> 355K.
> > > > The same Onode size. And 3096 other metadata objects. Hence we had
> > > > 1024 SharedBlob instances thata took ~ 220K.
> > > >
> > > >
> > > > And finally I removed Blob instances from measurements. Resulting
> > > > mem usage =3D 99K. And 2072 other objects. Hence Blob instances tak=
e
> > > > another ~250K
> > >
> > > Yikes!
> > >
> > > BTW you can get a full breakdown by type with 'mempool debug =3D true=
'
> > > in ceph.conf (-o 'mempool debug =3D true' on vstart.sh command line)
> > > without having to recompile.  Do you mind repeating the test and
> > > including the full breakdown?
> > >
> > > > Yeah, that's the worst case( actually csum enable will give even
> > > > more mem use) but shouldn't we revisit some Onode internals due to
> > > > such
> > > numbers?
> > >
> > > Yep!
> > >
> > > sage
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe
> > > ceph-devel" in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at http://vger.kernel.org/majordomo-info.html
> >
> >
