Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B8743C7C8
	for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2026 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587385; cv=none; b=E/GSPmkfXYFhmvln8CQNaMeYL93bQqsHLPWzoSW1Uv8bzrdjzbXh1dtKKlLSFWN1gZ5jCqCOukKDxK0+LrxHQsVzBDfd6iMqRtvh6IL3h7CZHRXE/mLPrScgyQWAZ6A2wUUs0lJEOSEGodpjBvwOJlerUpdyi6Zb1dBB075nQh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587385; c=relaxed/simple;
	bh=pLkqvurGLvdYqh8GtQi6XdHxsYN0BqH3eXrptf9i3g8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=msBbEstOXKrhEQw0MAdNleFiD+key6tzWIPlhNvsQgZv9Ta0S2R+LOlQMrlztJfpr3sg3bUehmlqd2VK9sjBUIlBhxOKe6Ikmautk3sdSZ0nMjASCAbYvv61D1tz5nSK9Z+Al/qBmq3GdKa+gUrL7Cxn6yCgLbD644bndlbVK5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=b4qez36e; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="b4qez36e"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6a3d915616fso1467445eaf.2
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2026 15:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1784587381; x=1785192181; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LRBIfkf3wdoxL+p/2humIPxU7mFmQ4bE3UFfQNRbQcs=;
        b=b4qez36ezgldzbDVjioJYk9G0qz9z6OfsInr4RTJIQnyAJyiUPthk65HzC5SzdxVYu
         mncnDkM98SkjS7uRFFCwr/t4U0JMgRRIwmgMMiuqKvSKYgCH/gxYEKMYtRoXJAvtolzU
         LR51UlDlEYe0C4iuu4WBS+tm/m+VoOJVKqVCEtjq0EZVT3RzBrGl5fPC07G4s2bZRTYx
         K54c+BsORBYrvzndAm9Bnmvn1NsBglaPdW3BniLwLpzNUrjp8n6Oh0JuJcS4UUkdouP5
         3quE/H/rt40gshup53ORTIVx0ARrBJEM9kPszAfyf6zq8CHyU1zzSYHQ4La2hj6WbFBC
         Ua2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784587381; x=1785192181;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LRBIfkf3wdoxL+p/2humIPxU7mFmQ4bE3UFfQNRbQcs=;
        b=Ob8CVhrpZwzWye24rhcZvi67Ip413R+U65CSXFIdZjQv6FbJOeMxmWoaLM9j+HvQ6F
         +VMXvhG5NGggtvtQ5ES8TSvvDytv8lR0tjN21o5hh8yW1obd9o5TmCT4jFnMMG87LhN1
         q/rcRzs8+//EBe1MUVRe7SU5LBkfXkFlsEFd8TTtfbplqylrRiCV9HWvlN936JhO0WRZ
         ijBzXI4eTlGgOTsJHCy6o23Jj9Z723QcJvhrmpkBfO4atkDL8jAHf0ti7eptxDUsTsqc
         bizGfRo4xz+zLfF8mfXo5GLhV7uxvjGj9/hwwRU958dzKjv+9BH8Hvv3FckNpsioFjLU
         FkqQ==
X-Gm-Message-State: AOJu0Yyuz1CjT2uTHXjLUPsoyYmwqSHf88bhNe5hg2ECip3YWo0I84kO
	Ina2t2Iaj0hyJReHn1KsPJHT0aqMIPDeUHJqWWWe/ZbPDeyuVuk0YYSZklgHHi8wxAQ=
X-Gm-Gg: AfdE7cm47+l5DiU7NUnFJ0USwcinF0q8v0YDPUXchbUX2Z+nlECbICx8J08y+pnzTA8
	LAzuLO6O/FrlNyZJWhQkKAG7vABNVSpS+EiU2Wkp4MlUY7qFsAt3E3kE2s2wIcBlHrgNmnd05v4
	bWV4gA0F0RYXc9fUwEOVc5xobYKmSlOqE7Ic2VkTbZRojp0kKkCTQDBUvXc0PbCkEeHK4r0BUai
	yrRgGMu/rESvLKV6Pw7znwWNMRrQIYBxvMlx3+J9JCWtCGJAnEzxtdYPIIcZepWEOowEmEzgmCg
	ng4G71TT2vYaNic6xqdsTZokh3cGn0kYzChWG5Hptyk0ql5X9W5+GoYnZGa4OKEWvXQMHinQ/Ob
	xsBuNZcivnHC3j8wxao2fcqo76AOsLIoYI8HJfkyC9mBMx8sCR0itGxuZRsEE5raayE8=
X-Received: by 2002:a05:6820:81c9:b0:69e:2cb4:2ed8 with SMTP id 006d021491bc7-6a5367e83d3mr8090305eaf.26.1784587380935;
        Mon, 20 Jul 2026 15:43:00 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:bf21:2632::3ce:1b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4568e6a8c92sm9629886fac.14.2026.07.20.15.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 15:43:00 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
Date: Mon, 20 Jul 2026 17:42:43 -0500
Subject: [PATCH v3] libceph: reset OSD session when keepalive2 acks stop
 arriving
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-fix-rbd-keepalives-v3-1-c344fbad63a4@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAGKkXmoC/33NwQ7CIAyA4VdZehazwWDgyfcwHhh0jjjHAko0y
 95dtpOJxuPftF9niBgcRjgUMwRMLjo/5mC7AkyvxwsSZ3MDLakom7IhnXuS0FpyRZz04BJGIkT
 doaJCGMYhH04B89aGns65exfvPry2H6lap3+5VJGKtCiltJxyK/TRDP5hu0EH3Bt/g9VM9NNRP
 x2aHaZsLWuhFTf45SzL8gagrsurAQEAAA==
X-Change-ID: 20260707-fix-rbd-keepalives-664fe9266c35
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@cloudflare.com, Andrew DeMaria <ademaria@cloudflare.com>, 
 Chris J Arges <carges@cloudflare.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1784587379; l=6764;
 i=carges@cloudflare.com; h=from:subject:message-id;
 bh=pLkqvurGLvdYqh8GtQi6XdHxsYN0BqH3eXrptf9i3g8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgaxY1IIT5oTohBZJmhnVgJo2HsM7Sv
 9I0LdJCgpeGX6gAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBmmRH8n21GUCpfoJ/zD/gO92+C16VxjAFJUwUX0InSE5LeD9/tucii/WhP7w7S5bblPCG2uEWY
 +aEbW5XftpwI=
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
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
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
Changes in v3:
- Rebase and collected Reviewed-By tag
- Link to v2: https://patch.msgid.link/20260709-fix-rbd-keepalives-v2-1-39d4846a95ce@cloudflare.com

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
base-commit: b95f03f04d475aa6719d15a636ddf32222d55657
change-id: 20260707-fix-rbd-keepalives-664fe9266c35

Best regards,
--  
Chris J Arges <carges@cloudflare.com>

