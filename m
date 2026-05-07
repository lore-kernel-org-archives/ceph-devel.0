Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A8F35CB7F
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182308; cv=none; b=t7knYSG6SgcK07FmvZkc3cjycuh4pGYsjIwiCZAMRc2Qb/7/spZn9G6NYMd/HqvaTrbw4EEfAYZkPARK1X2HVndudfrynOIThHuN41X1GV4ZpxM3Ok4oPV5wpDl3p0+FOaugkKpc6F5a+B1eYMNtoE1P0NGc77UVs59BGXa61jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182308; c=relaxed/simple;
	bh=JgSqdl2D/cq1D+mVAwxG8BFZwIUHyOMouM/lubEGT3c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jCeRnljrZ4rTPAtiywZDxqueYZfHa+cYSIT+jvEj3hBudqAnZge96gTlT0zQGtkx09VG17zoavUQ7dKECCIN8+r87+5lt5T/NibyXWf6Fb2Mysvct7M2/34TfslT8ia3dy6+H6gWmXFQbboW5tcpqK4OoLEZbJBIj+BiGPSutA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYvhUGHj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JTvbBcoM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYvhUGHj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JTvbBcoM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778182305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omOviZBPs8i/feB3UPtOLGb6+54cH2ZCUHwxxX1Ffnc=;
	b=eYvhUGHjW6f+/vwfX1xtLgYc09VlOmmp5Tczn2kbdgPQMXfJoaIv8j9wGVJYC1yVNmHeg1
	cA2iCXkzOx7IysH//AYxazZP7OTcpwiFv3XZPHpEQ3CXXi7zL1dQO9Mm/lIBr2Jtbg0XsJ
	SS6MmG5u4x5mNitWVJe3H7MHfME2syY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-PlR14TLhM-uGOQ39-GBLEQ-1; Thu, 07 May 2026 15:31:43 -0400
X-MC-Unique: PlR14TLhM-uGOQ39-GBLEQ-1
X-Mimecast-MFC-AGG-ID: PlR14TLhM-uGOQ39-GBLEQ_1778182303
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bf0b47d2e2so30545007b3.3
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778182302; x=1778787102; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=omOviZBPs8i/feB3UPtOLGb6+54cH2ZCUHwxxX1Ffnc=;
        b=JTvbBcoMEz1tE8i2R1USK/RtZiYypjH6RdRQS1j8b0sFXNj5wuBf7RFQ0Fvls5jLj6
         8QkkUjOPDUuaOAioMVr2Fptt/iaWN8sTBdY9gmzO5ziPJl/7BsZKCE9f6u04roGdiy9R
         ip25B7O27U1/Sr+TFsf+VAzbK0FN2GPVviqFZlq+YK5Mczu+m+9psVfaupZH6yFRBTKa
         AZ32k9SvRidTptPMKSvXlnQToZ5a5fjk2+jpFT658JME4kSPTHK7lYnvA3SdFSXfYs+U
         a6EBcferyRJWpCUFfuCI/uG/qpq+YMsBY59eum4tScaUJzWawamY7eeO2Jddr299LuQS
         Xi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778182302; x=1778787102;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=omOviZBPs8i/feB3UPtOLGb6+54cH2ZCUHwxxX1Ffnc=;
        b=rDXcjdR7KxcngV2XhI+ljdvDu95dv+9ueeSDb0CwHiKIQQyiCjohfrde1uD/w7j473
         WQlkiRDyaCzcZzoWiQLXUA7D9ch3qt4XKBrsHTQE/nYcHcXoNCLS9ZiuBl9Ep1tbHb9q
         rwq5N2bnOdmxTj4+6Ox9DkhDSJxlKHABn0d3kUjnUnpKlfoeofbsgJY2hCcR7CuIqFzK
         Ha7mThCl3zzbtEAwj7a1x/Gwgf3fRbN55TRNdq61D5Q3mFoJYCkDJci1MTCZaDj0PwB5
         GwYjaDTjF5XzNCJiRWZqciuVEirhnDyTJY8o5TLKMU3vSZcEyeW9fZ/Gkr8WVQdU4FXt
         cHAw==
