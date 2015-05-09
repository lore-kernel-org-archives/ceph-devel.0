From: Loic Dachary <loic@dachary.org>
Subject: Re: RFC: Deprecating ceph-tool commands
Date: Sat, 09 May 2015 10:57:48 +0200
Message-ID: <554DCC0C.7040000@dachary.org>
References: <554D4CD8.6020809@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Rk19saiQ2gQBC4rpN70nVevuuaFiQ4EGV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60344 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753276AbbEII5v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 May 2015 04:57:51 -0400
In-Reply-To: <554D4CD8.6020809@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rk19saiQ2gQBC4rpN70nVevuuaFiQ4EGV
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/05/2015 01:55, Joao Eduardo Luis wrote:
> This approach gives a lifespan of roughly 3 releases (at current rate,
> roughly 1.5 years) before being completely dropped.  This should give
> enough time to people to realize what has happened and adjust any
> scripts they may have.

That sounds reasonable.=20

In the python documentation I find it very convenient to have "New in X.Y=
=2EZ" next to a given API call or behavior, as well as "Deprectated since=
". Although release notes https://github.com/ceph/ceph/commit/e3b788a56c6=
40fb19d8aa9464ebf5bc84c97ec6f are useful when upgrading (to answer the qu=
estion "What API will break ?"), it's not the primary location I'll check=
 when considering using something.=20

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Rk19saiQ2gQBC4rpN70nVevuuaFiQ4EGV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVNzAwACgkQ8dLMyEl6F2236gCgi7jl0E5LXWNS620yehPLhzbD
NxIAnjbqfvNTKoG3xT1tNw2TdnA7TE1d
=Jo9s
-----END PGP SIGNATURE-----

--Rk19saiQ2gQBC4rpN70nVevuuaFiQ4EGV--
