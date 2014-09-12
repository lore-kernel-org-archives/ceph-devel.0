From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH 1/2] ceph: protect kick_requests() with mdsc->mutex
Date: Fri, 12 Sep 2014 13:16:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409121316080.21620@cobra.newdream.net>
References: <1410420156-3289-1-git-send-email-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41288 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbaILUQN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Sep 2014 16:16:13 -0400
In-Reply-To: <1410420156-3289-1-git-send-email-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org, "Yan, Zheng" <ukernel@gmail.com>

Reviewed-by: Sage Weil <sage@redhat.com>

On Thu, 11 Sep 2014, Yan, Zheng wrote:

> From: "Yan, Zheng" <ukernel@gmail.com>
> 
> Signed-off-by: Yan, Zheng <zyan@redhat.com>
> ---
>  fs/ceph/mds_client.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index f751fea..267ba44 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2471,9 +2471,8 @@ static void handle_session(struct ceph_mds_session *session,
>  		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
>  			pr_info("mds%d reconnect denied\n", session->s_mds);
>  		remove_session_caps(session);
> -		wake = 1; /* for good measure */
> +		wake = 2; /* for good measure */
>  		wake_up_all(&mdsc->session_close_wq);
> -		kick_requests(mdsc, mds);
>  		break;
>  
>  	case CEPH_SESSION_STALE:
> @@ -2503,6 +2502,8 @@ static void handle_session(struct ceph_mds_session *session,
>  	if (wake) {
>  		mutex_lock(&mdsc->mutex);
>  		__wake_requests(mdsc, &session->s_waiting);
> +		if (wake == 2)
> +			kick_requests(mdsc, mds);
>  		mutex_unlock(&mdsc->mutex);
>  	}
>  	return;
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
