Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641F93F880D
	for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774621875; cv=none; b=UWJWqaT10sw3QP9vwy+nd9Zhx4yi4mx53M5MxM/QrOy4dR0w8794V2RweQdQiXl1gqAwhGHZOc3JL4LKsqvvu1n16ugTmmg7r02hFrZApa6ko1GQ48Dx83kvqli1HwfPIWLzDkNp2clzCkUdroDoeFxHgiiV2wVgibzp2h2ANzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774621875; c=relaxed/simple;
	bh=EkfkQ+B7x5sRll9rfUza1vy0VfOIANzotdV3yf+l2Ag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URORXrfw959VVpxkLpgTuww46Y8++2DLU7GZjxEycUpWYnfFWP5ku75pHC3VJnvnWtFsPcXCSu3j90NSKVIGr9mKuPpp2u2U166tNCif6QbqtjCIauQNb0NFp4G/3neN8XJLkW6v3EoxUKtTxOZSKK6ntx9YINcxtWfbDyYuEWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ma4zwHrB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ljz89hw+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ma4zwHrB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ljz89hw+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774621873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JOlsTnwrp0NSbV+2c+o5QMBqiaEd47EO/LWfmDfIOE=;
	b=Ma4zwHrBuXutqnP83po3fkPAMLHvDwBGksBCpa3e8Vcbb/S4emX/Mm8Nks1KoJTTV5Mk7g
	U53bwZ/H2l2Y21c4bA05B/awK/1Z7VKKFSKRUR2CBsjcCfdpGfF5CPtC6zQ0k9/hlqWtBr
	fY+jg30DBmTR2wBCGOEWi76jYt5Exfw=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-_5E8KKl8NPy-3NNjafa5qw-1; Fri, 27 Mar 2026 10:31:10 -0400
X-MC-Unique: _5E8KKl8NPy-3NNjafa5qw-1
X-Mimecast-MFC-AGG-ID: _5E8KKl8NPy-3NNjafa5qw_1774621870
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d7eb8cf3d6so6249814a34.0
        for <ceph-devel@vger.kernel.org>; Fri, 27 Mar 2026 07:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774621869; x=1775226669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JOlsTnwrp0NSbV+2c+o5QMBqiaEd47EO/LWfmDfIOE=;
        b=Ljz89hw+pTuAUTfQ7gkyFYPrQHQaAhMTMuA7as6RcAVNlizCYLA07wkRtcOmruQjvW
         901FDPh9Rld00BBv24aToC4WczCChfhFqG5IGLlPEdJGvtGtaHj8n5dkvSP5TcfjQmHi
         aUWYGrJITCiDlJ7n4QeU57askCN0l6vy65v/NqLdsvpYO7R1oCYb3ijzdWoIx/PWo8n7
         kql8iknK/ChN7DDkDUEMUOCNTE2wVlG3fOFneL8ODd8CSOHoqu0whmdcKq2H84al4tr5
         ANWJxl96TQHDnTJ04lRK2vL+TzCWDzgIatfXALCVR+Q1w+0FCIjVjir1KAmr6qNM7+vk
         8dhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774621869; x=1775226669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0JOlsTnwrp0NSbV+2c+o5QMBqiaEd47EO/LWfmDfIOE=;
        b=M5GlRMjLTJvtuAKghJWq/a1tReeZShKL5kQ6MBoRsUkoxplzkucvzoLWa7mm6a8Xkg
         IfOpO1M2snspVs2cbpZhjAwUnw62K8I/Sdnbx0k3NnWzBaYBjmqi0Pt+addUN1RSRexP
         rO0Zak6cqHTG8sPPT1SMoa17clsKi9hseWOjun9Sh4YLL42Jz3bdmQkH/4Xb39jr+rqh
         RCITGWIs6JaXDuemD58fap5Nm8WMuTvvYbz3/Cd3o+d3JVWqfdO+MIU7XFqsd8UnBtk5
         El0ThM3DQNA+OOdp8TXA3mv3L3R3L6qvp3KmgeTCSP1b0qkTCi0PoaDiXz/jkG/8q+re
         IF4g==
