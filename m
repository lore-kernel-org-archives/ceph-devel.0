Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD83A8755
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jul 2026 00:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783471632; cv=none; b=FFsBRfdZRn0ODwUerxAe+JfC3AE+Wg0OPmpjQFOHaL9JZ0fOrUHTtac/nEZ0xbA3Yg4qy7fD/+KkaDaBGPEAShpMv+hgGQlQlSFAxhqvW4t7TMic4lhqfYUh18Zclh8l7KA/28kEBFpEfNcc1nKOiy7xYdXbK7dCQSHdhHX54GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783471632; c=relaxed/simple;
	bh=2xUJjcauQaMYHk6lMWTyi/YcPTMRDfLsHDdphhIl0ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IB2Vu5Dod8FNizahwZmZrj+GgZcDrWTg8k39kE46NFDUMgl8VfpsHmmSo5vcIrNJemxo47R97wLc7oTpWNw37cCtCp6fDddcdghZsfg76CTITbWk06CXk2+U16TSkSjmDT4gBAlxHO+oNKekJAq8TFdENxQMvGmA8qcIvleoooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DxlQgr2f; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DxlQgr2f"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4472500e25fso42929fac.1
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 17:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1783471628; x=1784076428; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ip+/gvYquiKGF93LCTTIfFeDQjtucuwYFMW/5/y3fCo=;
        b=DxlQgr2fm/1+5BVz7oKZXUTXB/pIEj2o/6sppIT3VaeDpI+IIwxcsf/mXF3DXsk6bc
         iQjDAkh6AVn2W41+OeOZXDZ3ogJOb6O0MAOtk+pNSnaMSR+OP3sHQeGiwg3cro18z7Lp
         KhmkerE5yYjCctG5e+hbbmcBKCREnYt7yCmGpsEIgMzzpiK7jZKND0QoHOOHKusxfU3Z
         VG5phTmR+lmzq4oOMEqoV4fw0rxH+jNzjVRVvOpYDHQWQgkeUwPmPtQp2x0rdYE3vum0
         Nkiqat4vDgXqswproJr05SXsX3vEULZBvRM/gXRexFPArg9QJl1lwHL7lGEXxTfmYW6n
         jtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783471628; x=1784076428;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ip+/gvYquiKGF93LCTTIfFeDQjtucuwYFMW/5/y3fCo=;
        b=pav1qKmuA+cGMrNGEh09tdkWIGVknWAsCqNIQ2i78BoVIYCFonsxvUMlYAtTYUBBap
         j6fYrFLPzi86wWd105dzKYzDpjPcdxvwRvA8EvllEMkgVy2AcbeE7Jobsisa5DgbgsuI
         ggp5IbMinuqXgjGWZZkgqM7WatDwxMdFkTGtG1T4k2FQuDLgzibbTb/ZbAagnGpVHddR
         mQBJOeeEiUUWJpT0gRw4owDMd6oH3pBDFF4pqPKsuoY6UU4yHkMDiU/3S5sxYG/XVF75
         SeJgSTr/QZzdbQYQfqmtn0U66JtdMwT1/t3zUIKJ/BuXUC0K4F5YulQ+Bl/nT8iSiKCa
         G2jQ==
X-Gm-Message-State: AOJu0YwQPijv6pwQLIRO6uQ0gKJXawjkFPAWakRIlQjH4D+GBDVUJj54
	QT2voXuGGPCL/8aUfb6bfSf5JIfefSaTngYqCxvRA7o7IGFIEiGzFBA7NLo7hDcviHQ=
