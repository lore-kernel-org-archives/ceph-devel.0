From: Abhishek L <abhishek@suse.com>
Subject: v11.0.2 released
Date: Tue, 18 Oct 2016 15:04:09 +0200
Message-ID: <87funtn706.fsf@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:47868 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755723AbcJRNEU (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Tue, 18 Oct 2016 09:04:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This development checkpoint release includes a lot of changes and
improvements to Kraken. This is the first release introducing ceph-mgr,
a new daemon which provides additional monitoring & interfaces to
external monitoring/management systems. There are also many improvements
to bluestore, RGW introduces sync modules, copy part for multipart
uploads and metadata search via elastic search as a tech preview. We've
had to skip releasing 11.0.1 due to an issue with git tags and package
versions as we were transitioning away from autotools to cmake and the
new build system in place.

Due to the really long changelog in this release, please read the
list of changes here:
http://ceph.com/releases/kraken-11-0-2-released/

The debian and rpm packages are available at the usual locations at
http://download.ceph.com/debian-kraken/ and
http://download.ceph.com/rpm-kraken respectively. For more details refer
below.


Getting Ceph
=2D-----------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-11.0.2.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-dep=
loy

=2D-
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton, =
HRB 21284 (AG N=C3=BCrnberg)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJYBh3RAAoJEPnwZB8bZe1fimwH/0etgc01WicJsVcdWKlwN28H
RBDVU7h840cpe4shbuYWvBFz8I3oZSI3wAM+n0xQD7wsLWNNQusxA7/vcoDmkhVc
rT54QE9+ydHAhESVdeuRGFQ5+h4997r/Z8Wvm1SiJZaPhpEU5btdQ/3of+a7oVUE
fi6En4OcXI/NssXynILFPIH4EXpJRXWdnfmwLm08cfDbURDglL1Zsm+V5UCcUhay
kTyifn0p5pnsGtgUEzav4qXes0scWpntu1/Qv8h+ui7/jDw7xDorz2cCCgZYR0Cj
0eMRNQ0Vjpc0Lrw8DI5rZl2nvNwxyu4Tf+JTNmuyNrFLelyT77tX0XamH450Xa4=
=qmL9
-----END PGP SIGNATURE-----
--=-=-=--
