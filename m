From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH v2 1/3] ceph: fix up comment for ceph_count_locks() as
 to which lock to hold
Date: Wed, 15 May 2013 10:38:12 -0600
Message-ID: <1368635894-114707-2-git-send-email-jaschut@sandia.gov>
References: <1368635894-114707-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:43758 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114Ab3EOQjN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 May 2013 12:39:13 -0400
In-Reply-To: <1368635894-114707-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@inktank.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>


Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 fs/ceph/locks.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 202dd3d..ffc86cb 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -169,7 +169,7 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 }
 
 /**
- * Must be called with BKL already held. Fills in the passed
+ * Must be called with lock_flocks() already held. Fills in the passed
  * counter variables, so you can prepare pagelist metadata before calling
  * ceph_encode_locks.
  */
-- 
1.7.8.2


