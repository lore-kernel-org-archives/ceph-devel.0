From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 2/6] ceph.spec.in: add rbd-fuse
Date: Wed, 30 Jan 2013 19:00:41 +0100
Message-ID: <1359568845-7634-3-git-send-email-danny.al-gaaf@bisect.de>
References: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:51040 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756578Ab3A3SAs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Jan 2013 13:00:48 -0500
In-Reply-To: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Add %{_bindir}/rbd-fuse to the ceph-fuse subpackage.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 ceph.spec.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ceph.spec.in b/ceph.spec.in
index b98ae06..38aef98 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -392,6 +392,7 @@ fi
 %files fuse
 %defattr(-,root,root,-)
 %{_bindir}/ceph-fuse
+%{_bindir}/rbd-fuse
 %{_mandir}/man8/ceph-fuse.8*
 /sbin/mount.fuse.ceph
 
-- 
1.8.1.1

