From: Robert LeBlanc <robert@leblancnet.us>
Subject: Build RPMs from git
Date: Tue, 9 Jun 2015 15:15:17 -0600
Message-ID: <CAANLjFqtNxo=CPwar3OYP9es-+5LgTbmiNgd_4RSCcndb_iCNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:35550 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbbFIVPS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 17:15:18 -0400
Received: by wgme6 with SMTP id e6so21577721wgm.2
        for <ceph-devel@vger.kernel.org>; Tue, 09 Jun 2015 14:15:17 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

OK, easy question...

Building Debian packages from git is wonderfully easy, RPMs seem ....
not so easy.

I got it to kind of work, but I feel like I'm doing it the "Hard Way" (tm).

mkdir -p ~/ceph && pushd ~/ceph
git clone https://github.com/ceph/ceph.git
./autogen.sh
./configure
echo "--- /root/ceph/ceph/ceph.spec   2015-06-09 13:03:08.240099443 -0600
+++ /root/rpmbuild/SPECS/ceph.spec      2015-06-09 13:12:54.145061355 -0600
@@ -464,12 +464,14 @@
 # common
 #################################################################################
 %prep
- -%setup -q
+#%setup -q
+cd %{buildroot}
 %if 0%{?fedora} || 0%{?rhel}
 %patch0 -p1 -b .init
 %endif

 %build
+cd %{buildroot}
 # Find jni.h
 for i in /usr/{lib64,lib}/jvm/java/include{,/linux}; do
     [ -d $i ] && java_inc="$java_inc -I$i"" | patch
rpmbuild -ba ceph.spec --define 'buildroot `pwd/ceph`'

It coughs at the install/RPM package part.

Any help with preventing the whole tar/untar process which I can't
seem to get exactly right either would be very helpful.

Thanks,

- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVd1diCRDmVDuy+mK58QAAlMQP/AlbiMj72J/r4rgvPCSv
6EVzFLCZOVewtmeV+/pnltzQgbj42/MRNC5wfJjPasAEn7Ctj0PgnzNA9LYy
m4vkrS2Lc4BiRc5dkI31my6T51LxMswZjKecy9yiCDUoUW7cD15PMvyoq27G
+JpeNbrrCvl6Sxfx7S4IjvgnP1Xko2qSi17GoYxJzxwAZJ0LwNUSzvhlQnab
fEswyO1af3uWUmTGWUKML8jGYSyLnjNa43t2DmEKG5o4yWaXFx0UcUiUdk4v
gLxHZvUxuNVIb862aoP4gXUC4V508Vu8nnfXx7BuAYXSN0w+Yh2XYU/2T4gL
Ikqo2ASi3kZoMRoxjX0S/kSn0OdrJkJCkI0fJmYxoBrULqDPu/EslKSX8IGZ
MN9jGPNrr6G7US25aPPWM1MH4Ikmb0M8/wsmiU60yfQz7bFqxzmIUgoetwHS
gKSJnu7DyovrGkPTD4nc8yCuFohcIqtD47hh1NLgpQbikGhEIpa//W5A9ikL
ZO/ke3EMVT+2wWRikQv9QLBx8hkXazEq3ko5KNXK+m+CtJr0Ae56xKPZUu+R
4gFZyqO+P5bHk51j2V63n+M0bAxQpjTB7j3YV7oToezbJwhELVXATNfVwB8g
PixgthHIkFhbPM606qBW48XVVJ+QxV61prUgEp0Sni7oy22yMtaoso5sdGjn
cCtC
=QqbH
-----END PGP SIGNATURE-----
