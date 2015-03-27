From: Loic Dachary <loic@dachary.org>
Subject: lttng broken on i386 trusty
Date: Fri, 27 Mar 2015 10:55:50 +0100
Message-ID: <55152926.9000400@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AIQVOIkpgSHKgXDo94HLn0Vco2fgiTtS1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37663 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753566AbbC0Jzy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2015 05:55:54 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AIQVOIkpgSHKgXDo94HLn0Vco2fgiTtS1
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

In case you did not notice:

http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-tarball-trusty-i386-basi=
c/log.cgi?log=3Ddca722ec7b2a7fc9214844ec92310074b5cb2faa

CXXLD radosgw-admin
CXXLD rados
/usr/lib/gcc/i686-linux-gnu/4.8/../../../i386-linux-gnu/liblttng-ust.so: =
undefined reference to `dlclose'
/usr/lib/gcc/i686-linux-gnu/4.8/../../../i386-linux-gnu/liblttng-ust.so: =
undefined reference to `dlsym'
/usr/lib/gcc/i686-linux-gnu/4.8/../../../i386-linux-gnu/liblttng-ust.so: =
undefined reference to `dlopen'

    error: collect2: ld returned 1 exit status

make[3]: *** [ceph_tpbench] Error 1
make[3]: *** Waiting for unfinished jobs....
CXXLD ceph-objectstore-tool
make[3]: Leaving directory `/srv/autobuild-ceph/gitbuilder.git/build/src'=

make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/srv/autobuild-ceph/gitbuilder.git/build/src'=

make[1]: *** [all] Error 2
make[1]: Leaving directory `/srv/autobuild-ceph/gitbuilder.git/build/src'=


    make: *** [all-recursive] Error 1

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--AIQVOIkpgSHKgXDo94HLn0Vco2fgiTtS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUVKScACgkQ8dLMyEl6F22i5gCfdoWpC9XTrFrq/OUip/7/CaAx
IHYAnjO0YVPwmr1gM6OTYHNF7Y3ElVPn
=ABYQ
-----END PGP SIGNATURE-----

--AIQVOIkpgSHKgXDo94HLn0Vco2fgiTtS1--
