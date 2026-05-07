Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5AB3F077C
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156885; cv=none; b=EUtGB5atb6AsHZmWdZKeBbvbWIxqhz0WJxf5aH+17kCyDmn0mG3pDI0VnxPtRLk2ydIpSbIkYVgbxQRV8IbMOpKmhVxYl8zFon+dFego0FFbwl4G4mrlyeGXyOxXMXFXpB01b4nb76VJ8Cp+YcRrBCWm9mpqNyCYrnmlhkgae9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156885; c=relaxed/simple;
	bh=WjhOLO37OUy3DRn1TE5ng3ua7CXTWY8Qs3RpRBaofdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uiNJSNCf9lMnJm3u7WEwkWHab1Z9egZuVJ7lotbE3LWCXd6neJ+2Q1gHnx4JqlABnjCflQ11ianWbhdIyYUBsFPMymTFT50+duQ3FH4qIRWbY8skHmlNza1hldwLE/Tla1RDlmCLF3ga4ze8V3Q3E7zA0Jvh3Y60h9wvLToXzho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LQ8ZTwuz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbN0nVWz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LQ8ZTwuz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbN0nVWz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778156881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+iED2/yFjWeWtKsIOHFNx3B45qGsWcF6UkxSG0bS5k=;
	b=LQ8ZTwuzyLtl1StmbO8Lw5b4LoadVMvYhbQVUKZsG1R4RUXwxM/Tq76t9Ar8KGHzSF+pZ8
	7c39xlFuqiMbd7tVmbd3obihnEuQwgZoHsIRk7IFazLD0V48lwTCEWXVZ/JFisg+i3LMq7
	KEB/HKulJQAUCbjTm64Sr7SBTsEkglk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-Slo23vidMVWCheVBBWkJVA-1; Thu, 07 May 2026 08:28:00 -0400
X-MC-Unique: Slo23vidMVWCheVBBWkJVA-1
X-Mimecast-MFC-AGG-ID: Slo23vidMVWCheVBBWkJVA_1778156879
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-bc577f52c94so68304466b.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778156879; x=1778761679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+iED2/yFjWeWtKsIOHFNx3B45qGsWcF6UkxSG0bS5k=;
        b=XbN0nVWzXdj4jd0GmNpqKmY4z+ZZrzFelDEN1loBpROebDfsLloNzZ0gfAI4fFU14O
         KGzBG6NpcIpQbvr55TdHAIyqOY7EPRjl4G+cX1RYbCVi40ttzLYGY0t2ffnFxl6HoOAs
         pR3dfJeBOBn/E8kG3e7xeskWJn4N1KBsvIlfDfabIUp5/95Eopf6Tbxul0Nyid67a6mY
         SRztUSVGu0UpbLsYyXX707+5eBUxltVGx9dLZqSePiqBVB2MUaKiZOFLInEEGkThJCXw
         kkAZ7yuz9Z7StgLd62TwsJzhGAQJVmvfdjVsiSAp0vsfL+sgSqIIiIZ92qWy5taEIJS5
         ZxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156879; x=1778761679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B+iED2/yFjWeWtKsIOHFNx3B45qGsWcF6UkxSG0bS5k=;
        b=lDP3f7kqjMWs00drss25qy63QSY89J+LlBqMwcOp7HuYry/WkaiTrikHnXl/llnUZy
         6Lx4M+axTEpG47L/xo85JYLucHOgQYZNZ2ehzjiU52Lbjxl+KRyyICOCOrq0e8jE2vgD
         Dv3M+in/mb+6fk2zOm2IWHLe2MZ0iCxPTG6ZRewVReOu4WhisNDv2oz/sinnNCYpJgT0
         PaWAR6xqGOS9jIuDZLz0NQlnyzMt+rB8+EmvLZEJrm5gcFbXHQd6h4Z4r4LrHhJyQJlH
         EZfTJPIy5CEmOVvxYlC2qxZseOmctxz45ruFE+3wzOeZ/LU/HSqrMHLgYqtIfw2y3+6T
         xyqA==
X-Gm-Message-State: AOJu0YzAa5stp2tyd/5ontGOriuuvJ3oK9+rVSWeqoCSSVV0nYU8xB5v
	yHgmjlpKFqAuiNI2EQF3Q8MZY7CpSF+W9uEacm3Gr0zzQAuogzpoQYSSY3dwcdzQYcBo0KF3Q71
	izN9cCyymhjWr1rF0J94dWmErT7jVzZRdlAyYTTsJqV/9LRJ5h0o5qrFO2JXgEBqZgcKFxCeKGo
	EIOvlimMebLzh83n7iMmre/eCRWFpMjhpxo6Gx1332qRe6oGsNNA==
