From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Fri, 23 Aug 2013 01:03:52 +0200
Message-ID: <521698D8.5020009@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E494B06990@PLOXCHG04.cern.ch> <51D73960.3070303@dachary.org> <CAGhffvx5-xmprT-vL1VNrz12+pJSikg1WsUqy_JRdW0JNm5auQ@mail.gmail.com> <51D8827E.8030906@dachary.org> <3472A07E6605974CBC9BC573F1BC02E494B06E64@PLOXCHG04.cern.ch> <5211F508.3030706@dachary.org> <CAGhffvwB87a+1294BjmPrfu0a9hYdu17N-eHOvYCHWMXDLcJmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAC4B197B8A00B2B43CDACBE0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:51340 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab3HVXDz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Aug 2013 19:03:55 -0400
In-Reply-To: <CAGhffvwB87a+1294BjmPrfu0a9hYdu17N-eHOvYCHWMXDLcJmA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAC4B197B8A00B2B43CDACBE0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 22/08/2013 23:42, Andreas-Joachim Peters wrote:> Hi Loic,=20
> sorry for the late reply, I was on vacation ...  you are right, I did a=
 simple logical mistake since I assumed you loose only the data stripes b=
ut never the parity stripes which is a very wrong assumption.
>=20
> So for testing you probably could just implement (2+1) and then move to=
 jerasure or dual parity (4+2) where you build horizontal and diagonal pa=
rities.
>=20

Hi Andreas,

That's what I did :-) It would be great if you could review the proposed =
implementation at https://github.com/ceph/ceph/pull/518/files . I'll keep=
 working on https://github.com/dachary/ceph/commit/83845a66ae1cba63c122c0=
ef7658b97b474c2bd2 tomorrow to create the jerasure plugin but it's not re=
ady for review yet.=20

Cheers

> Cheers Andreas.
>=20
>=20
>=20
>=20
>=20
> On Mon, Aug 19, 2013 at 12:35 PM, Loic Dachary <loic@dachary.org <mailt=
o:loic@dachary.org>> wrote:
>=20
>     Hi Andreas,
>=20
>     Trying to write minimal code as you suggested, for an example plugi=
n. My first attempt at writing an erasure coding function. I don't get ho=
w you can rebuild P1 + A from P2 + B + C. I must be missing something obv=
ious :-)
>=20
>     Cheers
>=20
>     On 07/07/2013 23:04, Andreas Joachim Peters wrote:
>     >
>     > Hi Loic,
>     > I don't think there is a better generic implementation. Just made=
 a benchmark .. the Jerasure library with algorithm 'cauchy_good' gives 1=
=2E1 GB/s (Xeon 2.27 GHz) on a single core for a 4+2 encoding w=3D32. Jus=
t to give a feeling if you do 10+4 it is 300 MB/s .... there is a special=
ized implementation in QFS (Hadoop in C++) for (M+3) ... for curiosity I =
will make a benchmark with this to compare with Jerasure ...
>     >
>     > In any case I would do an optimized implementation for 3+2 which =
would be probably the most performant implementation having the same reli=
ability like standard 3-fold replication in CEPH using only 53% of the sp=
ace.
>     >
>     > 3+2 is trivial since you encode (A,B,C) with only two parity oper=
ations
>     > P1 =3D A^B
>     > P2 =3D B^C
>     > and reconstruct with one or two parity operations:
>     > A =3D P1^B
>     > B =3D P1^A
>     > B =3D P2^C
>     > C =3D P2^B
>     > aso.
>     >
>     > You can write this as a simple loop using advanced vector extensi=
ons on Intel (AVX). I can paste a benchmark tomorrow.
>     >
>     > Considering the crc32c-intel code you added ... I would provide a=
 function which provides a crc32c checksum and detects if it can do it us=
ing SSE4.2 or implements just the standard algorithm e.g if you run in a =
virtual machine you need this emulation ...
>     >
>     > Cheers Andreas.
>     > ________________________________________
>     > From: Loic Dachary [loic@dachary.org <mailto:loic@dachary.org>]
>     > Sent: 06 July 2013 22:47
>     > To: Andreas Joachim Peters
>     > Cc: ceph-devel@vger.kernel.org <mailto:ceph-devel@vger.kernel.org=
>
>     > Subject: Re: CEPH Erasure Encoding + OSD Scalability
>     >
>     > Hi Andreas,
>     >
>     > Since it looks like we're going to use jerasure-1.2, we will be a=
ble to try (C)RS using
>     >
>     > https://github.com/tsuraan/Jerasure/blob/master/src/cauchy.c
>     > https://github.com/tsuraan/Jerasure/blob/master/src/cauchy.h
>     >
>     > Do you know of a better / faster implementation ? Is there a trad=
eoff between (C)RS and RS ?
>     >
>     > Cheers
>     >
>     > On 06/07/2013 15:43, Andreas-Joachim Peters wrote:
>     >> HI Loic,
>     >> (C)RS stands for the Cauchy Reed-Solomon codes which are based o=
n pure parity operations, while the standard Reed-Solomon codes need more=
 multiplications and are slower.