X-Forwarded-Encrypted: i=1; AFNElJ9Rk4chMlKfcUo+1HqJQ9LizD3Q27qPbE/r3RG9dYGhE6hvjqnfn6JDMF8JPxfVo6M8nfuKdtqQ5+/O@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8UcOapoqTvwJ811uidAbMKUJgyYaP8fjBKhwyEseDMKCLHhQQ
	Z+mPk8fj0spF/KOdGeW70J0aT1G1p1q5xCSwdwpdUbC/xuCShOOhRUEHyxFPge/ztXjdStpoogs
	anhr5d+8Y/a0kwwbwLMPypuPX/djgj3AwGCbw1DuBf/wbrBE3AYBq605yhzaVB8EZL+GzjXU=
X-Gm-Gg: Acq92OEv6KJaGPhQ63HJqfE4CquZ/PEdt1s0HNrlDOUaVDu3fAJNtXnW7kS95SWUJiO
	4tAlfTBtuEe0flB5k/hN4ug+6Gn+gvIc9ozFw9XyXeWXR4rIgegn50RPVKFK2UCyWTUB2nMVr83
	SrvCmfNillZdA/GXASHqHt6CspbtDKaSbrgYxpC7j7yYIfr/q+YssCiPf3v9xGSdUlJakdSB12f
	QXsIbfHPSvGarV7qN1GObXxxx0tQbh/tA5/C+KZLOZjZwU9P4QOgpCVowqqLW4FwG2I8rhZdS6C
	fuE26aOY3sdCf2qoSljYantl1itgYDDRXWrdm5h65jHBgaJZ0MAYgLzL0Exo6uHjtv4SJMVby46
	hutUluOwhfqEsBFJXrXL3h3LrJdN/y0qZzcaMtg2IRvpgQlZX52KQ
X-Received: by 2002:a53:ad4b:0:b0:651:c024:5733 with SMTP id 956f58d0204a3-65c79c695e2mr6673161d50.13.1778182302194;
        Thu, 07 May 2026 12:31:42 -0700 (PDT)
X-Received: by 2002:a53:ad4b:0:b0:651:c024:5733 with SMTP id 956f58d0204a3-65c79c695e2mr6673084d50.13.1778182300865;
        Thu, 07 May 2026 12:31:40 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d93341bb8sm102816d50.4.2026.05.07.12.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:31:40 -0700 (PDT)
