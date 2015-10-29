From: Loic Dachary <loic@dachary.org>
Subject: Re: civetweb upstream/downstream divergence
Date: Fri, 30 Oct 2015 01:56:15 +0900
Message-ID: <56324FAF.9040504@dachary.org>
References: <5631E4A5.9020003@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="W06HERHXC2iDtmQ9CD7J96jI9ORsS0BT9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52017 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757354AbbJ2Q4W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Oct 2015 12:56:22 -0400
In-Reply-To: <5631E4A5.9020003@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W06HERHXC2iDtmQ9CD7J96jI9ORsS0BT9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

It would be a good thing to get a report on a regular basis that shows ho=
w different the git submodules are from their respective upstream.

Cheers

On 29/10/2015 18:19, Nathan Cutler wrote:
> Hi Ceph:
>=20
> The civetweb code in RGW is taken from https://github.com/ceph/civetweb=
/
> which is a fork of https://github.com/civetweb/civetweb. The last commi=
t
> to our fork took place on March 18.
>=20
> Upstream civetweb development has progressed ("This branch is 19 commit=
s
> ahead, 972 commits behind civetweb:master.")
>=20
> Are there plans to rebase to a newer upstream version or should we thin=
k
> more in terms of backporting (to ceph/civetweb.git) from upstream
> (civetweb/civetweb.git) when we need to fix bugs or add features?
>=20
> Thanks and regards
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--W06HERHXC2iDtmQ9CD7J96jI9ORsS0BT9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEUEARECAAYFAlYyT68ACgkQ8dLMyEl6F20E7QCYkjUHmtx/mqv25IfgCd/pte2F
NACgm00/Dp7lAhcOgBP+mAGcQtY5R4A=
=jaWo
-----END PGP SIGNATURE-----

--W06HERHXC2iDtmQ9CD7J96jI9ORsS0BT9--
