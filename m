From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] libceph: Allocate larger oid buffer in request msgs
Date: Thu, 10 Nov 2011 22:23:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111102219410.27241@cobra.newdream.net>
References: <1320932737-5215-1-git-send-email-psomas@grnet.gr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55852 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab1KKGXK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2011 01:23:10 -0500
In-Reply-To: <1320932737-5215-1-git-send-email-psomas@grnet.gr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stratos Psomadakis <psomas@grnet.gr>
Cc: ceph-devel@vger.kernel.org

Hmm, I wish we could just make r_oid a char * and dynamically allocate the 
name.  Unfortunately that would significantly complicate things because we 
need to allocate osd requests in the writeback path during reclaim and 
that'd involve a fallback memory pool or something similar.

A larger fixed-sized buffer seems like the way to go for now.

I'll stick this in the queue, tho it'll probably get adjusted when the rbd 
constants get cleaned up.

Thanks!
sage


On Thu, 10 Nov 2011, Stratos Psomadakis wrote:

> ceph_osd_request struct allocates a 40-byte buffer for object names.
> RBD image names can be up to 96 chars long (100 with the .rbd suffix),
> which results in the object name for the image being truncated, and a
> subsequent map failure.
> 
> Increase the oid buffer in request messages, in order to avoid the
> truncation.
> 
> Signed-off-by: Stratos Psomadakis <psomas@grnet.gr>
> ---
> 
> This is a quick fix, until #1701 is sorted out. I'm not sure if this
> is the best way to do it.
> 
> 
>  include/linux/ceph/osd_client.h |    8 +++++++-
>  net/ceph/osd_client.c           |    2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index f88eacb..7c05ac2 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -10,6 +10,12 @@
>  #include "osdmap.h"
>  #include "messenger.h"
>  
> +/* 
> + * Maximum object name size 
> + * (must be at least as big as RBD_MAX_MD_NAME_LEN -- currently 100) 
> + */
> +#define MAX_OBJ_NAME_SIZE 100
> +
>  struct ceph_msg;
>  struct ceph_snap_context;
>  struct ceph_osd_request;
> @@ -75,7 +81,7 @@ struct ceph_osd_request {
>  	struct inode *r_inode;         	      /* for use by callbacks */
>  	void *r_priv;			      /* ditto */
>  
> -	char              r_oid[40];          /* object name */
> +	char              r_oid[MAX_OBJ_NAME_SIZE];          /* object name */
>  	int               r_oid_len;
>  	unsigned long     r_stamp;            /* send OR check time */
>  
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 733e4600..f4f3f58 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -244,7 +244,7 @@ struct ceph_osd_request *ceph_osdc_alloc_request(struct ceph_osd_client *osdc,
>  		ceph_pagelist_init(req->r_trail);
>  	}
>  	/* create request message; allow space for oid */
> -	msg_size += 40;
> +	msg_size += MAX_OBJ_NAME_SIZE;
>  	if (snapc)
>  		msg_size += sizeof(u64) * snapc->num_snaps;
>  	if (use_mempool)
> -- 
> 1.7.2.5
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
