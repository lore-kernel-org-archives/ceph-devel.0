From: Alex Elder <elder@inktank.com>
Subject: [PATCH 7/9] rbd: don't use ENOTSUPP
Date: Thu, 13 Dec 2012 11:02:38 -0600
Message-ID: <50CA0A2E.1030003@inktank.com>
References: <50CA0915.1090801@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:48913 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753702Ab2LMRCo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 12:02:44 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so2164460iay.19
        for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 09:02:44 -0800 (PST)
In-Reply-To: <50CA0915.1090801@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

ENOTSUPP is not a standard errno (it shows up as "Unknown error 524"
in an error message).  This is what was getting produced when the
the local rbd code does not implement features required by a
discovered rbd image.

Change the error code returned in this case to ENXIO.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index ce26b749..4daa400 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2456,7 +2456,7 @@ static int _rbd_dev_v2_snap_features(struct
rbd_device *rbd_dev, u64 snap_id,

 	incompat = le64_to_cpu(features_buf.incompat);
 	if (incompat & ~RBD_FEATURES_ALL)
-		return -ENOTSUPP;
+		return -ENXIO;

 	*snap_features = le64_to_cpu(features_buf.features);

-- 
1.7.9.5

