Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60548332ECB
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182434; cv=none; b=hiEAtvHpOUSPvy1e7hUCS5RrqRPn70aCDjNxXTzNSzJg2YkQ0FINd4jZpfWrP3zJOMF4/Ck8Avib2OIKqyVv0V/7RTx3cVSO+9jhWnaCaGJsbAE1SZDF6Mi4mJ3GzhYivfv/5vr0SZB9mN5QhFk22hoJsuYvf9gWt5YmBWCLkwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182434; c=relaxed/simple;
	bh=rKJi3aoEGT13qz//GDSpRAlXMcVXWcpyvh1RN4vNTGM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g7EiH0fdaMI1aqzKRlsUy+hPrcaqh5UB2rIsF7pwt6JhgCw6YrEVXP3ImdxmsxWHzOLE1Oka4l9/oUc/T21cS4ohEfNobqFDVooyuaET0YsAl85D5CaOsmQfutQ4lFe8Ej81J59DFLMrr/WRlQkF+w+pqiAfCYkYQcqjL+xHpHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KkpG8X+2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=E5vJR2r6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KkpG8X+2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5vJR2r6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778182431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oP7+VpFZc/QitwccIkg0zbE/NOCxTEYpg9OngYRT+V8=;
	b=KkpG8X+2AeFISkl3iWStHJk0yzlaXIt/VLMJB4UH6GaBCYKCKtllXrJmOpsD8C1fC/yYn3
	gb04BKj7puEBNEwHIZWRv9kBj41g5oJXjsRBdtFb9uvsjeJV626yA02PcFP6m8sFiykBqA
	yQsMZtxqp7YTrk7yWEG6/qLL3xzf8wQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-042JrLwvOP6RJwVF3WlKgQ-1; Thu, 07 May 2026 15:33:50 -0400
X-MC-Unique: 042JrLwvOP6RJwVF3WlKgQ-1
X-Mimecast-MFC-AGG-ID: 042JrLwvOP6RJwVF3WlKgQ_1778182429
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bd5e373be0so25239347b3.0
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 12:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778182429; x=1778787229; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oP7+VpFZc/QitwccIkg0zbE/NOCxTEYpg9OngYRT+V8=;
        b=E5vJR2r6C8JlwUmoQquUk8wa5In5xtwArKJ3Hpx9MYCPcTlQj8pTyHFT3A4C6PQgPc
         wMLJ/U2YzGUpNpE3ODcvaIfUnj8KzG7DLfRMYK/XkUzFSoYCRPCR3jDVibenGEk5rVlw
         AdHRJU0ZGo55yRhDi+dbWNtrcqeMJXmqbKOka0LZDhhK7ix+nVJ2vbueiDZvpOgkAGnQ
         +tLneoKOWuGri9/E7XfTNRSShTPCYTEfJkhE/7T0e1/Z+Ge3CqRArGH2xMPYSO5yiihL
         RQ2mQKI8Bl5yfYm96R+URcqZsMGUA7xNSMPEIi6UBFozKM5DHepwp7CqeqFqiDlxKOcE
         uAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778182429; x=1778787229;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oP7+VpFZc/QitwccIkg0zbE/NOCxTEYpg9OngYRT+V8=;
        b=pHOF1I37N93pApgJd2rUdZ+J6iIaknsM2N/zN7ZFmcIQV02c1e99a7JMU9pPyKRZ+O
         036FiSLlE/fHZajpCWhcXr5wCyimhJuZK6lW3OImVrsQ2YVZtRa7KMC17GLggzdmXLxx
         kbxyPzbVp3bzeeuQPYyXQKUmPUWPaPBqQIPkDOKXDWRrF8hjvemg8VeDf0UyGNAyP/N+
         lnE/3d1bRrvIZlgRYJHiv6drcDEHrMYdlzCaAztyTG5jwKsDt3Iu4REQm13Rl51upRg8
         4KbO8z2XPDpT/D0OSB4Buq2dBpBqk2T139UFUEEGpWrT8H8zJW8uJrTpvXHKfmH3XPwU
         Kp/w==
