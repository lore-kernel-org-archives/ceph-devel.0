From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/4] Misc patches for 3.14-rc2
Date: Mon, 3 Feb 2014 08:29:55 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402030829320.6345@cobra.newdream.net>
References: <1391435228-27874-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55122 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbaBCQ3z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2014 11:29:55 -0500
In-Reply-To: <1391435228-27874-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

Aside from the max pg size #define, these looks good!

Reviewed-by: Sage Weil <sage@inktank.com>

On Mon, 3 Feb 2014, Ilya Dryomov wrote:

> Hello,
> 
> - 1/4 is a simple error path fix
> - 2/4 replaces VLA with a heap buffer
> - 3/4 and 4/4 eliminate a possible race condition in redirect reply
>   handling
> 
> I think these can go into rc2 after some testing.
> 
> Thanks,
> 
>                 Ilya
> 
> 
> Ilya Dryomov (4):
>   libceph: fix error handling in ceph_osdc_init()
>   libceph: a per-osdc crush scratch buffer
>   libceph: factor out logic from ceph_osdc_start_request()
>   libceph: take map_sem for read in handle_reply()
> 
>  include/linux/ceph/osdmap.h |    3 ++
>  net/ceph/osd_client.c       |   84 +++++++++++++++++++++++++++----------------
>  net/ceph/osdmap.c           |   25 ++++++++-----
>  3 files changed, 73 insertions(+), 39 deletions(-)
> 
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
