Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400124EDCCA
	for <ceph-devel@vger.kernel.org>; Fri,  9 Oct 2026 16:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564181; cv=none; b=VC+RKN7c9/yWJy7SBiyOmhKcv0YyVPiZfO6W6am3YK0Nm92RJ8ZbiDerAN3BSPhXL4mqIUqlPFN01U/isXG5tdBBzImwTORdKr/ttbgRiCBtonfAqtJBa8htPcg5nOseVV000wSPnL1B91R44k/w+1cVefD51Wz21r3r5DTzRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564181; c=relaxed/simple;
	bh=A6KWolK0c33eD41IJEvzFDyw2UiHiDjUO7E90zR5SKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EVSBh7o43ppE8QICAINYm4+tQJNOpZEkSZwE50xFHYiB8AX4RxZPUf5HweOcLof3WDLk09IhMDguOmIryvC9xUeBlpdmsN7NbbBo3wF1PfywFqzd4S2vFAz3qdT0wf/49sJU1/FRz19mR4DzQbEfxXC3K7SyusVI2rOXSk/ZdVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cmzgB6Hn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D121fsqK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmzgB6Hn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D121fsqK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791564179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NBUbfteFLCzYrrRSx4LNQmXY/h1rlH9yllKa7izm09E=;
	b=cmzgB6Hn/8PgdzrY6ghfheRlVSDycpet8ruarmCXOY3IswhAfjg3K7dXQ8ysk4lWA1IISm
	yxvWFHgZTEInM43llVm/hqnYCSz8yIWap3qpnqspzKHBaWIpRC9wUp3KgX+W8QKx/03m4A
	CddRv3bT7JnabVf1M6oxvrxFNoOSX+A=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-FVUeifeYMsiokgZozFCDng-1; Fri, 9 Oct 2026 16:42:49 +0000
X-MC-Unique: FVUeifeYMsiokgZozFCDng-1
X-Mimecast-MFC-AGG-ID: FVUeifeYMsiokgZozFCDng_1791564169
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c25edb54d22so3745766b.1
        for <ceph-devel@vger.kernel.org>; Fri, 09 Oct 2026 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791564168; x=1792168968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NBUbfteFLCzYrrRSx4LNQmXY/h1rlH9yllKa7izm09E=;
        b=D121fsqKS+mCjmFA4hnidcW98xyqN12ATTBejLExMtnLGfLKg6dLWj0SNps7el2izb
         RqxLJTdZvXMHdJPm04Zn3oYjNOnkZKAigIpCgjqwqlF5AGPSQz7NRq6cC5JMksPNHh1s
         fYAlvnaM7hDbJb3WDDMr4KzQUSKkk/SmqikM9B2o35DZrADTWKJ+7nkv83B8VHnualBR
         w4EmZq9mNnUJCStITTdBvtYIg5jLXDbLjORaayyqHGDClWstJRQqTRQgb3M5KAbv9ZY/
         UusjFAV3uHG+Jk4ykY2Kxb9uylvz9MhuLKL8kupt2tOxdzS7vBvfzBMgk5pDyCpxB6o3
         L9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564168; x=1792168968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NBUbfteFLCzYrrRSx4LNQmXY/h1rlH9yllKa7izm09E=;
        b=Vi68LHgxsC7i3YfTxbm8mJE718NAA9WPMP5UWaUhfAelxk8JXNSZCxwACPuroQKqk0
         2egVIO2TRkFNREkywoe5A3Z0WlZJhVj3rE3OOW25OSXa7FM+t5znXBwXAODvLkqCfQDY
         JvQgoDHWIygoN+H1bb49s2404x2gFWYGJDvXzcKsA5+dBwZRl/Z42gx8JZrRe8Z3d7RP
         ko6PY7kk4iksr4HWoKEEaAeIWHqUCSyH7zQkt5mQ82nZG7xB2D2koNqxzAjyr8GT5LQm
         w5G2qBOrNFc4m7rXc0+tzqFy4cz11v4LaPKhY4s7yunNWZH5fujS9t+pEn60wKSO2qha
         N/3w==
X-Gm-Message-State: AFq9FYLeRVeGIcFF78r5sapNenPXYsrJMOHDPpDnfU1e7uM/VKeJSPsQ
	qF+5Mxh1Kq2e34gjgQuhoKssLD4txJath9bWz0bFfNDbOKyaChcrt95O3LFhpnuf7qjK+k4TQXc
	9mYG5wdQDXfY+iBNcFrpnJV/9VvTmMLpBchGanPFLdw3su1EmN9LemQM2LDoBPgRpATxKKu7MSC
	ufb8vNmhGYbiL754xBckh0AM8j4B7BMEow3tMvHT0DVEpvOh6asw==
