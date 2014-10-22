From: Loic Dachary <loic@dachary.org>
Subject: Re: Can pid be reused ?
Date: Wed, 22 Oct 2014 15:57:35 -0700
Message-ID: <5448365F.7070908@dachary.org>
References: <54471CA6.5040807@dachary.org> <0B26F614-B9E5-4E30-9471-A7F46656AA24@inktank.com> <alpine.DEB.2.00.1410221542450.29946@cobra.newdream.net> <87747DD3-21F2-480E-B61D-91B97237E510@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="11cnQJQpteGMmI9dGl9r614pwbGhbU4m1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51104 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932666AbaJVW5o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Oct 2014 18:57:44 -0400
In-Reply-To: <87747DD3-21F2-480E-B61D-91B97237E510@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--11cnQJQpteGMmI9dGl9r614pwbGhbU4m1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 22/10/2014 15:51, David Zafman wrote:
>=20
>> On Oct 22, 2014, at 3:43 PM, Sage Weil <sage@newdream.net> wrote:
>>
>> On Wed, 22 Oct 2014, David Zafman wrote:
>>> I just realized what it is.  The way killall is used when stopping a =

>>> vstart cluster, is to kill all processes by name!  You can't stop=20
>>> vstarted tests running in parallel.
>>
>> Ah.  FWIW I think we should avoid using stop.sh whenever possible and =

>> instead do ./init-ceph stop (which does an orderly shutdown via pid=20
>> files).
>>
>> sage
>=20
> Actually, vstart.sh can=E2=80=99t create 2 independent clusters anyway,=
 so it kills any existing processes. =20

It can actually, if given a different CEPH_DIR all is contained within th=
is specific directory.

Cheers

> Probably vstart.sh is what would have killed the processes in a paralle=
l make check.
>=20
> David
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--11cnQJQpteGMmI9dGl9r614pwbGhbU4m1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRINl8ACgkQ8dLMyEl6F23pXQCgp85X392F9eO0bYjbY/SJdPBz
xo8AniHWnqW3DNmV/tOg5T4D6VXGVqYn
=2c/x
-----END PGP SIGNATURE-----

--11cnQJQpteGMmI9dGl9r614pwbGhbU4m1--
