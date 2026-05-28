Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2393FF897
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983677; cv=none; b=KuGGJPurPUeqFitcnzuHlUn/I4jasc+b5JAuDZ1zDPCc3d8HG3htUBgV5NdPD6AGrEVbOmX7Hil/z3VI+pXA0YA4dUJxlRnuZaQvlCPiWPmj+tFUtvKcpiG65hB9KsXSg/oRn3fbzPTOBp2QBL+LkyRuA/1UT8vbhO819L1KFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983677; c=relaxed/simple;
	bh=DcBEo/HtZ3nxQJS62Fa3KeaMv0y58DZRcZhSTjuG3aU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GUC3W/bvYZ0X/hj/NjwDr2nNesgolXCC22CAzOUgiRtvLELf+OVPSqgBVJiQoJA3I3eJEvVw/sVFnRbfn+4GO4GuniZYwpyrJf9aKg/yI2QPeGjjq6G2D3gOlEab/teG1IVZsiMJiOAmTIkdKVq3uNi8ey3RdsjSeDbBH44YFNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=hcoscYJs; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="hcoscYJs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1779983667; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=DcBEo/HtZ3nxQJS62Fa3KeaMv0y58DZRcZhSTjuG3aU=;
 b=hcoscYJst9IfAwk7crtBRddI+S7dqXMX4u1XhPu+sRycXpbpozDczHet8SXyhntHbWot0
 vs6cKME8mc2gNcU/plV117oI2WkPB5ZL06EDkPQ/Nq/HFUdFUCdoHPJ7ejsQCfYjI7QXlDv
 IS1dFVzUrUnoMNC9h1/qOy/l9g37CX1S60L6ZRm4NKL5H0a82mvBXuosC2vBj68r8yfPdfR
 Zl7Lyxz21jQ9NiKNjXxUtE4WiuwbyIKjKKZin5D9gFlsdAdrZlY+VKp+0Wlf5+q1m0Zspyi
 iuMG+xRe4p9KjtB9D0IG52yWn9Sn/aa8Ld4R+GsHNT6ibQZ5H+QGAdAlTKXw==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 1581760139;
	Thu, 28 May 2026 17:54:26 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 1838A5FA3E;
	Thu, 28 May 2026 17:54:25 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: Handle rbtree insertion error in handle_backoff_block()
Date: Thu, 28 May 2026 17:54:07 +0200
Message-ID: <20260528155407.3682573-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A message of type CEPH_MSG_OSD_BACKOFF is used to block/unblock requests
to specific PGs or objects. If this message has op code
CEPH_OSD_BACKOFF_OP_BLOCK, handle_backoff_block() is called to block
requests. In this function, a backoff struct is created and inserted
into two rbtrees for tracking them. Both insertions use the asserting
rbtree insertion function by calling insert_backoff(), respectively
insert_backoff_by_id(). If a message contains a backoff with the same
begin ceph_hobject_id or the same id as a previous one, the assertion in
insert_backoff()/insert_backoff_by_id() triggers a kernel BUG when
trying to insert the backoff.

This patch fixes the issue by switching both calls to the non-asserting
rbtree function and ignoring the message if one of the insertions fails.

Fixes: a02a946dfe96 ("libceph: respect RADOS_BACKOFF backoffs")
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osd_client.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ff00070c181..af0fd9e08cd6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4427,8 +4427,18 @@ static void handle_backoff_block(struct ceph_osd *osd, struct MOSDBackoff *m)
 	backoff->end = m->end;
 	m->end = NULL;   /* ditto */
 
-	insert_backoff(&spg->backoffs, backoff);
-	insert_backoff_by_id(&osd->o_backoffs_by_id, backoff);
+	if (__insert_backoff(&spg->backoffs, backoff)) {
+		pr_err("%s failed to insert backoff\n", __func__);
+		free_backoff(backoff);
+		return;
+	}
+
+	if (__insert_backoff_by_id(&osd->o_backoffs_by_id, backoff)) {
+		pr_err("%s failed to insert backoff by id\n", __func__);
+		erase_backoff(&spg->backoffs, backoff);
+		free_backoff(backoff);
+		return;
+	}
 
 	/*
 	 * Ack with original backoff's epoch so that the OSD can
-- 
2.47.3

