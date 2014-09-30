From: Loic Dachary <loic@dachary.org>
Subject: Re: New Defects reported by Coverity Scan for ceph (fwd)
Date: Tue, 30 Sep 2014 19:26:35 +0200
Message-ID: <542AE7CB.6070907@dachary.org>
References: <alpine.DEB.2.00.1409300658510.6593@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AlsVRV5db0pVNb9kl0378tL1X0nmbV65G"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35046 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751874AbaI3R0m (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 13:26:42 -0400
In-Reply-To: <alpine.DEB.2.00.1409300658510.6593@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AlsVRV5db0pVNb9kl0378tL1X0nmbV65G
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I'll fix the aio.cc problems, thanks !

On 30/09/2014 15:59, Sage Weil wrote:
> Looks like recent changes from Greg, Loic, and I.
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--AlsVRV5db0pVNb9kl0378tL1X0nmbV65G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQq58sACgkQ8dLMyEl6F21hNgCgwWvU4WIVtPUBooFCvzH8xi8H
h6kAnj2XdNJcFIAeg7AP8zQau4aHS/Qd
=+BY7
-----END PGP SIGNATURE-----

--AlsVRV5db0pVNb9kl0378tL1X0nmbV65G--
