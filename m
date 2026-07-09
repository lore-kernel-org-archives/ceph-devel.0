Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18392EEE9D
	for <ceph-devel@vger.kernel.org>; Thu,  9 Jul 2026 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635406; cv=none; b=TrQ+Auuht+8MIWg6j45gUDWbJLYyYakDDLsn5zclNEpsQpvRvln4ToRrOvdZ/uLhGZn1wpbXjttggI+s4VUMHRPZ3yxcvR8RdNdJgN4dER99n+A5VnEL6Y4i21Z5G6OWaGlDc8cyxlFX+vOvB5h9K+9YGv3gmvJvlB6EQEohjmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635406; c=relaxed/simple;
	bh=0fau16+oxtmESNBbvRL+F+38Vn0xU/vpRgQPxP/zi/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bl5Ky53F55jJ9m/IGPjne6t3DxP9N0ED7pZazFn4ldbXP3WRmn0+P1qqn3gkWQR3HKgo1adNUuy01EtmWOnp0AHcD6DkNuIvhlKPfnNTUEJkMGFqQ+EYTtnCVHP0LKUEK5qLqFAQos6mwEq6bYQU9+EU4uYJwoYQIIqw0CmB150=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WNyJWuQI; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WNyJWuQI"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb68bdf53aso146155a34.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jul 2026 15:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1783635404; x=1784240204; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pVPNWissv5HEN5RE+5TpeN3CMvB/OKvbY5pu74lvCoQ=;
        b=WNyJWuQIAcM6Zz12G9owCuIl3ZqDZ2fVQOZJWGMyMPYc7gOkfZEIhaeq6zxzJKL1wU
         hSzauvlrD/psjR45KQLyCu+3Pl2w3e3MU735EzFkdutyU1b4prygdNE1ssm/6uT8uA/V
         yjo/kye3SG5pPgYeYAM9TqSwLLf0+xQHgFbJKAgZH5N9fL1JkGRdI6sXEwwvXpzhT+a4
         JRr7yEBWn7hvxvZCZtFRhKyo5oZ4C72SNOrHyeb1hx6j5ORmoCckrfKZHf7VYUfAX1sd
         LU/y21IHMGRiIsaawjmf5rmS6yyIXwA0dKwnXwTpy/aku9gFV/Vl30wpp92ueC3g0RAX
         RITQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783635404; x=1784240204;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pVPNWissv5HEN5RE+5TpeN3CMvB/OKvbY5pu74lvCoQ=;
        b=nxe0RqktZG0V+nPSYiLI5o3k9KVFE26POjE+Lbrbs71WeLMbTF3f956hpu5IQ8DZaj
         B8OU/up5vCtYratis1Hu1oFjQhAaxyxhPrwgpIaR07ppcBdbsE69l2eYlLoZ0gTs9cI1
         sZGEI/IVcFMpK+Ed/3AzSHBwDxG39lF8CKCOzMw3CNoBLPHyqrkWaid0mOkk6eK5RSU7
         jVkmu0EC8vtZpks+GYL/rlGELgGxU7MzrDgHYqcTrLliod2baZM4E24wCY5cgeXSiJvz
         kD4ieF2K/DLnWVwTWOW/H+zOLlWSgJxtWhfuzHi0BJtfzaGpZN8349r/WM035y3GzJza
         iKFw==
X-Gm-Message-State: AOJu0Yw9qivrZoArXTVtOhnkQk15smUm3UdZTDVliqI6yLkIXsbKyylZ
	tcjnmi1pWCX1i8rEZSYa1Ycq/d3mL4rrgyIq93olzQnM0JL2AuiiapMgXn/K5CJepQ8=
X-Gm-Gg: AfdE7clNOUVb28ajky2wgTH+YLFuUUR50Dca+yhQPrDfoPySSZRKvoo2PVh+WgM6SRl
	MIqblORA6n+971/3QprDMUxaKVb3x8o3u2WAb9KPnlQUi1cZMsmwB695sjno1Z9+hWq746pfnit
	9+siNmcY/4UWtjWsd0ww7O/LoyWXN8jYGf+CCOZTNmlvndPdKJYiHzuUGdssItdE+dpQ2Fe4OUK
	k0z5Hm+5QjOXBa06LWV13j5wFFNgPG4wIFTHQPFdaUpsNE3TOT22KLLWkG+Msmq3DoIIdFxwfc/
	P7/cGEVoKhDLtdtMexx72p2BUn+RmOOBOOY+16WdsrzIr3gUxxCKYwCUCxmjtjZNq2Pa7q+AkoE
	m4Uyw/jGEFN/G3yYFbCqVmdgv3u+jbpEZz3g3dpDUL7L7N4bc4yvlTonUUMwvHeX1NIaL9pLW5/
	7rwBBQnKR/VDna
