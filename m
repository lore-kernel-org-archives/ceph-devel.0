From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: return ETIMEDOUT errno to userland when request
 timed out
Date: Mon, 24 Feb 2020 14:18:00 -0800
Message-ID: <57fe13b3f31a85120c0bea9adb0318c543e11cae.camel@kernel.org>
References: <20200224032311.26107-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBXWSC (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:18:02 -0500
In-Reply-To: <20200224032311.26107-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiubli@redhat.com, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On Sun, 2020-02-23 at 22:23 -0500, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> The ETIMEOUT errno will be cleaner and be more user-friendly.
> 
> URL: https://tracker.ceph.com/issues/44215
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/mds_client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 3e792eca6af7..a1649eb3a3fd 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -2578,7 +2578,7 @@ static void __do_request(struct ceph_mds_client *mdsc,
>  	if (req->r_timeout &&
>  	    time_after_eq(jiffies, req->r_started + req->r_timeout)) {
>  		dout("do_request timed out\n");
> -		err = -EIO;
> +		err = -ETIMEDOUT;
>  		goto finish;
>  	}
>  	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_SHUTDOWN) {
> @@ -2752,7 +2752,7 @@ static int ceph_mdsc_wait_request(struct ceph_mds_client *mdsc,
>  		if (timeleft > 0)
>  			err = 0;
>  		else if (!timeleft)
> -			err = -EIO;  /* timed out */
> +			err = -ETIMEDOUT;  /* timed out */
>  		else
>  			err = timeleft;  /* killed */
>  	}


Thanks. Merged into ceph-client/testing.
-- 
Jeff Layton <jlayton@kernel.org>
