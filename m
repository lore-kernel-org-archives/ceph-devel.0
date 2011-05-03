From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] ceph: handle ceph_osdc_new_request failure in
 ceph_writepages_start
Date: Tue, 3 May 2011 09:08:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105030907530.20944@cobra.newdream.net>
References: <1304415916-1894-1-git-send-email-henry_c_chang@tcloudcomputing.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35181 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab1ECQHn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2011 12:07:43 -0400
In-Reply-To: <1304415916-1894-1-git-send-email-henry_c_chang@tcloudcomputing.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org, Henry C Chang <henry_c_chang@tcloudcomputing.com>

On Tue, 3 May 2011, Henry C Chang wrote:
> We should unlock the page and return -ENOMEM if ceph_osdc_new_request
> failed.
> 
> Signed-off-by: Henry C Chang <henry_c_chang@tcloudcomputing.com>
> ---
>  fs/ceph/addr.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 561438b..e14dd9f 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -775,6 +775,13 @@ get_more_pages:
>  					    ci->i_truncate_seq,
>  					    ci->i_truncate_size,
>  					    &inode->i_mtime, true, 1, 0);
> +
> +				if (!req) {
> +					rc = -ENOMEM;
> +					unlock_page(page);
> +					break;
> +				}
> +
>  				max_pages = req->r_num_pages;
>  
>  				alloc_page_vec(fsc, req);
> -- 
> 1.7.2.3

Applied, along with

From dbd49b7b369232fe2db568366f594689e8a57fff Mon Sep 17 00:00:00 2001
From: Sage Weil <sage@newdream.net>
Date: Tue, 3 May 2011 09:23:36 -0700
Subject: [PATCH] libceph: fix ceph_osdc_alloc_request error checks

ceph_osdc_alloc_request returns NULL on failure.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 drivers/block/rbd.c   |    4 ++--
 net/ceph/osd_client.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 16dc364..3e90471 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -777,9 +777,9 @@ static int rbd_do_request(struct request *rq,
 				      ops,
 				      false,
 				      GFP_NOIO, pages, bio);
-	if (IS_ERR(req)) {
+	if (!req) {
 		up_read(&header->snap_rwsem);
-		ret = PTR_ERR(req);
+		ret = -ENOMEM;
 		goto done_pages;
 	}
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 9204de4..33fe81a 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -470,8 +470,8 @@ struct ceph_osd_request *ceph_osdc_new_request(struct ceph_osd_client *osdc,
 					 snapc, ops,
 					 use_mempool,
 					 GFP_NOFS, NULL, NULL);
-	if (IS_ERR(req))
-		return req;
+	if (!req)
+		return NULL;
 
 	/* calculate max write size */
 	calc_layout(osdc, vino, layout, off, plen, req, ops);
-- 
1.7.0

