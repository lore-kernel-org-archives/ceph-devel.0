From: Jeff Mahoney <jeffm@suse.com>
Subject: [PATCH] ceph: fix atomic64_t initialization on ia64
Date: Thu, 10 Jun 2010 11:13:58 -0400
Message-ID: <4C110136.3080709@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52603 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759106Ab0FJPOI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Jun 2010 11:14:08 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, ceph-devel@vger.kernel.org

 bdi_seq is an atomic_long_t but we're using ATOMIC_INIT, which causes
 build failures on ia64. This patch fixes it to use ATOMIC_LONG_INIT.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 fs/ceph/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -926,7 +926,7 @@ static int ceph_compare_super(struct sup
 /*
  * construct our own bdi so we can control readahead, etc.
  */
-static atomic_long_t bdi_seq = ATOMIC_INIT(0);
+static atomic_long_t bdi_seq = ATOMIC_LONG_INIT(0);
 
 static int ceph_register_bdi(struct super_block *sb, struct ceph_client *client)
 {
-- 
Jeff Mahoney
SUSE Labs
