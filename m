Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BF9480335
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071863; cv=none; b=kQ+VVpGdiYdv7EBrIBqQDsWNaUB567i4xxXe96lXiYllMGnNhc02wOwORxtEsvP90XHoWGce0R83QgdqOHRSPi4Z+XVwnVOsA6SbYBgp2QJJiDaEKSCDGDtPx2wQz0MgeSKbmxBNj27BjDRShNdQK39M9TTyBX5SAVcwJ1UTUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071863; c=relaxed/simple;
	bh=8LgUy2BFaEjGHuHrIoGiwPXMTeqgpkp4a/hF5IekRa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6WIxGxXZkb/GBJtLCCq1mO5WrYMAvIgugb8NizHiit1QHfZx27ozxye8D21Aqcow/cWuSq83vUzG+W5UMHmo0bgscYwDbDhXCyR/QQkGfLnuMjbYjTI4sBS+5O0D8kQYXwbkwYQxvaVVU8EbmbB/G0sXw7imhchJDku6NS9SB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KgSrozXt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KgSrozXt"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4815bce4652so5434f8f.1
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787071859; x=1787676659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jWWeSg+YeuPpn5R77WgGZuu3+K+KH8o4UQiJN41+9N0=;
        b=KgSrozXtp1hwbX9Qv/ILD1/psKvGGpupq1DMPV0b8CNYqQXauvspB/k8ZM6VIzP2et
         ZDjELQS2x4BC5phpBXI/P2ShmY3kxYdjMqNwXdQbsJQDSuth8Dddmi5t8RWDzvQvpcWx
         RgVTR2RkXNOtVcW5lSxjyowLhUlJsrmA+foM3YRLfDk3OiyBB2ne4PXgW3OvWPBZPAFy
         dw3FRxnQv3+mCiPDPmApDnkHsLMV7ZVOhRNmFyjjrsRmM+HQiluM+PyLLu7xs9PQrGkN
         ZkW5qntxLTZQRqYi+ismCnfC9OBoJV32xZ3Rgbovl07zHUkojcsbrGIyb0vWCffNJxw2
         c73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787071859; x=1787676659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jWWeSg+YeuPpn5R77WgGZuu3+K+KH8o4UQiJN41+9N0=;
        b=otGYKzosMuFqVDXlHt9pGpnL/uKGBT0Xuf7yPKzjBZcColysyxBG5AXM4iY5Btjj/P
         9l+16EykSNAkp+zXI0rlOlAKpmY5DIiOKmx0LYB+kYNS00O1oMzhG+oLCfp8VpwEYCft
         G1y2+L1nwjAWZ/x33Eds5jg402yc1kpdD9fmuopdcaI4kjtRrcTUkSapDC+fnLF1GO/C
         +2Gvn5PnUBmvXvnUBX8+mk1g3ZAHnYBXpg8eOBI6V6JsmuIbut73vdADXvaXqDOwRwTD
         IPG2u1lGzkkDKwKU7H5DRDN/aentadt3KstmfvnsB9Go7dzH5Koee0NkzuNagwmRGJvX
         LDag==
X-Forwarded-Encrypted: i=1; AHgh+RrhxuNPUBK1VK3zOErzHhEzyb0L/iCYQzM9wA1lhiqiYuBOP+QVv1+vNKp4Q4v+CGG68Wt8wIAA/e7Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4aRg73SWjPDqOSqVw0dR0hN3lAYKqOPCgNwoMhpD6dlGGB7RN
	luHW08BD7nsClpn+EH6RNCtwlAp68U9kmmGojVf3B9qlHjzFYfq6aDEGBHWbNLQh2BczJ5pjtzR
	O5W353fE=
X-Gm-Gg: AR+sD13he6bvXwV2KSDu8Ke+zvz4o6XahPzv6927SdxiiqfV+/4q/Yq+OQi4IoSfUVT
	MxnkCozNoBgx+XBhKFL1HINj62Hu/FkvI6ORyz6AigrLuvXX2E+wvLWWHgB8QOiZnqewo8WZ2wq
	4Kei+Er0hVn43sd7bnkNJnOENwgvCU5M5wsAbVklgRgaOhXkZk3oSZzb/K7l60mfFj3g/LlcfmS
	znaTPmtEecJKkCbXRm/GcfKMoW9szkoayQoSLSpjEMvUdpuCso04mR+ipgG14DY54y0MCc32eK+
	VtEZvuOM1QOSLDN45aLZQJ9J3w8ixE9yBUJtuNe9UExJRWz8vG4l3vVRYkT+l78UfHDUEmTksf+
	iyIdoUrmcT75uEvh0Or1dOqivvPh56vEGhnTJguJDPhjOBwZjseI9FyWB9Tu7pP0mIFJiACd6aX
	9WFq/SipBrNv+Whp72wgQaviI5tcYmp3pgz41QD9fK9vJ8HgNKnpmPGsHCbqI2+8JA98bTJKAjG
	GfjYcG4vfNSMQuUkptBfCbbhn5XzcKz9V1csJfMjotslTKAHDXmuQD6IYB9CIM3
X-Received: by 2002:a05:600c:1988:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-4998798dc17mr529232465e9.15.1787071859133;
        Tue, 18 Aug 2026 09:50:59 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3157fsm12776042f8f.3.2026.08.18.09.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 09:50:58 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] ceph: don't unregister an MDS session before removing its caps
Date: Tue, 18 Aug 2026 18:50:53 +0200
Message-ID: <20260818165053.3514195-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_session() removed the session from mdsc->sessions[] at the very
top of `CEPH_SESSION_CLOSE` handling, before taking `s_mutex`.
Between session unregistration and remove_session_caps(), the MDS rank
has no registered session while the old session still owns all caps it
was granted.

