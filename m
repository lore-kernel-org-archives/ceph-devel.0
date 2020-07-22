From: Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH 11/11] ceph: re-enable fscache support
Date: Wed, 22 Jul 2020 06:55:11 -0400
Message-ID: <20200722105511.11187-12-jlayton@kernel.org>
References: <20200722105511.11187-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbgGVKzV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:55:21 -0400
In-Reply-To: <20200722105511.11187-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, dwysocha@redhat.com, smfrench@gmail.com

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
index 734d08b57ef9..bc5656966aca 100644
--- a/fs/ceph/Kconfig
+++ b/fs/ceph/Kconfig
@@ -21,7 +21,7 @@ config CEPH_FS
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
