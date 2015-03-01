From: Loic Dachary <loic@dachary.org>
Subject: Re: CephFS and the next firefly release
Date: Sun, 01 Mar 2015 11:18:47 +0100
Message-ID: <54F2E787.90003@dachary.org>
References: <54F1CE4B.5020004@dachary.org> <CAC6JEv9C0g7Kz2eXhzP8-ENVADnHvc+AiRnMvRi6-GwYerEwjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Ejx2bjGQlVx1WrAnPal5wQeI2kbDfbbqB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50888 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750897AbbCAKSu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Mar 2015 05:18:50 -0500
In-Reply-To: <CAC6JEv9C0g7Kz2eXhzP8-ENVADnHvc+AiRnMvRi6-GwYerEwjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ejx2bjGQlVx1WrAnPal5wQeI2kbDfbbqB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On 01/03/2015 06:00, Gregory Farnum wrote:
> On Sat, Feb 28, 2015 at 6:18 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Greg,
>>
>> The fs teuthology suite for the next firefly release as found in https=
://github.com/ceph/ceph/commits/firefly-backports came back with three fa=
ilures : http://tracker.ceph.com/issues/10641#fs. Do you think it is read=
y for QE to start their own round of testing ?
>>
>> Cheers
>>
>> P.S. I'll include the fs suite as part of the pre-QE round of testing =
from now on, unless you think it is redundant or not useful.
>=20
> It'd be nice to see those tests run on a new enough kernel that they
> pass,=20

Is there an open issue for this or should I create one ?

> but yes; should be good!

Cool.

Cheers
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Ejx2bjGQlVx1WrAnPal5wQeI2kbDfbbqB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTy54cACgkQ8dLMyEl6F22MFwCaA0SyAGMu25p9Yk5VwwsrqIJn
R84AmgLKleHKG/PknN0x4DdGTCq64BdW
=QxJh
-----END PGP SIGNATURE-----

--Ejx2bjGQlVx1WrAnPal5wQeI2kbDfbbqB--
