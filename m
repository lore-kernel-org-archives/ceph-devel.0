Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2242DEA8C
	for <ceph-devel@vger.kernel.org>; Fri,  3 Jul 2026 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783107494; cv=none; b=guyjAxiSipgXGILFPX+uzcVhD0nrx7OTSPkzpkrsCmUl/it62jIfrVGsURD2JKMa4tZb1Dg7dlMLPPG7atOLFPbDmZs/UHRq4CqMoccI6KYZ3eGOEWJsbfPek2DNXVrEk4oHKl6xNvHB6PiFgI8JPm4etZ1zleifhjs1JxfILGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783107494; c=relaxed/simple;
	bh=Cw0guS+j68JeU+JEBI1qgDtkFNVfPNlCd93WNMUE42M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gc7o5Gdne+qgIaYQvPkCSiWmnfiCimIxcSK75GZeuLoKaxi+W8GgRZjaw7fTijJiB0e3U3OD5sTIWa4Zg37MI2XkqNxCja/ydWTj4a1qPLGLKxNxG/LggPeUnh5PkYMQz2E0KrVLcKPTKKfrz+9SZGJdo2UGiMueqnpg7aKe1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WBY4d+56; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WBY4d+56"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4763b0c1dcdso915496f8f.2
        for <ceph-devel@vger.kernel.org>; Fri, 03 Jul 2026 12:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783107489; x=1783712289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NQM9LQdsZjIKTPMvZZf0YvSMgXTES0k1l0hlB4NJpYY=;
        b=WBY4d+56aKweESFb58x9zZQiQnirFTv8BbIh+Yazv+TTFc1hzAQ9wu38Y1GdFBmRU1
         2qn2/ItjD8aOCuD20citK68BLVGOpz39/YEdmRrkp9/PTENCHI4FNN4ZxbrkYXB4KM3U
         vUDZGQjHsA8h6UfkKJIyyckjEY8blgT0J7lwHtwqxjYGPA89wQedV/McPCq35ts8By+k
         EZ3DfrY0mR11H4zle9IuQAwIRp4DZjJWsRF9I3cx58RlhW6VfRVpzqakXQJ7cO0azzJ0
         rIpvkOTHhtbdH2/AvJgl335rdwNPVfiL172Cb+4oQgjGfWfi9mmLL6NSh5ZHJWcNAaV4
         EiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783107489; x=1783712289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NQM9LQdsZjIKTPMvZZf0YvSMgXTES0k1l0hlB4NJpYY=;
        b=KhqRKcBvNn/J0CRrpe8D/rnpD2M9Qqh3d+4y0Q/pPtybRuXcZVWplRbDZ9/SRcLqf+
         JVrAZQMJJwt0c+oacvng+uHYtbwJXYdQhLXis82SYk/sMYgKj7teUa3VFLV3JbPT77Yh
         B4kqy5sSj/rxF9bu4xMB76n6B65Y0Azx1lIheUOhGcbd+8Ysf6G1qU1FIMMMOcuK7OPu
         7Oizl11eXNZ3o+iVWxuYoalrWAhesbWDPblJSLu2Y+eVQT0Lr3ZrY9vDaJKFfJScb4XY
         +YQqII8YVeLgv7MogNkUeplsEXGUiy1nlmM/7KfSymSBqUZ/INBiXkA1iaVzKzsvCrSP
         Nkdg==
X-Forwarded-Encrypted: i=1; AHgh+Rpq4KQpJN5Lp6eeaMJOIX6rKEx1GTUMmiBShakI/HdWWVeleyJ6vPuej+o6LThkJhK/ZtAUIu/DQcF4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Mk9DeczI+4D/ltF6mugNcw99gqRsuNkHTzFvhX2g3Uy61u0j
	FwmTN8cOOmy0usbvN3THdtB6XHq2Uti0OtEbNZX7qbtp6/OrgSy2UQXsbuLE2QvbmBA=
