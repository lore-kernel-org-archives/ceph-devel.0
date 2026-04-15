Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4FE3E5595
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272493; cv=none; b=egyGVM4E8/k/XkHeKD+HJ2RNHEa1DS3F9IXoRjO4XAOitNBsnHXQw2UA8PBkEH4WffKuEfqCEdIhtDEc7Rly7+iBJJcSEmGB6ujXR2Ja6tDhNQ/fnVc63MoDq6mFyWJ9bI6ryK2ggYqFJVgXVG4bttGuwlqQsAZbMLc710URN/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272493; c=relaxed/simple;
	bh=8gT6vokTWEKbUxvLqk4CByx7e5d1SpvfNxrx6daGEGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIjli3DDVuTLF7vG33dbQBgOTuUwyle4eQB42zqO59kEfo2Rhltub2cKswyF6fAACifmdbiE2zp7r//kyzFz4feOEt0yGRXX4ADys90twkOrpqY/z0yY2T2gl/+SVM/xBIS7eF8c56d38o7TbvNS5G9YlFYd7EJm63WiepeP9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1K6R62k; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUSai7Pj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1K6R62k";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUSai7Pj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776272485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfxCWVgPSKWyOh8SVRbUsC8uFGpJNNAuHhK4HXyyfX4=;
	b=S1K6R62kFDn9TRPf/8ttBJ9NptIN6EJglwlj1P1w+ThdkZCt/TrSpqAtaxm4FdE+yZxfV1
	cqLN4OmbOP7VdkEtN+07ItqWFjt4UI0FPFVwrAGdND8BJHQb0Vl6GFJvHZmMC7VNpVx7PT
	sxJLo8Og2IqdlPFP2d+XLOOgjdHie7c=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-YRm6U4nmO-6KeWDvxgPs_A-1; Wed, 15 Apr 2026 13:01:24 -0400
X-MC-Unique: YRm6U4nmO-6KeWDvxgPs_A-1
X-Mimecast-MFC-AGG-ID: YRm6U4nmO-6KeWDvxgPs_A_1776272483
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6921f42fdc1so3133821eaf.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776272483; x=1776877283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfxCWVgPSKWyOh8SVRbUsC8uFGpJNNAuHhK4HXyyfX4=;
        b=jUSai7PjFc42SO74/QT+Gu5/U3uEZWxHgCwSwlZvhmSiFGGk60QAdifbgghadmecb/
         m+arWmqFI6xKJ/E6/g86mPgB6DGwebp4j1n6AAZyNINrtNYT6uiMt5Cj50ORjl2Bj17P
         D9unPaAs30eJoH9/s7KtRcSutztrEuxVatybkZxgyF04STTphUdgj3JOKVkcc7XD8QTr
         l/5jJgPO25Td6VtHwI+oMQm2eeLeZRwqSFSgZ9Sts9cx1a9vjgnBTzzQuektiArA9Dyh
         PU3zPLCWnD+QqhH54zy7D9DhBpRiFErpDXsH365UI2Q2EqS9E9aARm7Z+2v+VaScexPW
         ROKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776272483; x=1776877283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BfxCWVgPSKWyOh8SVRbUsC8uFGpJNNAuHhK4HXyyfX4=;
        b=cX9mASPNQgk74M1Y4xMsDxxXM3sYwKT+nO6Zos3Sl0xhhdL1cBpxEBRnDZ1pE4WDEm
         QJqDvWqvZpCTQ0FPl3xq+mGEmDHomLkyg95mPL4nUrCqYnB10G+w1/ZdnktKi0OBdvyV
         Mez/A3dKDe/flF/wSpE5ld0DPgNGlU62dpWs1sVrEYjy9kW3BLBmCnrwbR8HUYWufSSa
         vnYlHI5T5zAv7AS4tfZuyUkVftbqxAUJxpV3ddZmGy1mdYfzS7b27wwB74qH3Z0cQcLA
         JCT09s3FZ1sH/LpOSD9aZk9aPdsHb5IWvaB/P+YCj+I8wppUEhuKfRfh/El+deNe1Ca0
         R3iQ==
X-Gm-Message-State: AOJu0Yy5gNd85bITJ5zX9V9HEFF7JwzTXJyRoKvYeDw0/BzGpPIvT/so
	C4tv0QeDzIccUDxwlEbTrJ1dlMxB9eU6VnEtlCW9vuNUG/jsppfEm+JdHQ1gFc+oOJdz8Yhr2Ym
	ortfQgFgfeMTh6CuGystbi5Tk4j0Rupufa50sjrQGAJbgCnqOHrP019EOcpP/Hk+cGSzIpGMvBk
	sJsplSi2/F1lAqFstXmsSJ9+mos22hPVoodLuDCVsDz6rH/vus/w==
X-Gm-Gg: AeBDieu6RMchM0Wlcsru6F3PpHZIIPaEGVBioz9lvjaYyoH2NWpAfi//tlf0BbPuE4b
	WCHG2vBXDJTmZ9WPem3CXupoY5Qr9SOhbvKQbkrVyJjKLrDlZ3vZVCUOlUbSAq+Lw+8QW8Fwem/
	bFcyirfgHv6+DA49PX2qGY/RGbQYhbIt951Ht7AfX8DaNDwFVnQe/SkOyrhL3greIr+aS25y5Yb
	HnZdUn3/MC4VihRIodvPPYffoJNxmjMi4nuuG4b/+Q5iCvOZp6cfbmn0UCIthSPjSY4UbV8Tvr/
	w3wBsCzQurapNyMXlYlC/hWYxqKNbufODH6hfveRgQl63VFshV9Rv7rut1q/7vWNzj2mxviurCz
	qzdHJZRPe3b3MNENkJMN2B6ZM94IePrrRZFSF/0OJYT3gJTWd6FwEEhMg63dlur2pbA==
X-Received: by 2002:a05:6820:168d:b0:68a:d414:b428 with SMTP id 006d021491bc7-68be8fcba82mr11040537eaf.59.1776272480641;
        Wed, 15 Apr 2026 10:01:20 -0700 (PDT)
X-Received: by 2002:a05:6820:168d:b0:68a:d414:b428 with SMTP id 006d021491bc7-68be8fcba82mr11040407eaf.59.1776272478882;
        Wed, 15 Apr 2026 10:01:18 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm16817841cf.16.2026.04.15.10.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:01:18 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 7/7] ceph: add manual reset selftests and validation harness
Date: Wed, 15 Apr 2026 17:00:43 +0000
Message-Id: <20260415170043.3882912-8-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415170043.3882912-1-amarkuze@redhat.com>
References: <20260415170043.3882912-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add single-client selftests and a validation wrapper for manual
client reset.

The test set covers reset stress under concurrent metadata
activity together with targeted corner cases for overlap,
dirty-state handling, stale lock behavior, and unmount while reset
is active.  A validation wrapper runs the individual stages with
watchdog timeouts and captures the final reset status for post-run
checks.

The stress validator checks failure_count in addition to
last_errno so that transient mid-run reset failures are caught
even when a later reset succeeds.