X-Gm-Message-State: AOJu0YxVbUWcqqsP04hIlwrMSMyPvbUzNNiq166jIXcYfUYqHvcvOYjZ
	OQieYdXFpzLCnJY1ZBxDAoynhK8A5VpUFQaETLmEMv8mvC97QE9P21jjycTqC1ZAiF7IcL2zemp
	kaM7xcBaulRtdiIVSj6afAfn/q+1c8/YphWL6QhTJOfZZEvykPgKorjM+8Va2MOqeYlNKnzqh3g
	5hz1KO4+0JT4pQIeKCEG3EZpfZya0P1cHnGa1nFZrOPGXF/jpE+g==
X-Gm-Gg: ATEYQzwWxbHuzzJik9TS9vkoyKUGELPmRhkn1mDAFziLpGQmpbD3FHt4liy/dHk8lVk
	F+WZBJa1rluK2doyg7hv3IKhHkhDCMytfk2YB5ebmtRtZuoBSipcoBHbwI/cOMlh7BnmNBA4gJi
	IIFyiLTzhvYGpLtAOlBbo7b+6HrO4AnTVRzKsGW2XaFbQJl+l/BA/L0Ub2/1u3BEZkjpmOrVR0M
	bhjMZAtRTqEoRTpRcMR221+yhWndNWgRsP4TQfuPSkHMHqknDOG6HJVZgZ7xGqD1eoaldYkx8eX
	5n/ws0FgzJcNM6AZ0jFYH8XwhLJ259yEUjmlWj0kn7hxwJkg7As62WQtYzeCZUh8nQNJS4sLHX1
	E8bdeez11IBdOmCMCKeQAETcxI4OcxLipe9DyL59g9Bl9ckYNW5UIvCc=
X-Received: by 2002:a05:6820:f029:b0:67e:1dee:db5 with SMTP id 006d021491bc7-67e1dee127bmr734275eaf.12.1774621869097;
        Fri, 27 Mar 2026 07:31:09 -0700 (PDT)
X-Received: by 2002:a05:6820:f029:b0:67e:1dee:db5 with SMTP id 006d021491bc7-67e1dee127bmr734236eaf.12.1774621868522;
        Fri, 27 Mar 2026 07:31:08 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e502081sm515168585a.36.2026.03.27.07.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 07:31:07 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH 09/10] ceph: send SESSION_REQUEST_CLOSE before forced teardown in manual reset
Date: Fri, 27 Mar 2026 14:30:45 +0000
Message-Id: <20260327143045.1393612-10-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260327143045.1393612-1-amarkuze@redhat.com>
References: <20260327143045.1393612-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue SESSION_REQUEST_CLOSE through the normal close-session path before
forced teardown so the MDS can release state immediately and racing
sequence updates still retransmit the close request correctly.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 8b86c577c127..864c35c6f55f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
+#include <linux/delay.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/ratelimit.h>
@@ -5391,6 +5392,33 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 	st->phase = CEPH_CLIENT_RESET_TEARDOWN;
 	spin_unlock(&st->lock);
 
+	/*
+	 * Ask each MDS to close the session before we tear it down
+	 * locally.  Without this the MDS sees only a connection drop and
+	 * waits for the client to reconnect (up to session_autoclose
+	 * seconds) before evicting the session and releasing locks.
+	 *
+	 * Reuse the normal close machinery so the session state/sequence
+	 * snapshot is serialized under s_mutex and a racing s_seq bump
+	 * retransmits REQUEST_CLOSE while the session remains CLOSING.
+	 * We send all close requests first, then yield briefly to let the
+	 * network stack transmit them before __unregister_session()
+	 * closes the connections.
+	 */
+	for (i = 0; i < n; i++) {
+		int err;
+
+		mutex_lock(&sessions[i]->s_mutex);
+		err = __close_session(mdsc, sessions[i]);
+		mutex_unlock(&sessions[i]->s_mutex);
+		if (err < 0)
+			pr_warn_client(cl,
+				       "mds%d failed to queue close request before reset: %d\n",
+				       sessions[i]->s_mds, err);
+	}
+	if (n > 0)
+		msleep(100);
+
 	/*
 	 * Tear down each session: close the connection, remove all
 	 * caps, clean up requests, then kick pending requests so they
-- 
2.34.1

