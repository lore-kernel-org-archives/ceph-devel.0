Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F8D480DE4
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 19:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182210; cv=none; b=AW4IiEApU1nUFZlyd92QV5hGY+Q7MiOQ9thgkqOzpGUpZPKEDEwok8253V1xcIt9jXVMftD9LaXnrzctUBbbKA1tKpOVb6ELuWxAMXvQklRIahulrJy+H66xO+b0BKCD83xgfOiXeTLiJTpbZPB/xQGDGZrzq338ClH/3R1Fphc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182210; c=relaxed/simple;
	bh=s7mmcGJn4cxGfZhEmsQHmRuYnLPWzBBMhmOxiL7G1uQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i0PRZwg370UN5TTRlnxOnz79gcPHmWq8SMs557D6mL9KNpKqLfEgjMjv1Z5PdCTPf6xw08pG480Az5KJevHhXB48IhC+q/hg8W2HVLdC81VR9AmkuoY34wJP0/JY6c7fyak3OykcikV7jLDDPQqyaANwqSGgtUZyBq1Ha3TnDi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NjdZs/vk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nE6d4oAD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NjdZs/vk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nE6d4oAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778182203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/bnJdq7Re8pzWXsv3AFtsBSvp+qvot+lT7d6JLb/D0=;
	b=NjdZs/vkaTKR/AjDdxwAN0eD548WwNW8DT6qfptCkj97vgBoTtYwQ/oeqPtt7Ik4sHeY3o
	trFwaHTXlmGh4X6YBkys3peY3l8PZx6ACALVKLmdAkYob9y5HUuMvHiZ30EM7cKVgRXMnT
	vcI6z+kXLX5elFzOyf1NTZz0iXygZBk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-LNkCX4khN9y8nFpsYBhdWQ-1; Thu, 07 May 2026 15:30:01 -0400
X-MC-Unique: LNkCX4khN9y8nFpsYBhdWQ-1
X-Mimecast-MFC-AGG-ID: LNkCX4khN9y8nFpsYBhdWQ_1778182201
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bf0b47d2f8so25875827b3.2
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778182201; x=1778787001; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6/bnJdq7Re8pzWXsv3AFtsBSvp+qvot+lT7d6JLb/D0=;
        b=nE6d4oADH0X7mOoAdx+eCggUsKvZ3qpmt5RSFRwa2x+pQDb4B8eH2dHtzEEsA9tRI9
         z6Uc04X5ToBfjyfSp8CblF1xsInK3vgJ+jKxhNi4cgJdduTpvJKzdvfjHkQn15shv+M6
         wTPTSZQEdn+M32ACN+/V/4/2qBXF3ITIr8NYNlCPdjj4MpiersZiB+UPqfAIzFvqST06
         ZXm9D36oNHa9BRiyZKBqBkPB58BVBeQqUN36OiVJ/Fp/0L5cYgoADRi/56+8CvXwbdrP
         j8pjlzdOJW0YgbhtcSubwFjSWr2U3fSB/ZNgO/+c1Or3+qp19lLwc8RzI1wBFKpcoWgQ
         ymIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778182201; x=1778787001;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/bnJdq7Re8pzWXsv3AFtsBSvp+qvot+lT7d6JLb/D0=;
        b=pzMXfkJPB8znOQY+G0T+ciN3mnlOt4UnzT4w5vUs9KvA02vv9Eh8Y7rE+Fg6gMi/qp
         7XlKk8Nysbf9dYYr4TjeqJUrhzXdm+hxE35ed3s6qGImYsQEOqoElxPyIY1TV0K/qnVy
         +zPqwthyi5sduUuoj4XjdqhbGXeXxYaxljStXfnFwvWQfGsgeQGy6Sg2DyjsrtEo6/PQ
         Ht6euS/LfveIMVQj3qAZTjFsqDx+VBzDOmfYU0BHDBjrc4EcK8tuq+6il4SW4hu2+WU7
         cBRPsccKHtTJWZVnSvNJb2swYQcWBmQcKkjeQZqL5dHUU5cGiZNLQ3SlQo3khCT9zeE9
         wzqw==
