From: Sage Weil <sage@inktank.com>
Subject: Re: Don't package no longer installed crush headers
Date: Tue, 14 Aug 2012 08:57:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208140857340.18862@cobra.newdream.net>
References: <or393qypje.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54882 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab2HNP5j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 11:57:39 -0400
In-Reply-To: <or393qypje.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

Applied, thanks!

On Tue, 14 Aug 2012, Alexandre Oliva wrote:

> The rules that install crush headers are commented out in
> src/Makefile.am, so don't attempt to package them.
> 
> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> ---
>  ceph.spec.in |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/ceph.spec.in b/ceph.spec.in
> index 70e9e08..af204e9 100644
> --- a/ceph.spec.in
> +++ b/ceph.spec.in
> @@ -340,11 +340,11 @@ fi
>  %defattr(-,root,root,-)
>  %dir %{_includedir}/cephfs
>  %{_includedir}/cephfs/libcephfs.h
> -%dir %{_includedir}/crush
> -%{_includedir}/crush/crush.h
> -%{_includedir}/crush/hash.h
> -%{_includedir}/crush/mapper.h
> -%{_includedir}/crush/types.h
> +# %dir %{_includedir}/crush
> +# %{_includedir}/crush/crush.h
> +# %{_includedir}/crush/hash.h
> +# %{_includedir}/crush/mapper.h
> +# %{_includedir}/crush/types.h
>  %dir %{_includedir}/rados
>  %{_includedir}/rados/librados.h
>  %{_includedir}/rados/librados.hpp
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