X-Gm-Gg: AfdE7cl99Im0Ah8knCU3dYGHLrUOQVAjYGTs/yZDVzSyKLGQalhDZ0iHJksKzF8tPSX
	kUPnoALyUO1bsGS2r9jUP1KCF4arEnjbxbVq3NDhLNphCLwR/TA0UnhT1SfLC6IKgMKFGgjMsr7
	rED6JPNy5gMLmMplKpEth+tzUDrNVBH1x1tDdbLRKzYXEyLSY+daaReIxdZFKX8eo34PsV7kGZM
	n9VTm/fTCcVXFhGNQCITSuIp/7fB4dIvFjrwNYfR5oX40HEu6UJmc0MAxzygedO0VHjrTAia4c2
	y6LycUqcW42JUkVzusuW5AhnvbrD7wG6H+c9ZLGn/6VCRDAG8p13UaTyg1t8uLjjiPR0lpgVb5B
	x9JFbiaXXKPgjUeM7zkg4nNoYFeWdCRxenUjHkoQ1jEt7H8R+BwCv2IZmcI8syZKeckK4i7wSj5
	ABu6fH/VHIU4URMHdhacuI5k1V/1RNFqFoApY2oAH7tTPXhdiFCLPAEPDkLNad5MzqcasbX3Nrx
	Nj2nTaRYXn+UiXT
X-Received: by 2002:a05:6000:298d:10b0:46f:558:a43f with SMTP id ffacd0b85a97d-47aab57d3b9mr548436f8f.4.1783107489363;
        Fri, 03 Jul 2026 12:38:09 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a558easm1717005f8f.27.2026.07.03.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:38:09 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/ceph/messenger: add separate lock for `out_queue`
Date: Fri,  3 Jul 2026 21:38:03 +0200
Message-ID: <20260703193803.3689912-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a lot of lock contention for `ceph_connection.mutex` because
both the worker kthread (i.e. ceph_con_workfn()) and ceph_con_send()
are using this mutex.

ceph_con_workfn() does the actual socket I/O and handles incoming
packets; it can hold the mutex for very long periods of time.
ceph_con_send(), on the other hand, may be called by arbitrary
userspace processes invoking system calls for I/O on Ceph files.  This
means heavy contention of the mutex may slow down thousands of
userspace processes.

However, ceph_con_send() accesses just con->out_queue and little else.
The real work is later done by ceph_con_workfn().  It is therefore
trivial to introduce a light-weight spinlock just for `out_queue` and
eliminate almost all of the contention.

This is a /proc/lock_stat I captured on one of our web servers for 5
minutes without to this patch:

   class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg

  &con->mutex:         15918          15962           0.40       37877.04     7853358.52         492.00       13430455       33994666           0.08       93555.76   446452667.84          13.13
  -----------
  &con->mutex          15902          [<00000000aacd116f>] ceph_con_send+0x5c/0x170
  &con->mutex             51          [<000000001b111558>] ceph_con_in_msg_alloc+0x74/0x1c0
  &con->mutex              5          [<0000000068ae10b2>] ceph_con_keepalive+0x28/0x80
  &con->mutex              3          [<000000009208fc49>] ceph_con_workfn+0x30/0x418
  -----------
  &con->mutex          13253          [<00000000c9c4e344>] ceph_con_process_message+0x90/0xd0
  &con->mutex           1792          [<000000009208fc49>] ceph_con_workfn+0x30/0x418
  &con->mutex            897          [<000000001b111558>] ceph_con_in_msg_alloc+0x74/0x1c0
  &con->mutex             20          [<00000000aacd116f>] ceph_con_send+0x5c/0x170

ceph_con_process_message() is holding the mutex all the time, and
there are lots of ceph_con_send() calls waiting for it.  Each of these
gets delayed by an average of 0.5 ms.

Now the same but with this patch:

     class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg

 &con->out_lock:         63452          64484           0.04         835.92      210874.20           3.27       13212464       36953693           0.04         902.60    16032508.44           0.43
 --------------
 &con->out_lock          42003          [<00000000e6da95fb>] ceph_con_send+0x64/0x1a0
 &con->out_lock           4451          [<00000000981ab2f3>] ceph_con_discard_sent+0x48/0x188
 &con->out_lock          18025          [<000000009ca1ffc1>] ceph_con_v1_try_write+0x2d8/0x768
 &con->out_lock              5          [<0000000030330169>] ceph_con_get_out_msg+0xc0/0x210
 --------------
 &con->out_lock          34132          [<000000009ca1ffc1>] ceph_con_v1_try_write+0x2d8/0x768
 &con->out_lock          23239          [<00000000e6da95fb>] ceph_con_send+0x64/0x1a0
 &con->out_lock           7112          [<00000000981ab2f3>] ceph_con_discard_sent+0x48/0x188
 &con->out_lock              1          [<0000000030330169>] ceph_con_get_out_msg+0xc0/0x210

    &con->mutex:            16             16           7.96        7130.96       13680.60         855.04        4962257       28359208           0.08      237939.28   369261170.32          13.02
    -----------
    &con->mutex             16          [<00000000f3e4b849>] ceph_con_keepalive+0x28/0x80
    -----------
    &con->mutex             15          [<000000005fc149e2>] ceph_con_process_message+0x90/0xd0
    &con->mutex              1          [<000000006b2ce95a>] ceph_con_in_msg_alloc+0x74/0x1c0

