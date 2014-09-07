From: Loic Dachary <loic@dachary.org>
Subject: Storing cls and erasure code plugins in a pool
Date: Sun, 07 Sep 2014 10:26:04 +0200
Message-ID: <540C169C.9030603@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="vgt4e889gJ6gF3jvo3MHljJHQ566VGxre"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46671 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750840AbaIGI0M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Sep 2014 04:26:12 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 36EBB420A2
	for <ceph-devel@vger.kernel.org>; Sun,  7 Sep 2014 10:26:05 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vgt4e889gJ6gF3jvo3MHljJHQ566VGxre
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

There is a need for a cluster to share code such as cls https://github.co=
m/ceph/ceph/tree/master/src/cls or erasure code plugins https://github.co=
m/ceph/ceph/tree/master/src/erasure-code/.

These plugins could have a life cycle independent of Ceph, as long as the=
y comply to the supported API ( https://github.com/ceph/ceph/blob/master/=
src/erasure-code/ErasureCodeInterface.h ). For erasure code plugins it cu=
rrently works this way (or it will as soon as https://github.com/ceph/cep=
h/pull/2397 is merged):

a) upgrade from Hammer to I* half the OSD nodes. The new I* have new eras=
ure code plugins
b) the MON will refuse to create an erasure coded pool using the new I* p=
lugins, otherwise the Hammer nodes will find themselves unable to partici=
pate in the pool

Instead it could work this way:

a) upgrade from Hammer to I* half the OSD nodes. The new I* have new eras=
ure code plugins
b) the new erasure code plugins are uploaded to a "plugins" pool
c) an erasure coded pool is created using a new plugin from I*
d) the Hammer OSD downloads the plugin from the pool and can participate =
in the pool

It is easier said than done and there are a lot of details to consider. H=
owever it not different from maintaining an Operating System that include=
s shared libraries and the path to do so properly is well known.

Thoughts ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--vgt4e889gJ6gF3jvo3MHljJHQ566VGxre
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQMFp0ACgkQ8dLMyEl6F21rugCgh9qANjX2ATmF56bAR3fTPcsX
pUoAn1O8D4CBAK7smvpmMW5/sGjGeO2Y
=i7ju
-----END PGP SIGNATURE-----

--vgt4e889gJ6gF3jvo3MHljJHQ566VGxre--
