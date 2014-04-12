From: Loic Dachary <loic@dachary.org>
Subject: Re: New Defects reported by Coverity Scan for ceph (fwd)
Date: Sat, 12 Apr 2014 10:26:05 +0200
Message-ID: <5348F89D.3080407@dachary.org>
References: <alpine.DEB.2.00.1404112105310.16913@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ARD55gGn7koBDfHG0xugOJf1JVFUpipoU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:48209 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaDLI0M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Apr 2014 04:26:12 -0400
In-Reply-To: <alpine.DEB.2.00.1404112105310.16913@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ARD55gGn7koBDfHG0xugOJf1JVFUpipoU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I'll deal with the problems found in gf-complete: http://tracker.ceph.com=
/issues/8083

On 12/04/2014 06:06, Sage Weil wrote:
> Several new defects.  This wasn't running for the last couple of weeks =

> because the submodules didn't update on the test checkout.
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--ARD55gGn7koBDfHG0xugOJf1JVFUpipoU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNI+J0ACgkQ8dLMyEl6F21A5gCdHNPp+0Np7u3gaWLmqaac6isV
wnEAoLYX2xBq2EGMa8VaQNJx7xGk+XoZ
=+OZQ
-----END PGP SIGNATURE-----

--ARD55gGn7koBDfHG0xugOJf1JVFUpipoU--
