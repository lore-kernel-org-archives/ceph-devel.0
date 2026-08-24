Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695733C518
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596252; cv=none; b=rWIKG2fdV0L9Eb+43DD+Vr6/stDaSNbVa7Sj8SRnzZ7mK6D1TuW2KmKxL/TGfeZbEH5m5JXuX2SrTmdWymHaparbEAe/1IH8F50tqemZB3EpQGV+2FBfHIUEdQeCTAttT83xMmSK3QWUmZzs5u4rMOEAE0qKBxPOIRGzNaRaPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596252; c=relaxed/simple;
	bh=lug8D/gwm+//7nB/GcWju+KmpU9wdi06PAyWwrfzTQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXQ6eNHpC0Pn/O8yehxFdLUmFcQGaDQ9ID2y/13q+bwXBq93LepEGVZYAsRMTT/ftpcmtV78K9TbWPQiqd9QT+BS88QOTTU1SNJGUcxKpJpuxIeyuCSUuEXr2Z9YZHXSYeAPHnHYNcpvWq0j4yYvq3mOGh4ti61+9bnq6AQtNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PXmA19D4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PXmA19D4"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c169ae1cb26so36694066b.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 11:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787596248; x=1788201048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3BoLIO7lcdj90ONYVLICn+P8MyFPuf4efx8eyi6Fpp0=;
        b=PXmA19D4LZS1YsAm6QsZG/B4HPzMOOM/jZbWjilVaIrCzoOwKoLB7Z/0cP21SJY3/c
         1UQ19KcyPBd9LUJpCDwiFu4Kqdc6+cHZSdB4kEgfa55Na8OFVQxeubnjaYfGUnY7xD3I
         t/Z0fy61nS9MyAIdZBJHb8nuBgG+1p7WpqyFTGZ5CTcfFJ0yiRDIjgznh76CWQF5cq7G
         ZtsewYpsgVlKZ4uQhdwRBK9AhF8CGuv2Hz/IXnatrkrF36j3/j5WfEK604T+tx5J3UMA
         r2oegzt2ljl0BzGHzEJhBSc5dmrwURz5ZK99/49th3IBQ+0PO9r9N76AtFozrC6Gvc1u
         +csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596248; x=1788201048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3BoLIO7lcdj90ONYVLICn+P8MyFPuf4efx8eyi6Fpp0=;
        b=owJH+ib/DCA8ZRd834Zjn6OLIBnARI73HbwJjIsdwAYiSxCKr57gHGa4UxWfqz8KBF
         guWVJhAw3bAvLjgnxMCrzbrtICempWKch8qR5HK5saJxIph1mHYzIBpXbWGEYpS0iT9h
         Lb38OLSoVgWvq2gl+xkiMyqy6IrXi02zqLRn8mwevs669A5CEnNRCUl99JWcXAYXMsY+
         1PVJzYbOzfqePXFWUPmXeew3kCDfFO3oKiftD6Fkh4RsmzSNA+DMJkxkpxrQKFM2USkt
         7h9tQOFM+FQlHv8PDhTLHyf6p8/UGjHBruYkx9a4dwa03VzKubkwyziO575JIjaEV3ab
         plPg==
X-Forwarded-Encrypted: i=1; AHgh+Rq7f+6PjHk/dFlONzgmlMa00BEspVyKhmOgi2TFmUTqXs+yKo9IOmbYjJib80mW1Hhaimho2/YXY/t9@vger.kernel.org
X-Gm-Message-State: AFuF++n4jQ3ZuwYLLQxyKwBeTKjiiM6YXs+4mTzXRFV0DnJuhe4hwlWp
	l0rLiPByQaS/h5oS4yscbBXl/0uRJtTg7z3qdX/Y+DTh892CI3DSw4RArO88aG+m2Eg=
X-Gm-Gg: AR+sD12E90jXslceM0ga6RVPf0tGf6sXsUHbouB4Joo7l+hCAF9xNorh33JuAt8O07+
	SLhaDKR9iF51D0aYY5HYw2pWm6f+2GAdE/jetum3nHN5vU9wtsDb3fGzdSIRw216HEOaEVGkQL7
	N+9vW6uQmKRhKgUN1VURKGeiJEjzkHBtoIQALZm/QtQyPgvGWX5gPUDFlWiogxdTSdJSW26CFeh
	+M3ZdysZlMqw5O5gewz+79TrFY276Jn1XHUyR4kRtcj1Smwn3iVy/zjCaWmwxNWnnK8USxHPlx6
	yWzNL9JHPFarhYNyOPTeghubtqVj1Ec1ZX08CX+1EmkEkcFRwX26dszK2oYelYlGBSnfYXNxJv9
	nTnqHoeFWrazMlrBchhPOsod4mJ2sY0OO9rX1lLji0LtQ6LCNoC2k6j3rrfkZREJe3nTArAUN8g
	LE+kZ75VdX9U8T3ZXkbZ043j6mz0nBNulwi4iWHiBeymSedB50ek1z7RQxraAYFH//U6MyP+3nh
	DSqAiXnZFvXX7EKm3meGOUfI8mcgAmxVsbNHmOc0x8sifY45qxkNtf+HjzdIIhy
X-Received: by 2002:a17:907:e98a:b0:c20:7cb0:f33c with SMTP id a640c23a62f3a-c24e3005531mr82011766b.16.1787596247597;
        Mon, 24 Aug 2026 11:30:47 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962bbea6sm1294342266b.27.2026.08.24.11.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:30:47 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2] ceph: don't unregister an MDS session before removing its caps
Date: Mon, 24 Aug 2026 20:30:42 +0200
Message-ID: <20260824183042.234264-1-max.kellermann@ionos.com>
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
v1->v2: skip CLOSED sessions in check_new_map()
---
 fs/ceph/caps.c       |  9 +++++++-
 fs/ceph/mds_client.c | 55 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 58 insertions(+), 6 deletions(-)

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
index 3c692ad02c85..b13632c7dbbb 100644
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
@@ -5801,6 +5835,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		if (!mdsc->sessions[i])
 			continue;
 		s = mdsc->sessions[i];
+		if (s->s_state == CEPH_MDS_SESSION_CLOSED)
+			continue;
 		oldstate = ceph_mdsmap_get_state(oldmap, i);
 		newstate = ceph_mdsmap_get_state(newmap, i);
 
@@ -5909,6 +5945,15 @@ static void check_new_map(struct ceph_mds_client *mdsc,
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
+			continue;
+		}
 		if (likely(!s)) {
 			s = __open_export_target_session(mdsc, i);
 			if (IS_ERR(s)) {
-- 
2.47.3

