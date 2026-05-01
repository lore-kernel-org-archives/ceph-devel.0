Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241A3CFF56
	for <ceph-devel@vger.kernel.org>; Fri,  1 May 2026 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664254; cv=none; b=s+YJd29R684XOIjADA2Z3HMuciAU3igyYME/ZpNpGZtfnIbwVYHcdaHwqXEGvy/pfFwQg5FRLuaxiLj9BxFmxrfjrKMkHaEM+aAGfka3BjoaNB0y/98eM+nr5/Wp2KKzNv4b/qv95vXw8Hdnjt62GmN8+wAiKw1MnEyve+OWP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664254; c=relaxed/simple;
	bh=VYJbZJzslFD4b8QuqfR1IU5anj5rce7lywSdea4tNW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t9Kv4QFJZOKzcE+7dU1IdTyH5wXZH5jf3QroVLW/lQaaheACmpJG0Wimgeh6tKWr8hD5mBso9dcYfzbV+QU2i0Av9D74K1BYzbRE4599wsMcgnLN8aHFGaWJBK2P5dMJWSjQRbFZhXZpjVxW9wLxgsdOLCGG26V4I74odjn+9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYtm0Dng; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYtm0Dng"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38def541b0bso19575781fa.1
        for <ceph-devel@vger.kernel.org>; Fri, 01 May 2026 12:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777664251; x=1778269051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=84KWYYkdGr7OYA/h0dhqW+Pzo6IgELFrs8AW+9UxHKc=;
        b=kYtm0DngY2EhGQngPwJYYkTXXpBjX3du4soV9DRR0xPQ8OWCsFXZ7gvSyop1tyuIW2
         R9zjVNWEl6aOAe1RPE8z4VtLdCqZgcwfaZeqtS9qHNktJtEYYSZ7yJrMbwXkHhqe88By
         mv4QMB88DJ/r1YdjbZiEFgizW7Lvt5XRULp/7Gp4aDw8YraU63NsZwpE9drpxX6r16bT
         A057AoeXXWayhQYDrCaGlw/n4YeUlZBV0yaVb/kS9Gea3KmrDWONmFPzGa1j4NQz/859
         vVst+rHoB7xJGgZUKsZs9FGe0q32xxXCosaXRt78h9c5eN6PwYFvXmPcz9CPNxJquoKb
         Nmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777664251; x=1778269051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84KWYYkdGr7OYA/h0dhqW+Pzo6IgELFrs8AW+9UxHKc=;
        b=Fo9Sieqn39f9xguOFZQsr9DlLc3hfR7QeBFLKQ01ajLHA/+jJKfuqKa7cgS+fnFqij
         6L2U+IdubNJetKv3EEBFdCqXwaGiJ13NBdE/FFBOwJFC1EC4ebwGGamZzL4S8HXoaFa0
         jPjU8dd61NVx+4TTlGTLGpi14N7kmA8yQ/zEKIEEM+C1UXc9rUzNwGy0vlKZpJ05n1SO
         PiWpeHenHDuJp0W3cjydn3Jnoh9vr11qKIkQSHOgauKhUwbYn3WsDatnBDs/AXk9xSB+
         n8wrrAQhTuMw8/hUggBCpYlhkFCBg6nDH8ZzP8oT3hUFcFJfRjeXPJIva3OGu+VkxcyI
         yNBw==
X-Gm-Message-State: AOJu0Yz1JKh1XCQnIwqfkbsTT4+GW+LMsg6oyX6hryfbXGivIOvZP+nn
	HCjutyw/Bobn+FkZlMlA6gJv3JykkBDO2qjqCd8VXB4oOHkkEckD4Jw3
X-Gm-Gg: AeBDievbPBplXrfh9NoEcqrFxiMm+c2wSh4jb9s4O9bCP30yQacZAWf8Y2PkMgcVVq0
	sUsgMll5CYlloDI3/PF2RaBuR62Qn7Eow5ejq833LFd1b6ui+Xb1jsFuexKzT75uUwiuE5dEXHa
	Qw5+W+BcZUP7Bdo1KJ5PZZg5PVen8yxpQDcBt1DDXW4btgGHC12NWIYOibHBkskhrSfla/wlEHR
	xei5xtyK8qtxFOmhK7cdvq0gdhMws+/j+OYE68SCkdqcc6G3SC0u/Ib0NF927GFChZ7TnCEcISI
	dyB20TJ1X02pBbcoMCLtyurtalkO1E6D6wLHcH+WFsMn6yikaF9XhTOQDcBNyjdpGeK5iF77xQ6
	aYWqGSg3+haVKy1SbSJdCYQ9/Qe4uQQnC/0AUUbN3hNAJRCokVNQWnZErglchLleg2eXNHjWnWT
	cBdunWHJHmD8NxmNft3KHu2uaeLJ1PNJM6s6DSGDgJ4Oeig3x5yR0F1+z/5Hx23EWy1IGgImce+
	IUzA5fvo37AYevpGB8fvZl8UbWGwosQFm6EP7p2pXfCRiOO13JXp8yWAlZn0gxp448TOE5kwCsy
