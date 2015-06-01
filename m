From: Loic Dachary <loic@dachary.org>
Subject: Re: Adding "chance_test_backfill_full" thrasher in the ec tasks
Date: Mon, 01 Jun 2015 17:31:12 +0200
Message-ID: <556C7AC0.6040209@dachary.org>
References: <CAMxOGo076WPLnvo+peo=KmDpZUY2Qt34_vXMzgMQqF_TAcEWEA@mail.gmail.com> <1131392043.10604321.1433171919792.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LxPGFB9UN1jTgBEeJGXMS66BiDmimRORI"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54497 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751461AbbFAPbQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jun 2015 11:31:16 -0400
In-Reply-To: <1131392043.10604321.1433171919792.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>, shylesh kumar <shylesh.mohan@gmail.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LxPGFB9UN1jTgBEeJGXMS66BiDmimRORI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I filed http://tracker.ceph.com/issues/11831 and will work on it

On 01/06/2015 17:18, Samuel Just wrote:
> Yep, that should be included in the ec thrashing tests.
> -Sam
>=20
> ----- Original Message -----
> From: "shylesh kumar" <shylesh.mohan@gmail.com>
> To: "Samuel Just" <sjust@redhat.com>, loic@dachary.org
> Cc: ceph-devel@vger.kernel.org
> Sent: Saturday, May 30, 2015 8:27:20 AM
> Subject: Adding "chance_test_backfill_full" thrasher in the ec tasks
>=20
> Hi ,
>=20
> As per discussion with loic none of the ec tests have
> "chance_test_backfill_full" thrasher in the tasks, do you think it
> would be a good idea to add it which can simulate disk space
> scenarios.
>=20
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--LxPGFB9UN1jTgBEeJGXMS66BiDmimRORI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVsesAACgkQ8dLMyEl6F20dAwCfYvAdeaE9mUD2wtolkIo/cPn1
hlsAnRqt3MfeBKYxqY4gshvGx5LvCox4
=ViDV
-----END PGP SIGNATURE-----

--LxPGFB9UN1jTgBEeJGXMS66BiDmimRORI--
