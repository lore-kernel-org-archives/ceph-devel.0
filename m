Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318AD3FBEC9
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467161; cv=none; b=daBxYkdjb/sGMA1UJCdN3Kuo/7Ah9QHrFICwn/abVGArTx5jKLlIEZUcXjMYXtg16cAyMXLn5cZIAWrQqidl4BTZ2iqIQYLjqNj9m8MrRuEb+V3kfwyOClX2SFWJuBwCDz7iwQuvk882OdeHM37EINyTFmya7nX8MHdlwfKSYP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467161; c=relaxed/simple;
	bh=cvmRKyXcgWy+wVZel1Y334Cia/srHcuaT6Zl2noNFDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jPk6D3RbubZc4ZU1tbTC0toNyE1uo4XeXH6IXlfXmayYS3YYRpy5x9cUkdgSGoDOj7apNesU6mOALeuDwpZy/0i1pcC487gdF1nOTzUe1rkdG2wIUGHPnYpQtd7b81QQYLx3GGFQwv9tczjLh8Wwwvjj5v8YvdpYlYgc9T8Krpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U1W93mwb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rRKXeXl8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1W93mwb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rRKXeXl8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777467158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ3yFm+nsOqIg5UchE4FK+BGBUgY4XyMIBuZ7FNX6Dw=;
	b=U1W93mwbozADge2I+bfUo8ZenUUQTCEdGiVn7V0fzBfnPX8lnRoWC9NOk5pNBeURQ6pXHy
	JkDnK7z79DvYnp8QqQVfYyiLnbTgxXofplC85lcyHONbFmttEBYD9/+adT3Rg4c0QQuoV6
	4DfLzwW/jDUtd9EGsHLZl29+gjEDHmI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-qJdc_p6rOI6hqaLY9ULeFQ-1; Wed, 29 Apr 2026 08:52:36 -0400
X-MC-Unique: qJdc_p6rOI6hqaLY9ULeFQ-1
X-Mimecast-MFC-AGG-ID: qJdc_p6rOI6hqaLY9ULeFQ_1777467155
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b90bb54d034so80956566b.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 05:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777467155; x=1778071955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQ3yFm+nsOqIg5UchE4FK+BGBUgY4XyMIBuZ7FNX6Dw=;
        b=rRKXeXl8Hn3pFTZPQNNlBUDage74PCNDjzNL0M0Uml/1scAEz6jS0JHF7Tc/CYxQFp
         vWbIU9EKvI+5rwzUWPH1A+4IDTUdB4t26QBj1J26z16QVJolo7e1xcUa29rtCCnzz58L
         SYj6JM3cZeGRfaizAj8h3pn1TSsAfsPNIE/XZPN5+prSGPbKPdMmM0BMGvphl2GfC1dN
         B31F3PWXPA1awJcZUhbvdrGYq1iSfGO3codzEjWN6ZejOWOkdOy3kTX1XX/8cmc/p+9i
         CcnQ1Z/SNYYiTJHRU+ipZXNwWThxJzfjXpdxmRfCq25qO6LEPfq+vmxby1VKMPSXPBKp
         XoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467155; x=1778071955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PQ3yFm+nsOqIg5UchE4FK+BGBUgY4XyMIBuZ7FNX6Dw=;
        b=HxKpQpRtbF4Rk1czjcY9O6t5cIEo4pHucFpONgy4wOGOcWrOX0G39uuBNcRY/WoEFO
         xXuSbUhsFz91Lmxe03sBGhn7cu9QMpxh07C+pdPig9V85z0mgcQ0PSHpeCcxWfODj2xT
         U7el38P83OeQWyWRk7z3gvU1CSrhsUeELmvezZhfUJML3Gzu5kwqtzkurawL24O2OZnm
         rtzj4nkrsVNmsLyxu3Wgih+s3RTAm0FI8wA9hAmekH7D8Qcwe57ysvIQQXMvn2AJS78Q
         i+VXWfauAQlrxXqNRepcAo9ba1RNeI3VukE3FUjlmtNN/z9utMGhwmRBMzXbXEwlRZia
         4W5w==
X-Gm-Message-State: AOJu0Yx87vCNbX/Uon2H19YIzIT8mL4igPXMStZrMxHZYCLV2YQIa2eJ
	WHUxd0hALdSvEA8cl7L3/o5eWc5pvzGbmHq1yGnNVftu4HbJr0L3lw2swg2WBmnvUkSF3dI4ZyT
	HhtiTZHqimDgbDvPohT2HSJ+t/8blkGo0UeUZNOGl92NMdKnG8BQWnIotRSHPYIn0NSD5eHveRA
	Fyyyiom9s4Y1rmijjo2zrlBXhsCwr6cAxyb7k+pE8b3QanR70uYA==
X-Gm-Gg: AeBDietABrr8RMzNEWeI350hn39tFVrenR5XA2SxSm/j6BzMPh6hdziU7OLV6ToTd+9
	Mhq1uOglsgTlrrrtVG+GB76qsOT/F4BZBQyH5avT1+1lJhyj1wnLiuIdhBQmCmFjWtey8HiOVjb
	5iQgcVORBAmMEHRtW2ZCkUFcf68d2G4nJjvHQqRZ/r0ZMxcvfyJHRTOAmbh5/EE5JK892727fF+
	3awOWKPI3g7dZ6ZyLp7m5TdkK/AAcaas01lTNgrO8dm6Aj94qCVBD1GzgYalyu4d15T0UD+0oxx
	0YEv1svZh61FLRmpUP6+zJ/ecJFdzMeATxtIwTc5wLD3VaqrarA0LGk8zyojVtKjTccpwKwVt/V
	ISQpLP3so2k3l2hqWoAS+S/zBDzqg7F86sIgD/qNvZkuhP4EaEzL3VMHbU4in53ZsIA==
X-Received: by 2002:a17:907:3cc6:b0:bba:302d:6c90 with SMTP id a640c23a62f3a-bba302d6d0fmr47832366b.10.1777467154875;
        Wed, 29 Apr 2026 05:52:34 -0700 (PDT)
X-Received: by 2002:a17:907:3cc6:b0:bba:302d:6c90 with SMTP id a640c23a62f3a-bba302d6d0fmr47830466b.10.1777467154333;
        Wed, 29 Apr 2026 05:52:34 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22166a6esm680526a12.25.2026.04.29.05.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:52:33 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v3 11/11] selftests: ceph: wire up Ceph reset kselftests and documentation
Date: Wed, 29 Apr 2026 12:52:06 +0000
Message-Id: <20260429125206.1512203-12-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260429125206.1512203-1-amarkuze@redhat.com>
References: <20260429125206.1512203-1-amarkuze@redhat.com>
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
 tools/testing/selftests/Makefile              |  1 +
 .../selftests/filesystems/ceph/Makefile       |  7 ++
 .../testing/selftests/filesystems/ceph/README | 84 +++++++++++++++++++
 .../selftests/filesystems/ceph/settings       |  1 +
 5 files changed, 94 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/ceph/Makefile
 create mode 100644 tools/testing/selftests/filesystems/ceph/README
 create mode 100644 tools/testing/selftests/filesystems/ceph/settings

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f..87c36a26c1f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5917,6 +5917,7 @@ B:	https://tracker.ceph.com/
 T:	git https://github.com/ceph/ceph-client.git
 F:	Documentation/filesystems/ceph.rst
 F:	fs/ceph/
+F:	tools/testing/selftests/filesystems/ceph/
 
 CERTIFICATE HANDLING
 M:	David Howells <dhowells@redhat.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 450f13ba4cca..81c01a7062e0 100644
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

