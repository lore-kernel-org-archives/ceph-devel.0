From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure code library summary
Date: Wed, 19 Jun 2013 12:41:45 +0200
Message-ID: <51C18AE9.1060405@dachary.org>
References: <51C05123.8000002@dachary.org> <kpr0dn$3cr$1@ger.gmane.org> <kpr0ld$3cr$2@ger.gmane.org> <51C156FA.2000509@dachary.org> <kprnn8$l72$1@ger.gmane.org> <51C16CE3.9020004@dachary.org> <kprsfk$7ag$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig03E6FBE7150CDE66AEBB273F"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:50144 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933991Ab3FSKlr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 06:41:47 -0400
In-Reply-To: <kprsfk$7ag$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig03E6FBE7150CDE66AEBB273F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 06/19/2013 11:09 AM, Alex Elsayed wrote:
> Loic Dachary wrote:
>=20
>> Hi Alex,
>>
>> If I understand correctly, part of what you propose is to make use of
>> fountain codes to optimize replicas transmissions. It could even be us=
ed
>> to speed up replication by allowing existing copies to contribute to t=
he
>> completion of the others. Although this is very appealing, it may be
>> outside of the scope of my current work. Unless you tell me that both
>> topics are intimately linked and should be handled simultaneously for =
some
>> reason :-)
>=20
> No, just an idea that hit while I was thinking about Raptor codes with =

> regard to Ceph. I'd read up on them a bit ago and had seen a few papers=
=20
> describing video distribution systems that made use of that.
>=20
>> The erasure coded placement group could work as follows:
>>
>> * Placement group is using K+M OSDs
>>
>> * An object is sent by a client to the primary OSD
>> * The primary OSD code the object in K+M chunks
>> * The primary OSD writes the chunks to the OSDs in order
>=20
> Well, one thing to consider is whether you want the additional complexi=
ty of=20
> explicitly scheduling where they go, when it's been said before that a.=
)=20
> parity recovery is going to be a (somewhat) common operation and b.) we=
're=20
> unlikely to be CPU-bound on encode/decode, considering network and disk=
 IO.
>=20
> It might be a win to have some simple header denoting which chunk is wh=
ich,=20
> toss them onto the appropriate OSDs in whatever order, and just let the=
=20
> read-side decode whichever K it gets. With Reed-Solomon being an optima=
l=20
> erasure code, K are guaranteed to be enough.
>=20
>> * The primary OSD acknowledge the write
>>
>> * An object is read by a client from the primary OSD
>> * The primary OSD reads the K chunks from the K OSDs
>> * The primary OSD concatenates the K chunks and returns the result
>=20
> The other reason I suggested what I did above is that then you have exa=
ctly=20
> one code path here - fetch && decode. If the K you get are the input da=
ta,=20
> it's a nice degenerate case, but having a single codepath might help wi=
th=20
> reliability and maintainability.
>=20
> Unless it's known to be a bottleneck, this just tweaks my 'premature=20
> optimization' meter a little.
>=20
> If you want to add it later, it can be done without breaking compatibil=
ity -=20
> add a branch for if the chunks you got are the contiguous real data on =
the=20
> read side, preferentially fetch from certain OSDs, and do that location=
=20
> scheduling on the write side for new chunks.
>=20
> Over time, chunks will be allocated in such a way that you get the beha=
vior=20
> you propose above, and for older chunks it just decodes them like alway=
s.
>=20
>> I'd be interested to know if you see a problem with this approach. I c=
ould
>> elaborate on how it would behave when scrubbing, or when the OSDMap
>> changes ( either because new OSDs becomes available or because an OSD
>> fails ).
>=20
> I'd like that, because those are exactly the cases I'd expect the expli=
cit=20
> scheduling to be a burden rather than a help.

You made me realize that I always thought about the best case scenario :-=
) It is indeed easier to store the rank of the chunk as an attribute of t=
he object containing the payload so that the order of the chunks does not=
 rely on the order of the OSDs.

A placement group uses an ordered list of OSDs, the first of which is it =
the primary and the others are the replicas. The order of the list does n=
ot change as long as the OSD map stays the same (i.e. no change in the cr=
ush map and no OSD coming in or going out ). Let say we have K =3D 3, M =3D=
 2

epoch 1 =3D> OSD 1 / chunk 1, OSD 2 / chunk 2, OSD 3 / chunk 3, OSD 4 / c=
hunk 4, OSD 5 / chunk 5

The first three chunks ( K =3D 3 ) are on OSD 1, 2, 3 and could be used w=
hen reading by concatenating them in order. The parity chunks are on OSD =
4, 5.

OSD 2 dies and the placement group needs to recover

epoch 1 =3D> OSD 1 / chunk 1, OSD 2 / chunk 2, OSD 3 / chunk 3, OSD 4 / c=
hunk 4, OSD 5 / chunk 5
epoch 2 =3D> OSD 1 / chunk 1, OSD 3 / chunk 3, OSD 4 / chunk 4, OSD 5 / c=
hunk 5, OSD 6 / chunk 2=20

The placement group can still allow reads and does so with OSD 1, OSD 3 a=
nd OSD 4 although they cannot be concatenated. The missing chunk ( 2 ) is=
 reconstructed during the placement group recovery and written to OSD 6 t=
ogether with its rank.

Reducing the CPU load by making sure chunks are simply concatenated when =
possible does look like early optimization indeed. It can be implemented =
later, if necessary, without changing the architecture.

Cheers
>=20
>> Cheers
>>
>=20
> <snip quotes>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig03E6FBE7150CDE66AEBB273F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHBiukACgkQ8dLMyEl6F23DXwCfRCj2x7/6gmjYJ9f+Cb6J1iaj
xwIAn1wZL82OhBpmn2oo9DE3pGTusGlt
=7m5B
-----END PGP SIGNATURE-----

--------------enig03E6FBE7150CDE66AEBB273F--
