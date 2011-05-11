From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 1/3] ceph: print debug message before put mds session
Date: Wed, 11 May 2011 10:30:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105111029480.17222@cobra.newdream.net>
References: <1305109794-7967-1-git-send-email-henry.cy.chang@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40858 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733Ab1EKRaB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2011 13:30:01 -0400
In-Reply-To: <1305109794-7967-1-git-send-email-henry.cy.chang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

Applied all three of these.  Thanks, Henry!  I'll send them to Linus today 
or tomorrow so they'll make 2.6.39.

sage


On Wed, 11 May 2011, Henry C Chang wrote:

> The mds session, s, could be freed during ceph_put_mds_session.
> Move dout before ceph_put_mds_session.
> 
> Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
> ---
>  fs/ceph/mds_client.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index f60b07b..d0fae4c 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3304,8 +3304,8 @@ static void con_put(struct ceph_connection *con)
>  {
>  	struct ceph_mds_session *s = con->private;
>  
> +	dout("mdsc con_put %p (%d)\n", s, atomic_read(&s->s_ref) - 1);
>  	ceph_put_mds_session(s);
> -	dout("mdsc con_put %p (%d)\n", s, atomic_read(&s->s_ref));
>  }
>  
>  /*
> -- 
> 1.7.2.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