X-Forwarded-Encrypted: i=1; AFNElJ9k4DZvbw1VyJOgNV6ix5VuaxX0zp5EhMzQ8Bh3cF+Quls1angTqeXcm040S5O9yqDV2GFf8DZAV6UU@vger.kernel.org
X-Gm-Message-State: AOJu0YzJTiFJ0h+O9c1Lz3gur+Sf8MW+vdmENSPgV/EVsswvTerMzgg2
	t+0/fvNPGvvZ5mfcZQ+WjlNu9mtDuNuBiAfNGP7u6eaSA3eO5Dicbt8IC5HrwGBilktamJx2W3l
	Lnh7hIbIIKyYc788pdztGWYaeaCmLW6tXY7pG9A8hOm+pQhNIBEYKjYAvj79rRsg=
X-Gm-Gg: Acq92OE/+Pj1mxHKA+mniwnY0wUSjeY/NoIhv79m+cvgCIz1+6z2410aoDJJx43IS8R
	OBaU0ASMTGclc5ouGm7tNzAdfITeRM2g5O+onL0IjalKJC+5VnWuACfVbjNX8rj1wgWDbRPxuLs
	fn+nuhMMPU0iuxiy0caJzlElONMxwTpXRd83WgRa0JAnQriRXGbZJUn5NJ6UhHU/AY1S+n1ZT6g
	t0OFvMf5ddO87/1z14BEaBHynwiA8K3XzT/sdvrORn+aDEaEs/1PyZZT8qyORkrlPJp+eKTSDay
	XGMHoyHv2QMWjkKQqnjRWROcUwyY3NRiuHDqAnLNSk5R8DeBvJNVy3FQ/sjsmTjK3oyYSi1g+JW
	1Nrt4pH22tUSz0T5wA+OTV7W+U6vmlNWdj8eHWutvnLK5oW9KVIWE
X-Received: by 2002:a05:690c:6e81:b0:7ba:f3a2:551d with SMTP id 00721157ae682-7bdf5deac70mr98822777b3.15.1778182429123;
        Thu, 07 May 2026 12:33:49 -0700 (PDT)
X-Received: by 2002:a05:690c:6e81:b0:7ba:f3a2:551d with SMTP id 00721157ae682-7bdf5deac70mr98822257b3.15.1778182428493;
        Thu, 07 May 2026 12:33:48 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66838851sm96751147b3.23.2026.05.07.12.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:33:48 -0700 (PDT)
Message-ID: <56dfb4b66773b70733464ce17e344e9fdc8ae756.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v4 10/11] selftests: ceph: add validation
 harness
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Thu, 07 May 2026 12:33:47 -0700
In-Reply-To: <20260507122737.2804094-11-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
	 <20260507122737.2804094-11-amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-05-07 at 12:27 +0000, Alex Markuze wrote:
