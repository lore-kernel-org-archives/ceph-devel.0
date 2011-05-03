From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH] ceph: handle ceph_osdc_new_request failure in ceph_writepages_start
Date: Tue,  3 May 2011 09:45:16 +0000
Message-ID: <1304415916-1894-1-git-send-email-henry_c_chang@tcloudcomputing.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57684 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab1ECJsS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2011 05:48:18 -0400
Received: by pwi15 with SMTP id 15so3053916pwi.19
        for <ceph-devel@vger.kernel.org>; Tue, 03 May 2011 02:48:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry_c_chang@tcloudcomputing.com>

We should unlock the page and return -ENOMEM if ceph_osdc_new_request
failed.

Signed-off-by: Henry C Chang <henry_c_chang@tcloudcomputing.com>
---
 fs/ceph/addr.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 561438b..e14dd9f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -775,6 +775,13 @@ get_more_pages:
 					    ci->i_truncate_seq,
 					    ci->i_truncate_size,
 					    &inode->i_mtime, true, 1, 0);
+
+				if (!req) {
+					rc = -ENOMEM;
+					unlock_page(page);
+					break;
+				}
+
 				max_pages = req->r_num_pages;
 
 				alloc_page_vec(fsc, req);
-- 
1.7.2.3

