Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206601531E8
	for <ceph-devel@vger.kernel.org>; Mon,  1 Jun 2026 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299145; cv=none; b=DO5uDKXLospChW3XSAXSQUm0InSgw3MbtUp7ayxj5K5ekjEeMNh9yPuoQRQ4h5nAexqjF79aurtZh+tmdLgBR7OISJH6lR2zX+U8b9hmVXez9llTD030fZt/FKgVAIBEd6ZOtKO7eBRAFjbxDqt2EHOSBJPfRLDucN7Wk+8/raQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299145; c=relaxed/simple;
	bh=oKGbwC1+KyDXG1NZ5dCPJWCh5bOL5LFywhNAKgB/TlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PX6pLKsok5OXw9ta6LujsxCxVhgk8421CtZ8eNJU6DRBcZjFoomTC964c7uSJ9c09pmcpIPRjcJvTrzkZ04StAwQFCJ/xC6F0HmLpo5/0WpExFCKqOfQNqvFREYcyIg28bjW10UVEy+9B8yEqA3n9cYQXy1y0xoJ2Jk+oOTAWe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=P1iwOsR9; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="P1iwOsR9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1780299141; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=oKGbwC1+KyDXG1NZ5dCPJWCh5bOL5LFywhNAKgB/TlY=;
 b=P1iwOsR9gfNrp1ml/yhwF62Jl4+epb5uZwL0GYnGS+UDuX7jmoJejM7Q9/hndNov4YReK
 PTu0jzS2xQeZuXICRMJz/qgmDSW/w5SomI5mMnmQ36rur2yDD0wDdxFhZjJNERhUfNgNu9X
 52URy6NZpblsH+Ro9l4EOc06LhYHnFIseHTVIkclBPcCRYVtRyGt98km2OKZHy/EKOYqkBW
 A2TBnsy/MzHrQrzFatAnlAjrTmPLBXlP8ibj+S5NQM3+9YoLFY/0kphqyxT7I6NgWVk8FmA
 5ZLWzTsixDKkh6gr4nHbNYVFpeMK2Px2TdNk80bq+KGe3ldQgB7WavNDiouA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id AD22360139;
	Mon,  1 Jun 2026 09:32:21 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 969B55FCAC;
	Mon,  1 Jun 2026 09:32:21 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v3] libceph: Handle rbtree insertion error in handle_backoff_block()
Date: Mon,  1 Jun 2026 09:32:16 +0200
Message-ID: <20260601073216.3828014-1-raphael.zimmer@tu-ilmenau.de>
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
index 2ff00070c181..1b31e2d50ec6 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4427,8 +4427,16 @@ static void handle_backoff_block(struct ceph_osd *osd, struct MOSDBackoff *m)
 	backoff->end = m->end;
 	m->end = NULL;   /* ditto */
 
-	insert_backoff(&spg->backoffs, backoff);
-	insert_backoff_by_id(&osd->o_backoffs_by_id, backoff);
+	if (!__insert_backoff(&spg->backoffs, backoff)) {
+		pr_err_ratelimited("%s failed to insert backoff\n", __func__);
+		goto err_free_backoff;
+	}
+
+	if (!__insert_backoff_by_id(&osd->o_backoffs_by_id, backoff)) {
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

