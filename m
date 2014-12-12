From: Loic Dachary <loic@dachary.org>
Subject: Re: Reducing backfilling/recovery long tail
Date: Fri, 12 Dec 2014 18:59:42 +0100
Message-ID: <548B2D0E.2030004@dachary.org>
References: <548B06D2.90609@dachary.org> <alpine.DEB.2.00.1412120812070.23559@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lXOAWRgA5uhLhrPN7tjvFc2pxe0wWEldC"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52089 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031159AbaLLR7p (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Dec 2014 12:59:45 -0500
In-Reply-To: <alpine.DEB.2.00.1412120812070.23559@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Samuel Just <sam.just@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lXOAWRgA5uhLhrPN7tjvFc2pxe0wWEldC
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 12/12/2014 17:12, Sage Weil wrote:
> On Fri, 12 Dec 2014, Loic Dachary wrote:
>> Hi Sam & Sage,
>>
>> In the context of http://tracker.ceph.com/issues/9566 I'm inclined to =

>> think the best solution would be that the AsyncReserver choose a PG=20
>> instead of just picking the next one in the list when there is a free =

>> slot. It would always choose a PG that must move to/from an OSDs for=20
>> which there are more PGs waiting in the AsyncRerserver than any other =

>> OSD. The sort involved does not seem too expensive.
>>
>> Calculating priorities before adding the PG to the AsyncReserver seems=
=20
>> wrong because the state of the system will change significantly while =

>> the PG is waiting to be processed. For instance the first PGs to be=20
>> added have a low priority while the next have increasing priorities wh=
en=20
>> they accumulate. If reservations are canceled because the OSD map=20
>> changed again (maybe another OSD is decommissioned before recovery of =

>> the first one completes), you may end up having high priorities for PG=
s=20
>> that are no longer associated with busy OSDs. That could backfire and =

>> create even more frequent long tails.
>>
>> What do you think ?
>=20
> That makes sense.  In order to make that decision, it means that the OS=
Ds=20
> need to be sharing the level of recovery work they have pending on a=20
> regular basis, right?
> =20

It may not be necessary. The local_reserver is populated with all PGs tha=
t need to move. Say 50 of them are for osd.0 and 10 are for osd.1. The de=
cision is made to schedule a PG for osd.0 because it has more PG to go. T=
his PG will then try to get a remote_reserver slot on osd.0 : if it turns=
 out that osd.0 already is busy, it will be queued. Up to osd_max_backfil=
l can be queued for a given osd in the remote_reserver in this way becaus=
e only osd_max_backfill PGs will get a slot in the local_reserver. Since =
the remote_reserver queue is capped by osd_max_backfill, its length does =
not accurately reflect the workload associated to an OSD. For this reason=
 the priority could be modified when asking for the remote reservation (t=
he priority field that we currently have) to reflect the workload. If the=
 workload change while PGs are waiting in the remote_reserver queue, it c=
ould be that these PGs are given a priority that is sub-optimal. It is pr=
obably an acceptable tradeoff since it impacts onl
y osd_max_backfill PGs per osd. In contrast, hundreds of PGs could be que=
ued in the local_reserver and setting a priority for them at the time the=
y are queued could have lasting undesirable side effects.

I should probably enumerate the steps of an actual situation to clarify m=
y thinking :-)

Cheers

> sage
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--lXOAWRgA5uhLhrPN7tjvFc2pxe0wWEldC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSLLQ4ACgkQ8dLMyEl6F20+mwCeI6LUAI8HBMOIDImiJqsrCeiM
lx0AniGgt123fl3bjOEZQqwIB4YySfkA
=cozG
-----END PGP SIGNATURE-----

--lXOAWRgA5uhLhrPN7tjvFc2pxe0wWEldC--
