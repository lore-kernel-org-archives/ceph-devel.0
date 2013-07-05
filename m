From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Fri, 05 Jul 2013 23:23:44 +0200
Message-ID: <51D73960.3070303@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E494B06990@PLOXCHG04.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig869B628D0E0DE141C2A240B0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:54465 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab3GEVXt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jul 2013 17:23:49 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E494B06990@PLOXCHG04.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig869B628D0E0DE141C2A240B0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On 04/07/2013 23:01, Andreas Joachim Peters wrote:> Hi Loic,
> thanks for the responses!
>=20
> Maybe this is useful for your erasure code discussion:
>=20
> as an example in our RS implementation we chunk a data block of e.g. 4M=
 into 4 data chunks of 1M. Then we create a 2 parity chunks.
>=20
> Data & parity chunks are split into 4k blocks and these 4k blocks get a=
 CRC32C block checksum each (SSE4.2 CPU extension =3D> MIT library or BTR=
FS). This creates 0.1% volume overhead (4 bytes per 4096 bytes) - nothing=
 compared to the parity overhead ...
>=20
> You can now easily detect data corruption using the local checksums and=
 avoid to read any parity information and (C)RS decoding if there is no c=
orruption detected. Moreover CRC32C computation is distributed over sever=
al (in this case 4) machines while (C)RS decoding would run on a single m=
achine where you assemble a block ... and CRC32C is faster than (C)RS dec=
oding (with SSE4.2) ...

What does (C)RS mean ? (C)Reed-Solomon ?=20

> In our case we write this checksum information separate from the origin=
al data ... while in a block-based storage like CEPH it would be probably=
 inlined in the data chunk.=20
> If an OSD detects to run on BRTFS or ZFS one could disable automaticall=
y the CRC32C code.=20

Nice. I did not know that was built-in :-)=20
https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/erasu=
re-code.rst#scrubbing

> (wouldn't CRC32C be also useful for normal CEPH block replication? )

I don't know the details of scrubbing but it seems CRC is already used by=
 deep scrubbing

https://github.com/ceph/ceph/blob/master/src/osd/PG.cc#L2731

Cheers

> As far as I know with the RS CODEC we use you can either miss stripes (=
data =3D0) in the decoding process but you cannot inject corrupted stripe=
s into the decoding process, so the block checksumming is important.
>=20
> Cheers Andreas.

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig869B628D0E0DE141C2A240B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHXOWEACgkQ8dLMyEl6F22vlQCfdOkyitg9SrxPR/6I0HFusvgn
998An2P845Hi7WYBFNRhiuldQCN9ZQqz
=LFig
-----END PGP SIGNATURE-----

--------------enig869B628D0E0DE141C2A240B0--
