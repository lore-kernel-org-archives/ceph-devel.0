From: David Flynn <davidf@rd.bbc.co.uk>
Subject: [PATCH] ceph: fix memory leak in async readpages
Date: Wed, 28 Sep 2011 18:19:54 +0000
Message-ID: <20110928181954.GA18512@rd.bbc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailout1.thls.bbc.co.uk ([132.185.240.36]:59743 "EHLO
	mailout1.thls.bbc.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab1I1S3w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 14:29:52 -0400
Received: from gateh.kw.bbc.co.uk (gateh.kw.bbc.co.uk [132.185.132.17])
	by mailout1.thls.bbc.co.uk (8.14.4/8.14.3) with ESMTP id p8SIJtg3001685
	for <ceph-devel@vger.kernel.org>; Wed, 28 Sep 2011 19:19:55 +0100 (BST)
Received: from mailhub.rd.bbc.co.uk ([172.29.120.130])
	by gateh.kw.bbc.co.uk (8.13.6/8.13.6) with ESMTP id p8SIJtx7000067
	for <ceph-devel@vger.kernel.org>; Wed, 28 Sep 2011 19:19:55 +0100 (BST)
Received: from lxg1.rd.bbc.co.uk ([172.29.123.71]:39640)
	by mailhub.rd.bbc.co.uk with esmtp (Exim 4.72)
	(envelope-from <davidf@rd.bbc.co.uk>)
	id 1R8yja-0003qj-QF
	for ceph-devel@vger.kernel.org; Wed, 28 Sep 2011 19:19:54 +0100
Received: from davidf by lxg1.rd.bbc.co.uk with local (Exim 4.72)
	(envelope-from <davidf@rd.bbc.co.uk>)
	id 1R8yja-0004ov-Mi
	for ceph-devel@vger.kernel.org; Wed, 28 Sep 2011 19:19:54 +0100
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The finish_read callback introduced in 63c90314546c1cec1f220f6ab24ea
fails to release the page list allocated in start_read.
---
 fs/ceph/addr.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e06a322..4144caf 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -261,6 +261,7 @@ static void finish_read(struct ceph_osd_request *req, struct ceph_msg *msg)
 		unlock_page(page);
 		page_cache_release(page);
 	}
+	kfree(req->r_pages);
 }
 
 /*
-- 
1.7.4.1
