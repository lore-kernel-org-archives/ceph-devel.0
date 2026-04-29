Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D143FB7E7
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 12:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467160; cv=none; b=L+RTBb2uuuIqQOqz9NdpeSRTZQy5S8nX00KF8Cv0Wf8sK3bQNvBwkKUTsnwDtd3APJaiUdcaKsI63U7ENErDr+B8UKIEGNLuXxozes5u/gq0sNraO1G7QZud6u3aBdSk85kZNxTcUrKXggYLUL3kHm6uhPal+gKdSVUVMoyE24M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467160; c=relaxed/simple;
	bh=tn7xy5Ayn+zIa11ASIUS5cpHLtLo4gvFlZuKOLg8ggQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2mgRx3AeYu4LXzTN2nYVooIyGcghawpzi/ZfYpYdTpD5A5btKxPjQxC8Ijotf+jfAKWI6B9UbWw87fGqMe1twn9VdF129Vuslnq/bXXpgSSotp9iRT0ZIET8yFKmOkwy2GGnoZhYgHSv0EMhh35zPW4NC+PmcAP38n4qbSC1i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQ7Z0brD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pOliXWP/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQ7Z0brD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pOliXWP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777467156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0K6M5C2sXobTuSTLF/q+6rql2ekW3akwO+6JwZKqbME=;
	b=EQ7Z0brDhQuyT6dqs8vkUj/DZYZHumj1TSG+FZIPPHXajnyEZL/cb3lScO/cnYoPHFYLDr
	6BjC/ctADQjcbxsjgPz4WlYE9HIyzIrYg1coWzpS1OsJQHqZ9B23LBTPMxubRRmvWJkhPU
	BWJw/DcFFtL8ysQuYpdnxmBiYtVwuVc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-eM6lVt2TMQGt_jT--D_usA-1; Wed, 29 Apr 2026 08:52:35 -0400
X-MC-Unique: eM6lVt2TMQGt_jT--D_usA-1
X-Mimecast-MFC-AGG-ID: eM6lVt2TMQGt_jT--D_usA_1777467154
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-66bb7305ae7so10754439a12.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777467153; x=1778071953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0K6M5C2sXobTuSTLF/q+6rql2ekW3akwO+6JwZKqbME=;
        b=pOliXWP/WLjz8rH+JLNU702DxinieMQnJzHondJ1LCeUt6mOy1/JLODhKAGUiUzUrh
         7W+w0RzpkDvbHzedypG5mt1tYeI8Z6XM73vI1YphKdsOGOsA+E3n2hTiXHo7+/v3ruDQ
         NVgUjZ5HMZbpDFYNFcQeSQnP9ZeWvh/fastgsZFx/XIqFyfDciv64rC0NMynE3v8Brvw
         LhB9C+/6P7MOob6ZvjQg2O9KYjzxDLpQ2xISdjTRzqFz9uKDRFVGz4Sip4uPgdJpVRfr
         DKYIPxNdOV1ipmxdktLlOWqrIx55BTBSiZfXi5hr72ntpXmnBnEiPjx7k2LdT0IcnehQ
         tAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467153; x=1778071953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0K6M5C2sXobTuSTLF/q+6rql2ekW3akwO+6JwZKqbME=;
        b=NMlYp1/C3QH9wLLD3X7M/J/W2m2rcKpqXgMUYM6gS+NK3w7DFeK9MdPEHSkKzXSwV/
         fjfjSKqnBEXTZCR38ekXk1bFhKowQAZYq/KucUM1KFiwzC6Gyz9zi0B2nHZ0V5DnzMrg
         KTyvgL0rnNytB3l0ZvcSUJ0iZ07V3dlflYpTjqIUD0X/1ClnA6Oiu2hs4YJhsOKZkaPD
         cr47cdnETbJ0jd4NXCtq4LuK5pYNMLpvXNWDGWuzgXbEXwb4eZLdGWfz8Ra0zs0Madg1
         OzOfiZ1fnaAiuAd17/9UZL89qUsNTdAGTYkTlOdo3cCo+6IdiYBY6ODcCACDWJe6/jcT
         CxrQ==
X-Gm-Message-State: AOJu0YxUTU1n2GFsDDcnRamUlCXfeo6vJnJvn9G2GAhmoWLnihgjUFb0
	QOqcWzP2+3RBiQCFd66OauKDknSkBaXx9rZc5ZKIBOOwAdyNyxSbutqOUF0ROKbleGUKXIzX/Mz
	gru3lmTVE563W85AmgYynKgrxgz0oGooTk4INVvCwTVu7Wy3FnuXD8NlZpF4bP/q4aTRomv+cQt
	onrnTFSI+b3rutRTmCBKox/SWXUJtU7NKbQVPLkrBJUyPtJUVQxA==
X-Gm-Gg: AeBDieuT+uCIr9ccbJYAaBEUJVQdXIyMHiF9c9YZmbD21MVFe6WIvujiXlIIGIQdGU8
	v+h53u4R0/uugD6buCBFInaklFvVd/OuxfkRdvzLv5o4OIfvSnVqL79BSQgu0eKgPsKuSBNJ1WN
	qg6HD/hEqCHqUHHljOrqpLW3ZDV8fbLZkeEmkaFWkYky2S/DErI8iaoZzNxRnaKz/OR8uDgnabv
	FrfrafIOMXlcbnkacVxQT1hKS0jDJ2913s5rcOeoXPEOypqe0LDL00XmwsKkH15GlFZxRrkIPOF
	UKQb0KtzRiwSGLBOnH6pwidptn/4qN5fSIO1HwTJGk+jaHY83uv+y2kfu02a/BSh12ywyKWfR+2
	yYmTZOFQXmZFp+oP4dOAZErOxb8ZQVcR3Zicvav0inGxANSJhQ71AW4ULPFnt3AFRZw==
X-Received: by 2002:a05:6402:1f89:b0:679:1fb6:5c71 with SMTP id 4fb4d7f45d1cf-679bb0969f7mr3816269a12.22.1777467153209;
        Wed, 29 Apr 2026 05:52:33 -0700 (PDT)
X-Received: by 2002:a05:6402:1f89:b0:679:1fb6:5c71 with SMTP id 4fb4d7f45d1cf-679bb0969f7mr3816243a12.22.1777467152450;
        Wed, 29 Apr 2026 05:52:32 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22166a6esm680526a12.25.2026.04.29.05.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:52:31 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v3 10/11] selftests: ceph: add validation harness
Date: Wed, 29 Apr 2026 12:52:05 +0000
Message-Id: <20260429125206.1512203-11-amarkuze@redhat.com>
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

Add a one-shot validation wrapper that orchestrates the full reset
test suite with per-stage watchdog timeouts and a final status check.

The harness runs five stages: baseline (no resets), corner cases,
moderate stress, aggressive stress, and a post-run status validation.
Each stage runs with an independent timeout so a hang in one stage
does not block the entire run.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 .../filesystems/ceph/run_validation.sh        | 350 ++++++++++++++++++
 1 file changed, 350 insertions(+)
 create mode 100755 tools/testing/selftests/filesystems/ceph/run_validation.sh

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
-- 
2.34.1

