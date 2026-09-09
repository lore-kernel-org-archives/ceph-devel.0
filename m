Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546D1550DD0
	for <ceph-devel@vger.kernel.org>; Wed,  9 Sep 2026 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955842; cv=none; b=V7jZ+3OCg3/y37IXg5rxJcbktkDePkRiDgvaaFDqJ4weANO0Jlyf/xbxAUnfLwLFjbn1A8DQ4U+2yCDB+HuaX069eexjrmqfxFd+xrXuUA+Mbm8LOw0s1+72OQF2hRzGoN3qwT2/Rx91C7A1xLbdqzVByd3eyxboLaGa4gUJXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955842; c=relaxed/simple;
	bh=CvoXi/lBFOPTWtQZ1SJkAnJCKCmB/9zxR0I6yiIIUl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkweD3SkFk7KS+pbeNVdv8rh0bCQ4Jnu/Cseslxk6jdOE/eiL9oSwyRk0BYlVIf815lttMsz2Wx9aKNq0NutRL2uAhIBbxo1LqRln23gbpe307cs9RRGTLWkYRvu4ZGWL+czLaoOiIb8qCtdrElj5kxguwMdBlqBDs0YkI0SljA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=TqT5r/zL; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="TqT5r/zL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1788955758; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=CvoXi/lBFOPTWtQZ1SJkAnJCKCmB/9zxR0I6yiIIUl8=;
 b=TqT5r/zL2lba0BFB30EANTqojwtVBHM8D8kMH23+Y2vsMgMAS/ZXxWcdqDdTRfsd5G9Re
 rFif43OJe1xXm4sZT/j6cQTaaOJFp26otahGgLYAKLtWbKaZXu1D+4hAnwC1kd9ojtw09fw
 CKxfAu/bgGGaHcDSyC1XiUpC0tcqgw3rStvjRNMEgkBkNKX3vb/9f2S2SAKYJMjN/KNKI2S
 jxYToxVo0cFu8l6GEw3LH1y7aJRZ8P6hN2aHCwJChUgQKOwSZAAUs2Hia7roM9gNAcIsqFP
 0h0ZwQB4XFpmdAHozouGBd9egukpU28xJbvZ67u7fArU6H+FYF3dr9J5u3vQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id CE4905FC74;
	Wed,  9 Sep 2026 14:09:18 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id A67765FA49;
	Wed,  9 Sep 2026 14:09:18 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Always kick off requests after updating an osdmap
Date: Wed,  9 Sep 2026 14:09:10 +0200
Message-ID: <20260909120910.751491-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Incoming osdmaps are handled in ceph_osdc_handle_map(). This function
creates two local stack variables that track (linger) requests that need
to be resent. For requests, this is an rb_root, and for linger requests,
a list_head. Subsequently, for each osdmap, handle_one_map() is called.
After successfully decoding an osdmap, handle_one_map() calls
scan_requests() for each osd. In scan_requests, the new target is
calculated for each (linger) request, and, in case of
CALC_TARGET_NEED_RESEND, they are unlinked from their current osd (in
case of linger requests also relinked to their new) and inserted into
the previously created list/rbtree. All requests in these structures are
kicked off to their new target osd after processing all osdmaps. If an
error occurs during processing, e.g., because an osdmap is corrupted,
ceph_osdc_handle_map() doesn't call kick_requests(). Therefore, the
(linger) requests are still inserted in the list/rbtree, which now
doesn't have a head/root anymore. This results in requests containing
invalid pointers to stack memory. Subsequently, this can have multiple
effects, ranging from not being able to insert linger requests again
because they still have prev and next pointers, triggering a BUG_ON()
assertion when trying to insert a non-empty rb_node again, to
overwriting stack memory.

This patch fixes the issue by also calling kick_requests() in case of a
decoding error. This ensures all (linger) requests are removed from the
list/rbtree and kicked off to their new target osd according to the last
successfully decoded osdmap.

Fixes: 5aea3dcd5021 ("libceph: a major OSD client update")
Fixes: 922dab613417 ("libceph, rbd: ceph_osd_linger_request, watch/notify v2")
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osd_client.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 7389d17fc770..ae3c3f046688 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4244,6 +4244,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 bad:
 	pr_err("osdc handle_map corrupt msg\n");
 	ceph_msg_dump(msg);
+	kick_requests(osdc, &need_resend, &need_resend_linger);
 	up_write(&osdc->lock);
 }
 
-- 
2.47.3

