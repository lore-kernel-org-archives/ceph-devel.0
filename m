From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 2/2] ceph: Add necessary clean up if invalid reply received in handle_reply()
Date: Wed, 27 Nov 2013 22:28:14 +0800
Message-ID: <4ea6e7ee4e9d67176a61839ff95193c7a96740e9.1385561919.git.liwang@ubuntukylin.com>
References: <cover.1385561919.git.liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:39564 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab3K0O23 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 09:28:29 -0500
In-Reply-To: <cover.1385561919.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1385561919.git.liwang@ubuntukylin.com>
References: <cover.1385561919.git.liwang@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Wake up possible waiters, invoke the call back if any, unregister the request

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
---
 net/ceph/osd_client.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2b4b32a..a17eaae 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1581,6 +1581,13 @@ done:
 	return;
 
 bad_put:
+	req->r_result = -EIO;
+	__unregister_request(osdc, req);
+	if (req->r_callback)
+		req->r_callback(req, msg);
+	else
+		complete_all(&req->r_completion);
+	complete_request(req);
 	ceph_osdc_put_request(req);
 bad_mutex:
 	mutex_unlock(&osdc->request_mutex);
-- 
1.7.9.5

