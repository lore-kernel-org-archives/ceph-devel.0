From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 1/3] ceph: fix potential mdsc use-after-free crash
Date: Wed, 01 Jul 2020 07:17:32 -0400
Message-ID: <c586bbc39a666391c86be355b5c7cb32a5baa532.camel@kernel.org>
References: <1593582768-2954-1-git-send-email-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730140AbgGALRe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:17:34 -0400
In-Reply-To: <1593582768-2954-1-git-send-email-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiubli@redhat.com
Cc: idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On Wed, 2020-07-01 at 01:52 -0400, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> Make sure the delayed work stopped before releasing the resources.
> 
> Because the cancel_delayed_work_sync() will only guarantee that the
> work finishes executing if the work is already in the ->worklist.
> That means after the cancel_delayed_work_sync() returns and in case
> if the work will re-arm itself, it will leave the work requeued. And
> if we release the resources before the delayed work to run again we
> will hit the use-after-free bug.
> 
> URL: https://tracker.ceph.com/issues/46293
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/mds_client.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index d5e523c..9a09d12 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4330,6 +4330,9 @@ static void delayed_work(struct work_struct *work)
>  
>  	dout("mdsc delayed_work\n");
>  
> +	if (mdsc->stopping)
> +		return;
> +
>  	mutex_lock(&mdsc->mutex);
>  	renew_interval = mdsc->mdsmap->m_session_timeout >> 2;
>  	renew_caps = time_after_eq(jiffies, HZ*renew_interval +
> @@ -4689,7 +4692,16 @@ void ceph_mdsc_force_umount(struct ceph_mds_client *mdsc)
>  static void ceph_mdsc_stop(struct ceph_mds_client *mdsc)
>  {
>  	dout("stop\n");
> -	cancel_delayed_work_sync(&mdsc->delayed_work); /* cancel timer */
> +	/*
> +	 * Make sure the delayed work stopped before releasing
> +	 * the resources.
> +	 *
> +	 * Because the cancel_delayed_work_sync() will only
> +	 * guarantee that the work finishes executing. But the
> +	 * delayed work will re-arm itself again after that.
> +	 */
> +	flush_delayed_work(&mdsc->delayed_work);
> +
>  	if (mdsc->mdsmap)
>  		ceph_mdsmap_destroy(mdsc->mdsmap);
>  	kfree(mdsc->sessions);

This patch looks fine, but the subject says [PATCH 1/3]. Were there
others in this series that didn't make it to the list for some reason?

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
