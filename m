From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH 2/2] ceph: add request to the tail of unsafe write list
Date: Tue, 15 Mar 2011 09:18:02 +0000
Message-ID: <1300180682-18749-2-git-send-email-henry_c_chang@tcloudcomputing.com>
References: <1300180682-18749-1-git-send-email-henry_c_chang@tcloudcomputing.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:57899 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab1COJTp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Mar 2011 05:19:45 -0400
Received: by pxi2 with SMTP id 2so111580pxi.10
        for <ceph-devel@vger.kernel.org>; Tue, 15 Mar 2011 02:19:45 -0700 (PDT)
In-Reply-To: <1300180682-18749-1-git-send-email-henry_c_chang@tcloudcomputing.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In sync_write_wait(), we assume that the newest request is at the
tail of unsafe write list. We should maintain the semantics here.

Signed-off-by: Henry C Chang <henry_c_chang@tcloudcomputing.com>
---
 fs/ceph/file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index db5d863..bc09e72 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -564,7 +564,7 @@ more:
 			 * start_request so that a tid has been assigned.
 			 */
 			spin_lock(&ci->i_unsafe_lock);
-			list_add(&req->r_unsafe_item, &ci->i_unsafe_writes);
+			list_add_tail(&req->r_unsafe_item, &ci->i_unsafe_writes);
 			spin_unlock(&ci->i_unsafe_lock);
 			ceph_get_cap_refs(ci, CEPH_CAP_FILE_WR);
 		}
-- 
1.7.2.3

