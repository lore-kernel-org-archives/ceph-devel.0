From: Loic Dachary <loic@dachary.org>
Subject: Re: dumpling & giant backports update
Date: Tue, 10 Feb 2015 17:25:00 +0100
Message-ID: <54DA30DC.5040109@dachary.org>
References: <54DA2303.9070003@dachary.org> <190003157.14855539.1423585180297.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1pquwk5UjpIkkxR7EEFRiC5nUMg2JIgiv"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41836 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750877AbbBJQZD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Feb 2015 11:25:03 -0500
In-Reply-To: <190003157.14855539.1423585180297.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1pquwk5UjpIkkxR7EEFRiC5nUMg2JIgiv
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/02/2015 17:19, Yuri Weinstein wrote:
> Hi Loic
>=20
> I was thinking that as soon as one of the branches is declared "ready" =
we will merge *-backports with the main branch and execute appropriate se=
t of suites as we run them in the Octo lab for released branches.
>

Ok.

> For dumpling:
> rados
> rbd
> rgw
> fs
> ceph-deploy
> upgrade/dumpling
>=20
> For giant:
> rados
> rbd
> rgw
> fs
> krbd
> kcephfs
> knfs
> haddop
> samba
> rest
> multimds
> multi-version
> upgrade/giant
> powecycle
>=20
> Not sure if we need to run more tests, e.g. giant-x kind of suites for =
upgrades.
>=20
> Do you agree with this plan?=20

Yes !

Cheers

>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yuri.weinstein@inktank.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, February 10, 2015 7:25:55 AM
> Subject: dumpling & giant backports update
>=20
> Hi Yuri,
>=20
> The dumpling integration branch https://github.com/ceph/ceph/commits/du=
mpling-backports is ready for Josh and Sam and we are expecting approval =
from Yehuda (the details are here http://tracker.ceph.com/issues/10560).
>=20
> The giant integration branch https://github.com/ceph/ceph/commits/giant=
-backports is ready for Sam and we are expecting approval from Josh and Y=
ehuda (the details are here http://tracker.ceph.com/issues/10501).
>=20
> It is likely that we get approval for one branch or the other in the ne=
xt 48h. When we do, I assume you will be conducting your own round of tes=
ting, using the dumpling-backports and/or giant-backports branch. Do you =
have a list of suites you plan to run already ? I'm also curious to under=
stand who will be analyzing the results and ultimately declare that it is=
 ready to be released.
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--1pquwk5UjpIkkxR7EEFRiC5nUMg2JIgiv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTaMNwACgkQ8dLMyEl6F22qCgCfRUD5cHpAKZ+AeRxW9pU/mZ71
JwQAnjrOnT3J47c/YGL+Dv5pFfmQmhPw
=yFBM
-----END PGP SIGNATURE-----

--1pquwk5UjpIkkxR7EEFRiC5nUMg2JIgiv--
