From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: [PATCH] rbd: protect against duplicate client creation
Date: Thu, 30 May 2013 10:36:02 -0700
Message-ID: <aa580b87-575e-4e9d-908a-260794579ff5@email.android.com>
References: <51A66A29.6060805@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58289 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671Ab3E3Sgp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 14:36:45 -0400
In-Reply-To: <51A66A29.6060805@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

Alex Elder <elder@inktank.com> wrote:

>If more than one rbd image has the same ceph cluster configuration
>(same options, same set of monitors, same keys) they normally share
>a single rbd client.
>
>When an image is getting mapped, rbd looks to see if an existing
>client can be used, and creates a new one if not.
>
>The lookup and creation are not done under a common lock though, so
>mapping two images concurrently could lead to duplicate clients
>getting set up needlessly.  This isn't a major problem, but it's
>wasteful and different from what's intended.
>
>This patch fixes that by using the control mutex to protect
>both the lookup and (if needed) creation of the client.  It
>was previously used just when creating.
>
>This resolves:
>    http://tracker.ceph.com/issues/3094
>
>Signed-off-by: Alex Elder <elder@inktank.com>
>---
> drivers/block/rbd.c |    7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>index aec2438..d255541 100644
>--- a/drivers/block/rbd.c
>+++ b/drivers/block/rbd.c
>@@ -522,7 +522,7 @@ static const struct block_device_operations
>rbd_bd_ops = {
>
> /*
>  * Initialize an rbd client instance.  Success or not, this function
>- * consumes ceph_opts.
>+ * consumes ceph_opts.  Caller holds ctl_mutex
>  */
>static struct rbd_client *rbd_client_create(struct ceph_options
>*ceph_opts)
> {
>@@ -537,8 +537,6 @@ static struct rbd_client *rbd_client_create(struct
>ceph_options *ceph_opts)
> 	kref_init(&rbdc->kref);
> 	INIT_LIST_HEAD(&rbdc->node);
>
>-	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
>-
> 	rbdc->client = ceph_create_client(ceph_opts, rbdc, 0, 0);
> 	if (IS_ERR(rbdc->client))
> 		goto out_mutex;
>@@ -552,7 +550,6 @@ static struct rbd_client *rbd_client_create(struct
>ceph_options *ceph_opts)
> 	list_add_tail(&rbdc->node, &rbd_client_list);
> 	spin_unlock(&rbd_client_list_lock);
>
>-	mutex_unlock(&ctl_mutex);
> 	dout("%s: rbdc %p\n", __func__, rbdc);
>
> 	return rbdc;
>@@ -684,11 +681,13 @@ static struct rbd_client *rbd_get_client(struct
>ceph_options *ceph_opts)
> {
> 	struct rbd_client *rbdc;
>
>+	mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
> 	rbdc = rbd_client_find(ceph_opts);
> 	if (rbdc)	/* using an existing client */
> 		ceph_destroy_options(ceph_opts);
> 	else
> 		rbdc = rbd_client_create(ceph_opts);
>+	mutex_unlock(&ctl_mutex);
>
> 	return rbdc;
> }

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