Message-ID: <90ef613d8829a03647c3cbbae754af6f6a734031.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v4 09/11] selftests: ceph: add reset
 corner-case tests
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Thu, 07 May 2026 12:31:39 -0700
In-Reply-To: <20260507122737.2804094-10-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
	 <20260507122737.2804094-10-amarkuze@redhat.com>
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
> Add targeted corner-case tests for the CephFS manual session reset
> feature.  Four sequential tests cover:
>=20
>   [1/4] ebusy_rejection       - second reset rejected while first in-flig=
ht
>   [2/4] dirty_caps_at_reset   - reset with unflushed dirty caps
>   [3/4] flock_after_reset     - stale lock EIO + fresh lock after holder =
exit
>   [4/4] unmount_during_reset  - umount during active reset (ESHUTDOWN pat=
h)
>=20
> Requires: mounted CephFS, debugfs access (root), flock(1) utility.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  .../filesystems/ceph/reset_corner_cases.sh    | 646 ++++++++++++++++++
>  1 file changed, 646 insertions(+)
>  create mode 100755 tools/testing/selftests/filesystems/ceph/reset_corner=
_cases.sh
>=20
> diff --git a/tools/testing/selftests/filesystems/ceph/reset_corner_cases.=
sh b/tools/testing/selftests/filesystems/ceph/reset_corner_cases.sh
> new file mode 100755
> index 000000000000..a6dae84a616d
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/ceph/reset_corner_cases.sh
> @@ -0,0 +1,646 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# CephFS client reset corner case tests.
> +# Runs a checklist of targeted tests that exercise specific reset
> +# code paths not covered by the stress tests.
> +#
> +# Requires: mounted CephFS, debugfs access (root), flock(1) utility.
> +
> +set -uo pipefail
> +
> +KSFT_SKIP=3D4
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
> +DEBUGFS_ROOT=3D"/sys/kernel/debug/ceph"
> +DEBUGFS_CLIENT=3D""
> +TRIGGER_PATH=3D""
> +STATUS_PATH=3D""
> +TEMP_MNT=3D""
> +
> +PASS_COUNT=3D0
> +FAIL_COUNT=3D0
> +SKIP_COUNT=3D0
> +TOTAL=3D4
> +
> +log()
> +{
> +	printf '[%s] %s\n' "$(date -u +%H:%M:%S)" "$1"
> +}
> +
> +result()
> +{
> +	local num=3D"$1"
> +	local name=3D"$2"
> +	local status=3D"$3"
> +	local detail=3D"${4:-}"
> +
> +	case "$status" in
> +	PASS) PASS_COUNT=3D$((PASS_COUNT + 1)) ;;
> +	FAIL) FAIL_COUNT=3D$((FAIL_COUNT + 1)) ;;
> +	SKIP) SKIP_COUNT=3D$((SKIP_COUNT + 1)) ;;
> +	esac
> +
> +	if [[ -n "$detail" ]]; then
> +		printf '[%d/%d] %-30s %s  (%s)\n' "$num" "$TOTAL" "$name" "$status" "$=
detail"
> +	else
> +		printf '[%d/%d] %-30s %s\n' "$num" "$TOTAL" "$name" "$status"
> +	fi
> +}
> +
> +read_status_field()
> +{
> +	local field=3D"$1"
> +	awk -F': ' -v key=3D"$field" '$1 =3D=3D key {print $2}' "$STATUS_PATH" =
2>/dev/null
> +}
> +
> +wait_reset_done()
> +{
> +	local timeout=3D"${1:-30}"
> +	local elapsed=3D0
> +
> +	while [[ "$(read_status_field "phase")" !=3D "idle" ]]; do
> +		sleep 1
> +		elapsed=3D$((elapsed + 1))
> +		if [[ "$elapsed" -ge "$timeout" ]]; then
> +			return 1
> +		fi
> +	done
> +	return 0
> +}
> +
> +list_reset_clients()
> +{
> +	local entry
> +
> +	for entry in "$DEBUGFS_ROOT"/*/; do
> +		entry=3D"$(basename "$entry")"
> +		[[ -d "$DEBUGFS_ROOT/$entry/reset" ]] || continue
> +		[[ -w "$DEBUGFS_ROOT/$entry/reset/trigger" ]] || continue
> +		printf '%s\n' "$entry"
> +	done
> +}
> +
> +wait_status_nonidle()
> +{
> +	local status_path=3D"$1"
> +	local timeout=3D"${2:-10}"
> +	local polls=3D$((timeout * 10))
> +	local phase
> +
> +	while [[ "$polls" -gt 0 ]]; do
> +		phase=3D"$(awk -F': ' '$1 =3D=3D "phase" {print $2}' "$status_path" 2>=
/dev/null)"
> +		if [[ -n "$phase" && "$phase" !=3D "idle" ]]; then
> +			return 0
> +		fi
> +		sleep 0.1
> +		polls=3D$((polls - 1))
> +	done
> +
> +	return 1
> +}
> +
> +discover_debugfs()
> +{
> +	local candidates=3D()
> +	local entry
> +
> +	if [[ -n "$DEBUGFS_CLIENT" ]]; then
> +		if [[ ! -d "$DEBUGFS_ROOT/$DEBUGFS_CLIENT/reset" ]]; then
> +			echo "SKIP: reset debugfs not found for $DEBUGFS_CLIENT" >&2
> +			exit "$KSFT_SKIP"
> +		fi
> +		return 0
> +	fi
> +
> +	for entry in "$DEBUGFS_ROOT"/*/; do
> +		entry=3D"$(basename "$entry")"
> +		[[ -d "$DEBUGFS_ROOT/$entry/reset" ]] || continue
> +		[[ -w "$DEBUGFS_ROOT/$entry/reset/trigger" ]] || continue
> +		candidates+=3D("$entry")
> +	done
> +
> +	if [[ ${#candidates[@]} -eq 0 ]]; then
> +		echo "SKIP: No writable Ceph reset interface found under $DEBUGFS_ROOT=
" >&2
> +		exit "$KSFT_SKIP"
> +	fi
> +
> +	if [[ ${#candidates[@]} -gt 1 ]]; then
> +		echo "SKIP: Multiple Ceph clients found: ${candidates[*]}. Use --clien=
t-id." >&2
> +		exit "$KSFT_SKIP"
> +	fi
> +
> +	DEBUGFS_CLIENT=3D"${candidates[0]}"
> +}
> +
> +# --- Test 1: ebusy_rejection ------------------------------------------=
------
> +#
> +# Trigger a reset while another is guaranteed in-flight.  Creates
> +# dirty state so the first reset enters DRAINING (which takes
> +# measurable time), then polls until phase !=3D idle and issues the
> +# second trigger.  The second trigger must fail (the kernel returns
> +# -EBUSY), and only one reset must be counted in the accounting.
> +
> +test_ebusy_rejection()
> +{
> +	local num=3D1
> +	local name=3D"ebusy_rejection"
> +	local testfile=3D"$MOUNT_POINT/.reset_corner_ebusy_$$"
> +	local tc_before tc_after sc_before sc_after second_rc phase elapsed
> +
> +	tc_before=3D"$(read_status_field "trigger_count")"
> +	sc_before=3D"$(read_status_field "success_count")"
> +
> +	# Create dirty state so the first reset enters DRAINING
> +	echo "ebusy_dirty_data" > "$testfile"
> +	sync "$testfile"
> +
> +	python3 -c "
> +import os, sys
> +fd =3D os.open('$testfile', os.O_WRONLY | os.O_APPEND)
> +os.write(fd, b'dirty_for_ebusy_test\n')
> +sys.stdout.write('written')
> +" 2>/dev/null || {
> +		result "$num" "$name" FAIL "dirty write failed"
> +		rm -f "$testfile"
> +		return
> +	}
> +
> +	# Trigger the first reset -- it will drain dirty state
> +	echo "ebusy_first" > "$TRIGGER_PATH" 2>/dev/null || {
> +		result "$num" "$name" FAIL "first trigger failed"
> +		rm -f "$testfile"
> +		return
> +	}
> +
> +	# Poll until phase is non-idle (quiescing or draining)
> +	elapsed=3D0
> +	while true; do
> +		phase=3D"$(read_status_field "phase")"
> +		if [[ "$phase" !=3D "idle" ]]; then
> +			break
> +		fi
> +		sleep 0.1
> +		elapsed=3D$((elapsed + 1))
> +		if [[ "$elapsed" -ge 50 ]]; then
> +			result "$num" "$name" SKIP \
> +				"first reset completed before overlap could be tested"
> +			rm -f "$testfile" 2>/dev/null
> +			return
> +		fi
> +	done
> +
> +	# Issue the second trigger -- should be rejected with EBUSY
> +	second_rc=3D0
> +	echo "ebusy_second" > "$TRIGGER_PATH" 2>/dev/null && second_rc=3D0 || s=
econd_rc=3D$?
> +
> +	if ! wait_reset_done 30; then
> +		result "$num" "$name" FAIL "first reset never completed"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	tc_after=3D"$(read_status_field "trigger_count")"
> +	sc_after=3D"$(read_status_field "success_count")"
> +
> +	if [[ "$((tc_after - tc_before))" -ne 1 ]]; then
> +		result "$num" "$name" FAIL "trigger_count +$((tc_after - tc_before)), =
expected +1"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	if [[ "$((sc_after - sc_before))" -ne 1 ]]; then
> +		result "$num" "$name" FAIL "success_count +$((sc_after - sc_before)), =
expected +1"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	if [[ "$second_rc" -eq 0 ]]; then
> +		result "$num" "$name" FAIL "second trigger did not return error"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	rm -f "$testfile" 2>/dev/null
> +	result "$num" "$name" PASS
> +}
> +
> +# --- Test 2: dirty_caps_at_reset --------------------------------------=
------
> +#
> +# Write to a file without fsync (dirty caps), trigger reset, then
> +# verify the file is not corrupt.  Manual reset drains dirty caps
> +# before teardown (best-effort, 5s timeout).  For a non-stuck cap
> +# the dirty write should be flushed during drain and persist.
> +# If the drain window is too short, only the synced first line
> +# persists -- that is acceptable (data loss is documented for
> +# unflushed writes).
> +
> +test_dirty_caps_at_reset()
> +{
> +	local num=3D2
> +	local name=3D"dirty_caps_at_reset"
> +	local testfile=3D"$MOUNT_POINT/.reset_corner_dirty_caps_$$"
> +	local content_after line_count sc_before sc_after le
> +
> +	sc_before=3D"$(read_status_field "success_count")"
> +
> +	echo "line_1_before_dirty_write" > "$testfile"
> +	sync "$testfile"
> +
> +	python3 -c "
> +import os, sys
> +fd =3D os.open('$testfile', os.O_WRONLY | os.O_APPEND)
> +os.write(fd, b'line_2_dirty_no_fsync\n')
> +# deliberately no fsync -- leave caps dirty
> +sys.stdout.write('written')
> +" 2>/dev/null || {
> +		result "$num" "$name" FAIL "dirty write failed"
> +		rm -f "$testfile"
> +		return
> +	}
> +
> +	echo "dirty_caps_test" > "$TRIGGER_PATH" 2>/dev/null || {
> +		result "$num" "$name" FAIL "reset trigger failed"
> +		rm -f "$testfile"
> +		return
> +	}
> +
> +	if ! wait_reset_done 30; then
> +		result "$num" "$name" FAIL "reset did not complete"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	sc_after=3D"$(read_status_field "success_count")"
> +	if [[ "$sc_after" -le "$sc_before" ]]; then
> +		result "$num" "$name" FAIL "success_count did not increment (reset not=
 exercised)"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	sync "$testfile" 2>/dev/null || true
> +	content_after=3D"$(cat "$testfile" 2>/dev/null)" || {
> +		result "$num" "$name" FAIL "cannot read file after reset"
> +		rm -f "$testfile"
> +		return
> +	}
> +
> +	if [[ -z "$content_after" ]]; then
> +		result "$num" "$name" FAIL "file is empty after reset"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	line_count=3D"$(echo "$content_after" | wc -l)"
> +	if [[ "$line_count" -lt 1 ]]; then
> +		result "$num" "$name" FAIL "file has $line_count lines, expected >=3D =
1"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	echo "$content_after" | head -1 | grep -q "line_1_before_dirty_write" |=
| {
> +		result "$num" "$name" FAIL "first line corrupted"
> +		rm -f "$testfile"
> +		return
> +	}
> +
> +	le=3D"$(read_status_field "last_errno")"
> +	if [[ "$le" !=3D "0" ]]; then
> +		result "$num" "$name" FAIL "last_errno=3D$le, expected 0"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	rm -f "$testfile"
> +	result "$num" "$name" PASS "file intact ($line_count lines)"
> +}
> +
> +# --- Test 3: flock_after_reset ----------------------------------------=
------
> +#
> +# Take an exclusive flock, trigger reset, verify stale lock state is
> +# marked with CEPH_I_ERROR_FILELOCK (same-client flock attempt returns
> +# EIO).  After the original holder exits (releasing the local lock
> +# reference and clearing the error flag), a fresh lock can be acquired.
> +#
> +# The lock holder uses the fd-based flock form with exec, so killing
> +# $lock_pid closes the lock fd immediately (no orphaned child with an
> +# inherited fd copy that would prevent the VFS flock release).
> +
> +test_flock_after_reset()
> +{
> +	local num=3D3
> +	local name=3D"flock_after_reset"
> +	local testfile=3D"$MOUNT_POINT/.reset_corner_flock_$$"
> +	local lock_pid probe_rc sc_before sc_after
> +
> +	sc_before=3D"$(read_status_field "success_count")"
> +
> +	echo "flock_test_content" > "$testfile"
> +	sync "$testfile"
> +
> +	# Hold lock via fd in a subshell; exec ensures killing $lock_pid
> +	# closes the lock fd directly (no fork/child fd inheritance).
> +	(
> +		exec 9<"$testfile"
> +		flock --exclusive --nonblock 9 || exit 1
> +		exec sleep 300
> +	) &
> +	lock_pid=3D$!
> +	sleep 0.5
> +
> +	if ! kill -0 "$lock_pid" 2>/dev/null; then
> +		result "$num" "$name" FAIL "flock holder died immediately"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	echo "flock_after_reset_test" > "$TRIGGER_PATH" 2>/dev/null || {
> +		kill "$lock_pid" 2>/dev/null; wait "$lock_pid" 2>/dev/null
> +		result "$num" "$name" FAIL "reset trigger failed"
> +		rm -f "$testfile"
> +		return
> +	}
> +
> +	if ! wait_reset_done 30; then
> +		kill "$lock_pid" 2>/dev/null; wait "$lock_pid" 2>/dev/null
> +		result "$num" "$name" FAIL "reset did not complete"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	sc_after=3D"$(read_status_field "success_count")"
> +	if [[ "$sc_after" -le "$sc_before" ]]; then
> +		kill "$lock_pid" 2>/dev/null; wait "$lock_pid" 2>/dev/null
> +		result "$num" "$name" FAIL "success_count did not increment"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	# After teardown, CEPH_I_ERROR_FILELOCK is set on the inode.
> +	# A same-client lock attempt should fail (EIO), NOT succeed.
> +	probe_rc=3D0
> +	flock --exclusive --nonblock "$testfile" true 2>/dev/null && probe_rc=
=3D0 || probe_rc=3D$?
> +	if [[ "$probe_rc" -eq 0 ]]; then
> +		kill "$lock_pid" 2>/dev/null; wait "$lock_pid" 2>/dev/null
> +		result "$num" "$name" FAIL \
> +			"same-client probe succeeded, expected EIO from stale lock state"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	# Kill the holder -- the exec'd sleep IS $lock_pid, so killing it
> +	# closes fd 9 directly.  VFS flock release fires ceph_fl_release_lock()=
,
> +	# which decrements i_filelock_ref to 0 and clears CEPH_I_ERROR_FILELOCK=
.
> +	kill "$lock_pid" 2>/dev/null
> +	wait "$lock_pid" 2>/dev/null
> +
> +	# After the holder exits, a fresh lock should be acquirable.
> +	# The reset teardown sends SESSION_REQUEST_CLOSE so the MDS
> +	# releases locks promptly, but retry briefly in case the
> +	# message races with the connection close.
> +	local attempt
> +	probe_rc=3D1
> +	for attempt in 1 2 3 4 5; do
> +		probe_rc=3D0
> +		flock --exclusive --nonblock "$testfile" true 2>/dev/null \
> +			&& probe_rc=3D0 || probe_rc=3D$?
> +		[[ "$probe_rc" -eq 0 ]] && break
> +		sleep 1
> +	done
> +	if [[ "$probe_rc" -ne 0 ]]; then
> +		result "$num" "$name" FAIL \
> +			"cannot acquire fresh lock after holder exit (rc=3D$probe_rc, ${attem=
pt} attempts)"
> +		rm -f "$testfile"
> +		return
> +	fi
> +
> +	# Verify file content survived
> +	grep -q "flock_test_content" "$testfile" 2>/dev/null || {
> +		result "$num" "$name" FAIL "file content corrupted after reset"
> +		rm -f "$testfile"
> +		return
> +	}
> +
> +	rm -f "$testfile"
> +	result "$num" "$name" PASS "stale lock detected, fresh lock acquired af=
ter holder exit"
> +}
> +
> +# --- Test 4: unmount_during_reset -------------------------------------=
------
> +#
> +# Mount a fresh CephFS, trigger reset, immediately unmount. The
> +# ceph_mdsc_destroy() path must wake blocked waiters with -ESHUTDOWN
> +# and not hang.
> +
> +test_unmount_during_reset()
> +{
> +	local num=3D4
> +	local name=3D"unmount_during_reset"
> +	local temp_mnt=3D"/tmp/ceph_corner_mnt_$$"
> +	local mount_opts=3D""
> +	local mount_src=3D""
> +	local temp_trigger=3D""
> +	local temp_status=3D""
> +	local temp_client=3D""
> +	local temp_file=3D"$temp_mnt/.reset_corner_umount_$$"
> +	local phase=3D""
> +	local trigger_ok=3D0
> +	local attempt
> +	local -a new_clients=3D()
> +	declare -A existing_clients=3D()
> +
> +	mount_src=3D"$(awk -v mp=3D"$MOUNT_POINT" '$2 =3D=3D mp && $3 =3D=3D "c=
eph" {print $1; exit}' /proc/mounts 2>/dev/null)"
> +	mount_opts=3D"$(awk -v mp=3D"$MOUNT_POINT" '$2 =3D=3D mp && $3 =3D=3D "=
ceph" {print $4; exit}' /proc/mounts 2>/dev/null)"
> +
> +	if [[ -z "$mount_src" ]]; then
> +		result "$num" "$name" SKIP "cannot determine mount source from /proc/m=
ounts"
> +		return
> +	fi
> +
> +	while IFS=3D read -r existing; do
> +		[[ -n "$existing" ]] || continue
> +		existing_clients["$existing"]=3D1
> +	done < <(list_reset_clients)
> +
> +	mkdir -p "$temp_mnt"
> +
> +	if ! mount -t ceph "$mount_src" "$temp_mnt" -o "$mount_opts" 2>/dev/nul=
l; then
> +		result "$num" "$name" SKIP "cannot mount additional CephFS instance"
> +		rmdir "$temp_mnt" 2>/dev/null
> +		return
> +	fi
> +
> +	ls "$temp_mnt" > /dev/null 2>&1
> +	sync
> +	sleep 1
> +
> +	for attempt in $(seq 1 50); do
> +		new_clients=3D()
> +		while IFS=3D read -r entry; do
> +			[[ -n "$entry" ]] || continue
> +			if [[ -n "${existing_clients[$entry]+x}" ]]; then
> +				continue
> +			fi
> +			new_clients+=3D("$entry")
> +		done < <(list_reset_clients)
> +
> +		if [[ "${#new_clients[@]}" -eq 1 ]]; then
> +			temp_client=3D"${new_clients[0]}"
> +			break
> +		fi
> +
> +		if [[ "${#new_clients[@]}" -gt 1 ]]; then
> +			break
> +		fi
> +
> +		sleep 0.1
> +	done
> +
> +	if [[ -z "$temp_client" ]]; then
> +		umount "$temp_mnt" 2>/dev/null || umount -l "$temp_mnt" 2>/dev/null
> +		rmdir "$temp_mnt" 2>/dev/null
> +		result "$num" "$name" SKIP "cannot identify debugfs client for temp mo=
unt"
> +		return
> +	fi
> +
> +	if [[ "${#new_clients[@]}" -gt 1 ]]; then
> +		umount "$temp_mnt" 2>/dev/null || umount -l "$temp_mnt" 2>/dev/null
> +		rmdir "$temp_mnt" 2>/dev/null
> +		result "$num" "$name" SKIP "multiple new debugfs clients appeared"
> +		return
> +	fi
> +
> +	temp_trigger=3D"$DEBUGFS_ROOT/$temp_client/reset/trigger"
> +	temp_status=3D"$DEBUGFS_ROOT/$temp_client/reset/status"
> +
> +	echo "umount_dirty_seed" > "$temp_file" 2>/dev/null || {
> +		umount "$temp_mnt" 2>/dev/null || umount -l "$temp_mnt" 2>/dev/null
> +		rmdir "$temp_mnt" 2>/dev/null
> +		result "$num" "$name" FAIL "cannot create dirty state on temp mount"
> +		return
> +	}
> +	sync "$temp_file"
> +	python3 -c "
> +import os, sys
> +fd =3D os.open('$temp_file', os.O_WRONLY | os.O_APPEND)
> +os.write(fd, b'dirty_for_umount_test\\n')
> +os.close(fd)
> +" 2>/dev/null || {
> +		umount "$temp_mnt" 2>/dev/null || umount -l "$temp_mnt" 2>/dev/null
> +		rmdir "$temp_mnt" 2>/dev/null
> +		result "$num" "$name" FAIL "cannot dirty temp mount for reset overlap"
> +		return
> +	}
> +
> +	echo "unmount_test" > "$temp_trigger" 2>/dev/null && trigger_ok=3D1 || =
trigger_ok=3D0
> +	if [[ "$trigger_ok" -ne 1 ]]; then
> +		umount "$temp_mnt" 2>/dev/null || umount -l "$temp_mnt" 2>/dev/null
> +		rmdir "$temp_mnt" 2>/dev/null
> +		result "$num" "$name" FAIL "cannot trigger reset on temp mount"
> +		return
> +	fi
> +
> +	if ! wait_status_nonidle "$temp_status" 10; then
> +		phase=3D"$(awk -F': ' '$1 =3D=3D "phase" {print $2}' "$temp_status" 2>=
/dev/null)"
> +		umount "$temp_mnt" 2>/dev/null || umount -l "$temp_mnt" 2>/dev/null
> +		rmdir "$temp_mnt" 2>/dev/null
> +		result "$num" "$name" FAIL \
> +			"reset never became active before umount (phase=3D${phase:-unknown})"
> +		return
> +	fi
> +
> +	local umount_ok=3D0
> +	timeout 30 umount "$temp_mnt" 2>/dev/null && umount_ok=3D1
> +
> +	if [[ "$umount_ok" -ne 1 ]]; then
> +		umount -l "$temp_mnt" 2>/dev/null || true
> +		rmdir "$temp_mnt" 2>/dev/null
> +		result "$num" "$name" FAIL "umount hung for >30s"
> +		return
> +	fi
> +
> +	rmdir "$temp_mnt" 2>/dev/null
> +
> +	ls "$MOUNT_POINT" > /dev/null 2>&1 || {
> +		result "$num" "$name" FAIL "original mount unhealthy after test"
> +		return
> +	}
> +
> +	result "$num" "$name" PASS
> +}
> +
> +# --- Main -------------------------------------------------------------=
-------
> +
> +usage()
> +{
> +	cat <<EOF
> +Usage: $0 --mount-point <path> [--client-id <id>] [--debugfs-root <path>=
]
> +
> +Runs targeted corner-case tests for the CephFS client reset feature.
> +Requires root (debugfs access) and a mounted CephFS filesystem.
> +
> +Options:
> +  --mount-point PATH     CephFS mount point (required)
> +  --client-id ID         Ceph debugfs client id (auto-detect if one clie=
nt)
> +  --debugfs-root PATH    Debugfs ceph root (default: /sys/kernel/debug/c=
eph)
> +  --help                 Show this message
> +EOF
> +}
> +
> +main()
> +{
> +	while [[ $# -gt 0 ]]; do
> +		case "$1" in
> +		--mount-point)   MOUNT_POINT=3D"$2"; shift 2 ;;
> +		--client-id)     DEBUGFS_CLIENT=3D"$2"; shift 2 ;;
> +		--debugfs-root)  DEBUGFS_ROOT=3D"$2"; shift 2 ;;
> +		--help|-h)       usage; exit 0 ;;
> +		*)               echo "Unknown option: $1" >&2; usage; exit 2 ;;
> +		esac
> +	done
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
> +	discover_debugfs
> +	TRIGGER_PATH=3D"$DEBUGFS_ROOT/$DEBUGFS_CLIENT/reset/trigger"
> +	STATUS_PATH=3D"$DEBUGFS_ROOT/$DEBUGFS_CLIENT/reset/status"
> +
> +	log "CephFS client reset corner case tests"
> +	log "Mount: $MOUNT_POINT"
> +	log "Client: $DEBUGFS_CLIENT"
> +	echo ""
> +
> +	test_ebusy_rejection
> +	test_dirty_caps_at_reset
> +	test_flock_after_reset
> +	test_unmount_during_reset
> +
> +	echo ""
> +	echo "Results: $PASS_COUNT passed, $FAIL_COUNT failed, $SKIP_COUNT skip=
ped (of $TOTAL)"
> +
> +	if [[ "$FAIL_COUNT" -gt 0 ]]; then
> +		exit 1
> +	fi
> +	exit 0
> +}
> +
> +main "$@"

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

