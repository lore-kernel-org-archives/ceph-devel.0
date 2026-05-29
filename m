Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C22DEA89
	for <ceph-devel@vger.kernel.org>; Fri, 29 May 2026 08:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042973; cv=none; b=LN6SOBByLgXx94K3lWL012KyjLsSvR16fr5LeFiX8Oq9Vnut3MJv+9Ejm7cScKx9xFl3JveDDX41cBpYTfNl3mhGfHR0kSRoja8W05YgA172+6vpn3s9Y+NyvcT3Gf+s/zfMMDTtMdA2Jbi50cTCgD0TB0NmiW6Pe1AbUPCzyuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042973; c=relaxed/simple;
	bh=zsuTaqsjQNjSeX03Qq91LUlkm6MAx1880CFyil8qcBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qeLCNqrc1LYnKtktp40xj1zxFnkpT8tghnCJZ3ArzTP2pzwjNF8RT+4mxeeZKxbVwjWn3TDJRdACGVPkgSgEFCMj0BXvm2N8bPVFszOiN1qiu/xYk0JB/63v1Ot6cJC4sW22Q4dphvbbvqNOyNx7gJIQOW9LTDYy4pHgVndu5jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=bhnFvlqK; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="bhnFvlqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1780042969; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=zsuTaqsjQNjSeX03Qq91LUlkm6MAx1880CFyil8qcBE=;
 b=bhnFvlqKGrYvuD3CBMYudOx5xWw8UT0cf7eWda7bY4yukE++EriJdgJ3usKCk0Pv6yAiv
 NaapHY8WXmSJLRzHG5saJDN61I9l1m6MMFBIVY5ilQF1yPF4tyxK09ow76awMaGsXw1HadH
 uR8NkL9a1pfd0AKCL/tzMQl8b7V2dT6GTrzPrb2Y5rKei5NPQrmovEMOtdHpF5lirUmvHEX
 RyM6g704MKfd5mBqHduObA5kZGSjzmkoxvOYruoI0LNIThqptPxMHuk6rkd52lbYRgAD+op
 mBxo45UYstUbPSOVKhydewR97tsqs4D4nmtw03z+1kEF5+jbW+mN5j5VYllg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 4FC6A5FD7C;
	Fri, 29 May 2026 10:22:49 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 3897A5FC31;
	Fri, 29 May 2026 10:22:49 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Handle rbtree insertion error in handle_backoff_block()
Date: Fri, 29 May 2026 10:22:42 +0200
Message-ID: <20260529082242.3726491-1-raphael.zimmer@tu-ilmenau.de>
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
 net/ceph/osd_client.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ff00070c181..482b89009649 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4427,8 +4427,16 @@ static void handle_backoff_block(struct ceph_osd *osd, struct MOSDBackoff *m)
 	backoff->end = m->end;
 	m->end = NULL;   /* ditto */
 
-	insert_backoff(&spg->backoffs, backoff);
-	insert_backoff_by_id(&osd->o_backoffs_by_id, backoff);
+	if (__insert_backoff(&spg->backoffs, backoff)) {
+		pr_err_ratelimited("%s failed to insert backoff\n", __func__);
+		goto err_free_backoff;
+	}
+
+	if (__insert_backoff_by_id(&osd->o_backoffs_by_id, backoff)) {
+		pr_err_ratelimited("%s failed to insert backoff by id\n",
+				   __func__);
+		goto err_erase_backoff;
+	}
 
 	/*
 	 * Ack with original backoff's epoch so that the OSD can
@@ -4440,6 +4448,16 @@ static void handle_backoff_block(struct ceph_osd *osd, struct MOSDBackoff *m)
 		return;
 	}
 	ceph_con_send(&osd->o_con, msg);
+	return;
+
+err_erase_backoff:
+	erase_backoff(&spg->backoffs, backoff);
+err_free_backoff:
+	free_backoff(backoff);
+	if (RB_EMPTY_ROOT(&spg->backoffs)) {
+		erase_spg_mapping(&osd->o_backoff_mappings, spg);
+		free_spg_mapping(spg);
+	}
 }
 
 static bool target_contained_by(const struct ceph_osd_request_target *t,
-- 
2.47.3