X-Received: by 2002:a05:6830:314c:b0:7e9:b772:9aae with SMTP id 46e09a7af769-7ebcff87a83mr6559127a34.23.1783635403805;
        Thu, 09 Jul 2026 15:16:43 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:bf21:2632::3ce:25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae20782sm5242763a34.4.2026.07.09.15.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 15:16:43 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
Date: Thu, 09 Jul 2026 17:16:37 -0500
Subject: [PATCH v2] libceph: reset OSD session when keepalive2 acks stop
 arriving
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-fix-rbd-keepalives-v2-1-39d4846a95ce@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAMQdUGoC/32NQQ7CIBBFr9LM2jEULUVX3sN0QWFqJ9bSgBJNw
 93FHsDl+/n//RUiBaYI52qFQIkj+7mA3FVgRzPfCNkVBimkEq1oceA3ht7hnWgxEyeKqNRxoJN
 Uyh4aKMMlUGlt0mtXeOT49OGzfaT6l/7VpRpr7Elr7RrZOGUudvIvN0wm0N76B3Q55y87gqLbu
 QAAAA==
X-Change-ID: 20260707-fix-rbd-keepalives-664fe9266c35
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew DeMaria <ademaria@cloudflare.com>, 
 Chris J Arges <carges@cloudflare.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1783635402; l=6552;
 i=carges@cloudflare.com; h=from:subject:message-id;
 bh=0fau16+oxtmESNBbvRL+F+38Vn0xU/vpRgQPxP/zi/I=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgaxY1IIT5oTohBZJmhnVgJo2HsM7Sv
 9I0LdJCgpeGX6gAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFvhUjIqfegM5sWiAImY++hh61w1qT6Po404Wr3My8N0cd54HLQCA46QxrN162PmfijeBeKVAjq
 NJo4SkrNMPgU=
X-Developer-Key: i=carges@cloudflare.com; a=openssh;
 fpr=SHA256:Cun99EBiH0EV7wvmfTBF9eDrld2NJx+aD4ScWZ45Q5M

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
Changes in v2:
- add static function to check if osd keepalive timed out
- Link to v1: https://patch.msgid.link/20260707-fix-rbd-keepalives-v1-1-be888d525d6a@cloudflare.com

To: Ilya Dryomov <idryomov@gmail.com>
To: Alex Markuze <amarkuze@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/ceph/libceph.h    |  1 +
 include/linux/ceph/osd_client.h |  1 +
 net/ceph/messenger.c            |  3 +++
 net/ceph/osd_client.c           | 29 ++++++++++++++++++++++++++++-
 4 files changed, 33 insertions(+), 1 deletion(-)

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
index 2ff00070c181..c4e1c0534801 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -53,6 +53,7 @@ static void link_linger(struct ceph_osd *osd,
 static void unlink_linger(struct ceph_osd *osd,
 			  struct ceph_osd_linger_request *lreq);
 static void clear_backoffs(struct ceph_osd *osd);
+static void kick_osd_requests(struct ceph_osd *osd);
 
 #if 1
 static inline bool rwsem_is_wrlocked(struct rw_semaphore *sem)
@@ -3420,6 +3421,15 @@ static int linger_notify_finish_wait(struct ceph_osd_linger_request *lreq,
 	return left;
 }
 
+static bool osd_keepalive_timed_out(struct ceph_osd *osd)
+{
+	if (!time_after_eq(jiffies,
+			   osd->o_keepalive_stamp + CEPH_OSD_PING_TIMEOUT))
+		return false;
+
+	return ceph_con_keepalive_expired(&osd->o_con, CEPH_OSD_PING_TIMEOUT);
+}
+
 /*
  * Timeout callback, called every N seconds.  When 1 or more OSD
  * requests has been active for more than N seconds, we send a keepalive
@@ -3480,8 +3490,11 @@ static void handle_timeout(struct work_struct *work)
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
@@ -3507,6 +3520,20 @@ static void handle_timeout(struct work_struct *work)
 							struct ceph_osd,
 							o_keepalive_item);
 		list_del_init(&osd->o_keepalive_item);
+
+		/* Record start of ping timeout from the first slow tick. */
+		if (!osd->o_keepalive_stamp) {
+			osd->o_keepalive_stamp = jiffies;
+		} else if (osd_keepalive_timed_out(osd)) {
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