X-Forwarded-Encrypted: i=1; AFNElJ9x4yLTC/fT5hfHE1q9Lrcfuvy4HqjdygkHEccmy2upHz7nHeTbHeQz1AmcoUSlRW+1WylXqco6WWKr@vger.kernel.org
X-Gm-Message-State: AOJu0YwI2D0qt+MQrzNKVVKAPCJrHek6QP2iiEqNUi2LzsupJSIxKeia
	Zk1R8s548zMMbnAfzIXUMMEPWPRnUckcZ9m2UZ/7SCCeGfyf0TkAcvWW77nodX7nwA2OApjb3a9
	lCwE5tPBTuZNCB8ly3EX0JO5K+iIdeUjVS0L+Jv514MHn7PTJxbp9CPrOWzsKF1c=
X-Gm-Gg: Acq92OHDNf7IXl0ZAHBrHAzmG6K90r8iMHbq/jmo66X+vVrG6LPHkwuiW86Lld23Kdl
	oUJFYqddyyISkzPQKDgs6+vOovrHrUlvZWvav/ai5WUiWdr6wJbrgan2cZf92Hj+wMpVbWxJ4ln
	OuHviXo6cmTZjejk6NVa3e6qParc08KOYnCU0juppNIw6nO1NCm+gBapud6Xaapb90ElT4ppNuY
	Mzx5OIEJvbFc9dw6Bi8HekVphgS3QlPvEJrkCpN3JA8tJmX96Z/957pi20U0My9wRCK/5dqM1Im
	2PdvWRaWe+xHWqiBlToYxn6C7BpE2TSfiwT09SWq9B8mfl1ML0P+TToj/P3A8utE6Gp5UJuI53A
	hMjDDR2x32U10/w6AORDiPgglWXIg6RimzA+MNXYCgCPzSpR+q26b
X-Received: by 2002:a05:690c:c4d3:b0:79a:7ff5:93ee with SMTP id 00721157ae682-7bdf5e250dbmr104743767b3.22.1778182200521;
        Thu, 07 May 2026 12:30:00 -0700 (PDT)
X-Received: by 2002:a05:690c:c4d3:b0:79a:7ff5:93ee with SMTP id 00721157ae682-7bdf5e250dbmr104743347b3.22.1778182199780;
        Thu, 07 May 2026 12:29:59 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66861afesm96931587b3.37.2026.05.07.12.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:29:59 -0700 (PDT)
