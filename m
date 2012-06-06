From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] ceph.spec.in: Fix license to GPL-2.0 and use SPDX format
Date: Tue, 5 Jun 2012 19:29:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206051928360.5946@cobra.newdream.net>
References: <4FCE0309.90104@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49079 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab2FFC34 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 22:29:56 -0400
In-Reply-To: <4FCE0309.90104@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Holger Macht <hmacht@suse.de>
Cc: ceph-devel@vger.kernel.org

On Tue, 5 Jun 2012, Holger Macht wrote:
> Minor spec file fix. LGPLv2 in spec file is not correct, because some of
> the included packages/binaries are GPLv2. For example:
> 
>  src/os/btrfs_ioctl.h -> package ceph, binary ceph-osd

My understanding is that including a header file (in this case, to get the 
ioctl number) does not create a derivative work.  Is that incorrect?

>  src/mount/mtab.c     -> package ceph, binary mount.ceph
>  src/common/fiemap.cc -> package ceph, binary rbd
> 
> Also use SPDX format: http://www.spdx.org/licenses
> 
> Signed-off-by: Holger Macht <hmacht@suse.de>
> ---
>  ceph.spec.in |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ceph.spec.in b/ceph.spec.in
> index 81e7040..3b3026d 100644
> --- a/ceph.spec.in
> +++ b/ceph.spec.in
> @@ -17,7 +17,7 @@ Name:		ceph
>  Version:	@VERSION@
>  Release:	6%{?dist}
>  Summary:	User space components of the Ceph file system
> -License:	LGPLv2
> +License:	GPL-2.0

So this is effectively the most restrictive license in the package?

Thanks-
sage

>  Group:		System Environment/Base
>  URL:		http://ceph.newdream.net/
>  Source0:	http://ceph.newdream.net/download/%{name}-%{version}.tar.bz2
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