Almost no contentions remain on the old `mutex`.  The new `out_lock`
has more contentions than before, but these are shorter: the total
wait time of both is reduced by a factor of 35.  The average wait time
was reduced from 492 us to 3 us.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/ceph/messenger.h | 19 +++++++-
 net/ceph/messenger.c           | 79 +++++++++++++++++++++++++++++-----
 net/ceph/messenger_v1.c        | 17 ++++++++
 net/ceph/messenger_v2.c        | 31 +++++++++++++
 4 files changed, 135 insertions(+), 11 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 6aa4c6478c9f..adfa4df2856a 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -476,7 +476,13 @@ struct ceph_connection {
 
 	struct ceph_messenger *msgr;
 
-	int state;  /* CEPH_CON_S_* */
+	/**
+	 * CEPH_CON_S_*
+	 *
+	 * Protected by both #mutex and #out_lock.  Writing must hold
+	 * both, reading either one.
+	 */
+	int state;
 	atomic_t sock_state;
 	struct socket *sock;
 
@@ -490,6 +496,12 @@ struct ceph_connection {
 	struct mutex mutex;
 
 	/* out queue */
+
+	/**
+	 * Protects #out_queue and #out_sent.
+	 */
+	spinlock_t out_lock;
+
 	struct list_head out_queue;
 	struct list_head out_sent;   /* sending or sent but unacked */
 	u64 out_seq;		     /* last message queued for send */
@@ -550,6 +562,11 @@ void ceph_addr_set_port(struct ceph_entity_addr *addr, int p);
 void ceph_con_process_message(struct ceph_connection *con);
 int ceph_con_in_msg_alloc(struct ceph_connection *con,
 			  struct ceph_msg_header *hdr, int *skip);
+
+/**
+ * Caller must hold both `ceph_connection.mutex` and
+ * `ceph_connection.out_lock`.
+ */
 struct ceph_msg *ceph_con_get_out_msg(struct ceph_connection *con);
 
 /* messenger_v1.c */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 34b3097b4c7b..3bd88054817a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -554,12 +554,22 @@ static void ceph_msg_remove_list(struct list_head *head)
 
 void ceph_con_reset_session(struct ceph_connection *con)
 {
+	LIST_HEAD(tmp);
+
 	dout("%s con %p\n", __func__, con);
 
 	WARN_ON(con->in_msg);
 	WARN_ON(con->out_msg);
-	ceph_msg_remove_list(&con->out_queue);
-	ceph_msg_remove_list(&con->out_sent);
+
+	/* move all messages to the stack and call
+	 * ceph_msg_remove_list() without holding the spinlock
+	 */
+	spin_lock(&con->out_lock);
+	list_splice_init(&con->out_queue, &tmp);
+	list_splice_init(&con->out_sent, &tmp);
+	spin_unlock(&con->out_lock);
+	ceph_msg_remove_list(&tmp);
+
 	con->out_seq = 0;
 	con->in_seq = 0;
 	con->in_seq_acked = 0;
@@ -577,7 +587,9 @@ void ceph_con_close(struct ceph_connection *con)
 {
 	mutex_lock(&con->mutex);
 	dout("con_close %p peer %s\n", con, ceph_pr_addr(&con->peer_addr));
+	spin_lock(&con->out_lock);
 	con->state = CEPH_CON_S_CLOSED;
+	spin_unlock(&con->out_lock);
 
 	ceph_con_flag_clear(con, CEPH_CON_F_LOSSYTX);  /* so we retry next
 							  connect */
@@ -603,7 +615,9 @@ void ceph_con_open(struct ceph_connection *con,
 	dout("con_open %p %s\n", con, ceph_pr_addr(addr));
 
 	WARN_ON(con->state != CEPH_CON_S_CLOSED);
+	spin_lock(&con->out_lock);
 	con->state = CEPH_CON_S_PREOPEN;
+	spin_unlock(&con->out_lock);
 
 	con->peer_name.type = (__u8) entity_type;
 	con->peer_name.num = cpu_to_le64(entity_num);
@@ -642,6 +656,7 @@ void ceph_con_init(struct ceph_connection *con, void *private,
 	con_sock_state_init(con);
 
 	mutex_init(&con->mutex);
+	spin_lock_init(&con->out_lock);
 	INIT_LIST_HEAD(&con->out_queue);
 	INIT_LIST_HEAD(&con->out_sent);
 	INIT_DELAYED_WORK(&con->work, ceph_con_workfn);
@@ -671,10 +686,16 @@ u32 ceph_get_global_seq(struct ceph_messenger *msgr, u32 gt)
  */
 void ceph_con_discard_sent(struct ceph_connection *con, u64 ack_seq)
 {
+	LIST_HEAD(tmp);
 	struct ceph_msg *msg;
 	u64 seq;
 
 	dout("%s con %p ack_seq %llu\n", __func__, con, ack_seq);
+
+	/* move all discarded messages to the stack and call
+	 * ceph_msg_remove_list() without holding the spinlock
+	 */
+	spin_lock(&con->out_lock);
 	while (!list_empty(&con->out_sent)) {
 		msg = list_first_entry(&con->out_sent, struct ceph_msg,
 				       list_head);
@@ -685,8 +706,11 @@ void ceph_con_discard_sent(struct ceph_connection *con, u64 ack_seq)
 
 		dout("%s con %p discarding msg %p seq %llu\n", __func__, con,
 		     msg, seq);
-		ceph_msg_remove(msg);
+		list_move_tail(&msg->list_head, &tmp);
 	}
+	spin_unlock(&con->out_lock);
+
+	ceph_msg_remove_list(&tmp);
 }
 
 /*
@@ -696,10 +720,16 @@ void ceph_con_discard_sent(struct ceph_connection *con, u64 ack_seq)
  */
 void ceph_con_discard_requeued(struct ceph_connection *con, u64 reconnect_seq)
 {
+	LIST_HEAD(tmp);
 	struct ceph_msg *msg;
 	u64 seq;
 
 	dout("%s con %p reconnect_seq %llu\n", __func__, con, reconnect_seq);
+
+	/* move all discarded messages to the stack and call
+	 * ceph_msg_remove_list() without holding the spinlock
+	 */
+	spin_lock(&con->out_lock);
 	while (!list_empty(&con->out_queue)) {
 		msg = list_first_entry(&con->out_queue, struct ceph_msg,
 				       list_head);
@@ -711,8 +741,11 @@ void ceph_con_discard_requeued(struct ceph_connection *con, u64 reconnect_seq)
 
 		dout("%s con %p discarding msg %p seq %llu\n", __func__, con,
 		     msg, seq);
-		ceph_msg_remove(msg);
+		list_move_tail(&msg->list_head, &tmp);
 	}
+	spin_unlock(&con->out_lock);
+
+	ceph_msg_remove_list(&tmp);
 }
 
 #ifdef CONFIG_BLOCK
@@ -1626,9 +1659,12 @@ static void con_fault(struct ceph_connection *con)
 
 	ceph_con_reset_protocol(con);
 
+	spin_lock(&con->out_lock);
+
 	if (ceph_con_flag_test(con, CEPH_CON_F_LOSSYTX)) {
 		dout("fault on LOSSYTX channel, marking CLOSED\n");
 		con->state = CEPH_CON_S_CLOSED;
+		spin_unlock(&con->out_lock);
 		return;
 	}
 
@@ -1642,6 +1678,7 @@ static void con_fault(struct ceph_connection *con)
 		dout("fault %p setting STANDBY clearing WRITE_PENDING\n", con);
 		ceph_con_flag_clear(con, CEPH_CON_F_WRITE_PENDING);
 		con->state = CEPH_CON_S_STANDBY;
+		spin_unlock(&con->out_lock);
 	} else {
 		/* retry after a delay. */
 		con->state = CEPH_CON_S_PREOPEN;
@@ -1653,6 +1690,7 @@ static void con_fault(struct ceph_connection *con)
 				con->delay = MAX_DELAY_INTERVAL;
 		}
 		ceph_con_flag_set(con, CEPH_CON_F_BACKOFF);
+		spin_unlock(&con->out_lock);
 		queue_con(con);
 	}
 }
@@ -1716,7 +1754,9 @@ static void clear_standby(struct ceph_connection *con)
 	/* come back from STANDBY? */
 	if (con->state == CEPH_CON_S_STANDBY) {
 		dout("clear_standby %p\n", con);
+		spin_lock(&con->out_lock);
 		con->state = CEPH_CON_S_PREOPEN;
+		spin_unlock(&con->out_lock);
 		if (!ceph_msgr2(from_msgr(con->msgr)))
 			con->v1.connect_seq++;
 		WARN_ON(ceph_con_flag_test(con, CEPH_CON_F_WRITE_PENDING));
@@ -1736,12 +1776,14 @@ void ceph_con_send(struct ceph_connection *con, struct ceph_msg *msg)
 	BUG_ON(msg->front.iov_len != le32_to_cpu(msg->hdr.front_len));
 	msg->needs_out_seq = true;
 
-	mutex_lock(&con->mutex);
+	msg_con_set(msg, NULL);
+
+	spin_lock(&con->out_lock);
 
 	if (con->state == CEPH_CON_S_CLOSED) {
 		dout("con_send %p closed, dropping %p\n", con, msg);
+		spin_unlock(&con->out_lock);
 		ceph_msg_put(msg);
-		mutex_unlock(&con->mutex);
 		return;
 	}
 
@@ -1756,8 +1798,14 @@ void ceph_con_send(struct ceph_connection *con, struct ceph_msg *msg)
 	     le32_to_cpu(msg->hdr.middle_len),
 	     le32_to_cpu(msg->hdr.data_len));
 
-	clear_standby(con);
-	mutex_unlock(&con->mutex);
+	if (con->state == CEPH_CON_S_STANDBY) {
+		spin_unlock(&con->out_lock);
+		mutex_lock(&con->mutex);
+		clear_standby(con);
+		mutex_unlock(&con->mutex);
+	} else {
+		spin_unlock(&con->out_lock);
+	}
 
 	/* if there wasn't anything waiting to send before, queue
 	 * new work */
@@ -1779,16 +1827,21 @@ void ceph_msg_revoke(struct ceph_msg *msg)
 	}
 
 	mutex_lock(&con->mutex);
+	spin_lock(&con->out_lock);
 	if (list_empty(&msg->list_head)) {
 		WARN_ON(con->out_msg == msg);
 		dout("%s con %p msg %p not linked\n", __func__, con, msg);
+		spin_unlock(&con->out_lock);
 		mutex_unlock(&con->mutex);
 		return;
 	}
 
+	list_del_init(&msg->list_head);
+	spin_unlock(&con->out_lock);
+
 	dout("%s con %p msg %p was linked\n", __func__, con, msg);
 	msg->hdr.seq = 0;
-	ceph_msg_remove(msg);
+	ceph_msg_put(msg);
 
 	if (con->out_msg == msg) {
 		WARN_ON(con->state != CEPH_CON_S_OPEN);
@@ -2114,6 +2167,9 @@ struct ceph_msg *ceph_con_get_out_msg(struct ceph_connection *con)
 {
 	struct ceph_msg *msg;
 
+	lockdep_assert_held(&con->mutex);
+	lockdep_assert_held(&con->out_lock);
+
 	if (list_empty(&con->out_queue))
 		return NULL;
 
@@ -2134,8 +2190,11 @@ struct ceph_msg *ceph_con_get_out_msg(struct ceph_connection *con)
 		msg->hdr.seq = cpu_to_le64(++con->out_seq);
 		msg->needs_out_seq = false;
 
-		if (con->ops->reencode_message)
+		if (con->ops->reencode_message) {
+			spin_unlock(&con->out_lock);
 			con->ops->reencode_message(msg);
+			spin_lock(&con->out_lock);
+		}
 	}
 
 	/*
diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index c9e002d96319..01b870927c93 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -888,7 +888,9 @@ static int process_connect(struct ceph_connection *con)
 		}
 
 		WARN_ON(con->state != CEPH_CON_S_V1_CONNECT_MSG);
+		spin_lock(&con->out_lock);
 		con->state = CEPH_CON_S_OPEN;
+		spin_unlock(&con->out_lock);
 		con->v1.auth_retry = 0;    /* we authenticated; clear flag */
 		con->v1.peer_global_seq =
 			le32_to_cpu(con->v1.in_reply.global_seq);
@@ -1343,7 +1345,9 @@ int ceph_con_v1_try_read(struct ceph_connection *con)
 		if (ret < 0)
 			goto out;
 
+		spin_lock(&con->out_lock);
 		con->state = CEPH_CON_S_V1_CONNECT_MSG;
+		spin_unlock(&con->out_lock);
 
 		/*
 		 * Received banner is good, exchange connection info.
@@ -1403,7 +1407,9 @@ int ceph_con_v1_try_read(struct ceph_connection *con)
 			break;
 		case CEPH_MSGR_TAG_CLOSE:
 			ceph_con_close_socket(con);
+			spin_lock(&con->out_lock);
 			con->state = CEPH_CON_S_CLOSED;
+			spin_unlock(&con->out_lock);
 			goto out;
 		default:
 			goto bad_tag;
@@ -1481,7 +1487,9 @@ int ceph_con_v1_try_write(struct ceph_connection *con)
 	/* open the socket first? */
 	if (con->state == CEPH_CON_S_PREOPEN) {
 		BUG_ON(con->sock);
+		spin_lock(&con->out_lock);
 		con->state = CEPH_CON_S_V1_BANNER;
+		spin_unlock(&con->out_lock);
 
 		con_out_kvec_reset(con);
 		prepare_write_banner(con);
@@ -1536,18 +1544,26 @@ int ceph_con_v1_try_write(struct ceph_connection *con)
 	}
 
 do_next:
+	/* hold con->out_lock while checking for things to write and
+	 * unlock it after clearing CEPH_CON_F_WRITE_PENDING to avoid
+	 * racing with ceph_con_send()
+	 */
+	spin_lock(&con->out_lock);
 	if (con->state == CEPH_CON_S_OPEN) {
 		if (ceph_con_flag_test_and_clear(con,
 				CEPH_CON_F_KEEPALIVE_PENDING)) {
+			spin_unlock(&con->out_lock);
 			prepare_write_keepalive(con);
 			goto more;
 		}
 		/* is anything else pending? */
 		if ((msg = ceph_con_get_out_msg(con)) != NULL) {
+			spin_unlock(&con->out_lock);
 			prepare_write_message(con, msg);
 			goto more;
 		}
 		if (con->in_seq > con->in_seq_acked) {
+			spin_unlock(&con->out_lock);
 			prepare_write_ack(con);
 			goto more;
 		}
@@ -1555,6 +1571,7 @@ int ceph_con_v1_try_write(struct ceph_connection *con)
 
 	/* Nothing to do! */
 	ceph_con_flag_clear(con, CEPH_CON_F_WRITE_PENDING);
+	spin_unlock(&con->out_lock);
 	dout("try_write nothing else to write.\n");
 	ret = 0;
 out:
diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 05f6eea299fc..96a78e0345dd 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -1744,7 +1744,9 @@ static int prepare_read_banner_prefix(struct ceph_connection *con)
 	reset_in_kvecs(con);
 	add_in_kvec(con, buf, CEPH_BANNER_V2_PREFIX_LEN);
 	add_in_sign_kvec(con, buf, CEPH_BANNER_V2_PREFIX_LEN);
+	spin_lock(&con->out_lock);
 	con->state = CEPH_CON_S_V2_BANNER_PREFIX;
+	spin_unlock(&con->out_lock);
 	return 0;
 }
 
@@ -1760,7 +1762,9 @@ static int prepare_read_banner_payload(struct ceph_connection *con,
 	reset_in_kvecs(con);
 	add_in_kvec(con, buf, payload_len);
 	add_in_sign_kvec(con, buf, payload_len);
+	spin_lock(&con->out_lock);
 	con->state = CEPH_CON_S_V2_BANNER_PAYLOAD;
+	spin_unlock(&con->out_lock);
 	return 0;
 }
 
@@ -2181,7 +2185,9 @@ static int process_banner_payload(struct ceph_connection *con)
 		return ret;
 	}
 
+	spin_lock(&con->out_lock);
 	con->state = CEPH_CON_S_V2_HELLO;
+	spin_unlock(&con->out_lock);
 	prepare_read_preamble(con);
 	return 0;
 
@@ -2249,7 +2255,9 @@ static int process_hello(struct ceph_connection *con, void *p, void *end)
 		return ret;
 	}
 
+	spin_lock(&con->out_lock);
 	con->state = CEPH_CON_S_V2_AUTH;
+	spin_unlock(&con->out_lock);
 	return 0;
 
 bad:
@@ -2409,7 +2417,9 @@ static int process_auth_done(struct ceph_connection *con, void *p, void *end)
 		goto out;
 	}
 
