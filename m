Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2948C37648D
	for <ceph-devel@vger.kernel.org>; Mon,  4 May 2026 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886212; cv=none; b=bmYN5pHbx89WaK5obtYunCpjnYr5Ew0ShHqkSE+EpH7aXFhFTjkLOaSxFF6T0+yzku/L30u0PnPtT6F1bVpevCn3XHRwuocWr5bfxGgYjsFhtscqeyUgmVkDCrqs/P72yvTt2+/APfXzYsKXOeTSqmPA32Ev86rmKqIJdPrVYCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886212; c=relaxed/simple;
	bh=bjp9+6ZHh5kA2wJX5YbiN76yptloXxxSyjk/HkLLCC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGrBq05YeUED5k9He+EGnz++O+DZb2gBqnf3jOkX2cgkAQJhIJGmd+vW3dXqT2/BevDuXV9eqxYTYL5VDAuosqgP4npKYglQFdLCPdlEeiDxAcRnMaMY/TXO4ylS+v7AChxaE+6vMOAc0g36kJWuK8/k+fogjHMB4c8muNpscfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1Oe0GeI; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1Oe0GeI"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-393a49d2e5eso4284031fa.2
        for <ceph-devel@vger.kernel.org>; Mon, 04 May 2026 02:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777886209; x=1778491009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9ZzvHzMTTp2n6bNSS7kPEE/1daWHQcLfOR7eCRpzzs=;
        b=C1Oe0GeIWEd25D2EkWJUNgWMOiDmWIQTjsxrm8FRziuyT4mDNliB/G5qX7yCPuvBZw
         9EgS+NuGr3j7VJ17+BmJYlNVFBzw0DiYpchPZ+cO3ZGoKSi8y/h8IEyqaD2gHfsCrP/D
         CBxMhzeF3j5fNQtPBQWSXtk05RsXc0gEiVziHogxolCOOmF45hZMY7yqOmR+ozEvYJea
         lWJ9jbMyQcKlQJZg/H0r3V2R1oTnNoS1rNN+jzcSipLXaTIWXWEPpubaA07A3Tnb//nl
         51nxHdAayYC04hSeyE19TRlu56q6EOhtyJqQM36k9ytJNDQjekc1o2wGq0BPMksPf547
         aJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777886209; x=1778491009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t9ZzvHzMTTp2n6bNSS7kPEE/1daWHQcLfOR7eCRpzzs=;
        b=Sd8S9FMGPW5nH6EkwocnI6JWKI9tjOYpjcGUFCJiwQdlmTH5Ui+9UMaMtPRb0U021F
         DzL+G3+bg6esJAq9M0PkjJkrR8MTkUJNkxYs6qo1Z3Awqt0/VUl0Z75HETtJw+Xn/k6I
         gn2hkvghLEBk7KDLnS5U57kLb4K6uK0KdZFTOLj6yTl+lAdoS5mODmmEgMUlKw/H0Jn/
         N5mpZsDPzhFnvxh4JielylorELvSA/E8N7P8ugofSqG1htqHPKLYOBYCfGGA41/PvpD3
         tipRizrl7prATtZbOshzWVTHqBgy77XUkmd9xbvn+FaDRw0hYjQJdB0ygKHSwNZiTQRI
         Bcjw==
X-Forwarded-Encrypted: i=1; AFNElJ8szTBjSmzvkFK0KEMSyoQ50d7gtJ6mUstwk2ac6Af3DUDWclVB6kQQ36sYaQfCuSZv1eUSZS+r1QtM@vger.kernel.org
X-Gm-Message-State: AOJu0YzbSn7c6Pd7HwdaP375EvawtHauZ+687exMjUAgcr2Vvfj/H+iB
	xRTv4Eu4ayMixsdH29qx/Sy2sj5MhYqaIiGUjdb/If7twCblS7JGQ8vI
X-Gm-Gg: AeBDievK58uSlsgEhch8ZCDytMB3K0F1HoTFHhZ9Kds7WXqLG8mK3viTBtrKzePZ+WP
	V02ujOJ/3UDU9fh7t2LdE7CIR2ZtXW3HWpgHM5Nem1nKA58LYEUqa85GDUdGEsI7qK56cuj2vGR
	f/e8T4vfDkbeQgkVNH5G6a9t0ahPaanTlRLOWGT1iWowyTFYK7TQ6bVcnHI7REkhL/n7uR9hI8r
	rn+NzAipyHJ8KBDQbhVmAzS89ScCH1pYr1Oik8nVZo8lYxYpYtpD3OhpNt9RH5FOdKaUnsrvTGU
	i7FulBjLgt7m5cm4Xp8lGGNH5HuCt3DZ7bucE4ah5uEFLoNk+EtEH53sTMpoKne3eKNkEfeZesP
	mVTjK/zasMvFI7Q1+j/EW828m5m3iukvf0otiPi7PiaxasyTTgGH5Mp95zCmrA6azSTutCin7KZ
	hY74n0vrY9HFEZnP3wYOZAv3nxm+eK+CT6OLxKuIt3Nx+yaJBolu3RQoSuvjLS7v1g/CtlK1qNx
	+qdPBcClUYTm8x+HeAsXiD2oSNE22oV9ve2S2pUSg==
X-Received: by 2002:a05:6512:3ba4:b0:5a7:42e2:db4 with SMTP id 2adb3069b0e04-5a862fbd93fmr2848737e87.15.1777886208914;
        Mon, 04 May 2026 02:16:48 -0700 (PDT)
Received: from localhost.localdomain ([94.204.104.200])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a86c7a1698sm1377703e87.3.2026.05.04.02.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 02:16:48 -0700 (PDT)
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
Subject: [PATCH v4] libceph, ceph: reject oversized mon and MDS data segments
Date: Mon,  4 May 2026 13:16:35 +0400
Message-ID: <20260504091635.17215-1-mishra.dhiraj95@gmail.com>
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

 fs/ceph/mds_client.c  | 13 +++++++++++++
 net/ceph/mon_client.c | 17 +++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ed17e0023705..3b92d37983d1 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -6543,9 +6543,12 @@ static int mds_handle_auth_bad_method(struct ceph_connection *con,
 static struct ceph_msg *mds_alloc_msg(struct ceph_connection *con,
 				struct ceph_msg_header *hdr, int *skip)
 {
+	struct ceph_mds_session *s = con->private;
+	struct ceph_client *cl = s->s_mdsc->fsc->client;
 	struct ceph_msg *msg;
 	int type = (int) le16_to_cpu(hdr->type);
 	int front_len = (int) le32_to_cpu(hdr->front_len);
+	u32 data_len = le32_to_cpu(hdr->data_len);
 
 	if (con->in_msg)
 		return con->in_msg;
@@ -6558,6 +6561,16 @@ static struct ceph_msg *mds_alloc_msg(struct ceph_connection *con,
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
index d2cdc8ee3155..9f1c7ca42f36 100644
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
@@ -1545,5 +1552,15 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
 		m = ceph_msg_new(type, front_len, GFP_NOFS, false);
 	}
 
+	if (m && data_len > m->data_length) {
+		pr_warn_ratelimited("mon message data %u > prealloc %zu (%u#%llu), skipping\n",
+				    data_len, m->data_length,
+				    (unsigned int)con->peer_name.type,
+				    le64_to_cpu(con->peer_name.num));
+		ceph_msg_put(m);
+		m = NULL;
+		*skip = 1;
+	}
+
 	return m;
 }
