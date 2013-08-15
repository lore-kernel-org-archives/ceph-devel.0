From: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Subject: rbd: format 2 support in rbd.ko ?
Date: Thu, 15 Aug 2013 13:42:29 +0200
Message-ID: <20130815114229.GA10572@oder.mch.fsc.net>
References: <50748FA5.4030508@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:16315 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755875Ab3HOLmf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Aug 2013 07:42:35 -0400
Content-Disposition: inline
In-Reply-To: <50748FA5.4030508@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

When will 'format 2' support be available in rbd.ko ?

-Dieter

# rbd info ssd2-v2-1T-4m  -p SSD-r2
rbd image 'ssd2-v2-1T-4m':
	size 1000 GB in 256000 objects
	order 22 (4096 KB objects)
	block_name_prefix: rbd_data.13032ae8944a
	format: 2
	features: layering

# rbd map -p SSD-r2 ssd2-v2-1T-4m
rbd: add failed: (6) No such device or address

# uname -a
Linux rx37-2.primary.ceph-poc.fsc.net 3.8.13 #11 SMP Thu Aug 1 09:27:48 CEST 2013 x86_64 x86_64 x86_64 GNU/Linux


On Tue, Oct 09, 2012 at 10:57:09PM +0200, Alex Elder wrote:
> This series includes updates for two patches posted previously.
> 
> 					-Alex
> 
> [PATCH 1/4] rbd: define rbd_update_size()
>      This is a simple addition so a bit of code used by both
>      format 1 and 2 can be common rather than duplicated.
> [PATCH 2/4, v2] rbd: define rbd_dev_v2_refresh()
>      Updated to fetch the image size in addition to the snapshot
>      context when refreshing.  The names of some functions no
>      longer contain "snapc" to reflect this.
> [PATCH 3/4] rbd: implement feature checks
>      This ensures that images requiring features not supported
>      by the local rbd client software are rejected.
> [PATCH 4/4] rbd: activate v2 image support
>      Same as before, and trivial.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