X-Gm-Gg: AYBFou27ZpLentSo1n4vmAXnDY5GyxY9ZnnHYc59VaCbbmJtodnt8A+/VI9wMhLFeoR
	Omeu+iZQNJv9RtxmRkmYkvgnGNpLwN+EhtPezCUkhRoFg0fUSYpvsSGk3cdZMLgyDOo/RnxQ8UM
	+88zQefTYhbR0O3N0NZleVpicIZEa4Y2gksQ1Yb9Otm6OB8h0cwbQBmTEDW2pE0DUBGP14TLOgh
	DOUlgHD2Bdka07SzHKe5JW+NBDMpKHcvpk6IsfZT7YFVsrFsniiEKBY0+tMDWDoVha4NYwICd+P
	Nst3J4c6CDv6hUi0actAkm7MGQvZqJEM1cpTLd507L3jAlDFSPmJjDslCK28oLVWYRiFvCmnmhc
	5P5sJzMTfD0lG9JbkdL1a0cWwDIhqkL22HemYZBsQ17liOrRZKvrWMxWZmjsAGW+shm3niobqUQ
	csaJ2o5hd1XCf0gQ==
X-Received: by 2002:a17:907:7b8a:b0:c2e:855:3375 with SMTP id a640c23a62f3a-c31aa05d48dmr264843066b.30.1791564168635;
        Fri, 09 Oct 2026 09:42:48 -0700 (PDT)
X-Received: by 2002:a17:907:7b8a:b0:c2e:855:3375 with SMTP id a640c23a62f3a-c31aa05d48dmr264840966b.30.1791564168254;
        Fri, 09 Oct 2026 09:42:48 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa8511sm120683666b.59.2026.10.09.09.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:42:47 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 1/3] ceph: add subvolume quarantine wire definitions
Date: Fri,  9 Oct 2026 16:42:43 +0000
Message-Id: <20261009164245.2483933-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009164245.2483933-1-amarkuze@redhat.com>
References: <20261009164245.2483933-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CephFS subvolume quarantine tells a client that an administrator has
isolated a subvolume. The MDS revokes caps down to PIN and sets the
MClientCaps oserrno to -EQUARANTINED (1000). When the isolation is
lifted it sends CEPH_MSG_CLIENT_QUARANTINE_DISABLE (0x315), carrying
the inode number and an errno used to clear the client-side state.

Add those definitions. EQUARANTINED is not a VFS errno; a later patch
fails applications with EACCES. Nothing advertises the feature or
consults the new message yet.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/linux/ceph/ceph_fs.h | 13 +++++++++++++
 net/ceph/ceph_common.c       |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index d70bbce1a1b2..06b07792c5ff 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -154,6 +154,7 @@ const char *ceph_con_mode_name(int mode);
 #define CEPH_MSG_CLIENT_SNAP            0x312
 #define CEPH_MSG_CLIENT_CAPRELEASE      0x313
 #define CEPH_MSG_CLIENT_QUOTA           0x314
+#define CEPH_MSG_CLIENT_QUARANTINE_DISABLE 0x315
 
 /* pool ops */
 #define CEPH_MSG_POOLOP_REPLY           48
@@ -921,4 +922,16 @@ struct ceph_mds_quota {
 	__le64 max_files;	/* quota max. files */
 } __attribute__ ((packed));
 
+/*
+ * Cap oserrno used by the MDS when a subvolume is quarantined.
+ * This is not a VFS errno; applications see -EACCES.
+ */
+#define CEPH_EQUARANTINED	1000
+
+/* MDS -> client: quarantine lifted for one inode (ino, oserrno). */
+struct ceph_mds_quarantine_disable {
+	__le64 ino;
+	__le32 oserrno;
+} __attribute__ ((packed));
+
 #endif
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 67e88f30409d..cc3d21fd7d5b 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -83,6 +83,8 @@ const char *ceph_msg_type_name(int type)
 	case CEPH_MSG_CLIENT_CAPS: return "client_caps";
 	case CEPH_MSG_CLIENT_CAPRELEASE: return "client_cap_release";
 	case CEPH_MSG_CLIENT_QUOTA: return "client_quota";
+	case CEPH_MSG_CLIENT_QUARANTINE_DISABLE:
+		return "client_quarantine_disable";
 	case CEPH_MSG_CLIENT_SNAP: return "client_snap";
 	case CEPH_MSG_CLIENT_LEASE: return "client_lease";
 	case CEPH_MSG_POOLOP_REPLY: return "poolop_reply";
-- 
2.34.1

