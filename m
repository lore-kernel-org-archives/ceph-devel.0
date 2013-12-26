From: Alex Elder <alex.elder@linaro.org>
Subject: [PATCH] MAINTAINERS: update an e-mail address
Date: Thu, 26 Dec 2013 08:37:43 -0600
Message-ID: <52BC3F37.6050103@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:39825 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab3LZOho (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Dec 2013 09:37:44 -0500
Received: by mail-ie0-f176.google.com with SMTP id at1so8423855iec.7
        for <ceph-devel@vger.kernel.org>; Thu, 26 Dec 2013 06:37:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

[Sage, perhaps you could sign off on or ack this, and take it in
through your tree.  Thanks.  -Alex]

I no longer have direct access to my Inktank e-mail.  I still pay
attention to rbd, so update its entry in MAINTAINERS accordingly.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5e4ff3..d42633c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7016,7 +7016,7 @@ F:	drivers/media/parport/*-qcam*
 RADOS BLOCK DEVICE (RBD)
 M:	Yehuda Sadeh <yehuda@inktank.com>
 M:	Sage Weil <sage@inktank.com>
-M:	Alex Elder <elder@inktank.com>
+M:	Alex Elder <elder@kernel.org>
 M:	ceph-devel@vger.kernel.org
 W:	http://ceph.com/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
-- 
1.7.9.5