X-Received: by 2002:a05:6512:690:b0:5a4:1133:c305 with SMTP id 2adb3069b0e04-5a8631bb6famr73694e87.26.1777664250869;
        Fri, 01 May 2026 12:37:30 -0700 (PDT)
Received: from localhost.localdomain (bba-92-98-184-214.alshamil.net.ae. [92.98.184.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c22ded5sm733229e87.17.2026.05.01.12.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 12:37:28 -0700 (PDT)
From: Dhiraj Mishra <mishra.dhiraj95@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Willy Tarreau <w@1wt.eu>,
	security@kernel.org,
	Dhiraj Mishra <mishra.dhiraj95@gmail.com>
Subject: [PATCH v2] libceph: reject monitor replies with oversized data segment
Date: Fri,  1 May 2026 23:37:22 +0400
Message-ID: <20260501193722.25194-1-mishra.dhiraj95@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Monitor messages can be allocated from preallocated reply messages or
with ceph_msg_new(), both of which may provide only front-buffer storage
and no data items.  The messenger receive path copies the wire header
into the selected ceph_msg and later uses hdr.data_len to decide whether
to initialize a data cursor.

If a malicious or compromised monitor advertises a non-zero data segment
for one of these front-only replies, the receive path can call
ceph_msg_data_cursor_init() with length greater than msg->data_length and
hit its BUG_ON() checks, crashing the client kernel.

I verified the issue against v7.1-rc1-123-ge75a43c7cec4.  The msgr2
trigger path is present since commit cd1a677cad99 ("libceph, ceph:
implement msgr2.1 protocol (crc and secure modes)"), which is contained
in v5.11-rc1 and later.  The monitor allocator pattern is older, but I
have not tested older msgr1-only kernels.

A concrete trigger is a monitor connection over msgr2 after
CEPH_CON_S_OPEN where a FRAME_TAG_MESSAGE contains a monitor reply type
handled by mon_alloc_msg(), a valid front_len for that message type and
data_len = 1.  CEPH_MSG_MON_MAP is one such example: the message is
allocated with ceph_msg_new(), leaving msg->data_length and
msg->num_data_items as zero.

Reject monitor replies whose wire data segment is larger than the data
backing allocated for the selected ceph_msg, mirroring the existing OSD
reply hardening.

Fixes: cd1a677cad99 ("libceph, ceph: implement msgr2.1 protocol (crc and secure modes)")
Signed-off-by: Dhiraj Mishra <mishra.dhiraj95@gmail.com>
---
v2:
  - Resend as an inline plain-text patch.
  - Add full email address to the From and Signed-off-by identities.
  - Add ceph-devel and LKML to the recipient list when sending.

 net/ceph/mon_client.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index d2cdc8ee3155..7f2293122bba 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -712,6 +712,7 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 	struct ceph_mon_client *monc = con->private;
 	struct ceph_mon_generic_request *req;
 	u64 tid = le64_to_cpu(hdr->tid);
+	u32 data_len = le32_to_cpu(hdr->data_len);
 	struct ceph_msg *m;
 
 	mutex_lock(&monc->mutex);
@@ -720,6 +721,16 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 		dout("get_generic_reply %lld dne\n", tid);
 		*skip = 1;
 		m = NULL;
+	} else if (!req->reply) {
+		pr_warn("%s tid %llu missing reply buffer, skipping\n",
+			__func__, tid);
+		*skip = 1;
+		m = NULL;
+	} else if (data_len > req->reply->data_length) {
+		pr_warn("%s tid %llu data %u > preallocated %zu, skipping\n",
+			__func__, tid, data_len, req->reply->data_length);
+		*skip = 1;
+		m = NULL;
 	} else {
 		dout("get_generic_reply %lld got %p\n", tid, req->reply);
 		*skip = 0;
@@ -1499,6 +1510,7 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
 	struct ceph_mon_client *monc = con->private;
 	int type = le16_to_cpu(hdr->type);
 	int front_len = le32_to_cpu(hdr->front_len);
+	u32 data_len = le32_to_cpu(hdr->data_len);
 	struct ceph_msg *m = NULL;
 
 	*skip = 0;
@@ -1544,6 +1556,15 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
 		ceph_msg_put(m);
 		m = ceph_msg_new(type, front_len, GFP_NOFS, false);
 	}
+	if (m && data_len > m->data_length) {
+		pr_warn("%s data %u > prealloc %zu (%u#%llu), skipping\n",
+			__func__, data_len, m->data_length,
+			(unsigned int)con->peer_name.type,
+			le64_to_cpu(con->peer_name.num));
+		ceph_msg_put(m);
+		m = NULL;
+		*skip = 1;
+	}
 
 	return m;
 }
-- 
2.49.0

