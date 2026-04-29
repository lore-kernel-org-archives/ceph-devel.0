Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34A03FFAA6
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 12:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467159; cv=none; b=YAI0Eq6Mm7fc4GY+QXE/SjneRCC6WGbu7ofuuU9NvUN9dHuztHrVzzsy2Z4L52R+SNMnT27FGt+7Vk2YXLpxrK/HF6YuIUZbd3RJv9md+YYK2Is38ZNBwE8MSRtVX12Xx8CWvMAIaL4TBKZJVWUK4Pt3mW8m7ga2UV1sePZjlBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467159; c=relaxed/simple;
	bh=MifFNiC+TKC8lDQyt2PtDrVcrjsIyIRVXqCVpmvmps4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MdVMTn/xg30gBPA/tfGVdq5lw/rPWQOkLeW+PwEG0Ys5OLREZe4VXB4DMp84gBmRQLVkHnytgkdxVD3H7PTyu9/c4x/8Ub95JYn97gebcwt5VAvqpyO1VfhJ8gkZ6BXX9z0GouV53b6e6MLH2bf90LkA1wsXeGt4CKapuLO9ork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhmI8M7U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfAtBdkF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhmI8M7U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfAtBdkF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777467155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=848yXqrWfV86+DAaUBiE05fWjJwwzyvaF5Dj6MZA6OU=;
	b=FhmI8M7U84qhyBB4OVG1Kz84YVmqU7BkP45NgD6Px4cR9Eo40nPLzXYbPrJn+lkCXkCsVX
	XluhKADjn5R1eBS6rb1SfuotMrepd8E25D6n7R52KtrL+OMzMy95QfCuPUpYovi+X3OLY1
	0xd+UViMkAgIqXlEfLOkZ5eR0fFGXLM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-K91QhEJ6M7WaD4NNpjAZyw-1; Wed, 29 Apr 2026 08:52:33 -0400
X-MC-Unique: K91QhEJ6M7WaD4NNpjAZyw-1
X-Mimecast-MFC-AGG-ID: K91QhEJ6M7WaD4NNpjAZyw_1777467153
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-67145c205acso6787781a12.3
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777467152; x=1778071952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=848yXqrWfV86+DAaUBiE05fWjJwwzyvaF5Dj6MZA6OU=;
        b=KfAtBdkFgvBBg6EwfZhUU6QadFmc+C8TN2b/Csu70qLImESpAYtAfce9LQw/iaboDG
         kSC7XG1nQ341Qp4+dEWX37OpL664kzpblDszYaw9aW7kzZ2YlxrQuQvB11rblEwIbAqX
         Y08nVZw9PcHH/ZdH5mXoy5K2a7SRg4sugtiZ79IexvpnRvV7RoD2WIDYnxfzwN70HTe6
         S9oTvtJIIEsHuMV5xxVhtmhtFFgHVVaE0pTXBOZbkhfUHuBDPhrJBhPukyd0i7JeMrX8
         Q+eObemGnotjnGM3hyAbVRSZi/icObf7iEfOv+h++2Bp3jEdUAyJsXvNsTxXj0+0ln4H
         mepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467152; x=1778071952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=848yXqrWfV86+DAaUBiE05fWjJwwzyvaF5Dj6MZA6OU=;
        b=DA0aJf/b1zbP1rbZRweSvuG6yXmptvDI2jM0zSRo111FKWeq1S5kjZPcqlvq3BcfHr
         wuKBmk2K3B8iw8oMklCaoQRgtp4WjH+YMbq4V5cD85NBB3Tgo3CSrvBDaV/RZwf7nXKZ
         L5o4rQdsTR8VtVloi57ODBUXcywayvzcZAQBHh1EszVwdR5JsllNrz2wIqDYG8YnvGH6
         uImwguFV8rRb9R0PIPo6yfmKMF5jMF13hoYpYMnPMl+oSTRHjFLoxyrAdCH2aOI+sIQ+
         Aq25wMFwNTpbyUWrfLH/kN91dLwgYkDnrf50AK/aKR/QlPKASmi01eWj8v1prIJeKh9q
         yx1A==
X-Gm-Message-State: AOJu0Yz2FvMiGyxr++i3SeRS0PCvFWetp2mXWzbwGMDrcpLi6hoRkq3S
	sYuEF+J4uJoj2k85i0c1Nt1719eTQFmkTjNQJEY9Kkq4v14cktwBj239cuJmb8t8NIVkvnJ4MkX
	0NvU0dVcxSFg/j7ykpLlQgrCdr1xN8t7hpZBlglULzVIGCPZwY76MYSOEnDRfi3mZZesfUtqDu+
	8FXwfz7sz+zKgYQ4J//OjCW2tyngAXufeo1szIMzvF+wCMM8K4vQ==
X-Gm-Gg: AeBDievWhFudCPhuCF2bEmnmD68ek/Db7imFkfWRD6u9US3kA1J22b0Mc8MazeU6PAU
	1/xZ4BAOJuKZKnFha/bOG6eLT0CbRvB/fQnldrGgzCCqwdQlV/xC/83wMhdfiADHl/jYEPu7Ilo
	Ii6Ehkqa5wDmmYhV6cQnK+AZeR+zy/pWy9D2kmVFDiwIUSnYVbWrvjflMra+BD3W1qED33yaC0C
	bCBpS84O6y9wFnIIfvqjnsVLagJez1Doq65BJRrWpY7Oa1NvCvSuftftTM0vYIo3LacepdvEZ6d
	llCHRgeooKXIKFxeDIrL4FKsAYGoQDAX5XJN/Fq75mULLeI+4ytyuG+fhsGoha8Dn3YyPL7nmbV
	yCXVA1+W/5sa/7RFoZ4YK+e3hXIWR/uZ9GQRr/AV/LSEpdulOk4rHv2X3kA2gI0WroA==
X-Received: by 2002:a05:6402:5484:b0:678:93eb:ca06 with SMTP id 4fb4d7f45d1cf-67b1fd96320mr2272596a12.7.1777467151837;
        Wed, 29 Apr 2026 05:52:31 -0700 (PDT)
X-Received: by 2002:a05:6402:5484:b0:678:93eb:ca06 with SMTP id 4fb4d7f45d1cf-67b1fd96320mr2272572a12.7.1777467151026;
        Wed, 29 Apr 2026 05:52:31 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22166a6esm680526a12.25.2026.04.29.05.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:52:30 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v3 09/11] selftests: ceph: add reset corner-case tests
Date: Wed, 29 Apr 2026 12:52:04 +0000
Message-Id: <20260429125206.1512203-10-amarkuze@redhat.com>
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

Add targeted corner-case tests for the CephFS manual session reset
feature.  Four sequential tests cover:

  [1/4] ebusy_rejection       - second reset rejected while first in-flight
  [2/4] dirty_caps_at_reset   - reset with unflushed dirty caps
  [3/4] flock_after_reset     - stale lock EIO + fresh lock after holder exit
  [4/4] unmount_during_reset  - umount during active reset (destroy-path wakeup)

Requires: mounted CephFS, debugfs access (root), flock(1) utility.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 .../filesystems/ceph/reset_corner_cases.sh    | 646 ++++++++++++++++++
 1 file changed, 646 insertions(+)
 create mode 100755 tools/testing/selftests/filesystems/ceph/reset_corner_cases.sh

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
-- 
2.34.1

