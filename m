Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB123E7151
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181570; cv=none; b=q0cl2RZrAzkrm/1XMvzz9Wdsgf2aKdEEjDVB7t9LyH78J3IJTZHlw4qmIA6NhB7vJjaCc2XVWm1nj/WZb08K+bsLFHFQdUtowidoOYGDWR3OCLdt/ATvOAOkWB66x3yru9dloHdNEjERJEeKht/+j0WX3Su19Ox2zG6zaJqVgx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181570; c=relaxed/simple;
	bh=kH0c2VDSK24pnhVZwXR2a+FovCJSpzb1a+1sHK8BpvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wryh60Dg9PtsBN9wcqLcUs6V1LriASiDsJCtODsKQGSwKH4GDE9LWsVaYRK1EdAOX26KC6dzwB5k1ysJ1djBYVb3uO70If+yYHnnXVk/aZbn9OXKsTXM2lOtRiT35wkWPbtp0SqKQjMYjvTCt0JrIU/P4NvYJjA1Jp3Ja2o4/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdWhhavn; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdWhhavn"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3938d17d6c5so9408231fa.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778181567; x=1778786367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYp8OKwBJc9iMgiS1ViaQ6sOjDvnki6o66u8rr1zm9c=;
        b=QdWhhavnwdznf+d38tgp+1W30leHllkSwfPeqlXmjWzBvazR6DIxkdRcAVBAsMFN9W
         EmR86TnoIhvtsljVk+HZOmsWJWUlxq3TD9hMRqFaByx7NxQZ1t0K1K3O/dKUmTmRJsRj
         L6S+f/qLNOGjJBmGYo2uCl7iDz4aUuB0+8SqfhxdHIvHQvHmybKC/z1/J6AcRiKi3gUI
         1dc3ZI4pA7Vp2jbXg7C056rv79kmvXDJeJxF6Gp8Swp7lJObQj3R2/zyGnVzC8W+Kn5d
         Bsm4hq+x0mUTZ+FXVB5iP2z8nGr+ooP8XSDSCjwdByhrKqCXy+sGp62gdNpG0plI/Wst
         mKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181567; x=1778786367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UYp8OKwBJc9iMgiS1ViaQ6sOjDvnki6o66u8rr1zm9c=;
        b=Oj4UkIu6mPIXNxGYHWjPiHT3nSDhNqfPWna+lyoHV2i/9bDPARg5H3Va795lIcuMDV
         xLMisxtd80usiR8eRkWOO+vVCctacSue3om6B96/KQEqWu82Q9dgIklECmyKCQsZtn8p
         iUOEU2TWOXaHJ+K68uV4Mqzp4XhXip5v7oplwDa2QXELp4ZHuMozN3pOjnFCwZVvDOjd
         SLVuT9cBa5N9O65V5V3YNCRAkuSr4kr0i4AyW3RevwaFeWoEeoPgLfvGnkHdZo2kdXYM
         fcHTp8wt3ia1ibWLMfcd+ZCXoICQWUtyULZB1AG2po3cL/0XJxDaPodewwx1uhGZCorT
         BMjw==
X-Forwarded-Encrypted: i=1; AFNElJ9+st99aC1pkLauRy4PRfPX/5bcNrANfMcVCC77kgAGw/2cRCcH+46rX1e+YCegFLEFSUDn2lDua55i@vger.kernel.org
X-Gm-Message-State: AOJu0YwkV8pvazwPG1j/nav10a9RGmb5lOFNfv+psf/tyh8hGCVaZ56k
	5mGMivmTgjVwsWmJFGKY19BEH2xbTURsRDGPxzxb9pz4+TKKPxqBsLKw
