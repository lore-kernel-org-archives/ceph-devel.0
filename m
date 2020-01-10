From: Jeff Layton <jlayton@kernel.org>
Subject: [RFC PATCH 5/9] libceph: export ceph_file_layout_is_valid
Date: Fri, 10 Jan 2020 15:56:43 -0500
Message-ID: <20200110205647.311023-6-jlayton@kernel.org>
References: <20200110205647.311023-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbgAJU4y (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 10 Jan 2020 15:56:54 -0500
In-Reply-To: <20200110205647.311023-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, pdonnell@redhat.com

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/ceph/ceph_fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/ceph_fs.c b/net/ceph/ceph_fs.c
index 756a2dc10d27..11a2e3c61b04 100644
--- a/net/ceph/ceph_fs.c
+++ b/net/ceph/ceph_fs.c
@@ -27,6 +27,7 @@ int ceph_file_layout_is_valid(const struct ceph_file_layout *layout)
 		return 0;
 	return 1;
 }
+EXPORT_SYMBOL(ceph_file_layout_is_valid);
 
 void ceph_file_layout_from_legacy(struct ceph_file_layout *fl,
 				  struct ceph_file_layout_legacy *legacy)
-- 
2.24.1
