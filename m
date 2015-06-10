From: Robert LeBlanc <robert@leblancnet.us>
Subject: Fwd: Build RPMs from git
Date: Wed, 10 Jun 2015 09:37:25 -0600
Message-ID: <CAANLjFpmJ0iCW4Qd3LejurwoWfRhEX65S8XUbH65dQ5kYcEFeg@mail.gmail.com>
References: <CAANLjFqtNxo=CPwar3OYP9es-+5LgTbmiNgd_4RSCcndb_iCNA@mail.gmail.com>
	<55780B84.1080306@redhat.com>
	<CAANLjFrgBDiVsRRUEfE3yvzieR7+4a0EBxxG8s9+buXi0T6HZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35555 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933557AbbFJPh1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 11:37:27 -0400
Received: by wiga1 with SMTP id a1so52659643wig.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2015 08:37:25 -0700 (PDT)
In-Reply-To: <CAANLjFrgBDiVsRRUEfE3yvzieR7+4a0EBxxG8s9+buXi0T6HZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Brad,

I've been able to do this just fine. I'm looking for a way to build
right out of a git branch where the tarball isn't on the downloads
page.

- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1

On Wed, Jun 10, 2015 at 4:03 AM, Brad Hubbard  wrote:
On 06/10/2015 07:15 AM, Robert LeBlanc wrote:
- -----BEGIN PGP SIGNED MESSAGE-----
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
- - -%setup -q
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

On F20 the instructions in doc/install/build-ceph.rst worked fine for
me with one extra step.

$ wget -P ~/rpmbuild/SOURCES/ http://ceph.com/download/ceph-9.0.0.tar.bz2
$ tar --strip-components=1 -C ~/rpmbuild/SPECS/ --no-anchored -xvjf
~/rpmbuild/SOURCES/ceph-9.0.0.tar.bz2 "ceph.spec"

$ cp rpm/init-ceph.in-fedora.patch ~/rpmbuild/SOURCES/

$ rpmbuild -ba ~/rpmbuild/SPECS/ceph.spec

$ ls ~/rpmbuild/RPMS/x86_64/
ceph-9.0.0-0.fc20.x86_64.rpm
ceph-fuse-9.0.0-0.fc20.x86_64.rpm
libcephfs1-devel-9.0.0-0.fc20.x86_64.rpm
libradosstriper1-9.0.0-0.fc20.x86_64.rpm
python-cephfs-9.0.0-0.fc20.x86_64.rpm
ceph-common-9.0.0-0.fc20.x86_64.rpm
ceph-libs-compat-9.0.0-0.fc20.x86_64.rpm
libcephfs_jni1-9.0.0-0.fc20.x86_64.rpm
libradosstriper1-devel-9.0.0-0.fc20.x86_64.rpm
python-rados-9.0.0-0.fc20.x86_64.rpm
ceph-debuginfo-9.0.0-0.fc20.x86_64.rpm
ceph-radosgw-9.0.0-0.fc20.x86_64.rpm
libcephfs_jni1-devel-9.0.0-0.fc20.x86_64.rpm
librbd1-9.0.0-0.fc20.x86_64.rpm
python-rbd-9.0.0-0.fc20.x86_64.rpm
ceph-devel-compat-9.0.0-0.fc20.x86_64.rpm
ceph-test-9.0.0-0.fc20.x86_64.rpm
librados2-9.0.0-0.fc20.x86_64.rpm
librbd1-devel-9.0.0-0.fc20.x86_64.rpm
rbd-fuse-9.0.0-0.fc20.x86_64.rpm
cephfs-java-9.0.0-0.fc20.x86_64.rpm
libcephfs1-9.0.0-0.fc20.x86_64.rpm
librados2-devel-9.0.0-0.fc20.x86_64.rpm
python-ceph-compat-9.0.0-0.fc20.x86_64.rpm
rest-bench-9.0.0-0.fc20.x86_
64.rpm

What OS are you using and what problems do you face following the above steps?

Cheers,
Brad


Thanks,

- - ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
- -----BEGIN PGP SIGNATURE-----
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
- -----END PGP SIGNATURE-----
- --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVeFl4CRDmVDuy+mK58QAAzYMP/1ImmG3tRbS0dh+2bwkm
wFfJSqtDbGOwqG+gumrRnbYBXUP48LBgywfWC4ekpe2j83EX39C0YW5tWBZa
timz7cv9gXn7lqTfpDybRQ0aVCT52EmgJcnxyPLJwc2GNVAZBbHs3SnzmMR2
cEfMqz+oF0qwXwyPBFfKtdd9Caw60QB5AyLGub3o0D6g5kvrs9XQHFpPTP5A
bvDeBoCp9gu429Qw6g22OJTzlSjDyzd4VmZ16QpweQ9ChD606om4oJ4Am+6R
q9MoH7RJITvRsWJVZPj9nAZwa2Y5bpKlBghn23lcAGUdidi/c71V7ww3mlDu
M+P09WfjokIBklLQdjBjdbnOGJcSYS15IPoMpFP2HQKD74xchWL581ywN5M7
r3MN3Z9d+Ez7r4D7wyjoP0Z7mMTZvchehL2Wf+UH4pnyX7LLi+FiQpRfr6L4
1PdWRBF/x1BQPMeCnw3qrWsNGPuahgFlDdl6ao4eS8qFD4qVGeywtU2PqfQf
PYlx6+AdxOvRim3AH8zvA+Qp2Z2StTRZRTFAo6by/kgq81u3cx2WSlAPUWFP
VOdU+/axOj5hpEmbeEOo6kHKlyDynon0FlSuF8HXQvdwaAarCPLGUv08vYwd
MbXMsZfan+wFnXmWvsy+swKD4J8T74YaF6Tfui9xOazIsaqTxHO00dE3rkvI
/gG1
=N/Hh
-----END PGP SIGNATURE-----