X-Gm-Gg: AeBDieunvG/bAmlUjVLCkZIYZocoubfXtshybNUDOWTkiukZkTsgyhpXC2ydhxW6k5a
	zCib6k3u1yi5VHQSYSu4pzg1/3j7XxAEYg+ry7gf9hYE4uD33Df9lPSzlknwHV29nx73wyu8JYG
	XyDZIxD79sBS91SwzgsCdKDDYSa9Xweyt9kQ+rrHQJZQi/ri7WTinErTeVo/2q5Jau6GHxRgoiz
	hpt8dQv4ikGDhVQ0+AOVqGL+S9/6hUBUMEOD43rfVr4aQecqSlui84SFw1G/FnR8Riff9jdlX0/
	sv5fzBvWkzrmORL4nFtFgqAQPFYBtYFhGehuuvysiANNjZ03ukcMNwSTNGLepwC4tdu+d8IiI1B
	IkVLHQdrgltp7ZAvLF3JYuJ+cOl+Jci/lRsAYFWcS7xlfbwRgt5ifSZb4sP1teNV7ng==
X-Received: by 2002:a17:907:c18:b0:bba:8587:1164 with SMTP id a640c23a62f3a-bc56c5231ecmr477101766b.15.1778156878407;
        Thu, 07 May 2026 05:27:58 -0700 (PDT)
X-Received: by 2002:a17:907:c18:b0:bba:8587:1164 with SMTP id a640c23a62f3a-bc56c5231ecmr477099666b.15.1778156877704;
        Thu, 07 May 2026 05:27:57 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc81cd34ce8sm76552566b.9.2026.05.07.05.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:27:57 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v4 11/11] selftests: ceph: wire up Ceph reset kselftests and documentation
Date: Thu,  7 May 2026 12:27:37 +0000
Message-Id: <20260507122737.2804094-12-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507122737.2804094-1-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire the CephFS reset test suite into the kselftest build:

  - Add filesystems/ceph to the top-level selftests Makefile.
  - Add the per-suite Makefile with run_validation.sh as TEST_PROGS.
  - Add the settings file (kselftest timeout).
  - Add the MAINTAINERS entry for the test directory.
  - Add README with prerequisites, usage, and troubleshooting.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 MAINTAINERS                                   |  1 +
 fs/ceph/mds_client.c                          |  3 +-
 fs/ceph/mds_client.h                          |  1 +
 tools/testing/selftests/Makefile              |  1 +
 .../selftests/filesystems/ceph/Makefile       |  7 ++
 .../testing/selftests/filesystems/ceph/README | 84 +++++++++++++++++++
 .../selftests/filesystems/ceph/settings       |  1 +
 7 files changed, 97 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/filesystems/ceph/Makefile
 create mode 100644 tools/testing/selftests/filesystems/ceph/README
 create mode 100644 tools/testing/selftests/filesystems/ceph/settings

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..bf6d973ac3fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5905,6 +5905,7 @@ B:	https://tracker.ceph.com/
 T:	git https://github.com/ceph/ceph-client.git
 F:	Documentation/filesystems/ceph.rst
 F:	fs/ceph/
