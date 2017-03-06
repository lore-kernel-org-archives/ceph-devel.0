From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] libceph: don't set weight to IN when OSD is destroyed
Date: Mon, 6 Mar 2017 19:02:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703061901410.24356@piezo.novalocal>
References: <1488825838-11576-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37927 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753657AbdCFTNU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 14:13:20 -0500
In-Reply-To: <1488825838-11576-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 6 Mar 2017, Ilya Dryomov wrote:
> Since ceph.git commit 4e28f9e63644 ("osd/OSDMap: clear osd_info,
> osd_xinfo on osd deletion"), weight is set to IN when OSD is deleted.
> This changes the result of applying an incremental for clients, not
> just OSDs.  Because CRUSH computations are obviously affected,
> pre-4e28f9e63644 servers disagree with post-4e28f9e63644 clients on
> object placement, resulting in misdirected requests.
> 
> Mirrors ceph.git commit a6009d1039a55e2c77f431662b3d6cc5a8e8e63f.
> 
> Fixes: 930c53286977 ("libceph: apply new_state before new_up_client on incrementals")
> Link: http://tracker.ceph.com/issues/19122
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---

Reviewed-by: Sage Weil <sage@redhat.com>

>  net/ceph/osdmap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index cc22dd282a3e..ffe9e904d4d1 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1379,7 +1379,6 @@ static int decode_new_up_state_weight(void **p, void *end,
>  		if ((map->osd_state[osd] & CEPH_OSD_EXISTS) &&
>  		    (xorstate & CEPH_OSD_EXISTS)) {
>  			pr_info("osd%d does not exist\n", osd);
> -			map->osd_weight[osd] = CEPH_OSD_IN;
>  			ret = set_primary_affinity(map, osd,
>  						   CEPH_OSD_DEFAULT_PRIMARY_AFFINITY);
>  			if (ret)
> -- 
> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
