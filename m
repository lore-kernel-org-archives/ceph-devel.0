From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] Update ceph.spec for ceph-0.47
Date: Wed, 23 May 2012 10:55:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1205231048060.15923@cobra.newdream.net>
References: <orfwasr5n8.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55715 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717Ab2EWRzj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 May 2012 13:55:39 -0400
In-Reply-To: <orfwasr5n8.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

On Tue, 22 May 2012, Alexandre Oliva wrote:
> Add BuildRequires: libxml2-devel.
> Move BuildRequires: libcurl-devel to a more proper place.
> Uninstall libs3, incorrectly installed in RPM_BUILD_ROOT.

We fixed the Makefile so that libs3 is no longer installed in the first 
place, took that part out.

> Package %{_includedir}/rados/librgw.h.

This shouldn't be installed.. I've fixed the Makefile accordingly.

An abbreviated version of the patch is now in stable.

Thanks!
sage


> ---
>  ceph.spec.in |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/ceph.spec.in b/ceph.spec.in
> index b3dd3f0..1dbd645 100644
> --- a/ceph.spec.in
> +++ b/ceph.spec.in
> @@ -37,6 +37,8 @@ BuildRequires:	gdbm
>  BuildRequires:	pkgconfig
>  BuildRequires:	python
>  BuildRequires:  libaio-devel
> +BuildRequires:  libcurl-devel
> +BuildRequires:  libxml2-devel
>  
>  #################################################################################
>  # specific
> @@ -55,7 +57,6 @@ Requires(post):	chkconfig
>  Requires(preun):chkconfig
>  Requires(preun):initscripts
>  %endif
> -BuildRequires: libcurl-devel
>  %if 0%{with tcmalloc}
>  # use isa so this will not be satisfied by
>  # google-perftools-devel.i686 on a x86_64 box
> @@ -232,6 +233,10 @@ make -j$(getconf _NPROCESSORS_ONLN)
>  
>  %install
>  make DESTDIR=$RPM_BUILD_ROOT install
> +make DESTDIR=$RPM_BUILD_ROOT -C src/libs3 uninstall
> +rmdir $RPM_BUILD_ROOT/bin
> +rmdir $RPM_BUILD_ROOT/lib
> +rmdir $RPM_BUILD_ROOT/include
>  find $RPM_BUILD_ROOT -type f -name "*.la" -exec rm -f {} ';'
>  find $RPM_BUILD_ROOT -type f -name "*.a" -exec rm -f {} ';'
>  install -D src/init-ceph $RPM_BUILD_ROOT%{_initrddir}/ceph
> @@ -365,6 +370,7 @@ fi
>  %dir %{_includedir}/rados
>  %{_includedir}/rados/librados.h
>  %{_includedir}/rados/librados.hpp
> +%{_includedir}/rados/librgw.h
>  %{_includedir}/rados/buffer.h
>  %{_includedir}/rados/page.h
>  %{_includedir}/rados/crc32c.h
> -- 
> 1.7.7.6
> 
> -- 
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist      Red Hat Brazil Compiler Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
