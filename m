From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: properly wake up cap waiter after releasing
 revoked caps
Date: Mon, 11 May 2020 07:28:55 -0400
Message-ID: <53aab39a79f468514cc836ef0081066376ce7d8c.camel@kernel.org>
References: <20200511082512.4375-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730062AbgEKL25 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 11 May 2020 07:28:57 -0400
In-Reply-To: <20200511082512.4375-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org

On Mon, 2020-05-11 at 16:25 +0800, Yan, Zheng wrote:
> arg->wake can never be true. the bug was introduced by commit
> 0c4b255369bcf "ceph: reorganize __send_cap for less spinlock abuse"
> 
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  fs/ceph/caps.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index b3e65c89ba6e..a2a2cda117e0 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1376,6 +1376,12 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
>  	ci->i_ceph_flags &= ~CEPH_I_FLUSH;
>  
>  	cap->issued &= retain;  /* drop bits we don't want */
> +	/*
> +	 * Wake up any waiters on wanted -> needed transition. This is due to
> +	 * the weird transition from buffered to sync IO... we need to flush
> +	 * dirty pages _before_ allowing sync writes to avoid reordering.
> +	 */
> +	arg->wake = cap->implemented & ~cap->issued;
>  	cap->implemented &= cap->issued | used;
>  	cap->mds_wanted = want;
>  
> @@ -1439,13 +1445,6 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
>  		}
>  	}
>  	arg->flags = flags;
> -
> -	/*
> -	 * Wake up any waiters on wanted -> needed transition. This is due to
> -	 * the weird transition from buffered to sync IO... we need to flush
> -	 * dirty pages _before_ allowing sync writes to avoid reordering.
> -	 */
> -	arg->wake = cap->implemented & ~cap->issued;
>  }
>  
>  /*

Good catch! Merged (with a small revision to the commit message).
-- 
Jeff Layton <jlayton@kernel.org>
