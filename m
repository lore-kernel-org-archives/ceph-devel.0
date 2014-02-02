From: Loic Dachary <loic@dachary.org>
Subject: controlling erasure code chunk size
Date: Sun, 02 Feb 2014 16:15:52 +0100
Message-ID: <52EE6128.209@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xLXBqvOwDig15UP8vlCgTik17QIOtkhKU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:59253 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbaBBPPy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 2 Feb 2014 10:15:54 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xLXBqvOwDig15UP8vlCgTik17QIOtkhKU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[cc' ceph-devel]

Hi Sam,

Here is how chunks are expected to be aligned:

https://github.com/ceph/ceph/blob/4c4e1d0d470beba7690d1c0e39bfd1146a25f46=
5/src/osd/ErasureCodePluginJerasure/ErasureCodeJerasure.cc#L365

 unsigned alignment =3D k*w*packetsize*sizeof(int);
  if ( ((w*packetsize*sizeof(int))%LARGEST_VECTOR_WORDSIZE) )
    alignment =3D k*w*packetsize*LARGEST_VECTOR_WORDSIZE;
  return alignment;

If you are going to encode small objects, it may very well lead to oversi=
zed chunks if packetsize is large. At the moment the default is 3072

https://github.com/ceph/ceph/blob/4c4e1d0d470beba7690d1c0e39bfd1146a25f46=
5/src/common/config_opts.h#L406

A value I picked when experimenting with 1MB objects encoding ( http://da=
chary.org/?p=3D2594 ).=20

I'm not entirely sure why the alignment is calculated the way it is. Andr=
eas certainly has a better understanding on this topic.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--xLXBqvOwDig15UP8vlCgTik17QIOtkhKU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLuYSgACgkQ8dLMyEl6F20PIACgsAg4vXGvybG4woU9FgSyvRQj
iDMAoLwxJ09i0L+pHP3KO8ojMQqj2Meg
=ZZZd
-----END PGP SIGNATURE-----

--xLXBqvOwDig15UP8vlCgTik17QIOtkhKU--