Any concurrent filesystem operation may walk into that and the next
__do_request() call registers a new session for this rank.  Once it is
open and the MDS issues caps, ceph_fill_inode() calls
ceph_add_cap(), which looks caps up by rank, not
by session identity, finding old caps linked to the old session.

The list_move_tail() call then moves the cap object to the new
session, which is already a bad thing to do.  Since it doesn't
decrement `old_session->s_nr_caps`, this will quickly run into a BUG()
instead of crashing:

  kernel BUG at fs/ceph/mds_client.c:1959!
  Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
  [...]
  Workqueue: ceph-msgr ceph_con_workfn
  pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : remove_session_caps+0x2bc/0x2d8
  lr : remove_session_caps+0x74/0x2d8
  [...]
  Call trace:
   remove_session_caps+0x2bc/0x2d8 (P)
   mds_dispatch+0xf48/0x1b60
   ceph_con_process_message+0x74/0xa0
   ceph_con_v1_try_read+0x3a0/0x1510
   ceph_con_workfn+0x260/0x460
   process_one_work+0x168/0x3b8
   worker_thread+0x1bc/0x3a0
   kthread+0x118/0x1e0
   ret_from_fork+0x10/0x20

That's BUG_ON(session->s_nr_caps > 0).

I was able to reproduce this reliably by delaying the close and
starting I/O during the delay.

This patch keeps the session registered with
`CEPH_MDS_SESSION_CLOSED`.  New requests will be put on the
`s_waiting` list where they will be resumed on the new session.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c       |  9 +++++++-
 fs/ceph/mds_client.c | 53 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d7283fb54cec..ad9609162c4a 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4195,7 +4195,14 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		}
 		new_cap = ceph_get_cap(mdsc, NULL);
 	} else {
-		WARN_ON(1);
+		/*
+		 * -EAGAIN means the target rank's session is
+		 * currently being closed; set target=-1, which drops
+		 * the exported cap - the MDS will reissue it for the
+		 * new session
+		 */
+		WARN_ON(tsession != ERR_PTR(-EAGAIN));
+
 		tsession = NULL;
 		target = -1;
 		mutex_lock(&session->s_mutex);
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3c692ad02c85..6c7328f9ce94 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1750,6 +1750,16 @@ __open_export_target_session(struct ceph_mds_client *mdsc, int target)
 		if (IS_ERR(session))
 			return session;
 	}
+	if (session->s_state == CEPH_MDS_SESSION_CLOSED) {
+		/*
+		 * handle_session() is currently closing this session;
+		 * it stays registered until its caps are gone.  Do
+		 * not return it to our caller because we don't want
+		 * it to attach new caps to it.
+		 */
+		ceph_put_mds_session(session);
+		return ERR_PTR(-EAGAIN);
+	}
 	if (session->s_state == CEPH_MDS_SESSION_NEW ||
 	    session->s_state == CEPH_MDS_SESSION_CLOSING) {
 		ret = __open_session(mdsc, session);
@@ -4492,8 +4502,20 @@ static void handle_session(struct ceph_mds_session *session,
 			ceph_metric_bind_session(mdsc, session);
 	}
 	if (op == CEPH_SESSION_CLOSE) {
+		/*
+		 * Pin the session for the rest of this function.  The
+		 * __unregister_session() call is deferred until after
+		 * remove_session_caps() below, or else other
+		 * processes may find caps still assigned to this
+		 * session while working with a new session object.
+		 */
 		ceph_get_mds_session(session);
-		__unregister_session(mdsc, session);
+
+		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
+			pr_info_client(cl, "mds%d reconnect denied\n",
+				       session->s_mds);
+
+		session->s_state = CEPH_MDS_SESSION_CLOSED;
 	}
 	/* FIXME: this ttl calculation is generous */
 	session->s_ttl = jiffies + HZ*mdsc->mdsmap->m_session_autoclose;
@@ -4551,12 +4573,24 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_CLOSE:
-		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
-			pr_info_client(cl, "mds%d reconnect denied\n",
-				       session->s_mds);
-		session->s_state = CEPH_MDS_SESSION_CLOSED;
 		cleanup_session_requests(mdsc, session);
 		remove_session_caps(session);
+
+		/*
+		 * Now that all caps are removed, it is safe release
+		 * the MDS rank and allow other processes to create a
+		 * new session object.
+		 *
+		 * A concurrent ceph_mdsc_close_sessions() or
+		 * check_new_map() may have unregistered the session
+		 * already, so check __verify_registered_session()
+		 * first.
+		 */
+		mutex_lock(&mdsc->mutex);
+		if (!__verify_registered_session(mdsc, session))
+			__unregister_session(mdsc, session);
+		mutex_unlock(&mdsc->mutex);
+
 		wake = 2; /* for good measure */
 		wake_up_all(&mdsc->session_close_wq);
 		break;
@@ -5909,6 +5943,15 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		 * reconnection request in up:reconnect state.
 		 */
 		s = __ceph_lookup_mds_session(mdsc, i);
+		if (s && s->s_state == CEPH_MDS_SESSION_CLOSED) {
+			/*
+			 * handle_session() has not finished removing
+			 * this session yet, so it cannot do a
+			 * reconnect
+			 */
+			ceph_put_mds_session(s);
+			s = NULL;
+		}
 		if (likely(!s)) {
 			s = __open_export_target_session(mdsc, i);
 			if (IS_ERR(s)) {
-- 
2.47.3

