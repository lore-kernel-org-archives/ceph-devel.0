Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCA03CDBDF;
	Thu,  4 Jun 2026 07:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559018; cv=none; b=mSKIUDc50f9/rDjA8KeUWVyM+GcCOcHXJgOJwSoEFwr8rMDZrSO+R8AYj/NOdbpFt01oWBZbshtBSOQP8CenUt7UlfQYU3fq9Ab7wb0zykP+ZE1TKDrvzOtsSMVpZZSjUbZtap94ja9uGl5sh03vNLmOzb8mwtH8c74I3zw0uJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559018; c=relaxed/simple;
	bh=sz9IUhwbmqR2n493Ci0EJdXpR3CejCN0rrlv54recvM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MWCXQGgLe7FlgZQ2OC6rNQ5Uolsil4crxCk3j0MXpaleqtHTn5FKmIm/WpBdhspMPpj1wnte+UcvqNuHRXwM2EzXMYH9E2HqRQlDHjUBcr+eAhDbrG3NOaCg5ONbcclP51LkN4tgP6F34LDmVhWP9SY8tggzaJ4Oe1K//dK9RmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 14f934cc5fe911f1aa26b74ffac11d73-20260604
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:85391fbd-1ca0-4273-b394-82764f6ea626,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:09b0a0dd42006a51df36776c1e2f4c9e,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 14f934cc5fe911f1aa26b74ffac11d73-20260604
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 667632569; Thu, 04 Jun 2026 15:43:30 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	jlayton@kernel.org,
	jack@suse.cz,
	neil@brown.name,
	brauner@kernel.org
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH v2] ceph: Fix ERR_PTR(0) in ceph_mkdir()
Date: Thu,  4 Jun 2026 15:43:25 +0800
Message-Id: <20260604074325.214093-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mkdir succeeds, ceph_mkdir() sets ret to ERR_PTR(0) which is
incorrect. It should return NULL instead for success.

Fixes: 88d5baf69082 ("Change inode_operations.mkdir to return struct dentry *")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

---
Change in v2:
 -Add pre-reviewer
---
 fs/ceph/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 27ce9e55e947..7acd4353a7a7 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1169,7 +1169,7 @@ static struct dentry *ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	    !req->r_reply_info.head->is_target &&
 	    !req->r_reply_info.head->is_dentry)
 		err = ceph_handle_notrace_create(dir, dentry);
-	ret = ERR_PTR(err);
+	ret = err ? ERR_PTR(err) : NULL;
 out_req:
 	if (!IS_ERR(ret) && req->r_dentry != dentry)
 		/* Some other dentry was spliced in */
-- 
2.25.1

