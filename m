From: Sage Weil <sage@newdream.net>
Subject: Re: PATCH: ceph.spec.in
Date: Fri, 2 Jul 2010 08:04:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007020802470.17984@cobra.newdream.net>
References: <i0k73i$g5f$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48053 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770Ab0GBSYm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jul 2010 14:24:42 -0400
In-Reply-To: <i0k73i$g5f$2@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

Applied this, sans the unpackaged files part.. those are for debugging and 
testing, and don't need to be installed.  (That probably means 'make 
install' should ignore them...)

And removed all other traces of mkmonfs (it's replaced by 'cmon --mkfs').

sage


On Fri, 2 Jul 2010, Thomas Mueller wrote:
> hi
> 
> encountered following errors building an rpm package with the 
> ceph.spec.in:
> 
> RPM build errors:
>     File not found: /var/tmp/ceph-0.21~rc-4el5.elefant-root-mockbuild/usr/
> bin/mkmonfs
>     File must begin with "/": %{_initddir}/ceph
>     Installed (but unpackaged) file(s) found:
>    /usr/bin/dumpjournal
>    /usr/bin/dupstore
>    /usr/bin/psim
>    /usr/bin/radosacl
>    /usr/bin/streamtest
>    /usr/bin/test_ioctls
>    /usr/bin/test_trans
>    /usr/bin/testceph
>    /usr/bin/testcrypto
>    /usr/bin/testkeys
>    /usr/bin/testmsgr
>    /usr/bin/testrados
>    /usr/bin/testradospp
> 
> 
> * mkmonfs - vanished. isn't it used anymore? if so, the man/mkmonfs.8 can 
> also be removed
> * initddir can be ignored as it is centos/rhel specific (it's called 
> "initrddir")
> * added the unpackaged files
> * added CXXFLAGS to make
> 
> - Thomas
> 
> --- ceph.spec.in.orig	2010-07-02 09:05:59.000000000 +0200
> +++ ceph.spec.in	2010-07-02 10:12:54.000000000 +0200
> @@ -41,7 +41,7 @@
>  %build
>  ./autogen.sh
>  %{configure} --without-hadoop --without-debug
> -make CFLAGS="$RPM_OPT_FLAGS"
> +make CFLAGS="$RPM_OPT_FLAGS" CXXFLAGS="$RPM_OPT_FLAGS"
>  
>  %install
>  rm -rf $RPM_BUILD_ROOT
> @@ -84,9 +84,14 @@
>  %{_bindir}/cmon
>  %{_bindir}/cmds
>  %{_bindir}/cosd
> -%{_bindir}/mkmonfs
>  %{_bindir}/rados
>  %{_bindir}/rbdtool
> +%{_bindir}/test*
> +%{_bindir}/dumpjournal
> +%{_bindir}/dupstore
> +%{_bindir}/psim
> +%{_bindir}/radosacl
> +%{_bindir}/streamtest
>  %{_initddir}/ceph
>  %{_libdir}/libceph.so.*
>  %{_libdir}/libcrush.so.*
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
