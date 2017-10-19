From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: unlock dangling spinlock in try_flush_caps
Date: Thu, 19 Oct 2017 20:58:50 +0800
Message-ID: <56D91E2E-C4FA-4EC0-B266-91057FFB3E3F@redhat.com>
References: <20171019125258.19821-1-jlayton@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbdJSM7A (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 19 Oct 2017 08:59:00 -0400
In-Reply-To: <20171019125258.19821-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Sage Weil <sage@redhat.com>, idryomov@gmail.com, ceph-devel@vger.kernel.org



> On 19 Oct 2017, at 20:52, Jeff Layton <jlayton@kernel.org> wrote:
> 
> From: Jeff Layton <jlayton@redhat.com>
> 
> sparose warns:
>    fs/ceph/caps.c:2042:9: warning: context imbalance in 'try_flush_caps' - wrong count at exit
> 
> We need to exit this function with the lock unlocked, but a couple of
> cases leave it locked.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
> fs/ceph/caps.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 157fe59fbabe..1978a8cb1cb1 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1991,6 +1991,7 @@ static int try_flush_caps(struct inode *inode, u64 *ptid)
> retry:
> 	spin_lock(&ci->i_ceph_lock);
> 	if (ci->i_ceph_flags & CEPH_I_NOFLUSH) {
> +		spin_unlock(&ci->i_ceph_lock);
> 		dout("try_flush_caps skipping %p I_NOFLUSH set\n", inode);
> 		goto out;
> 	}
> @@ -2008,8 +2009,10 @@ static int try_flush_caps(struct inode *inode, u64 *ptid)
> 			mutex_lock(&session->s_mutex);
> 			goto retry;
> 		}
> -		if (cap->session->s_state < CEPH_MDS_SESSION_OPEN)
> +		if (cap->session->s_state < CEPH_MDS_SESSION_OPEN) {
> +			spin_unlock(&ci->i_ceph_lock);
> 			goto out;
> +		}
> 
> 		flushing = __mark_caps_flushing(inode, session, true,
> 						&flush_tid, &oldest_flush_tid);
> -- 
> 2.13.6

good catch

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>