Message-ID: <da51a7487cd1a6179d8c4ce2cb5b9caaec18c80d.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v4 08/11] selftests: ceph: add reset stress
 test
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Thu, 07 May 2026 12:29:58 -0700
In-Reply-To: <20260507122737.2804094-9-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
	 <20260507122737.2804094-9-amarkuze@redhat.com>
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
> Add a single-client stress test for the CephFS manual session reset
> feature.  The test runs concurrent I/O workers alongside periodic
> reset injection, then validates data integrity via
> validate_consistency.py.
>=20
> Supports four profiles (baseline, moderate, aggressive, soak) with
> configurable duration, reset interval, and worker counts.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  .../filesystems/ceph/reset_stress.sh          | 694 ++++++++++++++++++
>  1 file changed, 694 insertions(+)
>  create mode 100755 tools/testing/selftests/filesystems/ceph/reset_stress=
.sh
>=20
> diff --git a/tools/testing/selftests/filesystems/ceph/reset_stress.sh b/t=
ools/testing/selftests/filesystems/ceph/reset_stress.sh
> new file mode 100755
> index 000000000000..c503c75a5f7a
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/ceph/reset_stress.sh
> @@ -0,0 +1,694 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# CephFS reset stress test:
> +# - Runs concurrent I/O and rename workloads
> +# - Triggers random client resets through debugfs
> +# - Validates consistency and recovery behavior
> +
> +set -euo pipefail
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
> +PROFILE=3D"moderate"
> +DURATION_SEC=3D""
> +COOLDOWN_SEC=3D20
> +FILE_COUNT=3D64
> +IO_WORKERS=3D""
> +RENAME_WORKERS=3D""
> +MOUNT_POINT=3D""
> +OUT_DIR=3D""
> +CLIENT_ID=3D""
> +DEBUGFS_ROOT=3D"/sys/kernel/debug/ceph"
> +SLO_SECONDS=3D30
> +EXPECT_RESET=3D1
> +DMESG_CMD=3D""
> +SUDO=3D""
> +
> +RESET_MIN_SEC=3D5
> +RESET_MAX_SEC=3D15
> +
> +RUN_ID=3D"$(date +%Y%m%d-%H%M%S)"
> +WORKLOAD_FLAG=3D""
> +RESET_FLAG=3D""
> +DATA_DIR=3D""
> +
> +IO_LOG=3D""
> +RENAME_LOG=3D""
> +RESET_LOG=3D""
> +STATUS_LOG=3D""
> +STATUS_BEFORE=3D""
> +STATUS_FINAL=3D""
> +DMESG_LOG=3D""
> +SUMMARY_LOG=3D""
> +REPORT_JSON=3D""
> +
> +RESET_PID=3D0
> +STATUS_PID=3D0
> +declare -a IO_WORKER_PIDS=3D()
> +declare -a RENAME_WORKER_PIDS=3D()
> +
> +usage()
> +{
> +	cat <<EOF
> +Usage: $0 --mount-point <cephfs_mount> [options]
> +
> +Required:
> +  --mount-point PATH       CephFS mount point to test under
> +
> +Options:
> +  --profile NAME           baseline|moderate|aggressive|soak (default: m=
oderate)
> +  --duration-sec N         Override profile runtime in seconds
> +  --cooldown-sec N         Workload drain time after injector stop (defa=
ult: 20)
> +  --file-count N           Number of logical files (default: 64)
> +  --io-workers N           Number of concurrent I/O workers (profile def=
ault)
> +  --rename-workers N       Number of concurrent rename workers (profile =
default)
> +  --out-dir PATH           Artifact directory (default: /tmp/ceph_reset_=
stress_<ts>)
> +  --client-id ID           Ceph debugfs client id; auto-detect if one cl=
ient exists
> +  --debugfs-root PATH      Debugfs Ceph root (default: /sys/kernel/debug=
/ceph)
> +  --slo-seconds N          Max allowed post-reset stall window (default:=
 30)
> +  --no-reset               Disable reset injector (baseline mode helper)
> +  --help                   Show this message
> +
> +Examples:
> +  $0 --mount-point /mnt/cephfs --profile moderate
> +  $0 --mount-point /mnt/cephfs --profile aggressive --duration-sec 300
> +  $0 --mount-point /mnt/cephfs --profile baseline --no-reset
> +EOF
> +}
> +
> +now_ms()
> +{
> +	date +%s%3N
> +}
> +
> +set_profile_defaults()
> +{
> +	case "$PROFILE" in
> +	baseline)
> +		RESET_MIN_SEC=3D0
> +		RESET_MAX_SEC=3D0
> +		EXPECT_RESET=3D0
> +		: "${DURATION_SEC:=3D600}"
> +		: "${IO_WORKERS:=3D1}"
> +		: "${RENAME_WORKERS:=3D1}"
> +		;;
> +	moderate)
> +		RESET_MIN_SEC=3D5
> +		RESET_MAX_SEC=3D15
> +		: "${DURATION_SEC:=3D900}"
> +		: "${IO_WORKERS:=3D2}"
> +		: "${RENAME_WORKERS:=3D1}"
> +		;;
> +	aggressive)
> +		RESET_MIN_SEC=3D1
> +		RESET_MAX_SEC=3D5
> +		: "${DURATION_SEC:=3D900}"
> +		: "${IO_WORKERS:=3D4}"
> +		: "${RENAME_WORKERS:=3D2}"
> +		;;
> +	soak)
> +		RESET_MIN_SEC=3D5
> +		RESET_MAX_SEC=3D15
> +		: "${DURATION_SEC:=3D3600}"
> +		: "${IO_WORKERS:=3D2}"
> +		: "${RENAME_WORKERS:=3D1}"
> +		;;
> +	*)
> +		echo "Unknown profile: $PROFILE" >&2
> +		exit 2
> +		;;
> +	esac
> +}
> +
> +log_summary()
> +{
> +	local msg=3D"$1"
> +	printf '[%s] %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$msg" | tee -a "$S=
UMMARY_LOG"
> +}
> +
> +discover_client_id()
> +{
> +	local candidates=3D()
> +	local entry
> +
> +	if [[ -n "$CLIENT_ID" ]]; then
> +		if ! $SUDO test -d "$DEBUGFS_ROOT/$CLIENT_ID/reset"; then
> +			echo "SKIP: reset debugfs not found for client-id=3D$CLIENT_ID" >&2
> +			exit "$KSFT_SKIP"
> +		fi
> +		return 0
> +	fi
> +
> +	if ! $SUDO test -d "$DEBUGFS_ROOT"; then
> +		echo "SKIP: Debugfs root not found: $DEBUGFS_ROOT" >&2
> +		exit "$KSFT_SKIP"
> +	fi
> +
> +	while IFS=3D read -r entry; do
> +		$SUDO test -d "$DEBUGFS_ROOT/$entry/reset" || continue
> +		$SUDO test -w "$DEBUGFS_ROOT/$entry/reset/trigger" || continue
> +		candidates+=3D("$entry")
> +	done < <($SUDO ls -1 "$DEBUGFS_ROOT" 2>/dev/null || true)
> +
> +	if [[ ${#candidates[@]} -eq 1 ]]; then
> +		CLIENT_ID=3D"${candidates[0]}"
> +		return 0
> +	fi
> +
> +	if [[ ${#candidates[@]} -eq 0 ]]; then
> +		echo "SKIP: No writable Ceph reset interface found under $DEBUGFS_ROOT=
" >&2
> +		exit "$KSFT_SKIP"
> +	fi
> +
> +	echo "SKIP: Multiple Ceph clients found (${candidates[*]}). Use --clien=
t-id." >&2
> +	exit "$KSFT_SKIP"
> +}
> +
> +init_dataset()
> +{
> +	local i
> +	mkdir -p "$DATA_DIR/A" "$DATA_DIR/B"
> +
> +	for ((i =3D 0; i < FILE_COUNT; i++)); do
> +		printf 'seed logical_id=3D%05d ts_ms=3D%s\n' "$i" "$(now_ms)" > "$DATA=
_DIR/A/file_$(printf '%05d' "$i")"
> +	done
> +}
> +
> +io_worker()
> +{
> +	set +e
> +	local worker_id=3D"$1"
> +	local seq=3D0
> +	local id
> +	local relpath
> +	local abspath
> +	local payload
> +	local hash
> +	local ts
> +
> +	while [[ -f "$WORKLOAD_FLAG" ]]; do
> +		id=3D"$(printf '%05d' $((RANDOM % FILE_COUNT)))"
> +		if [[ -f "$DATA_DIR/A/file_$id" ]]; then
> +			relpath=3D"A/file_$id"
> +		elif [[ -f "$DATA_DIR/B/file_$id" ]]; then
> +			relpath=3D"B/file_$id"
> +		else
> +			sleep 0.02
> +			continue
> +		fi
> +
> +		abspath=3D"$DATA_DIR/$relpath"
> +		alt_relpath=3D""
> +		if [[ "$relpath" =3D=3D A/* ]]; then
> +			alt_relpath=3D"B/file_$id"
> +		else
> +			alt_relpath=3D"A/file_$id"
> +		fi
> +		alt_abspath=3D"$DATA_DIR/$alt_relpath"
> +		payload=3D"worker=3D${worker_id} io_seq=3D${seq} id=3D${id} ts_ms=3D$(=
now_ms)"
> +		result=3D"$(
> +			python3 - "$abspath" "$alt_abspath" "$payload" <<'PY'
> +import hashlib
> +import os
> +import sys
> +
> +path =3D sys.argv[1]
> +alt_path =3D sys.argv[2]
> +payload =3D sys.argv[3]
> +
> +try:
> +    fd =3D os.open(path, os.O_RDWR | os.O_APPEND)
> +    actual =3D path
> +except FileNotFoundError:
> +    try:
> +        fd =3D os.open(alt_path, os.O_RDWR | os.O_APPEND)
> +        actual =3D alt_path
> +    except FileNotFoundError:
> +        sys.exit(1)
> +
> +try:
> +    os.write(fd, (payload + "\n").encode())
> +    os.fsync(fd)
> +    os.lseek(fd, 0, os.SEEK_SET)
> +    digest =3D hashlib.sha256()
> +    while True:
> +        chunk =3D os.read(fd, 1 << 20)
> +        if not chunk:
> +            break
> +        digest.update(chunk)
> +    print(actual + " " + digest.hexdigest())
> +finally:
> +    os.close(fd)
> +PY
> +		)" || {
> +			sleep 0.02
> +			continue
> +		}
> +
> +		actual_abspath=3D"${result%% *}"
> +		hash=3D"${result#* }"
> +		if [[ "$actual_abspath" =3D=3D "$alt_abspath" ]]; then
> +			relpath=3D"$alt_relpath"
> +		fi
> +
> +		ts=3D"$(now_ms)"
> +		printf '%s,%s,%s,%s,%s\n' "$ts" "$seq" "$id" "$relpath" "$hash" >> "$I=
O_LOG"
> +		seq=3D$((seq + 1))
> +		sleep 0.02
> +	done
> +}
> +
> +rename_worker()
> +{
> +	set +e
> +	local worker_id=3D"$1"
> +	local seq=3D0
> +	local id
> +	local src_rel
> +	local dst_rel
> +	local rc
> +	local ts
> +
> +	while [[ -f "$WORKLOAD_FLAG" ]]; do
> +		id=3D"$(printf '%05d' $((RANDOM % FILE_COUNT)))"
> +
> +		if [[ -f "$DATA_DIR/A/file_$id" ]]; then
> +			src_rel=3D"A/file_$id"
> +			dst_rel=3D"B/file_$id"
> +		elif [[ -f "$DATA_DIR/B/file_$id" ]]; then
> +			src_rel=3D"B/file_$id"
> +			dst_rel=3D"A/file_$id"
> +		else
> +			sleep 0.02
> +			continue
> +		fi
> +
> +		ts=3D"$(now_ms)"
> +		if mv -T "$DATA_DIR/$src_rel" "$DATA_DIR/$dst_rel" 2>/dev/null; then
> +			rc=3D0
> +		else
> +			rc=3D$?
> +		fi
> +		printf '%s,%s,%s,%s,%s,%s,%s\n' "$ts" "$worker_id" "$seq" "$id" "$src_=
rel" "$dst_rel" "$rc" >> "$RENAME_LOG"
> +		seq=3D$((seq + 1))
> +		sleep 0.02
> +	done
> +}
> +
> +random_sleep_seconds()
> +{
> +	local min_sec=3D"$1"
> +	local max_sec=3D"$2"
> +	local wait_sec
> +	local span
> +
> +	span=3D$((max_sec - min_sec + 1))
> +	wait_sec=3D$((min_sec + RANDOM % span))
> +	sleep "$wait_sec"
> +}
> +
> +reset_injector()
> +{
> +	set +e
> +	local trigger_path=3D"$1"
> +	local seq=3D0
> +	local ts
> +	local reason
> +	local rc
> +
> +	while [[ -f "$RESET_FLAG" ]]; do
> +		random_sleep_seconds "$RESET_MIN_SEC" "$RESET_MAX_SEC"
> +		[[ -f "$RESET_FLAG" ]] || break
> +
> +		ts=3D"$(now_ms)"
> +		reason=3D"stress_${seq}_${ts}"
> +		if echo "$reason" | $SUDO tee "$trigger_path" > /dev/null 2>&1; then
> +			rc=3D0
> +		else
> +			rc=3D$?
> +		fi
> +		printf '%s,%s,%s,%s\n' "$ts" "$seq" "$reason" "$rc" >> "$RESET_LOG"
> +		seq=3D$((seq + 1))
> +	done
> +}
> +
> +status_sampler()
> +{
> +	set +e
> +	local status_path=3D"$1"
> +	local ts
> +	local kv_line
> +
> +	while [[ -f "$WORKLOAD_FLAG" || -f "$RESET_FLAG" ]]; do
> +		ts=3D"$(now_ms)"
> +		if $SUDO test -r "$status_path"; then
> +			kv_line=3D"$($SUDO awk -F': ' 'NF>=3D2 {gsub(/ /, "", $1); gsub(/ /, =
"", $2); printf "%s=3D%s;", $1, $2}' "$status_path")"
> +			printf '%s,%s\n' "$ts" "$kv_line" >> "$STATUS_LOG"
> +		fi
> +		sleep 1
> +	done
> +}
> +
> +stop_pid_with_timeout()
> +{
> +	local pid=3D"$1"
> +	local name=3D"$2"
> +	local timeout=3D"$3"
> +	local waited=3D0
> +
> +	if [[ "$pid" -le 0 ]]; then
> +		return 0
> +	fi
> +
> +	while kill -0 "$pid" 2>/dev/null; do
> +		if (( waited >=3D timeout )); then
> +			log_summary "Timeout waiting for $name (pid=3D$pid), sending SIGTERM/=
SIGKILL"
> +			kill -TERM "$pid" 2>/dev/null || true
> +			sleep 1
> +			kill -KILL "$pid" 2>/dev/null || true
> +			wait "$pid" 2>/dev/null || true
> +			return 1
> +		fi
> +		sleep 1
> +		waited=3D$((waited + 1))
> +	done
> +
> +	wait "$pid" 2>/dev/null || true
> +	return 0
> +}
> +
> +detect_privileges()
> +{
> +	if [[ -r "$DEBUGFS_ROOT" ]]; then
> +		SUDO=3D""
> +	elif sudo -n true 2>/dev/null; then
> +		SUDO=3D"sudo"
> +	else
> +		echo "WARNING: $DEBUGFS_ROOT is not readable and passwordless sudo is =
not available" >&2
> +		echo "WARNING: reset injection, debugfs status checks, and dmesg captu=
re will not work" >&2
> +	fi
> +
> +	if $SUDO dmesg > /dev/null 2>&1; then
> +		DMESG_CMD=3D"$SUDO dmesg"
> +	else
> +		DMESG_CMD=3D""
> +		echo "WARNING: dmesg is not accessible; kernel errors (hung tasks) wil=
l not be detected" >&2
> +	fi
> +}
> +
> +check_dmesg()
> +{
> +	local start_epoch=3D"$1"
> +
> +	if [[ -z "$DMESG_CMD" ]]; then
> +		return 0
> +	fi
> +
> +	if ! $DMESG_CMD --since "@$start_epoch" > "$DMESG_LOG" 2>/dev/null; the=
n
> +		if ! $DMESG_CMD > "$DMESG_LOG" 2>/dev/null; then
> +			log_summary "WARNING: dmesg capture failed unexpectedly"
> +			return 0
> +		fi
> +		log_summary "dmesg --since unsupported; captured full dmesg"
> +	fi
> +
> +	if grep -qi "hung task" "$DMESG_LOG" 2>/dev/null; then
> +		log_summary "ERROR: kernel log contains 'hung task' during test window=
"
> +		return 1
> +	fi
> +
> +	return 0
> +}
> +
> +cleanup()
> +{
> +	rm -f "$WORKLOAD_FLAG" "$RESET_FLAG"
> +	local pid
> +	for pid in "${IO_WORKER_PIDS[@]}" "${RENAME_WORKER_PIDS[@]}" "$RESET_PI=
D" "$STATUS_PID"; do
> +		[[ "$pid" -gt 0 ]] 2>/dev/null && kill "$pid" 2>/dev/null || true
> +	done
> +	wait 2>/dev/null || true
> +}
> +
> +parse_args()
> +{
> +	while [[ $# -gt 0 ]]; do
> +		case "$1" in
> +		--mount-point)
> +			MOUNT_POINT=3D"$2"
> +			shift 2
> +			;;
> +		--profile)
> +			PROFILE=3D"$2"
> +			shift 2
> +			;;
> +		--duration-sec)
> +			DURATION_SEC=3D"$2"
> +			shift 2
> +			;;
> +		--cooldown-sec)
> +			COOLDOWN_SEC=3D"$2"
> +			shift 2
> +			;;
> +		--file-count)
> +			FILE_COUNT=3D"$2"
> +			shift 2
> +			;;
> +		--io-workers)
> +			IO_WORKERS=3D"$2"
> +			shift 2
> +			;;
> +		--rename-workers)
> +			RENAME_WORKERS=3D"$2"
> +			shift 2
> +			;;
> +		--out-dir)
> +			OUT_DIR=3D"$2"
> +			shift 2
> +			;;
> +		--client-id)
> +			CLIENT_ID=3D"$2"
> +			shift 2
> +			;;
> +		--debugfs-root)
> +			DEBUGFS_ROOT=3D"$2"
> +			shift 2
> +			;;
> +		--slo-seconds)
> +			SLO_SECONDS=3D"$2"
> +			shift 2
> +			;;
> +		--no-reset)
> +			EXPECT_RESET=3D0
> +			shift
> +			;;
> +		--help|-h)
> +			usage
> +			exit 0
> +			;;
> +		*)
> +			echo "Unknown option: $1" >&2
> +			usage
> +			exit 2
> +			;;
> +		esac
> +	done
> +}
> +
> +main()
> +{
> +	local start_epoch
> +	local trigger_path=3D""
> +	local status_path=3D""
> +	local final_rc=3D0
> +	local reset_enabled=3D0
> +	local i
> +
> +	parse_args "$@"
> +
> +	if [[ -z "$MOUNT_POINT" ]]; then
> +		echo "--mount-point is required" >&2
> +		usage
> +		exit 2
> +	fi
> +
> +	if [[ ! -d "$MOUNT_POINT" ]]; then
> +		echo "SKIP: Mount point does not exist: $MOUNT_POINT" >&2
> +		exit "$KSFT_SKIP"
> +	fi
> +
> +	if ! touch "$MOUNT_POINT/.ceph_reset_test_probe" 2>/dev/null; then
> +		echo "SKIP: Mount point is not writable: $MOUNT_POINT" >&2
> +		exit "$KSFT_SKIP"
> +	fi
> +	rm -f "$MOUNT_POINT/.ceph_reset_test_probe"
> +
> +	if ! command -v python3 > /dev/null 2>&1; then
> +		echo "SKIP: python3 is required but not found in PATH" >&2
> +		exit "$KSFT_SKIP"
> +	fi
> +
> +	if ! stat -f -c '%T' "$MOUNT_POINT" 2>/dev/null | grep -qi ceph; then
> +		echo "WARNING: $MOUNT_POINT does not appear to be a CephFS mount" >&2
> +	fi
> +
> +	detect_privileges
> +
> +	set_profile_defaults
> +	if [[ "$EXPECT_RESET" -eq 0 ]]; then
> +		PROFILE=3D"baseline"
> +		RESET_MIN_SEC=3D0
> +		RESET_MAX_SEC=3D0
> +	fi
> +
> +	if ! [[ "$IO_WORKERS" =3D~ ^[0-9]+$ && "$RENAME_WORKERS" =3D~ ^[0-9]+$ =
]]; then
> +		echo "io-workers and rename-workers must be integers" >&2
> +		exit 2
> +	fi
> +
> +	if [[ "$IO_WORKERS" -le 0 || "$RENAME_WORKERS" -le 0 ]]; then
> +		echo "io-workers and rename-workers must be > 0" >&2
> +		exit 2
> +	fi
> +
> +	if [[ -z "$OUT_DIR" ]]; then
> +		OUT_DIR=3D"/tmp/ceph_reset_stress_${RUN_ID}"
> +	fi
> +	mkdir -p "$OUT_DIR"
> +
> +	WORKLOAD_FLAG=3D"$OUT_DIR/workload.running"
> +	RESET_FLAG=3D"$OUT_DIR/reset.running"
> +
> +	DATA_DIR=3D"$MOUNT_POINT/ceph_reset_stress_${RUN_ID}"
> +	mkdir -p "$DATA_DIR"
> +
> +	IO_LOG=3D"$OUT_DIR/io.log"
> +	RENAME_LOG=3D"$OUT_DIR/rename.log"
> +	RESET_LOG=3D"$OUT_DIR/reset.log"
> +	STATUS_LOG=3D"$OUT_DIR/status.log"
> +	STATUS_BEFORE=3D"$OUT_DIR/reset_status.before"
> +	STATUS_FINAL=3D"$OUT_DIR/reset_status.final"
> +	DMESG_LOG=3D"$OUT_DIR/dmesg.log"
> +	SUMMARY_LOG=3D"$OUT_DIR/summary.log"
> +	REPORT_JSON=3D"$OUT_DIR/validator_report.json"
> +
> +	: > "$IO_LOG"
> +	: > "$RENAME_LOG"
> +	: > "$RESET_LOG"
> +	: > "$STATUS_LOG"
> +	: > "$SUMMARY_LOG"
> +
> +	start_epoch=3D"$(date +%s)"
> +
> +	log_summary "Starting Ceph reset stress test"
> +	log_summary "Profile=3D$PROFILE duration=3D${DURATION_SEC}s cooldown=3D=
${COOLDOWN_SEC}s file_count=3D${FILE_COUNT} io_workers=3D${IO_WORKERS} rena=
me_workers=3D${RENAME_WORKERS}"
> +	[[ -n "$SUDO" ]] && log_summary "Using sudo for privileged operations"
> +	[[ -z "$DMESG_CMD" ]] && log_summary "WARNING: dmesg not available; hun=
g task detection disabled"
> +	log_summary "Artifacts=3D$OUT_DIR"
> +	log_summary "Data dir=3D$DATA_DIR"
> +
> +	init_dataset
> +
> +	if [[ "$EXPECT_RESET" -eq 1 ]]; then
> +		discover_client_id
> +		trigger_path=3D"$DEBUGFS_ROOT/$CLIENT_ID/reset/trigger"
> +		status_path=3D"$DEBUGFS_ROOT/$CLIENT_ID/reset/status"
> +		if ! $SUDO test -w "$trigger_path"; then
> +			echo "SKIP: Reset trigger is not writable: $trigger_path" >&2
> +			exit "$KSFT_SKIP"
> +		fi
> +		if ! $SUDO test -r "$status_path"; then
> +			echo "SKIP: Reset status is not readable: $status_path" >&2
> +			exit "$KSFT_SKIP"
> +		fi
> +		$SUDO cat "$status_path" > "$STATUS_BEFORE" || true
> +		reset_enabled=3D1
> +		log_summary "Using ceph client id: $CLIENT_ID"
> +	fi
> +
> +	trap cleanup EXIT INT TERM
> +
> +	touch "$WORKLOAD_FLAG"
> +	for ((i =3D 0; i < IO_WORKERS; i++)); do
> +		io_worker "$i" &
> +		IO_WORKER_PIDS+=3D("$!")
> +	done
> +
> +	for ((i =3D 0; i < RENAME_WORKERS; i++)); do
> +		rename_worker "$i" &
> +		RENAME_WORKER_PIDS+=3D("$!")
> +	done
> +
> +	if [[ "$reset_enabled" -eq 1 ]]; then
> +		touch "$RESET_FLAG"
> +		reset_injector "$trigger_path" &
> +		RESET_PID=3D$!
> +
> +		status_sampler "$status_path" &
> +		STATUS_PID=3D$!
> +	fi
> +
> +	sleep "$DURATION_SEC"
> +
> +	if [[ "$reset_enabled" -eq 1 ]]; then
> +		rm -f "$RESET_FLAG"
> +		stop_pid_with_timeout "$RESET_PID" "reset_injector" 20 || final_rc=3D1
> +		log_summary "Injector stopped; entering cooldown=3D${COOLDOWN_SEC}s"
> +	fi
> +
> +	sleep "$COOLDOWN_SEC"
> +
> +	rm -f "$WORKLOAD_FLAG"
> +	for i in "${!IO_WORKER_PIDS[@]}"; do
> +		stop_pid_with_timeout "${IO_WORKER_PIDS[$i]}" "io_worker[$i]" 20 || fi=
nal_rc=3D1
> +	done
> +	for i in "${!RENAME_WORKER_PIDS[@]}"; do
> +		stop_pid_with_timeout "${RENAME_WORKER_PIDS[$i]}" "rename_worker[$i]" =
20 || final_rc=3D1
> +	done
> +
> +	if [[ "$reset_enabled" -eq 1 ]]; then
> +		stop_pid_with_timeout "$STATUS_PID" "status_sampler" 10 || final_rc=3D=
1
> +		$SUDO cat "$status_path" > "$STATUS_FINAL" || true
> +	fi
> +
> +	if ! check_dmesg "$start_epoch"; then
> +		final_rc=3D1
> +	fi
> +
> +	if ! python3 "$SCRIPT_DIR/validate_consistency.py" \
> +		--data-dir "$DATA_DIR" \
> +		--file-count "$FILE_COUNT" \
> +		--io-log "$IO_LOG" \
> +		--rename-log "$RENAME_LOG" \
> +		--reset-log "$RESET_LOG" \
> +		--status-final "$STATUS_FINAL" \
> +		--slo-seconds "$SLO_SECONDS" \
> +		--report-json "$REPORT_JSON" \
> +		$( [[ "$reset_enabled" -eq 1 ]] && echo "--expect-reset" ); then
> +		final_rc=3D1
> +	fi
> +
> +	if [[ "$final_rc" -eq 0 ]]; then
> +		log_summary "PASS: stress run completed successfully"
> +	else
> +		log_summary "FAIL: stress run detected one or more failures"
> +	fi
> +
> +	log_summary "Artifacts available in: $OUT_DIR"
> +	exit "$final_rc"
> +}
> +
> +main "$@"

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