X-Gm-Gg: AeBDies/M4tg4bt6jgYad08JfpCyv7N08yA0XZ8DwZAVvD9cio+zFqsTEBSlfjRL3vA
	MGGbiZmicK7kDL0pWRkZCBe+7B0FuAWq8MJXPou7SsHkWc7th6zKkRf6uSch/4fN0F9nPw4N2Fm
	8wOED2R0JL+HjBUimXN38CyQ9m+S9r7tFFWMhQSeEO00IPzA790K8gorM9KvtkVK4azOzc5+mHf
	9ZD6fyQzUVdJ86MefS7bV0In2NrfWlt2XngNwaxfTJegwHlSsdaAR68o/Lc9YowFqb/MrQcs8TD
	hUiyqS4NklFdC3TL8GtG0OvlJHnharTgWK5FO30bT6Xsj8YugSiBb71djd/oOifgWslUhb6JBkg
	SGVOOde6T31QTbpazA+FMc3zrM3tIAtNzzjt/KasnOM3MMcfJXKoAJfhmY1Bls22NiWB4iDp+vh
	U950YfPmMwrPjj7t2KcRGuwqrQq0le+4u3Ia070TZOOt6Gqxh+hYy4BDQW+hzLvp2HeZYyte4qk
	0i2OZscTyf6Cx9j
X-Received: by 2002:a2e:9a14:0:b0:38d:fca1:4a6c with SMTP id 38308e7fff4ca-393c41c7591mr36921581fa.17.1778181566568;
        Thu, 07 May 2026 12:19:26 -0700 (PDT)
Received: from localhost.localdomain ([87.201.39.98])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393ef2c3e24sm1646721fa.20.2026.05.07.12.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:19:25 -0700 (PDT)
From: Dhiraj Mishra <mishra.dhiraj95@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Willy Tarreau <w@1wt.eu>,
	security@kernel.org,
	Dhiraj Mishra <mishra.dhiraj95@gmail.com>
Subject: [PATCH v5] libceph, ceph: reject oversized mon and MDS data segments
Date: Thu,  7 May 2026 23:19:19 +0400
Message-ID: <20260507191919.4985-1-mishra.dhiraj95@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <3fb2610b-5240-41ff-a5d9-699a445dffd3@tu-ilmenau.de>
References: <3fb2610b-5240-41ff-a5d9-699a445dffd3@tu-ilmenau.de>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Monitor and MDS messages can be allocated with only front-buffer storage
and no data items.  The messenger receive path copies the wire header
into the selected ceph_msg and later uses hdr.data_len to decide whether
to initialize a data cursor.

If a malicious or compromised peer advertises a non-zero data segment for
one of these front-only messages, the receive path can call
ceph_msg_data_cursor_init() with length greater than msg->data_length and
hit its BUG_ON() checks, crashing the client kernel.

