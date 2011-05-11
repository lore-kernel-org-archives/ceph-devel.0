From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH 2/3] ceph: fix list_add in ceph_put_snap_realm
Date: Wed, 11 May 2011 10:29:53 +0000
Message-ID: <1305109794-7967-2-git-send-email-henry.cy.chang@gmail.com>
References: <1305109794-7967-1-git-send-email-henry.cy.chang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44975 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898Ab1EKPil (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 May 2011 11:38:41 -0400
Received: by pwi15 with SMTP id 15so296924pwi.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 May 2011 08:38:40 -0700 (PDT)
In-Reply-To: <1305109794-7967-1-git-send-email-henry.cy.chang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry.cy.chang@gmail.com>

Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
---
 fs/ceph/snap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index e86ec11..24067d6 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -206,7 +206,7 @@ void ceph_put_snap_realm(struct ceph_mds_client *mdsc,
 		up_write(&mdsc->snap_rwsem);
 	} else {
 		spin_lock(&mdsc->snap_empty_lock);
-		list_add(&mdsc->snap_empty, &realm->empty_item);
+		list_add(&realm->empty_item, &mdsc->snap_empty);
 		spin_unlock(&mdsc->snap_empty_lock);
 	}
 }
-- 
1.7.2.3

