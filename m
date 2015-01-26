From: Loic Dachary <loic@dachary.org>
Subject: upcoming dumpling v0.67.12
Date: Mon, 26 Jan 2015 16:37:33 +0100
Message-ID: <54C65F3D.5020200@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sTBgLNfc9whehJ7vLLjwcaNFee9MMj2dS"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47217 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753135AbbAZPhg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jan 2015 10:37:36 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sTBgLNfc9whehJ7vLLjwcaNFee9MMj2dS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

Here is a short update on the progress of the upcoming dumpling v0.67.12.=


It is tracked with http://tracker.ceph.com/issues/10560. In the inventory=
 part, there is a list of all pull requests that are already merged in th=
e dumpling branch. There only is one pull request waiting to be merged an=
d three issues waiting for backports. While these last three are being wo=
rked on, I started rbd, rgw and rados suites.

I chose to display the inventory by pull request because I figured it wou=
ld be more convenient to read because sometimes a single pull request spa=
ns multiple issues ( https://github.com/ceph/ceph/pull/2611 for instance =
fixes two issues ).=20

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--sTBgLNfc9whehJ7vLLjwcaNFee9MMj2dS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTGXz0ACgkQ8dLMyEl6F232QwCeL2M5lMSHVBqZ80NkMWL+696v
zmoAoJYwhl8SoXZr5+sL78hA788jOd8+
=tbn8
-----END PGP SIGNATURE-----

--sTBgLNfc9whehJ7vLLjwcaNFee9MMj2dS--
