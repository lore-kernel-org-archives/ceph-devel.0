From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 235/671] rbd: clear ->xferred on error from rbd_obj_issue_copyup()
Date: Thu, 16 Jan 2020 11:52:24 -0500
Message-ID: <20200116165940.10720-118-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388399AbgAPRCb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:02:31 -0500
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

[ Upstream commit 356889c49d84f11f446ec235bd52ca1a7d581aa0 ]

Otherwise the assert in rbd_obj_end_request() is triggered.

Fixes: 3da691bf4366 ("rbd: new request handling code")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 585378bc988c..b942f4c8cea8 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2506,6 +2506,7 @@ static bool rbd_obj_handle_write(struct rbd_obj_request *obj_req)
 		ret = rbd_obj_issue_copyup(obj_req, obj_req->xferred);
 		if (ret) {
 			obj_req->result = ret;
+			obj_req->xferred = 0;
 			return true;
 		}
 		return false;
-- 
2.20.1
