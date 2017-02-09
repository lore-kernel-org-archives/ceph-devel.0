From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH] ceph: remove req from unsafe list before calling
 __unregister_request
Date: Thu, 9 Feb 2017 21:32:26 +0800
Message-ID: <747B8E9C-B3AB-4646-86CF-0DD7DE6483FC@redhat.com>
References: <20170209121815.4244-1-jlayton@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752712AbdBINdY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 9 Feb 2017 08:33:24 -0500
In-Reply-To: <20170209121815.4244-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, idryomov@gmail.com


> On 9 Feb 2017, at 20:18, Jeff Layton <jlayton@redhat.com> wrote:
> 
> ...and while we're at it, let's ensure that no one inadvertantly
> leaves this thing on the unsafe list. There's no reason it should
> ever be on a s_unsafe list but not in the request tree.
> 
> Cc: stable@vger.kernel.org
> Link: http://tracker.ceph.com/issues/18474
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
> fs/ceph/mds_client.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 52521f339745..b47e97680a66 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -628,6 +628,8 @@ static void __unregister_request(struct ceph_mds_client *mdsc,
> {
> 	dout("__unregister_request %p tid %lld\n", req, req->r_tid);
> 
> +	WARN_ON_ONCE(!list_empty(&req->r_unsafe_item));
> +
> 	if (req->r_tid == mdsc->oldest_tid) {
> 		struct rb_node *p = rb_next(&req->r_node);
> 		mdsc->oldest_tid = 0;
> @@ -3512,6 +3514,7 @@ static void wait_requests(struct ceph_mds_client *mdsc)
> 		while ((req = __get_oldest_req(mdsc))) {
> 			dout("wait_requests timed out on tid %llu\n",
> 			     req->r_tid);
> +			list_del_init(&req->r_unsafe_item);
> 			__unregister_request(mdsc, req);
> 		}
> 	}

Reviewed-by: Yan, Zheng <zyan@redhat.com>
> -- 
> 2.9.3
> 

