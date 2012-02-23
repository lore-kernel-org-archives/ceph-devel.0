From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Package ceph-dencoder
Date: Wed, 22 Feb 2012 21:39:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202222138540.27988@cobra.newdream.net>
References: <orpqd81rjg.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55955 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348Ab2BWFjT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Feb 2012 00:39:19 -0500
In-Reply-To: <orpqd81rjg.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

A patch to add this is in the wip-decoder branch, including a man page and 
adding it to the .deb as well.  Should be merged shortly.

s

On Tue, 21 Feb 2012, Alexandre Oliva wrote:

> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> ---
>  ceph.spec.in |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/ceph.spec.in b/ceph.spec.in
> index 58c3af7d..f62f95a 100644
> --- a/ceph.spec.in
> +++ b/ceph.spec.in
> @@ -313,6 +313,7 @@ fi
>  %{_bindir}/boto_tool
>  %{_bindir}/ceph-coverage
>  %{_bindir}/obsync
> +%{_bindir}/ceph-dencoder
>  %{_initrddir}/ceph
>  %dir %{_libdir}/rados-classes
>  /sbin/mkcephfs
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
