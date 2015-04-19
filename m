From: Loic Dachary <loic@dachary.org>
Subject: creating images for teuthology VMs
Date: Sun, 19 Apr 2015 12:17:50 +0200
Message-ID: <553380CE.3060703@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="twNpAaocjtjmSQpX0jPhiLHlfIuQaWnJ7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48970 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751997AbbDSKRx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Apr 2015 06:17:53 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--twNpAaocjtjmSQpX0jPhiLHlfIuQaWnJ7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zack,

The easier path to get images (fedora-21-amd64, ubuntu-14.04-i386, etc. e=
tc.) I can think of is by injecting an ssh key in cloud images such as

     http://cloud-images.ubuntu.com/trusty/current/trusty-server-cloudimg=
-arm64-disk1.img

using a config drive. The rationale is that there is at least one well ma=
intained set of cloud ready images for every distribution (at least the d=
istributions Ceph supports). The only work required is to find the URL of=
 such images since there does not seem to be a catalog anywhere to match =
operating system + version + architecture to a downloadable URL.

I wrote down the details at http://dachary.org/?p=3D3625. There probably =
are many aspects of the problem that I don't take into consideration and =
it's only a tiny part of the puzzle. But sharing unpolished ideas is a go=
od activity for a Sunday ;-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--twNpAaocjtjmSQpX0jPhiLHlfIuQaWnJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUzgM4ACgkQ8dLMyEl6F21j4QCgw4w+kS4BQEWaKYW7RIFRRSeV
lHIAn1mnT75hkYoQu/wLMMzE69lvznqr
=B4yI
-----END PGP SIGNATURE-----

--twNpAaocjtjmSQpX0jPhiLHlfIuQaWnJ7--
