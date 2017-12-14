From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Ceph Manager brag module
Date: Thu, 14 Dec 2017 22:37:16 +0000
Message-ID: <robbat2-20171214T223534-352252711Z@orbis-terrarum.net>
References: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mPOSj6iWmtyhwOMz"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:35034 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753990AbdLNWhS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 14 Dec 2017 17:37:18 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id EE3973416A4
        for <ceph-devel@vger.kernel.org>; Thu, 14 Dec 2017 22:37:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <92f9a34b-65ef-0441-10a0-1112ffadb87f@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--mPOSj6iWmtyhwOMz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2017 at 10:24:24AM +0100, Wido den Hollander wrote:
> Hi,
>=20
> After discussing with Sage I started to work [0] on a 'brag' module for=
=20
> Ceph Manager.
>=20
> The intention of this module is to send (after a opt-in!) statistics=20
> about a Ceph cluster back to the project every few days.
I like it, but have one concern.

> My intention is to include:
> - fsid (as identifier)
Please don't expose the raw FSID.
Consider a hash of FSID before submission.

> - number of MONs
> - number of OSDs
> - FileStore / BlueStore
> - number of pools / PGs
> - data used in bytes
> - data free
> - number of objects,
> - version(s)
RGWs?

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Asst. Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--mPOSj6iWmtyhwOMz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAloy/RtfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsQ1OA/8CoVPrbMxd4PBNyB76jJchDkAgIf1HbHPLZpdGNybqchc+g9eyp6++3Ih
wAFrxCZNWxfhl9upigvGIMsMFmua8Sk57B0Jd/iljyvtmaBBCdIuHzzDA5F50M58
2ulI5m51uZKCwAOtWmRF2oH79Le7teySpN+uyPGUby6RTqGKioTg6XbQIKBqSbr3
mrEgftIxkRF77FgddmFaaY4jzerd9g9uZ2Vx5SfChdYzTlxyYWwcp+LZi5rDeGfb
woo4QYSTTtcXDcfmgfXOKb4rSqPR0S1Q07nZ7XUdAK0DtADANKGzaDXxQYtD4ntd
jB4Z60nEVsgOETE6dLdqJKtdahzLK+eDSj2Wl1eoPHKsQXQu6CAOOkRt2z2zb1Zg
nY8cWnk49ulqmu+xUg1cY74EBAAm8Xi06/pVak1O9Wi8cl7ghSEqba/gQvSh7zFH
KXiywFk1Abeg5pcWRCTw1wX2/LH/l9h8vNUaBK/9ET9ZIeF44aJe+pkXViNDrLF5
tZa6iz1+ZDZan5eKgzzI97vWFIRyMpmD+CshONOaaqLPzDY80KT9LuHlStsamK38
wDjvhK1/TZZV7FKMdh3191XFUiO6Qt3Ug/eB++I/S6WZK8cL7YN19b4ZHeVFGxsO
AQSk/ROa/Ctr/WwdJ+7Nhk1ta/jkts2SBQmX1nhgen4hJCelPfE=
=FFs8
-----END PGP SIGNATURE-----

--mPOSj6iWmtyhwOMz--
