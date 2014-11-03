From: Sage Weil <sage@newdream.net>
Subject: Re: inode64 mount option for XFS
Date: Mon, 3 Nov 2014 06:20:31 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1411030619220.15135@cobra.newdream.net>
References: <545774FA.2070102@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42998 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbaKCOUb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Nov 2014 09:20:31 -0500
In-Reply-To: <545774FA.2070102@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 3 Nov 2014, Wido den Hollander wrote:
> Hi,
> 
> While look at init-ceph and ceph-disk I noticed a discrepancy between them.
> 
> init-ceph mounts XFS filesystems with rw,noatime,inode64, but
> ceph-disk(-active) with rw,noatime
> 
> As inode64 gives the best performance, shouldn't ceph-disk do the same?

I noticed this a while back but didn't finish fixing it.. can you take a 
look at wip-xfs-inode64 and see if it looks right?
 
> Any implications if we add inode64 on running deployments?

I don't think so!  Note that on new kernels I think inode64 is now the 
default, so this is really about performance on older systems (precise, 
rhel6, probably).

sage

> 
> -- 
> Wido den Hollander
> 42on B.V.
> Ceph trainer and consultant
> 
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
