From: Sage Weil <sage@newdream.net>
Subject: Re: ceph.spec.in still packages libceph.so in 0.36
Date: Mon, 3 Oct 2011 13:22:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110031321350.28468@cobra.newdream.net>
References: <orhb3s9zz7.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45515 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756471Ab1JCUW3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Oct 2011 16:22:29 -0400
In-Reply-To: <orhb3s9zz7.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

Thanks, updated this in the stable branch.

sage

On Sat, 1 Oct 2011, Alexandre Oliva wrote:

> Package libcephfs.so instead of libceph.so.
> 
> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> 
> diff --git a/ceph.spec.in b/ceph.spec.in
> index b655a9f..f87278d 100644
> --- a/ceph.spec.in
> +++ b/ceph.spec.in
> @@ -246,7 +246,7 @@ fi
>  %{_includedir}/rados/crc32c.h
>  %{_includedir}/rbd/librbd.h
>  %{_includedir}/rbd/librbd.hpp
> -%{_libdir}/libceph.so
> +%{_libdir}/libcephfs.so
>  %{_libdir}/librados.so
>  %{_libdir}/librbd.so
>  %{_libdir}/rados-classes/libcls_rbd.so
> 
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
