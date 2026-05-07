Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67083E92AC
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181877; cv=none; b=ZzNB5bAHTbluIv8ib4wxSO0WVMCZYZaI62EFY2BDyKX/YWFZzZlwru3D23JMsRBlYdBwoeIdYFMZXV5in2gZlSZl9y+bgo9Jg05YVoXmBXrpk3oaVkRtGbqiWYLwSavzizReuXP03CL8po9fxzVaJzcFzUsxtziu/1gN+Gk504w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181877; c=relaxed/simple;
	bh=Ldcy+NfeCKQL4gdHy6jOYRlm7dqkx4JsUXfsmQ7fkyE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m+J3Z+eplrI2z2216MFPeVVVqzIpxJ28R3XLUklw3bjyrecujdrsfNTi0FcVVyNUKImWzfHeLj5i27CD8ViLkbxhwR/g/KdvLakpi9oZ1kF/v4liL3WWfSDFqY1WLglY/FMqTBZzFEvvvdv3jjhedssYbUZs+EOOLRP4Wf7DjtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAolMxtH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwjP0Xlq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAolMxtH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwjP0Xlq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778181874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJas2sGqLwB+vZWX5Y6mMjONuOkT/m3kcsxZweoSdiM=;
	b=CAolMxtHN47Sg+kbhLQw2qp98+bCqHmyFza2pjdQCFhqQQPSynnTMwmW435QEAnQMOUSxw
	ZvK2lrlxUMLDAULFWLt0JOHs1rzGytt4TaFONs1dzqbxUFJZTJ1OuFHAx8RG/rkDBkoTdf
	TsGxvT1kSApvKXJZIxFyybO3oKlVFng=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-UnPZ28CfPBCcZhznLE_X2A-1; Thu, 07 May 2026 15:24:33 -0400
X-MC-Unique: UnPZ28CfPBCcZhznLE_X2A-1
X-Mimecast-MFC-AGG-ID: UnPZ28CfPBCcZhznLE_X2A_1778181873
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-65c223da702so2647139d50.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778181873; x=1778786673; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eJas2sGqLwB+vZWX5Y6mMjONuOkT/m3kcsxZweoSdiM=;
        b=GwjP0XlqJh6XXpLvqEBjvQ+LIomHQZFIQvFWw1x6ojH0CRmSA27Rp5KekHwwb6HSBM
         WchnH/0ICUu8kRP8XfGXFwj8uvIrLDjw7lqSkj2OaIQabvFwU5CwIsTfRBeZqL4fTHMA
         lwxmnz9LSh7Gknj1ONYKrvY1e1HE3ogexjovw42GbnfrRAlb5oTfv7P0dH0T0MQNw5/f
         LnhqE9fcc06z4bBUnzqUtBK4L6MTJGrYRjaGoUq9Qu5KTQ+BIWkKlc8wnFLI0Yp7/9zP
         ZZaVQfOMuSy+N8AHsMWoXwCpR6uCw3LgADjkQG2D3CFVXfpRom/CTwxneBwBNX/BcR+L
         FuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181873; x=1778786673;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJas2sGqLwB+vZWX5Y6mMjONuOkT/m3kcsxZweoSdiM=;
        b=s3U4KPRmH8Lc+YMu13apK9ws8QGaemyG5Zt1G1cJLWT9EqqVgsegqCapKQeAbAMP+Y
         krhWfCg6kr/u9GlVgWW5EEt36VqqtjN12dneh5uzst7RVbW6kZVIrEeMqGBuuvv1N4hN
         1veqpY0g4kP03WbKjEDsh2K4crsFyileY7L0BQd1UwwO4gnZvd1K9ujygFIMZ20ibl5i
         /gNII3dyilktU5PT04o3VWjJdClNmPlUwjCpMMuOgPsKzvgrRAX3GtFe7mBkpFY6ThIz
         qvBVFa7EwPf0EcyWe6tNDA6bCTuMZ73s+Nxj3XxhZtJk3cwKwd7t7UlqQ6/4ASYNrjjX
         RA/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Hm0ET4asUiuKWoBO0MZf3LrZDH/ZtCiIab35BWftFdNBoTziugWnpUzdL5XUDdg0G0eTE2c+ExN7U@vger.kernel.org
X-Gm-Message-State: AOJu0YwLRmUpOnK19sh6XlyzABTtq1ap6AxU8hfHm0EJnMj/aCXR/1h/
	j7vKDsjNiMSDzo0hXubLcIkqoh81Dhn8WycU3/X4UGQAUHUHZGanUTNgP9PtztkJUFyYHCNlpzV
	9dw+I7TOLftFF7to/o+DKaFY21xCXHa51HaPw5zGj3VV6KBm0fE36XR3zN/A/CgA=