X-Gm-Gg: AfdE7cmfwlkIbbMK1pFCYVPGSOa+vZ6VZfX91uouTFyxBB4Kvlrp41sE79GIpmmnMqX
	8wqVaRDqDvRftjmrAvqf7NsAjRIGViLN6gJXdSr+1QoJziB1rwriAW5SoXtxq4ZicL1sL3Ukjmi
	3y/LvrTbdYFcLKcPwg3wk4taYbLrHZKidWZmJAJcmOiQfNeoRjSa1OTsfwAyBjw5vnIdInNSQrl
	nwXVcyhusfiiIbx6LrAdQ40RBKJge/lI/eLRKN37SJ9fnDwahm/DhXP3ILNoolIf+EvxewzwJLU
	M912WW2E1/wz+IiXT+pXvGWyXbi86gOOWYYedHfNXwiD0ZZpK4cNC4b8NM9VMOdshcmIxn1hxW/
	49PHsnQF2QyRdD6gtnctQB4caGdd/fUHnrleHPzDNEY7w4lgUwpuJStx0AF9PgX8LmwvBR+nVS4
	oehvLErP6r6o74
X-Received: by 2002:a05:6870:918b:b0:44c:fb6c:4fe0 with SMTP id 586e51a60fabf-45163a97f1cmr191633fac.21.1783471628241;
        Tue, 07 Jul 2026 17:47:08 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:bf21:1923::281:22])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb559559sm15458321fac.9.2026.07.07.17.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 17:47:07 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
Date: Tue, 07 Jul 2026 19:46:42 -0500
Subject: [PATCH] libceph: reset OSD session when keepalive2 acks stop
 arriving
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-fix-rbd-keepalives-v1-1-be888d525d6a@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAPGdTWoC/x2M3QpAQBQGX0Xn2qm1OOJV5MLPhxOh3dqUvLvN5
 dTMPOThFJ6a5CGHoF7PI0KWJjSu/bGAdYpM1lgxlal41pvdMPEGXP2uAZ5Fihm1FRnzkmJ4OUT
 rn7bd+37gA45ZZAAAAA==
X-Change-ID: 20260707-fix-rbd-keepalives-664fe9266c35
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@cloudflare.com, Andrew DeMaria <ademaria@cloudflare.com>, 
 Chris J Arges <carges@cloudflare.com>
X-Mailer: b4 0.15.2

handle_timeout() in osd_client.c sends CEPH_MSGR2_TAG_KEEPALIVE2 frames
to OSDs with stalled requests, but libceph never verifies if the ACKs
actually return.

Consequently, if an OSD messenger queue wedges while the underlying
TCP socket remains ESTABLISHED, the client will block indefinitely in
ceph_osdc_wait_request(), causing tasks to hang in D state.

Fix this by introducing a watchdog in handle_timeout() that checks
ceph_con_keepalive_expired() against a new CEPH_OSD_PING_TIMEOUT (60s).
On expiry, reset the sparse-read state, call reopen_osd(), and kick
outstanding requests when the session is reopened.

Because OSD keepalives are only sent to OSDs with stalled requests,
last_keepalive_ack can be stale on an otherwise healthy connection that
has simply been idle. Track the start of each slow/probing episode per
OSD and require the episode to last CEPH_OSD_PING_TIMEOUT before checking
for an expired keepalive ack, so the watchdog only fires after we have
been actively pinging.

Additionally, seed last_keepalive_ack to the current time in
ceph_con_open() to prevent the watchdog from firing spuriously on fresh
connections for both OSD and monitor clients.

Fixes: 8b9558aab853 ("libceph: use keepalive2 to verify the mon session is alive")
Link: https://tracker.ceph.com/issues/76202
Co-developed-by: Andrew DeMaria <ademaria@cloudflare.com>
Signed-off-by: Andrew DeMaria <ademaria@cloudflare.com>
Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
This patch fixes an issue where the kernel rbd client and an OSD have an
ESTABLISHED TCP connection, but keepalive2 ACKs stop returning from the
OSD. When that happens, outstanding OSD requests can remain held by the
client and callers can hang in D state. We were able to mitgiate this
issue by using ss -K to kill the affected OSD TCP connection which
reopened the OSD session.

We were able to reproduce this issue in production a few times, and
synthetically by dropping OSD to rbd application frames while allowing
TCP ACKs through.

https://tracker.ceph.com/issues/76202 describes the same situation.

