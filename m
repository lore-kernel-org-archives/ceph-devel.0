From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology rados runs for next
Date: Tue, 21 Jul 2015 17:42:37 +0200
Message-ID: <55AE686D.2010802@dachary.org>
References: <55AE0667.8020000@dachary.org> <alpine.DEB.2.00.1507210642560.8878@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="OALPe59B06oQVFkAM2lf78sJBPQBviT5I"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53750 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754727AbbGUPmk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 11:42:40 -0400
In-Reply-To: <alpine.DEB.2.00.1507210642560.8878@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OALPe59B06oQVFkAM2lf78sJBPQBviT5I
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Ok !

teuthology-kill -m multi -r teuthology-2015-07-18_21:00:09-rados-next-dis=
tro-basic-multi
teuthology-kill -m multi -r teuthology-2015-07-20_21:00:09-rados-next-dis=
tro-basic-multi

I observed that the older=20

http://pulpito.ceph.com/teuthology-2015-07-17_21:00:10-rados-next-distro-=
basic-multi

is half way through but does not seem to make progress while the one sche=
duled today

http://pulpito.ceph.com/teuthology-2015-07-19_21:00:10-rados-next-distro-=
basic-multi

has one job running. Do you think best to kill the newer so it does not c=
ompete for resources that would prevent the older from finishing ? I'd be=
 tempted to kill the newer because it's so difficult to get jobs running =
right now that it makes sense to preserve a run that already managed to p=
ass > 100 jobs :-)

Cheers

On 21/07/2015 15:43, Sage Weil wrote:
> On Tue, 21 Jul 2015, Loic Dachary wrote:
>> Hi Sam,
>>
>> I noticed today that http://pulpito.ceph.com/?suite=3Drados&branch=3Dn=
ext is=20
>> lagging three days behind. Do we want to keep all the runs or should w=
e=20
>> kill the older ones ? I suppose there would be value in having the=20
>> results for all of them but given the current load in the sepia lab it=
=20
>> also significantly delays them. What do you think ?
>=20
> I think it's better to kill old scheduled runs.
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--OALPe59B06oQVFkAM2lf78sJBPQBviT5I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWuaG0ACgkQ8dLMyEl6F22q2ACeMlPduT1P36IKut/6MCKfC4Kz
sCMAn1f3lS1NRmQbkggjJMPWjdPP7CgU
=Bn7v
-----END PGP SIGNATURE-----

--OALPe59B06oQVFkAM2lf78sJBPQBviT5I--
