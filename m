Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0EC35E947;
	Fri, 17 Apr 2026 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776413185; cv=none; b=likTXaVpsiwemHY1YJEcHC6E4Sx3+nN+DdEeHrBmMrx0fOe9h3+ZqGJK6PMWeNkuUBGAT1i14mTTTkmIcygGWOZKOzP8YyIDZK5b8l3aLjHZjb93DtMdhFf/9g218hDuu14I5YHGnRvDftI+dgdDmBDyGBHpu5B6KHQW0KInYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776413185; c=relaxed/simple;
	bh=4KLqzV1nlKifN6bX/nDbdacL3sVjdtwENRAs6mPy8dE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sfkzTLMIzb9M+VbjVhdNtshAljghhWEO/BAhWz7JPsFiQnsR9FrM37eiKpq5/xq61dZzA9v7zeHsD5g1Kf+KjSMC7QrsNODLxkXa6rFQSkcg5Hq/ljLGpE1NPSxWPnzz+/uvKf+4uXRlXqIoAhmQP/v7ZixqjbdvoRAshjqX+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4da0dd3c3a3411f1aa26b74ffac11d73-20260417
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:55fa6b8b-556d-4cec-9ef4-daa740739adb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:d4cc15f7a17b671579d8cb6f0fdc79e4,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4da0dd3c3a3411f1aa26b74ffac11d73-20260417
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 753401955; Fri, 17 Apr 2026 16:06:14 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	brauner@kernel.org
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] ceph: fix potential ERR_PTR dereference in ceph_submit_write()
Date: Fri, 17 Apr 2026 16:06:09 +0800
Message-Id: <20260417080609.51361-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix smatch warning:
 fs/ceph/addr.c:1489 ceph_submit_write() error: 'req' dereferencing possible ERR_PTR()

Add a check to ensure req is not an ERR_PTR before calling
ceph_osdc_put_request().

Fixes: 1551ec61dc55 ("ceph: improve error handling in writeback")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ceph/addr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index fa4f25f99409..6091818674be 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1468,7 +1468,8 @@ int ceph_submit_write(struct address_space *mapping,
 			unlock_page(page);
 		}
 
-		ceph_osdc_put_request(req);
+		if (!IS_ERR(req))
+			ceph_osdc_put_request(req);
 		return -EIO;
 	}
 
-- 
2.25.1

