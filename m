From: Loic Dachary <loic@dachary.org>
Subject: Re: dumpling branch for v0.67.12 is ready for release
Date: Sun, 15 Mar 2015 22:24:32 +0100
Message-ID: <5505F890.1010000@dachary.org>
References: <54ECB06E.9020507@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="tqK2SOveSB8NgV2J209iGLrU6q7qtHj0e"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58367 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751296AbbCOVYo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 15 Mar 2015 17:24:44 -0400
In-Reply-To: <54ECB06E.9020507@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tqK2SOveSB8NgV2J209iGLrU6q7qtHj0e
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

A gentle reminder ;-)

Cheers

On 24/02/2015 18:10, Loic Dachary wrote:
> Hi Sage,
>=20
> QE approved https://github.com/ceph/ceph/commit/77dfbbaccfb5074899d0231=
4a26cb9ac46a69106 for release in the https://github.com/ceph/ceph/commits=
/dumpling branch. The release notes should now be written based on the co=
ntent of the issues and pull requests mentioned here http://workbench.dac=
hary.org/ceph/ceph-backports/wikis/dumpling#already-merged
>=20
> The release notes can now be written. In the future I'll ask about the =
release notes earlier: the last tests do not change anything significant =
and take days if not week. They can conveniently be done while the releas=
e notes are written[1] instead of making them a blocker at the very end. =

>=20
> Cheers
>=20
> [1] Cutting a new stable release http://ceph.com/docs/master/dev/develo=
pment-workflow/#cutting-a-new-stable-release
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--tqK2SOveSB8NgV2J209iGLrU6q7qtHj0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUF+JEACgkQ8dLMyEl6F23IKQCgiE5kvlCNXh9abaC4jT0MeIIX
beQAoIEqG2r+dnfOOqdk0ZjJNBIKyc6P
=vF0l
-----END PGP SIGNATURE-----

--tqK2SOveSB8NgV2J209iGLrU6q7qtHj0e--
