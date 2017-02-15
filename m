From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH] ceph: remove req from unsafe list before calling
 __unregister_request
Date: Wed, 15 Feb 2017 13:41:58 -0500
Message-ID: <1487184118.2774.3.camel@redhat.com>
References: <20170209121815.4244-1-jlayton@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33402 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbdBOSuK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 13:50:10 -0500
Received: by mail-qk0-f169.google.com with SMTP id p22so68751754qka.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2017 10:50:10 -0800 (PST)
In-Reply-To: <20170209121815.4244-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

On Thu, 2017-02-09 at 07:18 -0500, Jeff Layton wrote:
> ...and while we're at it, let's ensure that no one inadvertantly
> leaves this thing on the unsafe list. There's no reason it should
> ever be on a s_unsafe list but not in the request tree.
> 
> Cc: stable@vger.kernel.org
> Link: http://tracker.ceph.com/issues/18474
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  fs/ceph/mds_client.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 52521f339745..b47e97680a66 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -628,6 +628,8 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
>  {
>  	dout("__unregister_request %p tid %lld\n", req, req->r_tid);
>  
> +	WARN_ON_ONCE(!list_empty(&req->r_unsafe_item));
> +
>  	if (req->r_tid == mdsc->oldest_tid) {
>  		struct rb_node *p = rb_next(&req->r_node);
>  		mdsc->oldest_tid = 0;
> @@ -3512,6 +3514,7 @@ static void wait_requests(struct ceph_mds_client *mdsc)
>  		while ((req = __get_oldest_req(mdsc))) {
>  			dout("wait_requests timed out on tid %llu\n",
>  			     req->r_tid);
> +			list_del_init(&req->r_unsafe_item);
>  			__unregister_request(mdsc, req);
>  		}
>  	}

After going over the kernel code more thoroughly, I started to get
concerned that there were some cases (particularly those involving fatal
signals) where we could end up leaving it on the list before calling
__unregister_request.

I've just sent a v2 patch, that moves the list_del_init into
__unregister_request itself, which ensures that it's always removed from
the list in those cases as well.
-- 
Jeff Layton <jlayton@redhat.com>