X-Gm-Gg: Acq92OFlkLemD0Cfv/WidMUju8/2cFO3lbeZn/B5S1sx61u7tk8iSSqUX8WufJNGSmt
	64aGf0X348uHCH/2ytM8hM87yQxDpuhQDLLk3Dz5ZDv6n7DSksrW2Eqs4Z5zRPJUVR70ZgmUns8
	6/xowAobdCz2aSv6+UgS6a9VHLQRAM60MXjs2NHIy7wdwJGAUAhWM+l8Etf30EfTvAFCe1OF7OV
	Qwk66KMTrmWt3TXovW6ACxTjxVwIY+HwLLLOGElruPzUP4op63vxEZYvgSUPbYolziQDTqypLoo
	bs7jSROeABXttlWU68Bt2ES7AXWYRPouiLpxjQTAVM+XccptIWtwSzx9u6ClvWuuEgaEVl/Uu6G
	tN22UFtF/qBMb3/jabh8L2Ncr0VAOUujvcLoSw4sP3gQTU6kjqtqK
X-Received: by 2002:a05:690e:480a:b0:650:3952:3d2a with SMTP id 956f58d0204a3-65c79877bf0mr7764023d50.8.1778181872765;
        Thu, 07 May 2026 12:24:32 -0700 (PDT)
X-Received: by 2002:a05:690e:480a:b0:650:3952:3d2a with SMTP id 956f58d0204a3-65c79877bf0mr7763998d50.8.1778181872192;
        Thu, 07 May 2026 12:24:32 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d935f47eesm78722d50.18.2026.05.07.12.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:24:31 -0700 (PDT)
