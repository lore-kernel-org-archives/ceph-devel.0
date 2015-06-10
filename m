From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Build RPMs from git
Date: Wed, 10 Jun 2015 10:30:27 -0400 (EDT)
Message-ID: <581259457.12927282.1433946627668.JavaMail.zimbra@redhat.com>
References: <CAANLjFqtNxo=CPwar3OYP9es-+5LgTbmiNgd_4RSCcndb_iCNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:53320 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964837AbbFJOa3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 10:30:29 -0400
In-Reply-To: <CAANLjFqtNxo=CPwar3OYP9es-+5LgTbmiNgd_4RSCcndb_iCNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Here's how I do it.

1. Git clone

2. ./do_autogen.sh

3. ./configure --without-radosgw --without-fuse --without-tcmalloc --without-libatomic-ops --without-libxfs 

4. # The "configure" step above creates a ceph.spec with the proper version number, which you can then copy:
   cp ceph.spec ~/rpmbuild/SPECS/

5. # The "configure" step above also creates a Makefile, so you can run "make dist-bzip2" to get a properly-versioned tarball:
   make dist-bzip2

6. # Now move the tarball in to place, along with the .patch file:
   rm ~/rpmbuild/SOURCES/*
   mv *.bz2 ~/rpmbuild/SOURCES/
   cp rpm/*.patch ~/rpmbuild/SOURCES/

7. # Build a source RPM:
   rpmbuild -bs ~/rpmbuild/SPECS/ceph.spec

8. # Lastly, rebuild that SRPM in mock:
   mock -r epel-7-x86_64 rebuild ~/rpmbuild/SRPMS/ceph-....src.rpm


This whole process needs to be improved :) We're moving towards getting rid of the ./configure operation in step #3 since that is only done in order to figure out the right version number for steps #4 and #5.

Also, the .patch file in step #6 could be implemented in some other way. We could use sed during %prep to make the changes, which would avoid using a .patch file. Or, since src/init-ceph.in is an autoconf template anyway, we could conditionalize this with autoconf to print "Default-Start: 2 3 4 5" and "Default-Stop: 0 1 6" on Debian, and leave the values blank on Red Hat.

- Ken



----- Original Message -----
> From: "Robert LeBlanc" <robert@leblancnet.us>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, June 9, 2015 3:15:17 PM
> Subject: Build RPMs from git
> 
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
>  # common
>  #################################################################################
>  %prep
> - -%setup -q
> +#%setup -q
> +cd %{buildroot}
>  %if 0%{?fedora} || 0%{?rhel}
>  %patch0 -p1 -b .init
>  %endif
> 
>  %build
> +cd %{buildroot}
>  # Find jni.h
>  for i in /usr/{lib64,lib}/jvm/java/include{,/linux}; do
>      [ -d $i ] && java_inc="$java_inc -I$i"" | patch
> rpmbuild -ba ceph.spec --define 'buildroot `pwd/ceph`'
> 
> It coughs at the install/RPM package part.
> 
> Any help with preventing the whole tar/untar process which I can't
> seem to get exactly right either would be very helpful.
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
> 
