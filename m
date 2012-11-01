From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/5] rbd: don't use ENOTSUPP
Date: Thu, 01 Nov 2012 08:55:22 -0500
Message-ID: <50927F4A.1090404@inktank.com>
References: <50927D03.9060900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:53770 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758235Ab2KANzm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 09:55:42 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so1922492iag.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 06:55:42 -0700 (PDT)
In-Reply-To: <50927D03.9060900@inktank.com>
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
index 6512a8e..3378963 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2465,7 +2465,7 @@ static int _rbd_dev_v2_snap_features(struct
rbd_device *rbd_dev, u64 snap_id,

 	incompat = le64_to_cpu(features_buf.incompat);
 	if (incompat & ~RBD_FEATURES_ALL)
-		return -ENOTSUPP;
+		return -ENXIO;

 	*snap_features = le64_to_cpu(features_buf.features);

-- 
1.7.9.5