Message-ID: <c7ec42b9399464cfc0c4f7707df810e07e4a2630.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH v4 07/11] selftests: ceph: add reset
 consistency checker
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, idryomov@gmail.com
Date: Thu, 07 May 2026 12:24:30 -0700
In-Reply-To: <20260507122737.2804094-8-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
	 <20260507122737.2804094-8-amarkuze@redhat.com>
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
> Add a Python post-run validator for the CephFS client reset stress
> test.  The script reads data files written by the stress runner and
> checks that every file was either written completely or is missing,
> with no partial or corrupted content.
>=20
> This is a prerequisite for the stress test script which invokes it
> after each run.
>=20
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  .../filesystems/ceph/validate_consistency.py  | 297 ++++++++++++++++++
>  1 file changed, 297 insertions(+)
>  create mode 100755 tools/testing/selftests/filesystems/ceph/validate_con=
sistency.py
>=20
> diff --git a/tools/testing/selftests/filesystems/ceph/validate_consistenc=
y.py b/tools/testing/selftests/filesystems/ceph/validate_consistency.py
> new file mode 100755
> index 000000000000..c230a59bdb3a
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/ceph/validate_consistency.py
> @@ -0,0 +1,297 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import argparse
> +import bisect
> +import hashlib
> +import json
> +import os
> +from pathlib import Path
> +
> +
> +def sha256_file(path: Path) -> str:
> +    digest =3D hashlib.sha256()
> +    with path.open("rb") as handle:
> +        while True:
> +            chunk =3D handle.read(1 << 20)
> +            if not chunk:
> +                break
> +            digest.update(chunk)
> +    return digest.hexdigest()
> +
> +
> +def parse_io_log(path: Path):
> +    records =3D []
> +    if not path.exists():
> +        return records
> +    with path.open("r", encoding=3D"utf-8") as handle:
> +        for line_no, line in enumerate(handle, 1):
> +            line =3D line.strip()
> +            if not line:
> +                continue
> +            parts =3D line.split(",")
> +            if len(parts) !=3D 5:
> +                raise ValueError(f"io log line {line_no}: expected 5 col=
umns, got {len(parts)}")
> +            ts_ms, seq, logical_id, relpath, digest =3D parts
> +            records.append(
> +                {
> +                    "ts_ms": int(ts_ms),
> +                    "seq": int(seq),
> +                    "logical_id": int(logical_id),
> +                    "relpath": relpath,
> +                    "digest": digest,
> +                }
> +            )
> +    return records
> +
> +
> +def parse_rename_log(path: Path):
> +    records =3D []
> +    if not path.exists():
> +        return records
> +    with path.open("r", encoding=3D"utf-8") as handle:
> +        for line_no, line in enumerate(handle, 1):
> +            line =3D line.strip()
> +            if not line:
> +                continue
> +            parts =3D line.split(",")
> +            if len(parts) =3D=3D 6:
> +                ts_ms, seq, logical_id, src_rel, dst_rel, rc =3D parts
> +            elif len(parts) =3D=3D 7:
> +                ts_ms, worker_id, seq, logical_id, src_rel, dst_rel, rc =
=3D parts
> +                _ =3D worker_id  # worker id is informational only
> +            else:
> +                raise ValueError(
> +                    f"rename log line {line_no}: expected 6 or 7 columns=
, got {len(parts)}"
> +                )
> +            records.append(
> +                {
> +                    "ts_ms": int(ts_ms),
> +                    "seq": int(seq),
> +                    "logical_id": int(logical_id),
> +                    "src_rel": src_rel,
> +                    "dst_rel": dst_rel,
> +                    "rc": int(rc),
> +                }
> +            )
> +    return records
> +
> +
> +def parse_reset_log(path: Path):
> +    records =3D []
> +    if not path.exists():
> +        return records
> +    with path.open("r", encoding=3D"utf-8") as handle:
> +        for line_no, line in enumerate(handle, 1):
> +            line =3D line.strip()
> +            if not line:
> +                continue
> +            parts =3D line.split(",")
> +            if len(parts) !=3D 4:
> +                raise ValueError(f"reset log line {line_no}: expected 4 =
columns, got {len(parts)}")
> +            ts_ms, seq, reason, rc =3D parts
> +            records.append(
> +                {
> +                    "ts_ms": int(ts_ms),
> +                    "seq": int(seq),
> +                    "reason": reason,
> +                    "rc": int(rc),
> +                }
> +            )
> +    return records
> +
> +
> +def parse_status_file(path: Path):
> +    status =3D {}
> +    if not path.exists():
> +        return status
> +    with path.open("r", encoding=3D"utf-8") as handle:
> +        for line in handle:
> +            line =3D line.strip()
> +            if not line or ":" not in line:
> +                continue
> +            key, value =3D line.split(":", 1)
> +            status[key.strip()] =3D value.strip()
> +    return status
> +
> +
> +def to_int(value: str, default: int =3D 0):
> +    try:
> +        return int(value)
> +    except Exception:
> +        return default
> +
> +
> +def validate_namespace(data_dir: Path, file_count: int, issues):
> +    actual_locations =3D {}
> +    actual_paths =3D {}
> +    for logical_id in range(file_count):
> +        name =3D f"file_{logical_id:05d}"
> +        found =3D []
> +        for subdir in ("A", "B"):
> +            candidate =3D data_dir / subdir / name
> +            if candidate.exists():
> +                found.append((subdir, candidate))
> +        if len(found) !=3D 1:
> +            issues.append(
> +                f"namespace invariant failed for logical_id=3D{logical_i=
d:05d}: expected exactly one file in A/B, found {len(found)}"
> +            )
> +            continue
> +        actual_locations[logical_id] =3D found[0][0]
> +        actual_paths[logical_id] =3D found[0][1]
> +    return actual_locations, actual_paths
> +
> +
> +def validate_rename_invariant(rename_records, actual_locations, issues):
> +    expected_locations =3D {}
> +    for rec in rename_records:
> +        if rec["rc"] !=3D 0:
> +            continue
> +        dst =3D rec["dst_rel"]
> +        if "/" not in dst:
> +            continue
> +        expected_locations[rec["logical_id"]] =3D dst.split("/", 1)[0]
> +
> +    for logical_id, expected in expected_locations.items():
> +        actual =3D actual_locations.get(logical_id)
> +        if actual is None:
> +            continue
> +        if actual !=3D expected:
> +            issues.append(
> +                f"rename invariant failed for logical_id=3D{logical_id:0=
5d}: expected location=3D{expected}, actual=3D{actual}"
> +            )
> +
> +
> +def validate_data_invariant(io_records, actual_paths, issues):
> +    expected_hash =3D {}
> +    for rec in io_records:
> +        digest =3D rec["digest"]
> +        if not digest:
> +            continue
> +        expected_hash[rec["logical_id"]] =3D digest
> +
> +    for logical_id, digest in expected_hash.items():
> +        path =3D actual_paths.get(logical_id)
> +        if path is None:
> +            continue
> +        actual_digest =3D sha256_file(path)
> +        if digest !=3D actual_digest:
> +            issues.append(
> +                f"data invariant failed for logical_id=3D{logical_id:05d=
}: expected digest=3D{digest}, actual digest=3D{actual_digest}"
> +            )
> +
> +
> +def validate_reset_and_slo(args, reset_records, io_records, rename_recor=
ds, status, issues):
> +    if not args.expect_reset:
> +        return
> +
> +    successful_reset_times =3D [rec["ts_ms"] for rec in reset_records if=
 rec["rc"] =3D=3D 0]
