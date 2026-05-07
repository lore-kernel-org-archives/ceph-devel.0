Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1D3B7744
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156880; cv=none; b=EUgeuP6paELS7kPrbuXEbH7buKhrcx4cw9uKYimjbyNaprzrilTANz7eqv4Fp7BLa1FFi7pcSjrIJPOOCjtutQGotk7/kzb4uy+gLsgI1TXhC/cjsqQ2u0wcNm1GGFh+FGcdJ2mf5Ok6A/wxN2XDEW0XFznQ+HT0uYqvxb76Jvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156880; c=relaxed/simple;
	bh=T3SYwNAcawA/E2EIqbZFX+vNF+vMw0ueYcTwcN8x72o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fi/8+Vbm106ZIGc7RPD6nUUZt9bORhaO2vnASiRpvPBzeNGQ0uDgufrs/vLCHlgQUnhPnJsrODrO26drvS7cNVbd6OjcWhvX8nUPeQIZKrACHnmHnFdYQFd4kr8MZUaFOQqzkw8rxmyXI7Maso/DfkvCveFYPI2XX63rBaugAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVJjGl+0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5eUq+Fq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVJjGl+0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5eUq+Fq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778156877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kH1rfK/xXKO/jWZH3nIhV338I1U55E10FikanWCJaSM=;
	b=QVJjGl+0OhgmJemkI+rrj75MtOYv/UOUFuQZ6AR5WMdWtDrSw+/7q+GWQInPMSSaARv2+z
	VW2tQIAa/5LTswjZVVW+tGXNcnVO1j/pCDcjDoJwskKFXHbxwz3S4YMmYVmD0drEu/lJoY
	YJYarrbF5rvjUZumSTSYJw2H5HKlsMo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-5Jt-WAJKPECetFlRsHn_vQ-1; Thu, 07 May 2026 08:27:56 -0400
X-MC-Unique: 5Jt-WAJKPECetFlRsHn_vQ-1
X-Mimecast-MFC-AGG-ID: 5Jt-WAJKPECetFlRsHn_vQ_1778156875
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b934e96af9dso91025166b.3
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 05:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778156875; x=1778761675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH1rfK/xXKO/jWZH3nIhV338I1U55E10FikanWCJaSM=;
        b=A5eUq+Fq1S32GCmgm4N9j9bXoXc5DP04ZTnFU6ubY+X7O3GuP0eSsxq30yrN6JjV8v
         4GBnANP+8Fkz0Xtg2LbB5NZIvmJlzhSx0Lqo4EuFOjgOz+zSCZUAlCXuPv54QRrCYUwI
         UzF72YBj5txkYlE2BqybPBDysuFod7Pgxu36zpPkhJUBZcoS0TkIBv5DXS3KKQ9PFPsE
         2eIzzcJRbkz35gA4r3JVWKoB4raw9p/sxqIBgVyXsyuWJKYNj0zz7IHF0r8xsP7mKCGl
         63IkIKBbhTk0cbAXnramp5qWrpAcuPfgeEmmU0hgHYToBha1fpbC7G0PNsrvNc96I+Uh
         T1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156875; x=1778761675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kH1rfK/xXKO/jWZH3nIhV338I1U55E10FikanWCJaSM=;
        b=lv6bi0HJ6YaESLLJ1IsqTN8L3wcACRRojz9ko8oSw7IGgum9xYp8oWLa7RL/dLRbAi
         BnXrEaHMvI0+2t8fSzZ4QE5Z/GT1fVg1SHEKr2HijkQm/BsFkUTnAT/ijISmPld+ypAX
         JAxM8JDcS8QJ2WrQykkyQNG7aT7Wdthtk4VeeXLmaa6TMX9OUozF5r3rJe8QPpqSlGv8
         MABJtTqtiU7YY5d2RRFXpX6rc4sDJ0T27KQ3m3dTH4WJzusav/bmkojR0ApWPN+bEO6q
         lwXt4qB+uQnVAAfq2Xz3gZlKw0XgYtmk4AGO5R1yoUGi0YKNHD5YFmbGTIkP0ji916Pt
         lDZA==
X-Gm-Message-State: AOJu0YythGPk9pKk/NrmRSDgW947FY2wbJRax4rDshd7tLMI8rUDQqTg
	PWwi8jVsEHG8F12XzZYnmBDb++ijttrpTswjMQdUHdNnS6/mOGfLkiyzKyqpDTjyGe8AVnpV8X8
	sDTAvjk1ZXNTStj9NQmE9aQ4n2YdJW1XgNgXvnj16tC/MVQT3ONXXhgOvKF7YyZ7gCsGzfEiq1A
	1bxeyW68Wo2wTrr6eiNfCnKlaiWvveyd+cRefX+TS1peF21s20Xg==
X-Gm-Gg: AeBDiev0RD6Wa3EraeOOoLD+gBOdvz9He0EGvL8OjQZhFWgQQnLJCgef05rMr5oBaf2
	PQsA/fOaDOhq5CVy0S3P1tsC3zNN2dzvPL6CieFn0/XkJhp2WVvDuFn6YE13vPlb0b/RdOx4Yf7
	NKyOy2QaE9nn26pb3Kx/d/L7AS4rfG9o5PqY9ursGJQAVzU051id1IoVrQZDL22TmKbJLR3FDrV
	6WT+MZOvIb0L8FUvg+vd3Bv1wfW0+zp78WfI/Ih/0QghDfFMThhlCwluv+xPK9I/Vw0UumsVy8m
	K9CA4XuQ/sB6htGVtIgZamzXz6rEUxrH3tflBTkaeRF/DkySPQORIVhsVY5jC4dByYCubApcsc9
	GP+0e22HZjc+pPWfY6GgL2V8TNFq7wnYCSKnvtk/Zu4z2VIGc0DJtLrGE9F9nM1Unbw==
X-Received: by 2002:a17:907:874b:b0:bc3:cb1b:ed6a with SMTP id a640c23a62f3a-bc56c92bec6mr473714166b.15.1778156874643;
        Thu, 07 May 2026 05:27:54 -0700 (PDT)
X-Received: by 2002:a17:907:874b:b0:bc3:cb1b:ed6a with SMTP id a640c23a62f3a-bc56c92bec6mr473708866b.15.1778156873732;
        Thu, 07 May 2026 05:27:53 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc81cd34ce8sm76552566b.9.2026.05.07.05.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:27:53 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v4 07/11] selftests: ceph: add reset consistency checker
Date: Thu,  7 May 2026 12:27:33 +0000
Message-Id: <20260507122737.2804094-8-amarkuze@redhat.com>
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

Add a Python post-run validator for the CephFS client reset stress
test.  The script reads data files written by the stress runner and
checks that every file was either written completely or is missing,
with no partial or corrupted content.

This is a prerequisite for the stress test script which invokes it
after each run.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 .../filesystems/ceph/validate_consistency.py  | 297 ++++++++++++++++++
 1 file changed, 297 insertions(+)
 create mode 100755 tools/testing/selftests/filesystems/ceph/validate_consistency.py

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