Keep the test scope intentionally focused on the shipped
single-client reset behavior so the series includes a practical
regression signal for the final design.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/filesystems/ceph/Makefile       |   7 +
 .../selftests/filesystems/ceph/README.md      |  84 +++
 .../filesystems/ceph/reset_corner_cases.sh    | 646 ++++++++++++++++
 .../filesystems/ceph/reset_stress.sh          | 694 ++++++++++++++++++
 .../filesystems/ceph/run_validation.sh        | 350 +++++++++
 .../selftests/filesystems/ceph/settings       |   1 +
 .../filesystems/ceph/validate_consistency.py  | 297 ++++++++
 9 files changed, 2081 insertions(+)
 create mode 100644 tools/testing/selftests/filesystems/ceph/Makefile
 create mode 100644 tools/testing/selftests/filesystems/ceph/README.md
 create mode 100755 tools/testing/selftests/filesystems/ceph/reset_corner_cases.sh
 create mode 100755 tools/testing/selftests/filesystems/ceph/reset_stress.sh
 create mode 100755 tools/testing/selftests/filesystems/ceph/run_validation.sh
 create mode 100644 tools/testing/selftests/filesystems/ceph/settings
 create mode 100755 tools/testing/selftests/filesystems/ceph/validate_consistency.py

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
index 000000000000..3ad768bc8420
--- /dev/null
+++ b/tools/testing/selftests/filesystems/ceph/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS := run_validation.sh
+TEST_FILES := reset_stress.sh reset_corner_cases.sh \
+	      validate_consistency.py README.md settings
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/ceph/README.md b/tools/testing/selftests/filesystems/ceph/README.md
new file mode 100644
index 000000000000..47931edf52b0
--- /dev/null
+++ b/tools/testing/selftests/filesystems/ceph/README.md
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
+    [4/4] unmount_during_reset  umount during active reset (ESHUTDOWN path)
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
diff --git a/tools/testing/selftests/filesystems/ceph/reset_corner_cases.sh b/tools/testing/selftests/filesystems/ceph/reset_corner_cases.sh
new file mode 100755
index 000000000000..a6dae84a616d
--- /dev/null
+++ b/tools/testing/selftests/filesystems/ceph/reset_corner_cases.sh
@@ -0,0 +1,646 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# CephFS client reset corner case tests.
+# Runs a checklist of targeted tests that exercise specific reset
+# code paths not covered by the stress tests.
+#
+# Requires: mounted CephFS, debugfs access (root), flock(1) utility.
+
+set -uo pipefail
+
+KSFT_SKIP=4
+
+# kselftest auto-detect: when invoked with no arguments (e.g. by
+# "make run_tests"), find a CephFS mount automatically or skip.
+if [[ $# -eq 0 ]]; then
+	MOUNT_POINT="$(findmnt -t ceph -n -o TARGET 2>/dev/null | head -1)"
+	if [[ -z "$MOUNT_POINT" ]]; then
+		echo "SKIP: No CephFS mount found and --mount-point not specified"
+		exit "$KSFT_SKIP"
+	fi
+	exec "$0" --mount-point "$MOUNT_POINT"
+fi
+
+MOUNT_POINT=""
+DEBUGFS_ROOT="/sys/kernel/debug/ceph"
+DEBUGFS_CLIENT=""
+TRIGGER_PATH=""
+STATUS_PATH=""
+TEMP_MNT=""
+
+PASS_COUNT=0
+FAIL_COUNT=0
+SKIP_COUNT=0
+TOTAL=4
+
+log()
+{
+	printf '[%s] %s\n' "$(date -u +%H:%M:%S)" "$1"
+}
+
+result()
+{
+	local num="$1"
+	local name="$2"
+	local status="$3"
+	local detail="${4:-}"
+
+	case "$status" in
+	PASS) PASS_COUNT=$((PASS_COUNT + 1)) ;;
+	FAIL) FAIL_COUNT=$((FAIL_COUNT + 1)) ;;
+	SKIP) SKIP_COUNT=$((SKIP_COUNT + 1)) ;;
+	esac
+
+	if [[ -n "$detail" ]]; then
+		printf '[%d/%d] %-30s %s  (%s)\n' "$num" "$TOTAL" "$name" "$status" "$detail"
+	else
+		printf '[%d/%d] %-30s %s\n' "$num" "$TOTAL" "$name" "$status"
+	fi
+}
+
+read_status_field()
+{
+	local field="$1"
+	awk -F': ' -v key="$field" '$1 == key {print $2}' "$STATUS_PATH" 2>/dev/null
+}
+
+wait_reset_done()
+{
+	local timeout="${1:-30}"
+	local elapsed=0
+
+	while [[ "$(read_status_field "phase")" != "idle" ]]; do
+		sleep 1
+		elapsed=$((elapsed + 1))
+		if [[ "$elapsed" -ge "$timeout" ]]; then
+			return 1
+		fi
+	done
+	return 0
+}
+
+list_reset_clients()
+{
+	local entry
+
+	for entry in "$DEBUGFS_ROOT"/*/; do
+		entry="$(basename "$entry")"
+		[[ -d "$DEBUGFS_ROOT/$entry/reset" ]] || continue
+		[[ -w "$DEBUGFS_ROOT/$entry/reset/trigger" ]] || continue
+		printf '%s\n' "$entry"
+	done
+}
+
+wait_status_nonidle()
+{
+	local status_path="$1"
+	local timeout="${2:-10}"
+	local polls=$((timeout * 10))
+	local phase
+
+	while [[ "$polls" -gt 0 ]]; do
+		phase="$(awk -F': ' '$1 == "phase" {print $2}' "$status_path" 2>/dev/null)"
+		if [[ -n "$phase" && "$phase" != "idle" ]]; then
+			return 0
+		fi
+		sleep 0.1
+		polls=$((polls - 1))
+	done
+
+	return 1
+}
+
+discover_debugfs()
+{
+	local candidates=()
+	local entry
+
+	if [[ -n "$DEBUGFS_CLIENT" ]]; then
+		if [[ ! -d "$DEBUGFS_ROOT/$DEBUGFS_CLIENT/reset" ]]; then
+			echo "SKIP: reset debugfs not found for $DEBUGFS_CLIENT" >&2
+			exit "$KSFT_SKIP"
+		fi
+		return 0
+	fi
+
+	for entry in "$DEBUGFS_ROOT"/*/; do
+		entry="$(basename "$entry")"
+		[[ -d "$DEBUGFS_ROOT/$entry/reset" ]] || continue
+		[[ -w "$DEBUGFS_ROOT/$entry/reset/trigger" ]] || continue
+		candidates+=("$entry")
+	done
+
+	if [[ ${#candidates[@]} -eq 0 ]]; then
+		echo "SKIP: No writable Ceph reset interface found under $DEBUGFS_ROOT" >&2
+		exit "$KSFT_SKIP"
+	fi
+
+	if [[ ${#candidates[@]} -gt 1 ]]; then
+		echo "SKIP: Multiple Ceph clients found: ${candidates[*]}. Use --client-id." >&2
+		exit "$KSFT_SKIP"
+	fi
+
+	DEBUGFS_CLIENT="${candidates[0]}"
+}
+
+# --- Test 1: ebusy_rejection ------------------------------------------------
+#
+# Trigger a reset while another is guaranteed in-flight.  Creates
+# dirty state so the first reset enters DRAINING (which takes
+# measurable time), then polls until phase != idle and issues the
+# second trigger.  The second trigger must fail (the kernel returns
+# -EBUSY), and only one reset must be counted in the accounting.
+
+test_ebusy_rejection()
+{
+	local num=1
+	local name="ebusy_rejection"
+	local testfile="$MOUNT_POINT/.reset_corner_ebusy_$$"
+	local tc_before tc_after sc_before sc_after second_rc phase elapsed
+
+	tc_before="$(read_status_field "trigger_count")"
+	sc_before="$(read_status_field "success_count")"
+
+	# Create dirty state so the first reset enters DRAINING
+	echo "ebusy_dirty_data" > "$testfile"
+	sync "$testfile"
+
+	python3 -c "
+import os, sys
+fd = os.open('$testfile', os.O_WRONLY | os.O_APPEND)
+os.write(fd, b'dirty_for_ebusy_test\n')
+sys.stdout.write('written')
+" 2>/dev/null || {
+		result "$num" "$name" FAIL "dirty write failed"
+		rm -f "$testfile"
+		return
+	}
+
+	# Trigger the first reset -- it will drain dirty state
+	echo "ebusy_first" > "$TRIGGER_PATH" 2>/dev/null || {
+		result "$num" "$name" FAIL "first trigger failed"
+		rm -f "$testfile"
+		return
+	}
+
+	# Poll until phase is non-idle (quiescing or draining)
+	elapsed=0
+	while true; do
+		phase="$(read_status_field "phase")"
+		if [[ "$phase" != "idle" ]]; then
+			break
+		fi
+		sleep 0.1
+		elapsed=$((elapsed + 1))
+		if [[ "$elapsed" -ge 50 ]]; then
+			result "$num" "$name" SKIP \
+				"first reset completed before overlap could be tested"
+			rm -f "$testfile" 2>/dev/null
+			return
+		fi
+	done
+
+	# Issue the second trigger -- should be rejected with EBUSY
+	second_rc=0
+	echo "ebusy_second" > "$TRIGGER_PATH" 2>/dev/null && second_rc=0 || second_rc=$?
+
+	if ! wait_reset_done 30; then
+		result "$num" "$name" FAIL "first reset never completed"
+		rm -f "$testfile"
+		return
+	fi
+
+	tc_after="$(read_status_field "trigger_count")"
+	sc_after="$(read_status_field "success_count")"
+
+	if [[ "$((tc_after - tc_before))" -ne 1 ]]; then
+		result "$num" "$name" FAIL "trigger_count +$((tc_after - tc_before)), expected +1"
+		rm -f "$testfile"
+		return
+	fi
+
+	if [[ "$((sc_after - sc_before))" -ne 1 ]]; then
+		result "$num" "$name" FAIL "success_count +$((sc_after - sc_before)), expected +1"
+		rm -f "$testfile"
+		return
+	fi
+
+	if [[ "$second_rc" -eq 0 ]]; then
+		result "$num" "$name" FAIL "second trigger did not return error"
+		rm -f "$testfile"
+		return
+	fi
+
+	rm -f "$testfile" 2>/dev/null
+	result "$num" "$name" PASS
+}
+
+# --- Test 2: dirty_caps_at_reset --------------------------------------------
+#
+# Write to a file without fsync (dirty caps), trigger reset, then
+# verify the file is not corrupt.  Manual reset drains dirty caps
+# before teardown (best-effort, 5s timeout).  For a non-stuck cap
+# the dirty write should be flushed during drain and persist.
+# If the drain window is too short, only the synced first line
+# persists -- that is acceptable (data loss is documented for
+# unflushed writes).
+
+test_dirty_caps_at_reset()
+{
+	local num=2
+	local name="dirty_caps_at_reset"
+	local testfile="$MOUNT_POINT/.reset_corner_dirty_caps_$$"
+	local content_after line_count sc_before sc_after le
+
+	sc_before="$(read_status_field "success_count")"
+
+	echo "line_1_before_dirty_write" > "$testfile"
+	sync "$testfile"
+
+	python3 -c "
+import os, sys
+fd = os.open('$testfile', os.O_WRONLY | os.O_APPEND)
+os.write(fd, b'line_2_dirty_no_fsync\n')
+# deliberately no fsync -- leave caps dirty
+sys.stdout.write('written')
+" 2>/dev/null || {
+		result "$num" "$name" FAIL "dirty write failed"
+		rm -f "$testfile"
+		return
+	}
+
+	echo "dirty_caps_test" > "$TRIGGER_PATH" 2>/dev/null || {
+		result "$num" "$name" FAIL "reset trigger failed"
+		rm -f "$testfile"
+		return
+	}
+
+	if ! wait_reset_done 30; then
+		result "$num" "$name" FAIL "reset did not complete"
+		rm -f "$testfile"
+		return
+	fi
+
+	sc_after="$(read_status_field "success_count")"
+	if [[ "$sc_after" -le "$sc_before" ]]; then
+		result "$num" "$name" FAIL "success_count did not increment (reset not exercised)"
+		rm -f "$testfile"
+		return
+	fi
+
+	sync "$testfile" 2>/dev/null || true
+	content_after="$(cat "$testfile" 2>/dev/null)" || {
+		result "$num" "$name" FAIL "cannot read file after reset"
+		rm -f "$testfile"
+		return
+	}
+
+	if [[ -z "$content_after" ]]; then
+		result "$num" "$name" FAIL "file is empty after reset"
+		rm -f "$testfile"
+		return
+	fi
+
+	line_count="$(echo "$content_after" | wc -l)"
+	if [[ "$line_count" -lt 1 ]]; then
+		result "$num" "$name" FAIL "file has $line_count lines, expected >= 1"
+		rm -f "$testfile"
+		return
+	fi
+
+	echo "$content_after" | head -1 | grep -q "line_1_before_dirty_write" || {
+		result "$num" "$name" FAIL "first line corrupted"
+		rm -f "$testfile"
+		return
+	}
+
+	le="$(read_status_field "last_errno")"
+	if [[ "$le" != "0" ]]; then
+		result "$num" "$name" FAIL "last_errno=$le, expected 0"
+		rm -f "$testfile"
+		return
+	fi
+
+	rm -f "$testfile"
+	result "$num" "$name" PASS "file intact ($line_count lines)"
+}
+
+# --- Test 3: flock_after_reset ----------------------------------------------
+#
+# Take an exclusive flock, trigger reset, verify stale lock state is
+# marked with CEPH_I_ERROR_FILELOCK (same-client flock attempt returns
+# EIO).  After the original holder exits (releasing the local lock
+# reference and clearing the error flag), a fresh lock can be acquired.
+#
+# The lock holder uses the fd-based flock form with exec, so killing
+# $lock_pid closes the lock fd immediately (no orphaned child with an
+# inherited fd copy that would prevent the VFS flock release).
+
+test_flock_after_reset()
+{
+	local num=3
+	local name="flock_after_reset"
+	local testfile="$MOUNT_POINT/.reset_corner_flock_$$"
+	local lock_pid probe_rc sc_before sc_after
+
+	sc_before="$(read_status_field "success_count")"
+
+	echo "flock_test_content" > "$testfile"
+	sync "$testfile"
+
+	# Hold lock via fd in a subshell; exec ensures killing $lock_pid
+	# closes the lock fd directly (no fork/child fd inheritance).
+	(
+		exec 9<"$testfile"
+		flock --exclusive --nonblock 9 || exit 1
+		exec sleep 300
+	) &
+	lock_pid=$!
+	sleep 0.5
+
+	if ! kill -0 "$lock_pid" 2>/dev/null; then
+		result "$num" "$name" FAIL "flock holder died immediately"
+		rm -f "$testfile"
+		return
+	fi
+
+	echo "flock_after_reset_test" > "$TRIGGER_PATH" 2>/dev/null || {
+		kill "$lock_pid" 2>/dev/null; wait "$lock_pid" 2>/dev/null
+		result "$num" "$name" FAIL "reset trigger failed"
+		rm -f "$testfile"
+		return
+	}
+
+	if ! wait_reset_done 30; then
+		kill "$lock_pid" 2>/dev/null; wait "$lock_pid" 2>/dev/null
+		result "$num" "$name" FAIL "reset did not complete"
+		rm -f "$testfile"
+		return
+	fi
+
+	sc_after="$(read_status_field "success_count")"
+	if [[ "$sc_after" -le "$sc_before" ]]; then
+		kill "$lock_pid" 2>/dev/null; wait "$lock_pid" 2>/dev/null
+		result "$num" "$name" FAIL "success_count did not increment"
+		rm -f "$testfile"
+		return
+	fi
+
+	# After teardown, CEPH_I_ERROR_FILELOCK is set on the inode.
+	# A same-client lock attempt should fail (EIO), NOT succeed.
+	probe_rc=0
+	flock --exclusive --nonblock "$testfile" true 2>/dev/null && probe_rc=0 || probe_rc=$?
+	if [[ "$probe_rc" -eq 0 ]]; then
+		kill "$lock_pid" 2>/dev/null; wait "$lock_pid" 2>/dev/null
+		result "$num" "$name" FAIL \
+			"same-client probe succeeded, expected EIO from stale lock state"
+		rm -f "$testfile"
+		return
+	fi
+
+	# Kill the holder -- the exec'd sleep IS $lock_pid, so killing it
+	# closes fd 9 directly.  VFS flock release fires ceph_fl_release_lock(),
+	# which decrements i_filelock_ref to 0 and clears CEPH_I_ERROR_FILELOCK.
+	kill "$lock_pid" 2>/dev/null
+	wait "$lock_pid" 2>/dev/null
+
+	# After the holder exits, a fresh lock should be acquirable.
+	# The reset teardown sends SESSION_REQUEST_CLOSE so the MDS
+	# releases locks promptly, but retry briefly in case the
+	# message races with the connection close.
+	local attempt
+	probe_rc=1
+	for attempt in 1 2 3 4 5; do
+		probe_rc=0
+		flock --exclusive --nonblock "$testfile" true 2>/dev/null \
+			&& probe_rc=0 || probe_rc=$?
+		[[ "$probe_rc" -eq 0 ]] && break
+		sleep 1
+	done
+	if [[ "$probe_rc" -ne 0 ]]; then
+		result "$num" "$name" FAIL \
+			"cannot acquire fresh lock after holder exit (rc=$probe_rc, ${attempt} attempts)"
+		rm -f "$testfile"
+		return
+	fi
+
+	# Verify file content survived
+	grep -q "flock_test_content" "$testfile" 2>/dev/null || {
+		result "$num" "$name" FAIL "file content corrupted after reset"
+		rm -f "$testfile"
+		return
+	}
+
+	rm -f "$testfile"
+	result "$num" "$name" PASS "stale lock detected, fresh lock acquired after holder exit"
+}
+
+# --- Test 4: unmount_during_reset -------------------------------------------
+#
+# Mount a fresh CephFS, trigger reset, immediately unmount. The
+# ceph_mdsc_destroy() path must wake blocked waiters with -ESHUTDOWN
+# and not hang.
+
+test_unmount_during_reset()
+{
+	local num=4
+	local name="unmount_during_reset"
+	local temp_mnt="/tmp/ceph_corner_mnt_$$"
+	local mount_opts=""
+	local mount_src=""
+	local temp_trigger=""
+	local temp_status=""
+	local temp_client=""
+	local temp_file="$temp_mnt/.reset_corner_umount_$$"
+	local phase=""
+	local trigger_ok=0
+	local attempt
+	local -a new_clients=()
+	declare -A existing_clients=()
+
+	mount_src="$(awk -v mp="$MOUNT_POINT" '$2 == mp && $3 == "ceph" {print $1; exit}' /proc/mounts 2>/dev/null)"
+	mount_opts="$(awk -v mp="$MOUNT_POINT" '$2 == mp && $3 == "ceph" {print $4; exit}' /proc/mounts 2>/dev/null)"
+
+	if [[ -z "$mount_src" ]]; then
+		result "$num" "$name" SKIP "cannot determine mount source from /proc/mounts"
+		return
+	fi
+
+	while IFS= read -r existing; do
+		[[ -n "$existing" ]] || continue
+		existing_clients["$existing"]=1
+	done < <(list_reset_clients)
+
+	mkdir -p "$temp_mnt"
+
+	if ! mount -t ceph "$mount_src" "$temp_mnt" -o "$mount_opts" 2>/dev/null; then
+		result "$num" "$name" SKIP "cannot mount additional CephFS instance"
+		rmdir "$temp_mnt" 2>/dev/null
+		return
+	fi
+
+	ls "$temp_mnt" > /dev/null 2>&1
+	sync
+	sleep 1
+
+	for attempt in $(seq 1 50); do
+		new_clients=()
+		while IFS= read -r entry; do
+			[[ -n "$entry" ]] || continue
+			if [[ -n "${existing_clients[$entry]+x}" ]]; then
+				continue
+			fi
+			new_clients+=("$entry")
+		done < <(list_reset_clients)
+
+		if [[ "${#new_clients[@]}" -eq 1 ]]; then
+			temp_client="${new_clients[0]}"
+			break
+		fi
+
+		if [[ "${#new_clients[@]}" -gt 1 ]]; then
+			break
+		fi
+
+		sleep 0.1
+	done
+
+	if [[ -z "$temp_client" ]]; then
+		umount "$temp_mnt" 2>/dev/null || umount -l "$temp_mnt" 2>/dev/null
+		rmdir "$temp_mnt" 2>/dev/null
+		result "$num" "$name" SKIP "cannot identify debugfs client for temp mount"
+		return
+	fi
+
+	if [[ "${#new_clients[@]}" -gt 1 ]]; then
+		umount "$temp_mnt" 2>/dev/null || umount -l "$temp_mnt" 2>/dev/null
+		rmdir "$temp_mnt" 2>/dev/null
+		result "$num" "$name" SKIP "multiple new debugfs clients appeared"
+		return
+	fi
+
+	temp_trigger="$DEBUGFS_ROOT/$temp_client/reset/trigger"
+	temp_status="$DEBUGFS_ROOT/$temp_client/reset/status"
+
+	echo "umount_dirty_seed" > "$temp_file" 2>/dev/null || {
+		umount "$temp_mnt" 2>/dev/null || umount -l "$temp_mnt" 2>/dev/null
+		rmdir "$temp_mnt" 2>/dev/null
+		result "$num" "$name" FAIL "cannot create dirty state on temp mount"
+		return
+	}
+	sync "$temp_file"
+	python3 -c "
+import os, sys
+fd = os.open('$temp_file', os.O_WRONLY | os.O_APPEND)
+os.write(fd, b'dirty_for_umount_test\\n')
+os.close(fd)
+" 2>/dev/null || {
+		umount "$temp_mnt" 2>/dev/null || umount -l "$temp_mnt" 2>/dev/null
+		rmdir "$temp_mnt" 2>/dev/null
+		result "$num" "$name" FAIL "cannot dirty temp mount for reset overlap"
+		return
+	}
+
+	echo "unmount_test" > "$temp_trigger" 2>/dev/null && trigger_ok=1 || trigger_ok=0
+	if [[ "$trigger_ok" -ne 1 ]]; then
+		umount "$temp_mnt" 2>/dev/null || umount -l "$temp_mnt" 2>/dev/null
+		rmdir "$temp_mnt" 2>/dev/null
+		result "$num" "$name" FAIL "cannot trigger reset on temp mount"
+		return
+	fi
+
+	if ! wait_status_nonidle "$temp_status" 10; then
+		phase="$(awk -F': ' '$1 == "phase" {print $2}' "$temp_status" 2>/dev/null)"
+		umount "$temp_mnt" 2>/dev/null || umount -l "$temp_mnt" 2>/dev/null
+		rmdir "$temp_mnt" 2>/dev/null
+		result "$num" "$name" FAIL \
+			"reset never became active before umount (phase=${phase:-unknown})"
+		return
+	fi
+
+	local umount_ok=0
+	timeout 30 umount "$temp_mnt" 2>/dev/null && umount_ok=1
+
+	if [[ "$umount_ok" -ne 1 ]]; then
+		umount -l "$temp_mnt" 2>/dev/null || true
+		rmdir "$temp_mnt" 2>/dev/null
+		result "$num" "$name" FAIL "umount hung for >30s"
+		return
+	fi
+
+	rmdir "$temp_mnt" 2>/dev/null
+
+	ls "$MOUNT_POINT" > /dev/null 2>&1 || {
+		result "$num" "$name" FAIL "original mount unhealthy after test"
+		return
+	}
+
+	result "$num" "$name" PASS
+}
+
+# --- Main --------------------------------------------------------------------
+
+usage()
+{
+	cat <<EOF
+Usage: $0 --mount-point <path> [--client-id <id>] [--debugfs-root <path>]
+
+Runs targeted corner-case tests for the CephFS client reset feature.
+Requires root (debugfs access) and a mounted CephFS filesystem.
+
+Options:
+  --mount-point PATH     CephFS mount point (required)
+  --client-id ID         Ceph debugfs client id (auto-detect if one client)
+  --debugfs-root PATH    Debugfs ceph root (default: /sys/kernel/debug/ceph)
+  --help                 Show this message
+EOF
+}
+
+main()
+{
+	while [[ $# -gt 0 ]]; do
+		case "$1" in
+		--mount-point)   MOUNT_POINT="$2"; shift 2 ;;
+		--client-id)     DEBUGFS_CLIENT="$2"; shift 2 ;;
+		--debugfs-root)  DEBUGFS_ROOT="$2"; shift 2 ;;
+		--help|-h)       usage; exit 0 ;;
+		*)               echo "Unknown option: $1" >&2; usage; exit 2 ;;
+		esac
+	done
+
+	if [[ -z "$MOUNT_POINT" ]]; then
+		echo "--mount-point is required" >&2
+		usage
+		exit 2
+	fi
+
+	if [[ ! -d "$MOUNT_POINT" ]]; then
+		echo "SKIP: Mount point does not exist: $MOUNT_POINT" >&2
+		exit "$KSFT_SKIP"
+	fi
+
+	discover_debugfs
+	TRIGGER_PATH="$DEBUGFS_ROOT/$DEBUGFS_CLIENT/reset/trigger"
+	STATUS_PATH="$DEBUGFS_ROOT/$DEBUGFS_CLIENT/reset/status"
+
+	log "CephFS client reset corner case tests"
+	log "Mount: $MOUNT_POINT"
+	log "Client: $DEBUGFS_CLIENT"
+	echo ""
+
+	test_ebusy_rejection
+	test_dirty_caps_at_reset
+	test_flock_after_reset
+	test_unmount_during_reset
+
+	echo ""
+	echo "Results: $PASS_COUNT passed, $FAIL_COUNT failed, $SKIP_COUNT skipped (of $TOTAL)"
+
+	if [[ "$FAIL_COUNT" -gt 0 ]]; then
+		exit 1
+	fi
+	exit 0
+}
+
+main "$@"
diff --git a/tools/testing/selftests/filesystems/ceph/reset_stress.sh b/tools/testing/selftests/filesystems/ceph/reset_stress.sh
new file mode 100755
index 000000000000..c503c75a5f7a
--- /dev/null
+++ b/tools/testing/selftests/filesystems/ceph/reset_stress.sh
@@ -0,0 +1,694 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# CephFS reset stress test:
+# - Runs concurrent I/O and rename workloads
+# - Triggers random client resets through debugfs
+# - Validates consistency and recovery behavior
+
+set -euo pipefail
+
+KSFT_SKIP=4
+SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+
+# kselftest auto-detect: when invoked with no arguments (e.g. by
+# "make run_tests"), find a CephFS mount automatically or skip.
+if [[ $# -eq 0 ]]; then
+	MOUNT_POINT="$(findmnt -t ceph -n -o TARGET 2>/dev/null | head -1)"
+	if [[ -z "$MOUNT_POINT" ]]; then
+		echo "SKIP: No CephFS mount found and --mount-point not specified"
+		exit "$KSFT_SKIP"
+	fi
+	exec "$0" --mount-point "$MOUNT_POINT"
+fi
+
+PROFILE="moderate"
+DURATION_SEC=""
+COOLDOWN_SEC=20
+FILE_COUNT=64
+IO_WORKERS=""
+RENAME_WORKERS=""
+MOUNT_POINT=""
+OUT_DIR=""
+CLIENT_ID=""
+DEBUGFS_ROOT="/sys/kernel/debug/ceph"
+SLO_SECONDS=30
+EXPECT_RESET=1
+DMESG_CMD=""
+SUDO=""
+
+RESET_MIN_SEC=5
+RESET_MAX_SEC=15
+
+RUN_ID="$(date +%Y%m%d-%H%M%S)"
+WORKLOAD_FLAG=""
+RESET_FLAG=""
+DATA_DIR=""
+
+IO_LOG=""
+RENAME_LOG=""
+RESET_LOG=""
+STATUS_LOG=""
+STATUS_BEFORE=""
+STATUS_FINAL=""
+DMESG_LOG=""
+SUMMARY_LOG=""
+REPORT_JSON=""
+
+RESET_PID=0
+STATUS_PID=0
+declare -a IO_WORKER_PIDS=()
+declare -a RENAME_WORKER_PIDS=()
+
+usage()
+{
+	cat <<EOF
+Usage: $0 --mount-point <cephfs_mount> [options]
+
+Required:
+  --mount-point PATH       CephFS mount point to test under
+
+Options:
+  --profile NAME           baseline|moderate|aggressive|soak (default: moderate)
+  --duration-sec N         Override profile runtime in seconds
+  --cooldown-sec N         Workload drain time after injector stop (default: 20)
+  --file-count N           Number of logical files (default: 64)
+  --io-workers N           Number of concurrent I/O workers (profile default)
+  --rename-workers N       Number of concurrent rename workers (profile default)
+  --out-dir PATH           Artifact directory (default: /tmp/ceph_reset_stress_<ts>)
+  --client-id ID           Ceph debugfs client id; auto-detect if one client exists
+  --debugfs-root PATH      Debugfs Ceph root (default: /sys/kernel/debug/ceph)
+  --slo-seconds N          Max allowed post-reset stall window (default: 30)
+  --no-reset               Disable reset injector (baseline mode helper)
+  --help                   Show this message
+
+Examples:
+  $0 --mount-point /mnt/cephfs --profile moderate
+  $0 --mount-point /mnt/cephfs --profile aggressive --duration-sec 300
+  $0 --mount-point /mnt/cephfs --profile baseline --no-reset
+EOF
+}
+
+now_ms()
+{
+	date +%s%3N
+}
+
+set_profile_defaults()
+{
+	case "$PROFILE" in
+	baseline)
+		RESET_MIN_SEC=0
+		RESET_MAX_SEC=0
+		EXPECT_RESET=0
+		: "${DURATION_SEC:=600}"
+		: "${IO_WORKERS:=1}"
+		: "${RENAME_WORKERS:=1}"
+		;;
+	moderate)
+		RESET_MIN_SEC=5
+		RESET_MAX_SEC=15
+		: "${DURATION_SEC:=900}"
+		: "${IO_WORKERS:=2}"
+		: "${RENAME_WORKERS:=1}"
+		;;
+	aggressive)
+		RESET_MIN_SEC=1
+		RESET_MAX_SEC=5
+		: "${DURATION_SEC:=900}"
+		: "${IO_WORKERS:=4}"
+		: "${RENAME_WORKERS:=2}"
+		;;
+	soak)
+		RESET_MIN_SEC=5
+		RESET_MAX_SEC=15
+		: "${DURATION_SEC:=3600}"
+		: "${IO_WORKERS:=2}"
+		: "${RENAME_WORKERS:=1}"
+		;;
+	*)
+		echo "Unknown profile: $PROFILE" >&2
+		exit 2
+		;;
+	esac
+}
+
+log_summary()
+{
+	local msg="$1"
+	printf '[%s] %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$msg" | tee -a "$SUMMARY_LOG"
+}
+
+discover_client_id()
+{
+	local candidates=()
+	local entry
+
+	if [[ -n "$CLIENT_ID" ]]; then
+		if ! $SUDO test -d "$DEBUGFS_ROOT/$CLIENT_ID/reset"; then
+			echo "SKIP: reset debugfs not found for client-id=$CLIENT_ID" >&2
+			exit "$KSFT_SKIP"
+		fi
+		return 0
+	fi
+
+	if ! $SUDO test -d "$DEBUGFS_ROOT"; then
+		echo "SKIP: Debugfs root not found: $DEBUGFS_ROOT" >&2
+		exit "$KSFT_SKIP"
+	fi
+
+	while IFS= read -r entry; do
+		$SUDO test -d "$DEBUGFS_ROOT/$entry/reset" || continue
+		$SUDO test -w "$DEBUGFS_ROOT/$entry/reset/trigger" || continue
+		candidates+=("$entry")
+	done < <($SUDO ls -1 "$DEBUGFS_ROOT" 2>/dev/null || true)
+
+	if [[ ${#candidates[@]} -eq 1 ]]; then
+		CLIENT_ID="${candidates[0]}"
+		return 0
+	fi
+
+	if [[ ${#candidates[@]} -eq 0 ]]; then
+		echo "SKIP: No writable Ceph reset interface found under $DEBUGFS_ROOT" >&2
+		exit "$KSFT_SKIP"
+	fi
+
+	echo "SKIP: Multiple Ceph clients found (${candidates[*]}). Use --client-id." >&2
+	exit "$KSFT_SKIP"
+}
+
+init_dataset()
+{
+	local i
+	mkdir -p "$DATA_DIR/A" "$DATA_DIR/B"
+
+	for ((i = 0; i < FILE_COUNT; i++)); do
+		printf 'seed logical_id=%05d ts_ms=%s\n' "$i" "$(now_ms)" > "$DATA_DIR/A/file_$(printf '%05d' "$i")"
+	done
+}
+
+io_worker()
+{
+	set +e
+	local worker_id="$1"
+	local seq=0
+	local id
+	local relpath
+	local abspath
+	local payload
+	local hash
+	local ts
+
+	while [[ -f "$WORKLOAD_FLAG" ]]; do
+		id="$(printf '%05d' $((RANDOM % FILE_COUNT)))"
+		if [[ -f "$DATA_DIR/A/file_$id" ]]; then
+			relpath="A/file_$id"
+		elif [[ -f "$DATA_DIR/B/file_$id" ]]; then
+			relpath="B/file_$id"
+		else
+			sleep 0.02
+			continue
+		fi
+
+		abspath="$DATA_DIR/$relpath"
+		alt_relpath=""
+		if [[ "$relpath" == A/* ]]; then
+			alt_relpath="B/file_$id"
+		else
+			alt_relpath="A/file_$id"
+		fi
+		alt_abspath="$DATA_DIR/$alt_relpath"
+		payload="worker=${worker_id} io_seq=${seq} id=${id} ts_ms=$(now_ms)"
+		result="$(
+			python3 - "$abspath" "$alt_abspath" "$payload" <<'PY'
+import hashlib
+import os
+import sys
+
+path = sys.argv[1]
+alt_path = sys.argv[2]
+payload = sys.argv[3]
+
+try:
+    fd = os.open(path, os.O_RDWR | os.O_APPEND)
+    actual = path
+except FileNotFoundError:
+    try:
+        fd = os.open(alt_path, os.O_RDWR | os.O_APPEND)
+        actual = alt_path
+    except FileNotFoundError:
+        sys.exit(1)
+
+try:
+    os.write(fd, (payload + "\n").encode())
+    os.fsync(fd)
+    os.lseek(fd, 0, os.SEEK_SET)
+    digest = hashlib.sha256()
+    while True:
+        chunk = os.read(fd, 1 << 20)
+        if not chunk:
+            break
+        digest.update(chunk)
+    print(actual + " " + digest.hexdigest())
+finally:
+    os.close(fd)
+PY
+		)" || {
+			sleep 0.02
+			continue
+		}
+
+		actual_abspath="${result%% *}"
+		hash="${result#* }"
+		if [[ "$actual_abspath" == "$alt_abspath" ]]; then
+			relpath="$alt_relpath"
+		fi
+
+		ts="$(now_ms)"
+		printf '%s,%s,%s,%s,%s\n' "$ts" "$seq" "$id" "$relpath" "$hash" >> "$IO_LOG"
+		seq=$((seq + 1))
+		sleep 0.02
+	done
+}
+
+rename_worker()
+{
+	set +e
+	local worker_id="$1"
+	local seq=0
+	local id
+	local src_rel
+	local dst_rel
+	local rc
+	local ts
+
+	while [[ -f "$WORKLOAD_FLAG" ]]; do
+		id="$(printf '%05d' $((RANDOM % FILE_COUNT)))"
+
+		if [[ -f "$DATA_DIR/A/file_$id" ]]; then
+			src_rel="A/file_$id"
+			dst_rel="B/file_$id"
+		elif [[ -f "$DATA_DIR/B/file_$id" ]]; then
+			src_rel="B/file_$id"
+			dst_rel="A/file_$id"
+		else
+			sleep 0.02
+			continue
+		fi
+
+		ts="$(now_ms)"
+		if mv -T "$DATA_DIR/$src_rel" "$DATA_DIR/$dst_rel" 2>/dev/null; then
+			rc=0
+		else
+			rc=$?
+		fi
+		printf '%s,%s,%s,%s,%s,%s,%s\n' "$ts" "$worker_id" "$seq" "$id" "$src_rel" "$dst_rel" "$rc" >> "$RENAME_LOG"
+		seq=$((seq + 1))
+		sleep 0.02
+	done
+}
+
+random_sleep_seconds()
+{
+	local min_sec="$1"
+	local max_sec="$2"
+	local wait_sec
+	local span
+
+	span=$((max_sec - min_sec + 1))
+	wait_sec=$((min_sec + RANDOM % span))
+	sleep "$wait_sec"
+}
+
+reset_injector()
+{
+	set +e
+	local trigger_path="$1"
+	local seq=0
+	local ts
+	local reason
+	local rc
+
+	while [[ -f "$RESET_FLAG" ]]; do
+		random_sleep_seconds "$RESET_MIN_SEC" "$RESET_MAX_SEC"
+		[[ -f "$RESET_FLAG" ]] || break
+
+		ts="$(now_ms)"
+		reason="stress_${seq}_${ts}"
+		if echo "$reason" | $SUDO tee "$trigger_path" > /dev/null 2>&1; then
+			rc=0
+		else
+			rc=$?
+		fi
+		printf '%s,%s,%s,%s\n' "$ts" "$seq" "$reason" "$rc" >> "$RESET_LOG"
+		seq=$((seq + 1))
+	done
+}
+
+status_sampler()
+{
+	set +e
+	local status_path="$1"
+	local ts
+	local kv_line
+
+	while [[ -f "$WORKLOAD_FLAG" || -f "$RESET_FLAG" ]]; do
+		ts="$(now_ms)"
+		if $SUDO test -r "$status_path"; then
+			kv_line="$($SUDO awk -F': ' 'NF>=2 {gsub(/ /, "", $1); gsub(/ /, "", $2); printf "%s=%s;", $1, $2}' "$status_path")"
+			printf '%s,%s\n' "$ts" "$kv_line" >> "$STATUS_LOG"
+		fi
+		sleep 1
+	done
+}
+
+stop_pid_with_timeout()
+{
+	local pid="$1"
+	local name="$2"
+	local timeout="$3"
+	local waited=0
+
+	if [[ "$pid" -le 0 ]]; then
+		return 0
+	fi
+
+	while kill -0 "$pid" 2>/dev/null; do
+		if (( waited >= timeout )); then
+			log_summary "Timeout waiting for $name (pid=$pid), sending SIGTERM/SIGKILL"
+			kill -TERM "$pid" 2>/dev/null || true
+			sleep 1
+			kill -KILL "$pid" 2>/dev/null || true
+			wait "$pid" 2>/dev/null || true
+			return 1
+		fi
+		sleep 1
+		waited=$((waited + 1))
+	done
+
+	wait "$pid" 2>/dev/null || true
+	return 0
+}
+
+detect_privileges()
+{
+	if [[ -r "$DEBUGFS_ROOT" ]]; then
+		SUDO=""
+	elif sudo -n true 2>/dev/null; then
+		SUDO="sudo"
+	else
+		echo "WARNING: $DEBUGFS_ROOT is not readable and passwordless sudo is not available" >&2
+		echo "WARNING: reset injection, debugfs status checks, and dmesg capture will not work" >&2
+	fi
+
+	if $SUDO dmesg > /dev/null 2>&1; then
+		DMESG_CMD="$SUDO dmesg"
+	else
+		DMESG_CMD=""
+		echo "WARNING: dmesg is not accessible; kernel errors (hung tasks) will not be detected" >&2
+	fi
+}
+
+check_dmesg()
+{
+	local start_epoch="$1"
+
+	if [[ -z "$DMESG_CMD" ]]; then
+		return 0
+	fi
+
+	if ! $DMESG_CMD --since "@$start_epoch" > "$DMESG_LOG" 2>/dev/null; then
+		if ! $DMESG_CMD > "$DMESG_LOG" 2>/dev/null; then
+			log_summary "WARNING: dmesg capture failed unexpectedly"
+			return 0
+		fi
+		log_summary "dmesg --since unsupported; captured full dmesg"
+	fi
+
+	if grep -qi "hung task" "$DMESG_LOG" 2>/dev/null; then
+		log_summary "ERROR: kernel log contains 'hung task' during test window"
+		return 1
+	fi
+
+	return 0
+}
+
+cleanup()
+{
+	rm -f "$WORKLOAD_FLAG" "$RESET_FLAG"
+	local pid
+	for pid in "${IO_WORKER_PIDS[@]}" "${RENAME_WORKER_PIDS[@]}" "$RESET_PID" "$STATUS_PID"; do
+		[[ "$pid" -gt 0 ]] 2>/dev/null && kill "$pid" 2>/dev/null || true
+	done
+	wait 2>/dev/null || true
+}
+
+parse_args()
+{
+	while [[ $# -gt 0 ]]; do
+		case "$1" in
+		--mount-point)
+			MOUNT_POINT="$2"
+			shift 2
+			;;
+		--profile)
+			PROFILE="$2"
+			shift 2
+			;;
+		--duration-sec)
+			DURATION_SEC="$2"
+			shift 2
+			;;
+		--cooldown-sec)
+			COOLDOWN_SEC="$2"
+			shift 2
+			;;
+		--file-count)
+			FILE_COUNT="$2"
+			shift 2
+			;;
+		--io-workers)
+			IO_WORKERS="$2"
+			shift 2
+			;;
+		--rename-workers)
+			RENAME_WORKERS="$2"
+			shift 2
+			;;
+		--out-dir)
+			OUT_DIR="$2"
+			shift 2
+			;;
+		--client-id)
+			CLIENT_ID="$2"
+			shift 2
+			;;
+		--debugfs-root)
+			DEBUGFS_ROOT="$2"
+			shift 2
+			;;
+		--slo-seconds)
+			SLO_SECONDS="$2"
+			shift 2
+			;;
+		--no-reset)
+			EXPECT_RESET=0
+			shift
+			;;
+		--help|-h)
+			usage
+			exit 0
+			;;
+		*)
+			echo "Unknown option: $1" >&2
+			usage
+			exit 2
+			;;
+		esac
+	done
+}
+
+main()
+{
+	local start_epoch
+	local trigger_path=""
+	local status_path=""
+	local final_rc=0
+	local reset_enabled=0
+	local i
+
+	parse_args "$@"
+
+	if [[ -z "$MOUNT_POINT" ]]; then
+		echo "--mount-point is required" >&2
+		usage
+		exit 2
+	fi
+
+	if [[ ! -d "$MOUNT_POINT" ]]; then
+		echo "SKIP: Mount point does not exist: $MOUNT_POINT" >&2
+		exit "$KSFT_SKIP"
+	fi
+
+	if ! touch "$MOUNT_POINT/.ceph_reset_test_probe" 2>/dev/null; then
+		echo "SKIP: Mount point is not writable: $MOUNT_POINT" >&2
+		exit "$KSFT_SKIP"
+	fi
+	rm -f "$MOUNT_POINT/.ceph_reset_test_probe"
+
+	if ! command -v python3 > /dev/null 2>&1; then
+		echo "SKIP: python3 is required but not found in PATH" >&2
+		exit "$KSFT_SKIP"
+	fi
+
+	if ! stat -f -c '%T' "$MOUNT_POINT" 2>/dev/null | grep -qi ceph; then
+		echo "WARNING: $MOUNT_POINT does not appear to be a CephFS mount" >&2
+	fi
+
+	detect_privileges
+
+	set_profile_defaults
+	if [[ "$EXPECT_RESET" -eq 0 ]]; then
+		PROFILE="baseline"
+		RESET_MIN_SEC=0
+		RESET_MAX_SEC=0
+	fi
+
+	if ! [[ "$IO_WORKERS" =~ ^[0-9]+$ && "$RENAME_WORKERS" =~ ^[0-9]+$ ]]; then
+		echo "io-workers and rename-workers must be integers" >&2
+		exit 2
+	fi
+
+	if [[ "$IO_WORKERS" -le 0 || "$RENAME_WORKERS" -le 0 ]]; then
+		echo "io-workers and rename-workers must be > 0" >&2
+		exit 2
+	fi
+
+	if [[ -z "$OUT_DIR" ]]; then
+		OUT_DIR="/tmp/ceph_reset_stress_${RUN_ID}"
+	fi
+	mkdir -p "$OUT_DIR"
+
+	WORKLOAD_FLAG="$OUT_DIR/workload.running"
+	RESET_FLAG="$OUT_DIR/reset.running"
+
+	DATA_DIR="$MOUNT_POINT/ceph_reset_stress_${RUN_ID}"
+	mkdir -p "$DATA_DIR"
+
+	IO_LOG="$OUT_DIR/io.log"
+	RENAME_LOG="$OUT_DIR/rename.log"
+	RESET_LOG="$OUT_DIR/reset.log"
+	STATUS_LOG="$OUT_DIR/status.log"
+	STATUS_BEFORE="$OUT_DIR/reset_status.before"
+	STATUS_FINAL="$OUT_DIR/reset_status.final"
+	DMESG_LOG="$OUT_DIR/dmesg.log"
+	SUMMARY_LOG="$OUT_DIR/summary.log"
+	REPORT_JSON="$OUT_DIR/validator_report.json"
+
+	: > "$IO_LOG"
+	: > "$RENAME_LOG"
+	: > "$RESET_LOG"
+	: > "$STATUS_LOG"
+	: > "$SUMMARY_LOG"
+
+	start_epoch="$(date +%s)"
+
+	log_summary "Starting Ceph reset stress test"
+	log_summary "Profile=$PROFILE duration=${DURATION_SEC}s cooldown=${COOLDOWN_SEC}s file_count=${FILE_COUNT} io_workers=${IO_WORKERS} rename_workers=${RENAME_WORKERS}"
+	[[ -n "$SUDO" ]] && log_summary "Using sudo for privileged operations"
+	[[ -z "$DMESG_CMD" ]] && log_summary "WARNING: dmesg not available; hung task detection disabled"
+	log_summary "Artifacts=$OUT_DIR"
+	log_summary "Data dir=$DATA_DIR"
+
+	init_dataset
+
+	if [[ "$EXPECT_RESET" -eq 1 ]]; then
+		discover_client_id
+		trigger_path="$DEBUGFS_ROOT/$CLIENT_ID/reset/trigger"
+		status_path="$DEBUGFS_ROOT/$CLIENT_ID/reset/status"
+		if ! $SUDO test -w "$trigger_path"; then
+			echo "SKIP: Reset trigger is not writable: $trigger_path" >&2
+			exit "$KSFT_SKIP"
+		fi
+		if ! $SUDO test -r "$status_path"; then
+			echo "SKIP: Reset status is not readable: $status_path" >&2
+			exit "$KSFT_SKIP"
+		fi
+		$SUDO cat "$status_path" > "$STATUS_BEFORE" || true
+		reset_enabled=1
+		log_summary "Using ceph client id: $CLIENT_ID"
+	fi
+
+	trap cleanup EXIT INT TERM
+
+	touch "$WORKLOAD_FLAG"
+	for ((i = 0; i < IO_WORKERS; i++)); do
+		io_worker "$i" &
+		IO_WORKER_PIDS+=("$!")
+	done
+
+	for ((i = 0; i < RENAME_WORKERS; i++)); do
+		rename_worker "$i" &
+		RENAME_WORKER_PIDS+=("$!")
+	done
+
+	if [[ "$reset_enabled" -eq 1 ]]; then
+		touch "$RESET_FLAG"
+		reset_injector "$trigger_path" &
+		RESET_PID=$!
+
+		status_sampler "$status_path" &
+		STATUS_PID=$!
+	fi
+
+	sleep "$DURATION_SEC"
+
+	if [[ "$reset_enabled" -eq 1 ]]; then
+		rm -f "$RESET_FLAG"
+		stop_pid_with_timeout "$RESET_PID" "reset_injector" 20 || final_rc=1
+		log_summary "Injector stopped; entering cooldown=${COOLDOWN_SEC}s"
+	fi
+
+	sleep "$COOLDOWN_SEC"
+
+	rm -f "$WORKLOAD_FLAG"
+	for i in "${!IO_WORKER_PIDS[@]}"; do
+		stop_pid_with_timeout "${IO_WORKER_PIDS[$i]}" "io_worker[$i]" 20 || final_rc=1
+	done
+	for i in "${!RENAME_WORKER_PIDS[@]}"; do
+		stop_pid_with_timeout "${RENAME_WORKER_PIDS[$i]}" "rename_worker[$i]" 20 || final_rc=1
+	done
+
+	if [[ "$reset_enabled" -eq 1 ]]; then
+		stop_pid_with_timeout "$STATUS_PID" "status_sampler" 10 || final_rc=1
+		$SUDO cat "$status_path" > "$STATUS_FINAL" || true
+	fi
+
+	if ! check_dmesg "$start_epoch"; then
+		final_rc=1
+	fi
+
+	if ! python3 "$SCRIPT_DIR/validate_consistency.py" \
+		--data-dir "$DATA_DIR" \
+		--file-count "$FILE_COUNT" \
+		--io-log "$IO_LOG" \
+		--rename-log "$RENAME_LOG" \
+		--reset-log "$RESET_LOG" \
+		--status-final "$STATUS_FINAL" \
+		--slo-seconds "$SLO_SECONDS" \
+		--report-json "$REPORT_JSON" \
+		$( [[ "$reset_enabled" -eq 1 ]] && echo "--expect-reset" ); then
+		final_rc=1
+	fi
+
+	if [[ "$final_rc" -eq 0 ]]; then
+		log_summary "PASS: stress run completed successfully"
+	else
+		log_summary "FAIL: stress run detected one or more failures"
+	fi
+
+	log_summary "Artifacts available in: $OUT_DIR"
+	exit "$final_rc"
+}
+
+main "$@"
diff --git a/tools/testing/selftests/filesystems/ceph/run_validation.sh b/tools/testing/selftests/filesystems/ceph/run_validation.sh
new file mode 100755
index 000000000000..5d521e4f9e9b
--- /dev/null
+++ b/tools/testing/selftests/filesystems/ceph/run_validation.sh
@@ -0,0 +1,350 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# CephFS client reset - single-command validation.
+# Runs all test stages in sequence with per-stage timeouts.
+# If any stage hangs (filesystem stuck, process blocked), the
+# timeout kills it and reports failure.
+#
+# Usage:
+#   sudo ./run_validation.sh --mount-point /mnt/mycephfs
+#
+# Expected output on success:
+#
+#   === CephFS Client Reset Validation ===
+#   [stage 1/5] baseline         PASS  (60s, no resets)
+#   [stage 2/5] corner_cases     PASS  (4/4 passed)
+#   [stage 3/5] moderate         PASS  (120s, resets every 5-15s)
+#   [stage 4/5] aggressive       PASS  (120s, resets every 1-5s)
+#   [stage 5/5] status_check     PASS  (phase=idle, last_errno=0)
+#
+#   RESULT: 5/5 stages passed
+#   Artifacts: /tmp/ceph_reset_validation_<timestamp>
+
+set -uo pipefail
+
+KSFT_SKIP=4
+SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
+
+# kselftest auto-detect: when invoked with no arguments (e.g. by
+# "make run_tests"), find a CephFS mount automatically or skip.
+if [[ $# -eq 0 ]]; then
+	MOUNT_POINT="$(findmnt -t ceph -n -o TARGET 2>/dev/null | head -1)"
+	if [[ -z "$MOUNT_POINT" ]]; then
+		echo "SKIP: No CephFS mount found and --mount-point not specified"
+		exit "$KSFT_SKIP"
+	fi
+	exec "$0" --mount-point "$MOUNT_POINT"
+fi
+
+MOUNT_POINT=""
+CLIENT_ID=""
+declare -a CLIENT_ARGS=()
+declare -a DEBUGFS_ARGS=()
+RUN_ID="$(date +%Y%m%d-%H%M%S)"
+OUT_DIR="/tmp/ceph_reset_validation_${RUN_ID}"
+DEBUGFS_ROOT="/sys/kernel/debug/ceph"
+
+# Timeout margins: stage runtime + cooldown + validation + safety buffer
+STAGE1_TIMEOUT=120    # 60s run + 20s cooldown + 40s buffer
+STAGE2_TIMEOUT=300    # 4 corner cases, 30s each worst case + buffer
+STAGE3_TIMEOUT=240    # 120s run + 20s cooldown + 100s buffer
+STAGE4_TIMEOUT=240    # 120s run + 20s cooldown + 100s buffer
+STAGE5_TIMEOUT=10     # just reading debugfs
+
+PASS=0
+FAIL=0
+TOTAL=5
+
+usage()
+{
+	cat <<EOF
+Usage: $0 --mount-point <cephfs_mount> [options]
+
+Required:
+  --mount-point PATH    CephFS mount point
+
+Options:
+  --out-dir PATH        Artifact directory (default: /tmp/ceph_reset_validation_<ts>)
+  --client-id ID        Ceph debugfs client id (optional)
+  --debugfs-root PATH   Debugfs Ceph root (default: /sys/kernel/debug/ceph)
+  --help                Show this message
+EOF
+}
+
+stage_result()
+{
+	local num="$1"
+	local name="$2"
+	local status="$3"
+	local detail="$4"
+
+	if [[ "$status" == "PASS" ]]; then
+		PASS=$((PASS + 1))
+	else
+		FAIL=$((FAIL + 1))
+	fi
+	printf '[stage %d/%d] %-16s %s  (%s)\n' "$num" "$TOTAL" "$name" "$status" "$detail"
+}
+
+# Run a command with a timeout. Returns 0 on success, 1 on failure/timeout.
+# Sets RUN_TIMED_OUT=1 if killed by timeout.
+#
+# The stage command runs in its own session/process group (via setsid).
+# On timeout the entire process group is killed, not just the top-level
+# script PID.  This is required because stage scripts (reset_stress.sh,
+# reset_corner_cases.sh) spawn child processes - I/O workers, rename
+# workers, reset injectors, samplers - that would otherwise survive the
+# timeout and bleed into later stages, invalidating results.
+RUN_TIMED_OUT=0
+
+run_with_timeout()
+{
+	local timeout_sec="$1"
+	local logfile="$2"
+	shift 2
+
+	RUN_TIMED_OUT=0
+
+	# Start the stage in its own session via setsid so all descendant
+	# processes share a process group that we can kill atomically.
+	# In a non-interactive script, background children are not process
+	# group leaders, so setsid(1) calls setsid(2) directly (no extra
+	# fork) and the PID we capture IS the group leader.
+	setsid "$@" > "$logfile" 2>&1 &
+	local pid=$!
+
+	# Watchdog: on timeout, kill the entire process group
+	(
+		sleep "$timeout_sec"
+		if kill -0 "$pid" 2>/dev/null; then
+			echo "TIMEOUT: stage exceeded ${timeout_sec}s, killing process group $pid" >> "$logfile"
+			kill -TERM -- -"$pid" 2>/dev/null
+			sleep 2
+			kill -KILL -- -"$pid" 2>/dev/null
+		fi
+	) &
+	local watchdog_pid=$!
+
+	# Wait for the stage command
+	wait "$pid" 2>/dev/null
+	local rc=$?
+
+	# Kill the watchdog if it's still running
+	kill "$watchdog_pid" 2>/dev/null
+	wait "$watchdog_pid" 2>/dev/null
+
+	# Check if it was killed by timeout
+	if grep -q "^TIMEOUT:" "$logfile" 2>/dev/null; then
+		RUN_TIMED_OUT=1
+		return 1
+	fi
+
+	return "$rc"
+}
+
+find_status_path()
+{
+	local entry
+
+	if [[ -n "$CLIENT_ID" ]]; then
+		if [[ -r "$DEBUGFS_ROOT/$CLIENT_ID/reset/status" ]]; then
+			echo "$DEBUGFS_ROOT/$CLIENT_ID/reset/status"
+			return 0
+		fi
+		return 1
+	fi
+
+	for entry in "$DEBUGFS_ROOT"/*/; do
+		if [[ -r "${entry}reset/status" ]]; then
+			echo "${entry}reset/status"
+			return 0
+		fi
+	done
+	return 1
+}
+
+read_status_field()
+{
+	local status_path="$1"
+	local field="$2"
+	awk -F': ' -v key="$field" '$1 == key {print $2}' "$status_path" 2>/dev/null
+}
+
+# --- Parse arguments -------------------------------------------------------
+
+while [[ $# -gt 0 ]]; do
+	case "$1" in
+	--mount-point)  MOUNT_POINT="$2"; shift 2 ;;
+	--out-dir)      OUT_DIR="$2"; shift 2 ;;
+	--client-id)    CLIENT_ID="$2"; shift 2 ;;
+	--debugfs-root) DEBUGFS_ROOT="$2"; shift 2 ;;
+	--help|-h)      usage; exit 0 ;;
+	*)              echo "Unknown option: $1" >&2; usage; exit 2 ;;
+	esac
+done
+
+if [[ -z "$MOUNT_POINT" ]]; then
+	echo "SKIP: --mount-point is required" >&2
+	usage
+	exit "$KSFT_SKIP"
+fi
+
+if [[ ! -d "$MOUNT_POINT" ]]; then
+	echo "SKIP: Mount point does not exist: $MOUNT_POINT" >&2
+	exit "$KSFT_SKIP"
+fi
+
+# Auto-detect client id when not specified, so all stages (including
+# stage 5 status check) use the same client consistently.
+if [[ -z "$CLIENT_ID" ]]; then
+	candidates=()
+	for entry in "$DEBUGFS_ROOT"/*/; do
+		name="$(basename "$entry")"
+		if [[ -r "${entry}reset/status" ]]; then
+			candidates+=("$name")
+		fi
+	done
+	if [[ ${#candidates[@]} -eq 1 ]]; then
+		CLIENT_ID="${candidates[0]}"
+	elif [[ ${#candidates[@]} -gt 1 ]]; then
+		echo "SKIP: Multiple Ceph clients found (${candidates[*]}). Use --client-id." >&2
+		exit "$KSFT_SKIP"
+	fi
+fi
+
+if [[ -n "$CLIENT_ID" ]]; then
+	CLIENT_ARGS=(--client-id "$CLIENT_ID")
+fi
+DEBUGFS_ARGS=(--debugfs-root "$DEBUGFS_ROOT")
+
+# Quick sanity: can we write to the mount?
+if ! touch "$MOUNT_POINT/.validation_probe_$$" 2>/dev/null; then
+	echo "SKIP: Mount point is not writable: $MOUNT_POINT" >&2
+	exit "$KSFT_SKIP"
+fi
+rm -f "$MOUNT_POINT/.validation_probe_$$"
+
+mkdir -p "$OUT_DIR"
+
+echo ""
+echo "=== CephFS Client Reset Validation ==="
+echo ""
+
+# --- Stage 1: Baseline (no resets) -----------------------------------------
+
+stage1_out="$OUT_DIR/stage1_baseline"
+if run_with_timeout "$STAGE1_TIMEOUT" "$stage1_out.log" \
+	"$SCRIPT_DIR/reset_stress.sh" \
+	--mount-point "$MOUNT_POINT" \
+	--profile baseline \
+	--no-reset \
+	--duration-sec 60 \
+	"${CLIENT_ARGS[@]}" \
+	"${DEBUGFS_ARGS[@]}" \
+	--out-dir "$stage1_out"; then
+	stage_result 1 "baseline" "PASS" "60s, no resets"
+elif [[ "$RUN_TIMED_OUT" -eq 1 ]]; then
+	stage_result 1 "baseline" "FAIL" "HUNG: killed after ${STAGE1_TIMEOUT}s"
+else
+	stage_result 1 "baseline" "FAIL" "see $stage1_out.log"
+fi
+
+# --- Stage 2: Corner cases -------------------------------------------------
+
+stage2_out="$OUT_DIR/stage2_corner_cases"
+mkdir -p "$stage2_out"
+if run_with_timeout "$STAGE2_TIMEOUT" "$stage2_out/output.log" \
+	"$SCRIPT_DIR/reset_corner_cases.sh" \
+	"${CLIENT_ARGS[@]}" \
+	"${DEBUGFS_ARGS[@]}" \
+	--mount-point "$MOUNT_POINT"; then
+	pass_line=$(grep -Eo '[0-9]+ passed, [0-9]+ failed, [0-9]+ skipped' "$stage2_out/output.log" | tail -1)
+	stage_result 2 "corner_cases" "PASS" "${pass_line:-all tests passed}"
+elif [[ "$RUN_TIMED_OUT" -eq 1 ]]; then
+	stage_result 2 "corner_cases" "FAIL" "HUNG: killed after ${STAGE2_TIMEOUT}s"
+else
+	fail_line=$(grep -c 'FAIL' "$stage2_out/output.log" 2>/dev/null || echo "?")
+	stage_result 2 "corner_cases" "FAIL" "${fail_line} failures, see $stage2_out/output.log"
+fi
+
+# --- Stage 3: Moderate resets -----------------------------------------------
+
+stage3_out="$OUT_DIR/stage3_moderate"
+if run_with_timeout "$STAGE3_TIMEOUT" "$stage3_out.log" \
+	"$SCRIPT_DIR/reset_stress.sh" \
+	--mount-point "$MOUNT_POINT" \
+	--profile moderate \
+	--duration-sec 120 \
+	"${CLIENT_ARGS[@]}" \
+	"${DEBUGFS_ARGS[@]}" \
+	--out-dir "$stage3_out"; then
+	stage_result 3 "moderate" "PASS" "120s, resets every 5-15s"
+elif [[ "$RUN_TIMED_OUT" -eq 1 ]]; then
+	stage_result 3 "moderate" "FAIL" "HUNG: killed after ${STAGE3_TIMEOUT}s"
+else
+	stage_result 3 "moderate" "FAIL" "see $stage3_out.log"
+fi
+
+# --- Stage 4: Aggressive resets ---------------------------------------------
+
+stage4_out="$OUT_DIR/stage4_aggressive"
+if run_with_timeout "$STAGE4_TIMEOUT" "$stage4_out.log" \
+	"$SCRIPT_DIR/reset_stress.sh" \
+	--mount-point "$MOUNT_POINT" \
+	--profile aggressive \
+	--duration-sec 120 \
+	"${CLIENT_ARGS[@]}" \
+	"${DEBUGFS_ARGS[@]}" \
+	--out-dir "$stage4_out"; then
+	stage_result 4 "aggressive" "PASS" "120s, resets every 1-5s"
+elif [[ "$RUN_TIMED_OUT" -eq 1 ]]; then
+	stage_result 4 "aggressive" "FAIL" "HUNG: killed after ${STAGE4_TIMEOUT}s"
+else
+	stage_result 4 "aggressive" "FAIL" "see $stage4_out.log"
+fi
+
+# --- Stage 5: Post-run status check ----------------------------------------
+
+status_path=""
+if status_path=$(find_status_path); then
+	phase=$(read_status_field "$status_path" "phase")
+	last_errno=$(read_status_field "$status_path" "last_errno")
+	failure_count=$(read_status_field "$status_path" "failure_count")
+	drain_timed_out=$(read_status_field "$status_path" "drain_timed_out")
+	sessions_reset=$(read_status_field "$status_path" "sessions_reset")
+	blocked=$(read_status_field "$status_path" "blocked_requests")
+
+	# Save full status
+	cat "$status_path" > "$OUT_DIR/final_status.txt" 2>/dev/null
+
+	errors=""
+	[[ "$phase" != "idle" ]] && errors="${errors}phase=$phase "
+	[[ "$last_errno" != "0" ]] && errors="${errors}last_errno=$last_errno "
+	[[ "$failure_count" != "0" && -n "$failure_count" ]] && errors="${errors}failure_count=$failure_count "
+	[[ "$blocked" != "0" ]] && errors="${errors}blocked_requests=$blocked "
+
+	if [[ -z "$errors" ]]; then
+		detail="phase=$phase, last_errno=$last_errno, failure_count=${failure_count:-0}"
+		[[ "$drain_timed_out" == "yes" ]] && detail="$detail, drain_timed_out=yes"
+		[[ -n "$sessions_reset" ]] && detail="$detail, sessions_reset=$sessions_reset"
+		stage_result 5 "status_check" "PASS" "$detail"
+	else
+		stage_result 5 "status_check" "FAIL" "$errors"
+	fi
+else
+	stage_result 5 "status_check" "FAIL" "cannot read reset/status"
+fi
+
+# --- Summary ----------------------------------------------------------------
+
+echo ""
+if [[ "$FAIL" -eq 0 ]]; then
+	echo "RESULT: $PASS/$TOTAL stages passed"
+else
+	echo "RESULT: $PASS/$TOTAL stages passed, $FAIL FAILED"
+fi
+echo "Artifacts: $OUT_DIR"
+echo ""
+
+exit "$FAIL"
diff --git a/tools/testing/selftests/filesystems/ceph/settings b/tools/testing/selftests/filesystems/ceph/settings
new file mode 100644
index 000000000000..79b65bdf05db
--- /dev/null
+++ b/tools/testing/selftests/filesystems/ceph/settings
@@ -0,0 +1 @@
+timeout=1200
diff --git a/tools/testing/selftests/filesystems/ceph/validate_consistency.py b/tools/testing/selftests/filesystems/ceph/validate_consistency.py
new file mode 100755
index 000000000000..c230a59bdb3a
--- /dev/null
+++ b/tools/testing/selftests/filesystems/ceph/validate_consistency.py
@@ -0,0 +1,297 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import argparse
+import bisect
+import hashlib
+import json
+import os
+from pathlib import Path
+
+
+def sha256_file(path: Path) -> str:
+    digest = hashlib.sha256()
+    with path.open("rb") as handle:
+        while True:
+            chunk = handle.read(1 << 20)
+            if not chunk:
+                break
+            digest.update(chunk)
+    return digest.hexdigest()
+
+
+def parse_io_log(path: Path):
+    records = []
+    if not path.exists():
+        return records
+    with path.open("r", encoding="utf-8") as handle:
+        for line_no, line in enumerate(handle, 1):
+            line = line.strip()
+            if not line:
+                continue
+            parts = line.split(",")
+            if len(parts) != 5:
+                raise ValueError(f"io log line {line_no}: expected 5 columns, got {len(parts)}")
+            ts_ms, seq, logical_id, relpath, digest = parts
+            records.append(
+                {
+                    "ts_ms": int(ts_ms),
+                    "seq": int(seq),
+                    "logical_id": int(logical_id),
+                    "relpath": relpath,
+                    "digest": digest,
+                }
+            )
+    return records
+
+
+def parse_rename_log(path: Path):
+    records = []
+    if not path.exists():
+        return records
+    with path.open("r", encoding="utf-8") as handle:
+        for line_no, line in enumerate(handle, 1):
+            line = line.strip()
+            if not line:
+                continue
+            parts = line.split(",")
+            if len(parts) == 6:
+                ts_ms, seq, logical_id, src_rel, dst_rel, rc = parts
+            elif len(parts) == 7:
+                ts_ms, worker_id, seq, logical_id, src_rel, dst_rel, rc = parts
+                _ = worker_id  # worker id is informational only
+            else:
+                raise ValueError(
+                    f"rename log line {line_no}: expected 6 or 7 columns, got {len(parts)}"
+                )
+            records.append(
+                {
+                    "ts_ms": int(ts_ms),
+                    "seq": int(seq),
+                    "logical_id": int(logical_id),
+                    "src_rel": src_rel,
+                    "dst_rel": dst_rel,
+                    "rc": int(rc),
+                }
+            )
+    return records
+
+
+def parse_reset_log(path: Path):
+    records = []
+    if not path.exists():
+        return records
+    with path.open("r", encoding="utf-8") as handle:
+        for line_no, line in enumerate(handle, 1):
+            line = line.strip()
+            if not line:
+                continue
+            parts = line.split(",")
+            if len(parts) != 4:
+                raise ValueError(f"reset log line {line_no}: expected 4 columns, got {len(parts)}")
+            ts_ms, seq, reason, rc = parts
+            records.append(
+                {
+                    "ts_ms": int(ts_ms),
+                    "seq": int(seq),
+                    "reason": reason,
+                    "rc": int(rc),
+                }
+            )
+    return records
+
+
+def parse_status_file(path: Path):
+    status = {}
+    if not path.exists():
+        return status
+    with path.open("r", encoding="utf-8") as handle:
+        for line in handle:
+            line = line.strip()
+            if not line or ":" not in line:
+                continue
+            key, value = line.split(":", 1)
+            status[key.strip()] = value.strip()
+    return status
+
+
+def to_int(value: str, default: int = 0):
+    try:
+        return int(value)
+    except Exception:
+        return default
+
+
+def validate_namespace(data_dir: Path, file_count: int, issues):
+    actual_locations = {}
+    actual_paths = {}
+    for logical_id in range(file_count):
+        name = f"file_{logical_id:05d}"
+        found = []
+        for subdir in ("A", "B"):
+            candidate = data_dir / subdir / name
+            if candidate.exists():
+                found.append((subdir, candidate))
+        if len(found) != 1:
+            issues.append(
+                f"namespace invariant failed for logical_id={logical_id:05d}: expected exactly one file in A/B, found {len(found)}"
+            )
+            continue
+        actual_locations[logical_id] = found[0][0]
+        actual_paths[logical_id] = found[0][1]
+    return actual_locations, actual_paths
+
+
+def validate_rename_invariant(rename_records, actual_locations, issues):
+    expected_locations = {}
+    for rec in rename_records:
+        if rec["rc"] != 0:
+            continue
+        dst = rec["dst_rel"]
+        if "/" not in dst:
+            continue
+        expected_locations[rec["logical_id"]] = dst.split("/", 1)[0]
+
+    for logical_id, expected in expected_locations.items():
+        actual = actual_locations.get(logical_id)
+        if actual is None:
+            continue
+        if actual != expected:
+            issues.append(
+                f"rename invariant failed for logical_id={logical_id:05d}: expected location={expected}, actual={actual}"
+            )
+
+
+def validate_data_invariant(io_records, actual_paths, issues):
+    expected_hash = {}
+    for rec in io_records:
+        digest = rec["digest"]
+        if not digest:
+            continue
+        expected_hash[rec["logical_id"]] = digest
+
+    for logical_id, digest in expected_hash.items():
+        path = actual_paths.get(logical_id)
+        if path is None:
+            continue
+        actual_digest = sha256_file(path)
+        if digest != actual_digest:
+            issues.append(
+                f"data invariant failed for logical_id={logical_id:05d}: expected digest={digest}, actual digest={actual_digest}"
+            )
+
+
+def validate_reset_and_slo(args, reset_records, io_records, rename_records, status, issues):
+    if not args.expect_reset:
+        return
+
+    successful_reset_times = [rec["ts_ms"] for rec in reset_records if rec["rc"] == 0]
+    if not successful_reset_times:
+        issues.append("expected reset activity but no successful reset trigger was observed")
+
+    phase = status.get("phase")
+    blocked_requests = to_int(status.get("blocked_requests", "0"), default=-1)
+    last_errno = to_int(status.get("last_errno", "0"), default=1)
+    failure_count = to_int(status.get("failure_count", "0"), default=-1)
+
+    if phase is None:
+        issues.append("missing final reset status file or phase field")
+    elif phase.lower() != "idle":
+        issues.append(f"recovery invariant failed: phase={phase}, expected idle")
+
+    if blocked_requests != 0:
+        issues.append(f"recovery invariant failed: blocked_requests={blocked_requests}, expected 0")
+    if last_errno != 0:
+        issues.append(f"recovery invariant failed: last_errno={last_errno}, expected 0")
+    if failure_count > 0:
+        issues.append(
+            f"recovery invariant failed: failure_count={failure_count}, "
+            "one or more resets failed during the run"
+        )
+
+    op_times = [rec["ts_ms"] for rec in io_records]
+    op_times.extend(rec["ts_ms"] for rec in rename_records if rec["rc"] == 0)
+    op_times.sort()
+
+    if successful_reset_times and not op_times:
+        issues.append("recovery SLO failed: no workload completion events were recorded")
+        return
+
+    slo_ms = args.slo_seconds * 1000
+    for ts in successful_reset_times:
+        idx = bisect.bisect_left(op_times, ts)
+        if idx >= len(op_times):
+            issues.append(f"recovery SLO failed: no operation completion observed after reset at ts_ms={ts}")
+            continue
+        delta = op_times[idx] - ts
+        if delta > slo_ms:
+            issues.append(
+                f"recovery SLO failed: first post-reset completion at {delta}ms exceeds threshold {slo_ms}ms (reset ts_ms={ts})"
+            )
+
+
+def main():
+    parser = argparse.ArgumentParser(description="Validate Ceph reset stress artifacts")
+    parser.add_argument("--data-dir", required=True)
+    parser.add_argument("--file-count", required=True, type=int)
+    parser.add_argument("--io-log", required=True)
+    parser.add_argument("--rename-log", required=True)
+    parser.add_argument("--reset-log", required=True)
+    parser.add_argument("--status-final", required=False, default="")
+    parser.add_argument("--slo-seconds", required=False, type=int, default=30)
+    parser.add_argument("--expect-reset", action="store_true")
+    parser.add_argument("--report-json", required=False, default="")
+    args = parser.parse_args()
+
+    data_dir = Path(args.data_dir)
+    io_log = Path(args.io_log)
+    rename_log = Path(args.rename_log)
+    reset_log = Path(args.reset_log)
+    status_final = Path(args.status_final) if args.status_final else Path("__missing_status__")
+
+    issues = []
+
+    if not data_dir.exists():
+        issues.append(f"data directory is missing: {data_dir}")
+
+    try:
+        io_records = parse_io_log(io_log)
+        rename_records = parse_rename_log(rename_log)
+        reset_records = parse_reset_log(reset_log)
+    except Exception as exc:
+        issues.append(f"log parsing failed: {exc}")
+        io_records = []
+        rename_records = []
+        reset_records = []
+
+    status = parse_status_file(status_final)
+
+    actual_locations, actual_paths = validate_namespace(data_dir, args.file_count, issues)
+    validate_rename_invariant(rename_records, actual_locations, issues)
+    validate_data_invariant(io_records, actual_paths, issues)
+    validate_reset_and_slo(args, reset_records, io_records, rename_records, status, issues)
+
+    report = {
+        "file_count": args.file_count,
+        "io_records": len(io_records),
+        "rename_records": len(rename_records),
+        "reset_records": len(reset_records),
+        "expect_reset": args.expect_reset,
+        "issues": issues,
+    }
+
+    if args.report_json:
+        report_path = Path(args.report_json)
+        report_path.write_text(json.dumps(report, indent=2, sort_keys=True), encoding="utf-8")
+
+    if issues:
+        print("FAIL: consistency validation found issues")
+        for issue in issues:
+            print(f"  - {issue}")
+        raise SystemExit(1)
+
+    print("PASS: consistency validation succeeded")
+
+
+if __name__ == "__main__":
+    main()
-- 
2.34.1

