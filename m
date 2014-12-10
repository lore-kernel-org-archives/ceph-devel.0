From: Loic Dachary <loic@dachary.org>
Subject: Re: force pushes disabled for master in ceph.git and ceph-deploy.git
Date: Wed, 10 Dec 2014 23:41:22 +0100
Message-ID: <5488CC12.5020303@dachary.org>
References: <5488C747.2000003@redhat.com> <5488C861.1080005@dachary.org> <5488CA35.1040908@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="o1LIq4bXFIC4iQPpwtBXdoCkaLvWcirsr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50923 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932623AbaLJWlY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Dec 2014 17:41:24 -0500
In-Reply-To: <5488CA35.1040908@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o1LIq4bXFIC4iQPpwtBXdoCkaLvWcirsr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/12/2014 23:33, Ken Dreyer wrote:
> On 12/10/2014 03:25 PM, Loic Dachary wrote:
>> On 10/12/2014 23:20, Ken Dreyer wrote:
>>> Thanks to GitHub Support, force-pushes are now disabled for master in=

>>> ceph.git and ceph-deploy.git. This should save us from accidentally
>>> deleting history with a bad force-push to the wrong branch. (Not that=

>>> any of us were going to do that, of course! :)
>>
>> Thanks ! I did that last year and that makes me appreciate the precaut=
ion ;-)
>=20
> Whoops, so I duplicated your work apparently!

No, I meant I force pushed master inadvertendly last year ;-)
>=20
> I was thinking that we should do this for the release branches as well?=

> So "argonaut", "bobtail", "cuttlefish" "dumpling", "emperor", "firefly"=
,
> "giant"... any other branches?

That would be a good idea.

> And should we open a new support request each time we create a new
> release branch in the future?

Or make it so nobody except a gate has write access, but that's going to =
take some time.

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--o1LIq4bXFIC4iQPpwtBXdoCkaLvWcirsr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSIzBIACgkQ8dLMyEl6F21BXgCgpqPrAHpoqEbIqxxQwp8GleWI
UZAAnjo2JrSm2PCH2NGwr8tEhN3J37OD
=N78Y
-----END PGP SIGNATURE-----

--o1LIq4bXFIC4iQPpwtBXdoCkaLvWcirsr--