I verified the monitor issue against v7.1-rc1-123-ge75a43c7cec4.  The
msgr2 trigger path is present since commit cd1a677cad99 ("libceph,
ceph: implement msgr2.1 protocol (crc and secure modes)"), which is
contained in v5.11-rc1 and later.  The allocator patterns are older, but
I have not tested older msgr1-only kernels.

A concrete monitor trigger is a monitor connection over msgr2 after
CEPH_CON_S_OPEN where a FRAME_TAG_MESSAGE contains a monitor reply type
handled by mon_alloc_msg(), a valid front_len for that message type and
data_len = 1.  CEPH_MSG_MON_MAP is one such example: the message is
allocated with ceph_msg_new(), leaving msg->data_length and
msg->num_data_items as zero.

The MDS allocation path has the same issue: mds_alloc_msg() allocates the
incoming message with ceph_msg_new(type, front_len, GFP_NOFS, false),
leaving msg->data_length as zero for a front-only message selected from
an attacker-controlled wire header.

Reject monitor and MDS messages whose wire data segment is larger than
the data backing allocated for the selected ceph_msg, mirroring the
existing OSD reply hardening.

Fixes: 53ded495c6ac ("libceph: define mds_alloc_msg() method")
Fixes: cd1a677cad99 ("libceph, ceph: implement msgr2.1 protocol (crc and secure modes)")
Signed-off-by: Dhiraj Mishra <mishra.dhiraj95@gmail.com>
---
v5:
  - Restructure mon_alloc_msg() control flow per review.
  - Return early for unknown types and front-buffer reallocation failure.
  - Keep the data_len guard on the final message allocation.

v4:
  - Add the same oversized data_len guard to the MDS allocation path.

v3:
  - Remove the impossible !req->reply check for generic requests.
  - Use pr_warn_ratelimited() for malicious-monitor log spam resistance.
  - Avoid adding __func__ to the new mon_client warnings.
  - Add a blank line between the front_len and data_len checks.

v2:
  - Resend as an inline plain-text patch.
  - Add full email address to the From and Signed-off-by identities.
  - Add ceph-devel and LKML to the recipient list when sending.

 fs/ceph/mds_client.c  | 16 ++++++++++++++++
 net/ceph/mon_client.c | 24 +++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ed17e0023705e6d4e387ff7e5bd7fb53efdbaeb7..c84d12384717bbcaad369f353b00ccb8a7f2fcb0 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6543,13 +6543,19 @@ static int mds_handle_auth_bad_method(struct ceph_connection *con,
 static struct ceph_msg *mds_alloc_msg(struct ceph_connection *con,
 				struct ceph_msg_header *hdr, int *skip)
 {
+	struct ceph_mds_session *s;
+	struct ceph_client *cl;
 	struct ceph_msg *msg;
 	int type = (int) le16_to_cpu(hdr->type);
 	int front_len = (int) le32_to_cpu(hdr->front_len);
+	u32 data_len = le32_to_cpu(hdr->data_len);
 
 	if (con->in_msg)
 		return con->in_msg;
 
+	s = con->private;
+	cl = s->s_mdsc->fsc->client;
+
 	*skip = 0;
 	msg = ceph_msg_new(type, front_len, GFP_NOFS, false);
 	if (!msg) {
@@ -6558,6 +6564,16 @@ static struct ceph_msg *mds_alloc_msg(struct ceph_connection *con,
 		return NULL;
 	}
 
+	if (data_len > msg->data_length) {
+		pr_warn_ratelimited_client(cl,
+					   "mds%d message data %u > prealloc %zu, skipping\n",
+					   s->s_mds, data_len,
+					   msg->data_length);
+		ceph_msg_put(msg);
+		*skip = 1;
+		return NULL;
+	}
+
 	return msg;
 }
 
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index d2cdc8ee31551eb99ad062f191ac3cf984970130..66c0d6d6b33d37a25141117845b0f804664540ef 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -712,6 +712,7 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 	struct ceph_mon_client *monc = con->private;
 	struct ceph_mon_generic_request *req;
 	u64 tid = le64_to_cpu(hdr->tid);
+	u32 data_len = le32_to_cpu(hdr->data_len);
 	struct ceph_msg *m;
 
 	mutex_lock(&monc->mutex);
@@ -720,6 +721,11 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
 		dout("get_generic_reply %lld dne\n", tid);
 		*skip = 1;
 		m = NULL;
+	} else if (data_len > req->reply->data_length) {
+		pr_warn_ratelimited("mon generic reply tid %llu data %u > preallocated %zu, skipping\n",
+				    tid, data_len, req->reply->data_length);
+		*skip = 1;
+		m = NULL;
 	} else {
 		dout("get_generic_reply %lld got %p\n", tid, req->reply);
 		*skip = 0;
@@ -1499,6 +1505,7 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
 	struct ceph_mon_client *monc = con->private;
 	int type = le16_to_cpu(hdr->type);
 	int front_len = le32_to_cpu(hdr->front_len);
+	u32 data_len = le32_to_cpu(hdr->data_len);
 	struct ceph_msg *m = NULL;
 
 	*skip = 0;
@@ -1536,13 +1543,28 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
 	if (!m) {
 		pr_info("alloc_msg unknown type %d\n", type);
 		*skip = 1;
-	} else if (front_len > m->front_alloc_len) {
+		return m;
+	}
+
+	if (front_len > m->front_alloc_len) {
 		pr_warn("mon_alloc_msg front %d > prealloc %d (%u#%llu)\n",
 			front_len, m->front_alloc_len,
 			(unsigned int)con->peer_name.type,
 			le64_to_cpu(con->peer_name.num));
 		ceph_msg_put(m);
 		m = ceph_msg_new(type, front_len, GFP_NOFS, false);
+		if (!m)
+			return m;
+	}
+
+	if (data_len > m->data_length) {
+		pr_warn_ratelimited("mon message data %u > prealloc %zu (%u#%llu), skipping\n",
+				    data_len, m->data_length,
+				    (unsigned int)con->peer_name.type,
+				    le64_to_cpu(con->peer_name.num));
+		ceph_msg_put(m);
+		m = NULL;
+		*skip = 1;
 	}
 
 	return m;
-- 
2.54.0
