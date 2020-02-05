From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH resend v5 04/11] ceph: add r_end_stamp for the osdc
 request
Date: Wed, 05 Feb 2020 14:14:01 -0500
Message-ID: <6edd0eca025a4e1f1da719406219f8770e6cef91.camel@kernel.org>
References: <20200129082715.5285-1-xiubli@redhat.com>
         <20200129082715.5285-5-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbgBETOD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:14:03 -0500
In-Reply-To: <20200129082715.5285-5-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiubli@redhat.com, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On Wed, 2020-01-29 at 03:27 -0500, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> Grab the osdc requests' end time stamp.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  include/linux/ceph/osd_client.h | 1 +
>  net/ceph/osd_client.c           | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index 9d9f745b98a1..00a449cfc478 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -213,6 +213,7 @@ struct ceph_osd_request {
>  	/* internal */
>  	unsigned long r_stamp;                /* jiffies, send or check time */
>  	unsigned long r_start_stamp;          /* jiffies */
> +	unsigned long r_end_stamp;          /* jiffies */
>  	int r_attempts;
>  	u32 r_map_dne_bound;
>  
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 8ff2856e2d52..108c9457d629 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -2389,6 +2389,8 @@ static void finish_request(struct ceph_osd_request *req)
>  	WARN_ON(lookup_request_mc(&osdc->map_checks, req->r_tid));
>  	dout("%s req %p tid %llu\n", __func__, req, req->r_tid);
>  
> +	req->r_end_stamp = jiffies;
> +
>  	if (req->r_osd)
>  		unlink_request(req->r_osd, req);
>  	atomic_dec(&osdc->num_requests);

Maybe fold this patch into #6 in this series? I'd prefer to add the new
field along with its first user.
-- 
Jeff Layton <jlayton@kernel.org>