> +    if not successful_reset_times:
> +        issues.append("expected reset activity but no successful reset t=
rigger was observed")
> +
> +    phase =3D status.get("phase")
> +    blocked_requests =3D to_int(status.get("blocked_requests", "0"), def=
ault=3D-1)
> +    last_errno =3D to_int(status.get("last_errno", "0"), default=3D1)
> +    failure_count =3D to_int(status.get("failure_count", "0"), default=
=3D-1)
> +
> +    if phase is None:
> +        issues.append("missing final reset status file or phase field")
> +    elif phase.lower() !=3D "idle":
> +        issues.append(f"recovery invariant failed: phase=3D{phase}, expe=
cted idle")
> +
> +    if blocked_requests !=3D 0:
> +        issues.append(f"recovery invariant failed: blocked_requests=3D{b=
locked_requests}, expected 0")
> +    if last_errno !=3D 0:
> +        issues.append(f"recovery invariant failed: last_errno=3D{last_er=
rno}, expected 0")
> +    if failure_count > 0:
> +        issues.append(
> +            f"recovery invariant failed: failure_count=3D{failure_count}=
, "
> +            "one or more resets failed during the run"
> +        )
> +
> +    op_times =3D [rec["ts_ms"] for rec in io_records]
> +    op_times.extend(rec["ts_ms"] for rec in rename_records if rec["rc"] =
=3D=3D 0)
> +    op_times.sort()
> +
> +    if successful_reset_times and not op_times:
> +        issues.append("recovery SLO failed: no workload completion event=
s were recorded")
> +        return
> +
> +    slo_ms =3D args.slo_seconds * 1000
> +    for ts in successful_reset_times:
> +        idx =3D bisect.bisect_left(op_times, ts)
> +        if idx >=3D len(op_times):
> +            issues.append(f"recovery SLO failed: no operation completion=
 observed after reset at ts_ms=3D{ts}")
> +            continue
> +        delta =3D op_times[idx] - ts
> +        if delta > slo_ms:
> +            issues.append(
> +                f"recovery SLO failed: first post-reset completion at {d=
elta}ms exceeds threshold {slo_ms}ms (reset ts_ms=3D{ts})"
> +            )
> +
> +
> +def main():
> +    parser =3D argparse.ArgumentParser(description=3D"Validate Ceph rese=
t stress artifacts")
> +    parser.add_argument("--data-dir", required=3DTrue)
> +    parser.add_argument("--file-count", required=3DTrue, type=3Dint)
> +    parser.add_argument("--io-log", required=3DTrue)
> +    parser.add_argument("--rename-log", required=3DTrue)
> +    parser.add_argument("--reset-log", required=3DTrue)
> +    parser.add_argument("--status-final", required=3DFalse, default=3D""=
)
> +    parser.add_argument("--slo-seconds", required=3DFalse, type=3Dint, d=
efault=3D30)
> +    parser.add_argument("--expect-reset", action=3D"store_true")
> +    parser.add_argument("--report-json", required=3DFalse, default=3D"")
> +    args =3D parser.parse_args()
> +
> +    data_dir =3D Path(args.data_dir)
> +    io_log =3D Path(args.io_log)
> +    rename_log =3D Path(args.rename_log)
> +    reset_log =3D Path(args.reset_log)
> +    status_final =3D Path(args.status_final) if args.status_final else P=
ath("__missing_status__")
> +
> +    issues =3D []
> +
> +    if not data_dir.exists():
> +        issues.append(f"data directory is missing: {data_dir}")
> +
> +    try:
> +        io_records =3D parse_io_log(io_log)
> +        rename_records =3D parse_rename_log(rename_log)
> +        reset_records =3D parse_reset_log(reset_log)
> +    except Exception as exc:
> +        issues.append(f"log parsing failed: {exc}")
> +        io_records =3D []
> +        rename_records =3D []
> +        reset_records =3D []
> +
> +    status =3D parse_status_file(status_final)
> +
> +    actual_locations, actual_paths =3D validate_namespace(data_dir, args=
.file_count, issues)
> +    validate_rename_invariant(rename_records, actual_locations, issues)
> +    validate_data_invariant(io_records, actual_paths, issues)
> +    validate_reset_and_slo(args, reset_records, io_records, rename_recor=
ds, status, issues)
> +
> +    report =3D {
> +        "file_count": args.file_count,
> +        "io_records": len(io_records),
> +        "rename_records": len(rename_records),
> +        "reset_records": len(reset_records),
> +        "expect_reset": args.expect_reset,
> +        "issues": issues,
> +    }
> +
> +    if args.report_json:
> +        report_path =3D Path(args.report_json)
> +        report_path.write_text(json.dumps(report, indent=3D2, sort_keys=
=3DTrue), encoding=3D"utf-8")
> +
> +    if issues:
> +        print("FAIL: consistency validation found issues")
> +        for issue in issues:
> +            print(f"  - {issue}")
> +        raise SystemExit(1)
> +
> +    print("PASS: consistency validation succeeded")
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

