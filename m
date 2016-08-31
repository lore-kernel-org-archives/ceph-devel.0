From: NeilBrown <neilb@suse.com>
Subject: [PATCH 0/2]: CEPHFS: allow for races between direct and buffered writes
Date: Wed, 31 Aug 2016 12:56:23 +1000
Message-ID: <874m61eje0.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44225 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758387AbcHaC4b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 30 Aug 2016 22:56:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

--=-=-=
Content-Type: text/plain


Hi,
 it is quite possible for O_DIRECT and buffered writes to a file to
 race.
 The xfstests test suite has a test - generic/036 - which tests this
 case.

 Unlike most filesystems, cephfs does not hold inode_lock() across
 direct writes.  This means that buffer pages can become dirty while
 direct writes are happening.  This confused ceph a little.

 The following two patches allow ceph to handle this possibility a
 little more cleanly.  The more important patch removes a WARN_ON() for
 a circumstance which can easily be triggered.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxkdXAAoJEDnsnt1WYoG5iYgQAKxrK2nciPHR6ksIaUyVWIyl
7FX2XuUlePOV0vyUtAsTrD3D++teH+BHtnMVshKUO4rYveWry148VmtIxvM0FYtl
tD2mifqhI+4P3cpC6iWWoS2yPKmpy2OPfOXZoQpJ3PkLCeuR1QcxxwgLvsoqtSCV
WTfCqlHuFxlM+kjatYJNKwcuT0JvVeqeBrE4WvLS9mN2aCoX9B57sO/7ASHeVaY5
ab1oytfpT2YSyfkQcfWRTbm5+nBeD0NfM0qlEDJ7zom7fMt000RDQRSioBMPhJaw
/OQmy2xA6uaTjrFDb7AsxNBcaNPdu3ULYe8tY2Tr/Veit2O3hYoF60OC0gCL+vBx
fmdjcUAPnMmiT7g0VXrG1bzRuJwgkyjbaOFqE3WZ/H1kFk6sOhSxRYd4i3Tt61Fd
6YiBA0lhqbDWFA0QzRamKZ2ZEDxWR5RXZFOdxLVmL6h5vYAuZu98r1nS9Y7glTTz
lDC7hu7wVtL9mKxp2bXHeP4tOoA76cyaeZlk6m3r4uoUur4aR8t+RD6eWSBg72N6
+51BHxMCx3svGP5ZMqAENVsP9v4BlFkt/wLKcQKDCQSWksFq9k0EjUOQLz0IeFV9
M2ymlBcQh/K5uBRtqy/0KzJ2JKJKX91GlBT2QT1Iy1xL270Q3xUkAeF/mDMkKiX+
I50tgzJ1xFdO3PyBrBY/
=PMCp
-----END PGP SIGNATURE-----
--=-=-=--