The following patch addresses this by creating a watchdog that resets the
OSD session if this situation is detected.
---
 include/linux/ceph/libceph.h    |  1 +
 include/linux/ceph/osd_client.h |  1 +
 net/ceph/messenger.c            |  3 +++
 net/ceph/osd_client.c           | 23 ++++++++++++++++++++++-
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 63e0e2aa1ce9..1a117c5f1964 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -74,6 +74,7 @@ struct ceph_options {
  */
 #define CEPH_MOUNT_TIMEOUT_DEFAULT	msecs_to_jiffies(60 * 1000)
 #define CEPH_OSD_KEEPALIVE_DEFAULT	msecs_to_jiffies(5 * 1000)
+#define CEPH_OSD_PING_TIMEOUT		msecs_to_jiffies(60 * 1000)
 #define CEPH_OSD_IDLE_TTL_DEFAULT	msecs_to_jiffies(60 * 1000)
 #define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT 0  /* no timeout */
 #define CEPH_READ_FROM_REPLICA_DEFAULT	0  /* read from primary */
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 50b14a5661c7..52eb76e9d62a 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -94,6 +94,7 @@ struct ceph_osd {
 	struct ceph_auth_handshake o_auth;
 	unsigned long lru_ttl;
 	struct list_head o_keepalive_item;
+	unsigned long o_keepalive_stamp;
 	struct mutex lock;
 	struct ceph_sparse_read	o_sparse_read;
 };
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 34b3097b4c7b..f7776d83d506 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -610,6 +610,9 @@ void ceph_con_open(struct ceph_connection *con,
 
 	memcpy(&con->peer_addr, addr, sizeof(*addr));
 	con->delay = 0;      /* reset backoff memory */
+
+	ktime_get_real_ts64(&con->last_keepalive_ack);
+
 	mutex_unlock(&con->mutex);
 	queue_con(con);
 }
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ff00070c181..6d9530beb2e3 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -53,6 +53,7 @@ static void link_linger(struct ceph_osd *osd,
 static void unlink_linger(struct ceph_osd *osd,
 			  struct ceph_osd_linger_request *lreq);
 static void clear_backoffs(struct ceph_osd *osd);
+static void kick_osd_requests(struct ceph_osd *osd);
 
 #if 1
 static inline bool rwsem_is_wrlocked(struct rw_semaphore *sem)
@@ -3480,8 +3481,11 @@ static void handle_timeout(struct work_struct *work)
 			mutex_unlock(&lreq->lock);
 		}
 
-		if (found)
+		if (found) {
 			list_move_tail(&osd->o_keepalive_item, &slow_osds);
+		} else {
+			osd->o_keepalive_stamp = 0;
+		}
 	}
 
 	if (opts->osd_request_timeout) {
@@ -3507,6 +3511,23 @@ static void handle_timeout(struct work_struct *work)
 							struct ceph_osd,
 							o_keepalive_item);
 		list_del_init(&osd->o_keepalive_item);
+
+		/* Record start of ping timeout from the first slow tick. */
+		if (!osd->o_keepalive_stamp) {
+			osd->o_keepalive_stamp = jiffies;
+		} else if (time_after_eq(jiffies,
+				  osd->o_keepalive_stamp + CEPH_OSD_PING_TIMEOUT) &&
+		    ceph_con_keepalive_expired(&osd->o_con,
+					       CEPH_OSD_PING_TIMEOUT)) {
+			pr_warn_ratelimited("osd%d not responding to keepalives, resetting session\n",
+					    osd->o_osd);
+			osd->o_sparse_op_idx = -1;
+			ceph_init_sparse_read(&osd->o_sparse_read);
+			if (!reopen_osd(osd))
+				kick_osd_requests(osd);
+			continue;
+		}
+
 		ceph_con_keepalive(&osd->o_con);
 	}
 

---
base-commit: 0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53
change-id: 20260707-fix-rbd-keepalives-664fe9266c35

Best regards,
--  
Chris J Arges <carges@cloudflare.com>