+	spin_lock(&con->out_lock);
 	con->state = CEPH_CON_S_V2_AUTH_SIGNATURE;
+	spin_unlock(&con->out_lock);
 
 out:
 	memzero_explicit(session_key, sizeof(session_key));
@@ -2451,7 +2461,9 @@ static int process_auth_signature(struct ceph_connection *con,
 			return ret;
 		}
 
+		spin_lock(&con->out_lock);
 		con->state = CEPH_CON_S_V2_SESSION_CONNECT;
+		spin_unlock(&con->out_lock);
 	} else {
 		ret = prepare_session_reconnect(con);
 		if (ret) {
@@ -2459,7 +2471,9 @@ static int process_auth_signature(struct ceph_connection *con,
 			return ret;
 		}
 
+		spin_lock(&con->out_lock);
 		con->state = CEPH_CON_S_V2_SESSION_RECONNECT;
+		spin_unlock(&con->out_lock);
 	}
 
 	return 0;
@@ -2544,7 +2558,9 @@ static int process_server_ident(struct ceph_connection *con,
 	free_conn_bufs(con);
 	con->delay = 0;  /* reset backoff memory */
 
+	spin_lock(&con->out_lock);
 	con->state = CEPH_CON_S_OPEN;
+	spin_unlock(&con->out_lock);
 	con->v2.out_state = OUT_S_GET_NEXT;
 	return 0;
 
@@ -2595,7 +2611,9 @@ static int process_session_reconnect_ok(struct ceph_connection *con,
 	free_conn_bufs(con);
 	con->delay = 0;  /* reset backoff memory */
 
+	spin_lock(&con->out_lock);
 	con->state = CEPH_CON_S_OPEN;
+	spin_unlock(&con->out_lock);
 	con->v2.out_state = OUT_S_GET_NEXT;
 	return 0;
 
@@ -2710,7 +2728,9 @@ static int process_session_reset(struct ceph_connection *con,
 		return ret;
 	}
 
+	spin_lock(&con->out_lock);
 	con->state = CEPH_CON_S_V2_SESSION_CONNECT;
+	spin_unlock(&con->out_lock);
 	return 0;
 
 bad:
@@ -3285,6 +3305,7 @@ static int populate_out_iter(struct ceph_connection *con)
 	if (con->state != CEPH_CON_S_OPEN) {
 		WARN_ON(con->state < CEPH_CON_S_V2_BANNER_PREFIX ||
 			con->state > CEPH_CON_S_V2_SESSION_RECONNECT);
+		spin_lock(&con->out_lock);
 		goto nothing_pending;
 	}
 
@@ -3315,19 +3336,28 @@ static int populate_out_iter(struct ceph_connection *con)
 	}
 
 	WARN_ON(con->v2.out_state != OUT_S_GET_NEXT);
+
+	/* hold con->out_lock while checking for things to write and
+	 * unlock it after clearing CEPH_CON_F_WRITE_PENDING to avoid
+	 * racing with ceph_con_send()
+	 */
+	spin_lock(&con->out_lock);
 	if (ceph_con_flag_test_and_clear(con, CEPH_CON_F_KEEPALIVE_PENDING)) {
+		spin_unlock(&con->out_lock);
 		ret = prepare_keepalive2(con);
 		if (ret) {
 			pr_err("prepare_keepalive2 failed: %d\n", ret);
 			return ret;
 		}
 	} else if ((msg = ceph_con_get_out_msg(con)) != NULL) {
+		spin_unlock(&con->out_lock);
 		ret = prepare_message(con, msg);
 		if (ret) {
 			pr_err("prepare_message failed: %d\n", ret);
 			return ret;
 		}
 	} else if (con->in_seq > con->in_seq_acked) {
+		spin_unlock(&con->out_lock);
 		ret = prepare_ack(con);
 		if (ret) {
 			pr_err("prepare_ack failed: %d\n", ret);
@@ -3348,6 +3378,7 @@ static int populate_out_iter(struct ceph_connection *con)
 	WARN_ON(iov_iter_count(&con->v2.out_iter));
 	dout("%s con %p nothing pending\n", __func__, con);
 	ceph_con_flag_clear(con, CEPH_CON_F_WRITE_PENDING);
+	spin_unlock(&con->out_lock);
 	return 0;
 }
 
-- 
2.47.3