> Add a one-shot validation wrapper that orchestrates the full reset
> test suite with per-stage watchdog timeouts and a final status check.
>=20
> The harness runs five stages: baseline (no resets), corner cases,
> moderate stress, aggressive stress, and a post-run status validation.
> Each stage runs with an independent timeout so a hang in one stage
> does not block the entire run.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  .../filesystems/ceph/run_validation.sh        | 350 ++++++++++++++++++
>  1 file changed, 350 insertions(+)
>  create mode 100755 tools/testing/selftests/filesystems/ceph/run_validati=
on.sh
>=20
> diff --git a/tools/testing/selftests/filesystems/ceph/run_validation.sh b=
/tools/testing/selftests/filesystems/ceph/run_validation.sh
> new file mode 100755
> index 000000000000..5d521e4f9e9b
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/ceph/run_validation.sh
> @@ -0,0 +1,350 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# CephFS client reset - single-command validation.
> +# Runs all test stages in sequence with per-stage timeouts.
> +# If any stage hangs (filesystem stuck, process blocked), the
> +# timeout kills it and reports failure.
> +#
> +# Usage:
> +#   sudo ./run_validation.sh --mount-point /mnt/mycephfs
> +#
> +# Expected output on success:
> +#
> +#   =3D=3D=3D CephFS Client Reset Validation =3D=3D=3D
> +#   [stage 1/5] baseline         PASS  (60s, no resets)
> +#   [stage 2/5] corner_cases     PASS  (4/4 passed)
> +#   [stage 3/5] moderate         PASS  (120s, resets every 5-15s)
> +#   [stage 4/5] aggressive       PASS  (120s, resets every 1-5s)
> +#   [stage 5/5] status_check     PASS  (phase=3Didle, last_errno=3D0)
> +#
> +#   RESULT: 5/5 stages passed
> +#   Artifacts: /tmp/ceph_reset_validation_<timestamp>
> +
> +set -uo pipefail
> +
> +KSFT_SKIP=3D4
> +SCRIPT_DIR=3D"$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
> +
> +# kselftest auto-detect: when invoked with no arguments (e.g. by
> +# "make run_tests"), find a CephFS mount automatically or skip.
> +if [[ $# -eq 0 ]]; then
> +	MOUNT_POINT=3D"$(findmnt -t ceph -n -o TARGET 2>/dev/null | head -1)"
> +	if [[ -z "$MOUNT_POINT" ]]; then
> +		echo "SKIP: No CephFS mount found and --mount-point not specified"
> +		exit "$KSFT_SKIP"
> +	fi
> +	exec "$0" --mount-point "$MOUNT_POINT"
> +fi
> +
> +MOUNT_POINT=3D""
> +CLIENT_ID=3D""
> +declare -a CLIENT_ARGS=3D()
> +declare -a DEBUGFS_ARGS=3D()
> +RUN_ID=3D"$(date +%Y%m%d-%H%M%S)"
> +OUT_DIR=3D"/tmp/ceph_reset_validation_${RUN_ID}"
> +DEBUGFS_ROOT=3D"/sys/kernel/debug/ceph"
> +
> +# Timeout margins: stage runtime + cooldown + validation + safety buffer
> +STAGE1_TIMEOUT=3D120    # 60s run + 20s cooldown + 40s buffer
> +STAGE2_TIMEOUT=3D300    # 4 corner cases, 30s each worst case + buffer
> +STAGE3_TIMEOUT=3D240    # 120s run + 20s cooldown + 100s buffer
> +STAGE4_TIMEOUT=3D240    # 120s run + 20s cooldown + 100s buffer
> +STAGE5_TIMEOUT=3D10     # just reading debugfs
> +
> +PASS=3D0
> +FAIL=3D0
> +TOTAL=3D5
> +
> +usage()
> +{
> +	cat <<EOF
> +Usage: $0 --mount-point <cephfs_mount> [options]
> +
> +Required:
> +  --mount-point PATH    CephFS mount point
> +
> +Options:
> +  --out-dir PATH        Artifact directory (default: /tmp/ceph_reset_val=
idation_<ts>)
> +  --client-id ID        Ceph debugfs client id (optional)
> +  --debugfs-root PATH   Debugfs Ceph root (default: /sys/kernel/debug/ce=
ph)
> +  --help                Show this message
> +EOF
> +}
> +
> +stage_result()
> +{
> +	local num=3D"$1"
> +	local name=3D"$2"
> +	local status=3D"$3"
> +	local detail=3D"$4"
> +
> +	if [[ "$status" =3D=3D "PASS" ]]; then
> +		PASS=3D$((PASS + 1))
> +	else
> +		FAIL=3D$((FAIL + 1))
> +	fi
> +	printf '[stage %d/%d] %-16s %s  (%s)\n' "$num" "$TOTAL" "$name" "$statu=
s" "$detail"
> +}
> +
> +# Run a command with a timeout. Returns 0 on success, 1 on failure/timeo=
ut.
> +# Sets RUN_TIMED_OUT=3D1 if killed by timeout.
> +#
> +# The stage command runs in its own session/process group (via setsid).
> +# On timeout the entire process group is killed, not just the top-level
> +# script PID.  This is required because stage scripts (reset_stress.sh,
> +# reset_corner_cases.sh) spawn child processes - I/O workers, rename
> +# workers, reset injectors, samplers - that would otherwise survive the
> +# timeout and bleed into later stages, invalidating results.
> +RUN_TIMED_OUT=3D0
> +
> +run_with_timeout()
> +{
> +	local timeout_sec=3D"$1"
> +	local logfile=3D"$2"
> +	shift 2
> +
> +	RUN_TIMED_OUT=3D0
> +
> +	# Start the stage in its own session via setsid so all descendant
> +	# processes share a process group that we can kill atomically.
> +	# In a non-interactive script, background children are not process
> +	# group leaders, so setsid(1) calls setsid(2) directly (no extra
> +	# fork) and the PID we capture IS the group leader.
> +	setsid "$@" > "$logfile" 2>&1 &
> +	local pid=3D$!
> +
> +	# Watchdog: on timeout, kill the entire process group
> +	(
> +		sleep "$timeout_sec"
> +		if kill -0 "$pid" 2>/dev/null; then
> +			echo "TIMEOUT: stage exceeded ${timeout_sec}s, killing process group =
$pid" >> "$logfile"
> +			kill -TERM -- -"$pid" 2>/dev/null
> +			sleep 2
> +			kill -KILL -- -"$pid" 2>/dev/null
> +		fi
> +	) &
> +	local watchdog_pid=3D$!
> +
> +	# Wait for the stage command
> +	wait "$pid" 2>/dev/null
> +	local rc=3D$?
> +
> +	# Kill the watchdog if it's still running
> +	kill "$watchdog_pid" 2>/dev/null
> +	wait "$watchdog_pid" 2>/dev/null
> +
> +	# Check if it was killed by timeout
> +	if grep -q "^TIMEOUT:" "$logfile" 2>/dev/null; then
> +		RUN_TIMED_OUT=3D1
> +		return 1
> +	fi
> +
> +	return "$rc"
> +}
> +
> +find_status_path()
> +{
> +	local entry
> +
> +	if [[ -n "$CLIENT_ID" ]]; then
> +		if [[ -r "$DEBUGFS_ROOT/$CLIENT_ID/reset/status" ]]; then
> +			echo "$DEBUGFS_ROOT/$CLIENT_ID/reset/status"
> +			return 0
> +		fi
> +		return 1
> +	fi
> +
> +	for entry in "$DEBUGFS_ROOT"/*/; do
> +		if [[ -r "${entry}reset/status" ]]; then
> +			echo "${entry}reset/status"
> +			return 0
> +		fi
> +	done
> +	return 1
> +}
> +
> +read_status_field()
> +{
> +	local status_path=3D"$1"
> +	local field=3D"$2"
> +	awk -F': ' -v key=3D"$field" '$1 =3D=3D key {print $2}' "$status_path" =
2>/dev/null
> +}
> +
> +# --- Parse arguments --------------------------------------------------=
-----
> +
> +while [[ $# -gt 0 ]]; do
> +	case "$1" in
> +	--mount-point)  MOUNT_POINT=3D"$2"; shift 2 ;;
> +	--out-dir)      OUT_DIR=3D"$2"; shift 2 ;;
> +	--client-id)    CLIENT_ID=3D"$2"; shift 2 ;;
> +	--debugfs-root) DEBUGFS_ROOT=3D"$2"; shift 2 ;;
> +	--help|-h)      usage; exit 0 ;;
> +	*)              echo "Unknown option: $1" >&2; usage; exit 2 ;;
> +	esac
> +done
> +
> +if [[ -z "$MOUNT_POINT" ]]; then
> +	echo "SKIP: --mount-point is required" >&2
> +	usage
> +	exit "$KSFT_SKIP"
> +fi
> +
> +if [[ ! -d "$MOUNT_POINT" ]]; then
> +	echo "SKIP: Mount point does not exist: $MOUNT_POINT" >&2
> +	exit "$KSFT_SKIP"
> +fi
> +
> +# Auto-detect client id when not specified, so all stages (including
> +# stage 5 status check) use the same client consistently.
> +if [[ -z "$CLIENT_ID" ]]; then
> +	candidates=3D()
> +	for entry in "$DEBUGFS_ROOT"/*/; do
> +		name=3D"$(basename "$entry")"
> +		if [[ -r "${entry}reset/status" ]]; then
> +			candidates+=3D("$name")
> +		fi
> +	done
> +	if [[ ${#candidates[@]} -eq 1 ]]; then
> +		CLIENT_ID=3D"${candidates[0]}"
> +	elif [[ ${#candidates[@]} -gt 1 ]]; then
> +		echo "SKIP: Multiple Ceph clients found (${candidates[*]}). Use --clie=
nt-id." >&2
> +		exit "$KSFT_SKIP"
> +	fi
> +fi
> +
> +if [[ -n "$CLIENT_ID" ]]; then
> +	CLIENT_ARGS=3D(--client-id "$CLIENT_ID")
> +fi
> +DEBUGFS_ARGS=3D(--debugfs-root "$DEBUGFS_ROOT")
> +
> +# Quick sanity: can we write to the mount?
> +if ! touch "$MOUNT_POINT/.validation_probe_$$" 2>/dev/null; then
> +	echo "SKIP: Mount point is not writable: $MOUNT_POINT" >&2
> +	exit "$KSFT_SKIP"
> +fi
> +rm -f "$MOUNT_POINT/.validation_probe_$$"
> +
> +mkdir -p "$OUT_DIR"
> +
> +echo ""
> +echo "=3D=3D=3D CephFS Client Reset Validation =3D=3D=3D"
> +echo ""
> +
> +# --- Stage 1: Baseline (no resets) ------------------------------------=
-----
> +
> +stage1_out=3D"$OUT_DIR/stage1_baseline"
> +if run_with_timeout "$STAGE1_TIMEOUT" "$stage1_out.log" \
> +	"$SCRIPT_DIR/reset_stress.sh" \
> +	--mount-point "$MOUNT_POINT" \
> +	--profile baseline \
> +	--no-reset \
> +	--duration-sec 60 \
> +	"${CLIENT_ARGS[@]}" \
> +	"${DEBUGFS_ARGS[@]}" \
> +	--out-dir "$stage1_out"; then
> +	stage_result 1 "baseline" "PASS" "60s, no resets"
> +elif [[ "$RUN_TIMED_OUT" -eq 1 ]]; then
> +	stage_result 1 "baseline" "FAIL" "HUNG: killed after ${STAGE1_TIMEOUT}s=
"
> +else
> +	stage_result 1 "baseline" "FAIL" "see $stage1_out.log"
> +fi
> +
> +# --- Stage 2: Corner cases --------------------------------------------=
-----
> +
> +stage2_out=3D"$OUT_DIR/stage2_corner_cases"
> +mkdir -p "$stage2_out"
> +if run_with_timeout "$STAGE2_TIMEOUT" "$stage2_out/output.log" \
> +	"$SCRIPT_DIR/reset_corner_cases.sh" \
> +	"${CLIENT_ARGS[@]}" \
> +	"${DEBUGFS_ARGS[@]}" \
> +	--mount-point "$MOUNT_POINT"; then
> +	pass_line=3D$(grep -Eo '[0-9]+ passed, [0-9]+ failed, [0-9]+ skipped' "=
$stage2_out/output.log" | tail -1)
> +	stage_result 2 "corner_cases" "PASS" "${pass_line:-all tests passed}"
> +elif [[ "$RUN_TIMED_OUT" -eq 1 ]]; then
> +	stage_result 2 "corner_cases" "FAIL" "HUNG: killed after ${STAGE2_TIMEO=
UT}s"
> +else
> +	fail_line=3D$(grep -c 'FAIL' "$stage2_out/output.log" 2>/dev/null || ec=
ho "?")
> +	stage_result 2 "corner_cases" "FAIL" "${fail_line} failures, see $stage=
2_out/output.log"
> +fi
> +
> +# --- Stage 3: Moderate resets -----------------------------------------=
------
> +
> +stage3_out=3D"$OUT_DIR/stage3_moderate"
> +if run_with_timeout "$STAGE3_TIMEOUT" "$stage3_out.log" \
> +	"$SCRIPT_DIR/reset_stress.sh" \
> +	--mount-point "$MOUNT_POINT" \
> +	--profile moderate \
> +	--duration-sec 120 \
> +	"${CLIENT_ARGS[@]}" \
> +	"${DEBUGFS_ARGS[@]}" \
> +	--out-dir "$stage3_out"; then
> +	stage_result 3 "moderate" "PASS" "120s, resets every 5-15s"
> +elif [[ "$RUN_TIMED_OUT" -eq 1 ]]; then
> +	stage_result 3 "moderate" "FAIL" "HUNG: killed after ${STAGE3_TIMEOUT}s=
"
> +else
> +	stage_result 3 "moderate" "FAIL" "see $stage3_out.log"
> +fi
> +
> +# --- Stage 4: Aggressive resets ---------------------------------------=
------
> +
> +stage4_out=3D"$OUT_DIR/stage4_aggressive"
> +if run_with_timeout "$STAGE4_TIMEOUT" "$stage4_out.log" \
> +	"$SCRIPT_DIR/reset_stress.sh" \
> +	--mount-point "$MOUNT_POINT" \
> +	--profile aggressive \
> +	--duration-sec 120 \
> +	"${CLIENT_ARGS[@]}" \
> +	"${DEBUGFS_ARGS[@]}" \
> +	--out-dir "$stage4_out"; then
> +	stage_result 4 "aggressive" "PASS" "120s, resets every 1-5s"
> +elif [[ "$RUN_TIMED_OUT" -eq 1 ]]; then
> +	stage_result 4 "aggressive" "FAIL" "HUNG: killed after ${STAGE4_TIMEOUT=
}s"
> +else
> +	stage_result 4 "aggressive" "FAIL" "see $stage4_out.log"
> +fi
> +
> +# --- Stage 5: Post-run status check -----------------------------------=
-----
> +
> +status_path=3D""
> +if status_path=3D$(find_status_path); then
> +	phase=3D$(read_status_field "$status_path" "phase")
> +	last_errno=3D$(read_status_field "$status_path" "last_errno")
> +	failure_count=3D$(read_status_field "$status_path" "failure_count")
> +	drain_timed_out=3D$(read_status_field "$status_path" "drain_timed_out")
> +	sessions_reset=3D$(read_status_field "$status_path" "sessions_reset")
> +	blocked=3D$(read_status_field "$status_path" "blocked_requests")
> +
> +	# Save full status
> +	cat "$status_path" > "$OUT_DIR/final_status.txt" 2>/dev/null
> +
> +	errors=3D""
> +	[[ "$phase" !=3D "idle" ]] && errors=3D"${errors}phase=3D$phase "
> +	[[ "$last_errno" !=3D "0" ]] && errors=3D"${errors}last_errno=3D$last_e=
rrno "
> +	[[ "$failure_count" !=3D "0" && -n "$failure_count" ]] && errors=3D"${e=
rrors}failure_count=3D$failure_count "
> +	[[ "$blocked" !=3D "0" ]] && errors=3D"${errors}blocked_requests=3D$blo=
cked "
> +
> +	if [[ -z "$errors" ]]; then
> +		detail=3D"phase=3D$phase, last_errno=3D$last_errno, failure_count=3D${=
failure_count:-0}"
> +		[[ "$drain_timed_out" =3D=3D "yes" ]] && detail=3D"$detail, drain_time=
d_out=3Dyes"
> +		[[ -n "$sessions_reset" ]] && detail=3D"$detail, sessions_reset=3D$ses=
sions_reset"
> +		stage_result 5 "status_check" "PASS" "$detail"
> +	else
> +		stage_result 5 "status_check" "FAIL" "$errors"
> +	fi
> +else
> +	stage_result 5 "status_check" "FAIL" "cannot read reset/status"
> +fi
> +
> +# --- Summary ----------------------------------------------------------=
------
> +
> +echo ""
> +if [[ "$FAIL" -eq 0 ]]; then
> +	echo "RESULT: $PASS/$TOTAL stages passed"
> +else
> +	echo "RESULT: $PASS/$TOTAL stages passed, $FAIL FAILED"
> +fi
> +echo "Artifacts: $OUT_DIR"
> +echo ""
> +
> +exit "$FAIL"

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

