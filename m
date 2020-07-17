From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: check the sesion state and return false in case
 it is closed
Date: Fri, 17 Jul 2020 09:32:03 -0400
Message-ID: <efcd42ccc33c8e4a78ceb3c749e56a952e3989b2.camel@kernel.org>
References: <20200717132513.8845-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgGQNcF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:32:05 -0400
In-Reply-To: <20200717132513.8845-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiubli@redhat.com
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org, zyan@redhat.com, pdonnell@redhat.com, vshankar@redhat.com

On Fri, 2020-07-17 at 09:25 -0400, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> If the session is already in closed state, we should skip it.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/mds_client.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 887874f8ad2c..2af773168a0a 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4302,6 +4302,7 @@ bool check_session_state(struct ceph_mds_session *s)
>  	}
>  	if (s->s_state == CEPH_MDS_SESSION_NEW ||
>  	    s->s_state == CEPH_MDS_SESSION_RESTARTING ||
> +	    s->s_state == CEPH_MDS_SESSION_CLOSED ||
>  	    s->s_state == CEPH_MDS_SESSION_REJECTED)
>  		/* this mds is failed or recovering, just wait */
>  		return false;

Looks good. I merged this into testing and rebased the metrics patches
on top.

Thanks!
-- 
Jeff Layton <jlayton@kernel.org>