+F:	tools/testing/selftests/filesystems/ceph/
 
 CERTIFICATE HANDLING
 M:	David Howells <dhowells@redhat.com>
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b16638ebff7f..3b6560da8c4e 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2359,6 +2359,7 @@ struct flush_dump_entry {
 static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	int i;
 	struct flush_dump_entry entries[CEPH_CAP_FLUSH_MAX_DUMP_ENTRIES];
 	struct ceph_cap_flush *cf;
 	int n = 0, remaining = 0;
@@ -2388,7 +2389,7 @@ static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
 
 	pr_info_client(cl, "still waiting for cap flushes through %llu:\n",
 		       want_tid);
-	for (int i = 0; i < n; i++) {
+	for (i = 0; i < n; i++) {
 		struct flush_dump_entry *e = &entries[i];
 
 		if (e->ci_null)
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index b1a0621cd37e..731d6ad04956 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -121,6 +121,7 @@ static inline bool ceph_reset_is_idle(struct ceph_client_reset_state *st)
 {
 	return READ_ONCE(st->phase) == CEPH_CLIENT_RESET_IDLE;
 }
+
 struct ceph_mds_cap_match {
 	s64 uid;  /* default to MDS_AUTH_UID_ANY */
 	u32 num_gids;
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6e59b8f63e41..ab254ae793a9 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -32,6 +32,7 @@ TARGETS += exec
 TARGETS += fchmodat2
 TARGETS += filesystems
 TARGETS += filesystems/binderfs
+TARGETS += filesystems/ceph
 TARGETS += filesystems/epoll
 TARGETS += filesystems/fat
 TARGETS += filesystems/overlayfs
diff --git a/tools/testing/selftests/filesystems/ceph/Makefile b/tools/testing/selftests/filesystems/ceph/Makefile
new file mode 100644
index 000000000000..4ad3e8d40d90
--- /dev/null
+++ b/tools/testing/selftests/filesystems/ceph/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS := run_validation.sh
+TEST_FILES := reset_stress.sh reset_corner_cases.sh \
+	      validate_consistency.py README settings
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/ceph/README b/tools/testing/selftests/filesystems/ceph/README
new file mode 100644
index 000000000000..eb0092b38f80
--- /dev/null
+++ b/tools/testing/selftests/filesystems/ceph/README
@@ -0,0 +1,84 @@
+# CephFS Client Reset Test Suite
+
+Test suite for the CephFS kernel client manual session reset feature.
+This trimmed set contains the single-client stress test, the targeted
+corner-case test, and the one-shot validation harness used during
+feature bring-up.
+
+## Prerequisites
+
+- Linux kernel with the CephFS client reset feature (this branch)
+- A running Ceph cluster with at least one MDS
+- Root access (debugfs requires it)
+- Python 3 (for validators)
+- flock utility (for lock tests, usually in util-linux)
+
+## Test inventory
+
+| Test | Script(s) | What it covers |
+|------|-----------|----------------|
+| Single-client stress | `reset_stress.sh` | I/O + resets + data integrity on one mount |
+| Corner cases | `reset_corner_cases.sh` | EBUSY, dirty caps, flock reclaim, unmount-during-reset |
+| Validation harness | `run_validation.sh` | baseline + corner cases + moderate/aggressive stress + final status check |
+
+## Quick start
+
+Stress run:
+
+    sudo ./reset_stress.sh --mount-point /mnt/cephfs --profile moderate
+
+Corner cases:
+
+    sudo ./reset_corner_cases.sh --mount-point /mnt/cephfs
+
+End-to-end validation:
+
+    sudo ./run_validation.sh --mount-point /mnt/cephfs
+
+## Stress profiles
+
+    baseline   - no resets, 1 IO + 1 rename, 600s
+    moderate   - reset every 5-15s, 2 IO + 1 rename, 900s
+    aggressive - reset every 1-5s, 4 IO + 2 rename, 900s
+    soak       - reset every 5-15s, 2 IO + 1 rename, 3600s
+
+## Key options (all scripts)
+
+    --mount-point PATH   CephFS mount point (required)
+    --client-id ID       Debugfs client id (auto-detected if one)
+
+reset_stress.sh additionally accepts:
+
+    --profile NAME       baseline|moderate|aggressive|soak
+    --duration-sec N     Override profile runtime
+    --no-reset           Disable reset injection
+    --out-dir PATH       Artifact directory
+
+## Corner case tests
+
+    [1/4] ebusy_rejection       Second reset rejected while first in-flight
+    [2/4] dirty_caps_at_reset   Reset with unflushed dirty caps
+    [3/4] flock_after_reset     Stale lock EIO + fresh lock after holder exit
+    [4/4] unmount_during_reset  umount during active reset (destroy-path wakeup)
+
+Test 4 requires creating a second CephFS mount instance and SKIPs if
+the host cannot do so.  See `--help` output for details.
+
+## Troubleshooting
+
+**No writable Ceph reset interface found:**
+Kernel lacks the reset feature, debugfs not mounted, or not root.
+Check: `ls /sys/kernel/debug/ceph/*/reset/`
+
+**Multiple Ceph clients found:**
+Use `--client-id` to select one.
+List: `ls /sys/kernel/debug/ceph/`
+
+## Files
+
+| File | Role |
+|------|------|
+| `reset_stress.sh` | Single-client stress test runner |
+| `validate_consistency.py` | Single-client post-run validator |
+| `reset_corner_cases.sh` | Corner case harness (4 sequential tests) |
+| `run_validation.sh` | One-shot validation harness |
diff --git a/tools/testing/selftests/filesystems/ceph/settings b/tools/testing/selftests/filesystems/ceph/settings
new file mode 100644
index 000000000000..79b65bdf05db
--- /dev/null
+++ b/tools/testing/selftests/filesystems/ceph/settings
@@ -0,0 +1 @@
+timeout=1200
-- 
2.34.1

