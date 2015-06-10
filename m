From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Build RPMs from git
Date: Wed, 10 Jun 2015 20:03:48 +1000
Message-ID: <55780B84.1080306@redhat.com>
References: <CAANLjFqtNxo=CPwar3OYP9es-+5LgTbmiNgd_4RSCcndb_iCNA@mail.gmail.com>
Reply-To: bhubbard@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38100 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933376AbbFJKDz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Jun 2015 06:03:55 -0400
In-Reply-To: <CAANLjFqtNxo=CPwar3OYP9es-+5LgTbmiNgd_4RSCcndb_iCNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>, ceph-devel <ceph-devel@vger.kernel.org>

On 06/10/2015 07:15 AM, Robert LeBlanc wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> OK, easy question...
>
> Building Debian packages from git is wonderfully easy, RPMs seem ....
> not so easy.
>
> I got it to kind of work, but I feel like I'm doing it the "Hard Way" (tm).
>
> mkdir -p ~/ceph && pushd ~/ceph
> git clone https://github.com/ceph/ceph.git
> ./autogen.sh
> ./configure
> echo "--- /root/ceph/ceph/ceph.spec   2015-06-09 13:03:08.240099443 -0600
> +++ /root/rpmbuild/SPECS/ceph.spec      2015-06-09 13:12:54.145061355 -0600
> @@ -464,12 +464,14 @@
>   # common
>   #################################################################################
>   %prep
> - -%setup -q
> +#%setup -q
> +cd %{buildroot}
>   %if 0%{?fedora} || 0%{?rhel}
>   %patch0 -p1 -b .init
>   %endif
>
>   %build
> +cd %{buildroot}
>   # Find jni.h
>   for i in /usr/{lib64,lib}/jvm/java/include{,/linux}; do
>       [ -d $i ] && java_inc="$java_inc -I$i"" | patch
> rpmbuild -ba ceph.spec --define 'buildroot `pwd/ceph`'
>
> It coughs at the install/RPM package part.
>
> Any help with preventing the whole tar/untar process which I can't
> seem to get exactly right either would be very helpful.

On F20 the instructions in doc/install/build-ceph.rst worked fine for me with one extra step.

$ wget -P ~/rpmbuild/SOURCES/ http://ceph.com/download/ceph-9.0.0.tar.bz2
$ tar --strip-components=1 -C ~/rpmbuild/SPECS/ --no-anchored -xvjf ~/rpmbuild/SOURCES/ceph-9.0.0.tar.bz2 "ceph.spec"

$ cp rpm/init-ceph.in-fedora.patch ~/rpmbuild/SOURCES/

$ rpmbuild -ba ~/rpmbuild/SPECS/ceph.spec

$ ls ~/rpmbuild/RPMS/x86_64/
ceph-9.0.0-0.fc20.x86_64.rpm               ceph-fuse-9.0.0-0.fc20.x86_64.rpm         libcephfs1-devel-9.0.0-0.fc20.x86_64.rpm      libradosstriper1-9.0.0-0.fc20.x86_64.rpm        python-cephfs-9.0.0-0.fc20.x86_64.rpm
ceph-common-9.0.0-0.fc20.x86_64.rpm        ceph-libs-compat-9.0.0-0.fc20.x86_64.rpm  libcephfs_jni1-9.0.0-0.fc20.x86_64.rpm        libradosstriper1-devel-9.0.0-0.fc20.x86_64.rpm  python-rados-9.0.0-0.fc20.x86_64.rpm
ceph-debuginfo-9.0.0-0.fc20.x86_64.rpm     ceph-radosgw-9.0.0-0.fc20.x86_64.rpm      libcephfs_jni1-devel-9.0.0-0.fc20.x86_64.rpm  librbd1-9.0.0-0.fc20.x86_64.rpm                 python-rbd-9.0.0-0.fc20.x86_64.rpm
ceph-devel-compat-9.0.0-0.fc20.x86_64.rpm  ceph-test-9.0.0-0.fc20.x86_64.rpm         librados2-9.0.0-0.fc20.x86_64.rpm             librbd1-devel-9.0.0-0.fc20.x86_64.rpm           rbd-fuse-9.0.0-0.fc20.x86_64.rpm
cephfs-java-9.0.0-0.fc20.x86_64.rpm        libcephfs1-9.0.0-0.fc20.x86_64.rpm        librados2-devel-9.0.0-0.fc20.x86_64.rpm       python-ceph-compat-9.0.0-0.fc20.x86_64.rpm      rest-bench-9.0.0-0.fc20.x86_64.rpm

What OS are you using and what problems do you face following the above steps?

Cheers,
Brad

>
> Thanks,
>
> - ----------------
> Robert LeBlanc
> GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v0.13.1
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJVd1diCRDmVDuy+mK58QAAlMQP/AlbiMj72J/r4rgvPCSv
> 6EVzFLCZOVewtmeV+/pnltzQgbj42/MRNC5wfJjPasAEn7Ctj0PgnzNA9LYy
> m4vkrS2Lc4BiRc5dkI31my6T51LxMswZjKecy9yiCDUoUW7cD15PMvyoq27G
> +JpeNbrrCvl6Sxfx7S4IjvgnP1Xko2qSi17GoYxJzxwAZJ0LwNUSzvhlQnab
> fEswyO1af3uWUmTGWUKML8jGYSyLnjNa43t2DmEKG5o4yWaXFx0UcUiUdk4v
> gLxHZvUxuNVIb862aoP4gXUC4V508Vu8nnfXx7BuAYXSN0w+Yh2XYU/2T4gL
> Ikqo2ASi3kZoMRoxjX0S/kSn0OdrJkJCkI0fJmYxoBrULqDPu/EslKSX8IGZ
> MN9jGPNrr6G7US25aPPWM1MH4Ikmb0M8/wsmiU60yfQz7bFqxzmIUgoetwHS
> gKSJnu7DyovrGkPTD4nc8yCuFohcIqtD47hh1NLgpQbikGhEIpa//W5A9ikL
> ZO/ke3EMVT+2wWRikQv9QLBx8hkXazEq3ko5KNXK+m+CtJr0Ae56xKPZUu+R
> 4gFZyqO+P5bHk51j2V63n+M0bAxQpjTB7j3YV7oToezbJwhELVXATNfVwB8g
> PixgthHIkFhbPM606qBW48XVVJ+QxV61prUgEp0Sni7oy22yMtaoso5sdGjn
> cCtC
> =QqbH
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
