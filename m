From: Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH v2 11/11] ceph: re-enable fscache support
Date: Fri, 31 Jul 2020 09:04:21 -0400
Message-ID: <20200731130421.127022-12-jlayton@kernel.org>
References: <20200731130421.127022-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730217AbgGaNE3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:04:29 -0400
In-Reply-To: <20200731130421.127022-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: linux-cachefs@redhat.com, idryomov@gmail.com

Now that the code has been converted to use the new fscache API, we can
re-enable it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
index 432aa34b63e7..8e6b85275c79 100644
--- a/fs/ceph/Kconfig
+++ b/fs/ceph/Kconfig
@@ -22,7 +22,7 @@ config CEPH_FS
 if CEPH_FS
 config CEPH_FSCACHE
 	bool "Enable Ceph client caching support"
-	depends on CEPH_FS=m && FSCACHE_OLD || CEPH_FS=y && FSCACHE_OLD=y
+	depends on CEPH_FS=m && FSCACHE || CEPH_FS=y && FSCACHE=y
 	help
 	  Choose Y here to enable persistent, read-only local
 	  caching support for Ceph clients using FS-Cache
-- 
2.26.2
