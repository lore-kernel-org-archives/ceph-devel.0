From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 2/2] Revert "libceph: clear r_req_lru_item in
 __unregister_linger_request()"
Date: Wed, 20 May 2015 10:50:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505201050350.22256@cobra.newdream.net>
References: <1431529052-13932-1-git-send-email-idryomov@gmail.com> <1431529052-13932-3-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52104 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274AbbETRux (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 May 2015 13:50:53 -0400
In-Reply-To: <1431529052-13932-3-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, Alex Elder <elder@linaro.org>

On Wed, 13 May 2015, Ilya Dryomov wrote:
> This reverts commit ba9d114ec5578e6e99a4dfa37ff8ae688040fd64.
> 
> .. which introduced a regression that prevented all lingering requests
> requeued in kick_requests() from ever being sent to the OSDs, resulting
> in a lot of missed notifies.  In retrospect it's pretty obvious that
> r_req_lru_item item in the case of lingering requests can be used not
> only for notarget, but also for unsent linkage due to how tightly
> actual map and enqueue operations are coupled in __map_request().
> 
> The assertion that was being silenced is taken care of in the previous
> ("libceph: request a new osdmap if lingering request maps to no osd")
> commit: by always kicking homeless lingering requests we ensure that
> none of them ends up on the notarget list outside of the critical
> section guarded by request_mutex.
> 
> Cc: stable@vger.kernel.org # 3.18+, needs 3d8c73c93605 "libceph: request a new osdmap if lingering request maps to no osd"
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Reviewed-by: Sage Weil <sage@redhat.com>



> ---
>  net/ceph/osd_client.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 31d4b1ebff01..c4ec9239249a 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1306,8 +1306,6 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
>  		if (list_empty(&req->r_osd_item))
>  			req->r_osd = NULL;
>  	}
> -
> -	list_del_init(&req->r_req_lru_item); /* can be on notarget */
>  	ceph_osdc_put_request(req);
>  }
>  
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