>     >>
>     >> Considering the checksumming ... for comparison the CRC32 code f=
rom libz run's on a 8-core Xeon at ~730 MB/s for small block sizes while =
SSE4.2 CRC32C checksum run's at ~2GByte/s.
>     >>
>     >> Cheers Andreas.
>     >>
>     >>
>     >>
>     >>
>     >> On Fri, Jul 5, 2013 at 11:23 PM, Loic Dachary <loic@dachary.org =
<mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachary.o=
rg>>> wrote:
>     >>
>     >>     Hi Andreas,
>     >>
>     >>     On 04/07/2013 23:01, Andreas Joachim Peters wrote:> Hi Loic,=

>     >>     > thanks for the responses!
>     >>     >
>     >>     > Maybe this is useful for your erasure code discussion:
>     >>     >
>     >>     > as an example in our RS implementation we chunk a data blo=
ck of e.g. 4M into 4 data chunks of 1M. Then we create a 2 parity chunks.=

>     >>     >
>     >>     > Data & parity chunks are split into 4k blocks and these 4k=
 blocks get a CRC32C block checksum each (SSE4.2 CPU extension =3D> MIT l=
ibrary or BTRFS). This creates 0.1% volume overhead (4 bytes per 4096 byt=
es) - nothing compared to the parity overhead ...
>     >>     >
>     >>     > You can now easily detect data corruption using the local =
checksums and avoid to read any parity information and (C)RS decoding if =
there is no corruption detected. Moreover CRC32C computation is distribut=
ed over several (in this case 4) machines while (C)RS decoding would run =
on a single machine where you assemble a block ... and CRC32C is faster t=
han (C)RS decoding (with SSE4.2) ...
>     >>
>     >>     What does (C)RS mean ? (C)Reed-Solomon ?
>     >>
>     >>     > In our case we write this checksum information separate fr=
om the original data ... while in a block-based storage like CEPH it woul=
d be probably inlined in the data chunk.
>     >>     > If an OSD detects to run on BRTFS or ZFS one could disable=
 automatically the CRC32C code.
>     >>
>     >>     Nice. I did not know that was built-in :-)
>     >>     https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_in=
ternals/erasure-code.rst#scrubbing
>     >>
>     >>     > (wouldn't CRC32C be also useful for normal CEPH block repl=
ication? )
>     >>
>     >>     I don't know the details of scrubbing but it seems CRC is al=
ready used by deep scrubbing
>     >>
>     >>     https://github.com/ceph/ceph/blob/master/src/osd/PG.cc#L2731=

>     >>
>     >>     Cheers
>     >>
>     >>     > As far as I know with the RS CODEC we use you can either m=
iss stripes (data =3D0) in the decoding process but you cannot inject cor=
rupted stripes into the decoding process, so the block checksumming is im=
portant.
>     >>     >
>     >>     > Cheers Andreas.
>     >>
>     >>     --
>     >>     Lo=EFc Dachary, Artisan Logiciel Libre
>     >>     All that is necessary for the triumph of evil is that good p=
eople do nothing.
>     >>
>     >>
>     >
>     > --
>     > Lo=EFc Dachary, Artisan Logiciel Libre
>     > All that is necessary for the triumph of evil is that good people=
 do nothing.
>     >
>     > --
>     > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>     > the body of a message to majordomo@vger.kernel.org <mailto:majord=
omo@vger.kernel.org>
>     > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>     >
>=20
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>     All that is necessary for the triumph of evil is that good people d=
o nothing.
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigAC4B197B8A00B2B43CDACBE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIWmNgACgkQ8dLMyEl6F23aEACghbfB4TxlLDcizhH+CqA75uJM
hfMAoKFgNbmxQ/h1/IcSma5ftabzezxB
=0S7O
-----END PGP SIGNATURE-----

--------------enigAC4B197B8A00B2B43CDACBE0--
