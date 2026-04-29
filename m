Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB173FB071
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777467155; cv=none; b=Xe6mb6QDRCKyQrz0Xu0gdQOK3VPA5p/W0b14HYWgCj/XmjThiNTbDZ/8wTsTny5GOyhAXd/L+GdsZKfPOa077INDhimpALw1uOnYRVzfyJlVqphzf1nQxunoULFSL0yk50ZjhD5PDFpGXbKYaDO+f43rOdwMDgqR6uNl8nlcotM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777467155; c=relaxed/simple;
	bh=T3SYwNAcawA/E2EIqbZFX+vNF+vMw0ueYcTwcN8x72o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ux9aHKy74xwuWCfPRhv72qPLn4bCX4cw+qeKrLL8fW6Wi48fiubMtsCny/0JBWf72A8CV1MKgEmaxnHgSgRKMzTlaecpl0ybY3c+nnIOSWV3h8+3LYPvKDwYgWf+/Qicz17s7I5mW05sjO6p6mwtANJtRg0khuOkYTDuoJVeFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RuOjxjw9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9Vpmb2q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuOjxjw9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9Vpmb2q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777467152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kH1rfK/xXKO/jWZH3nIhV338I1U55E10FikanWCJaSM=;
	b=RuOjxjw96VxubTz56RyncLqk8eJHEkR6uQC+XCHce4MXjQxpN738zhKWj3QxLhrJMCia0N
	1mNxew6ySPWYmrPTuuWuIppDg6bPSZdLE1geUx2exnibshfhEbTwTz+VxiPeqr3OAiYBbP
	DrfOs0p2OF/Hcpg0VP2V38Ey1vsK3zw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-94os-fJ9OWa-JXYzZ0sOPw-1; Wed, 29 Apr 2026 08:52:30 -0400
X-MC-Unique: 94os-fJ9OWa-JXYzZ0sOPw-1
X-Mimecast-MFC-AGG-ID: 94os-fJ9OWa-JXYzZ0sOPw_1777467149
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b9bfd3b1c92so1221727766b.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777467149; x=1778071949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kH1rfK/xXKO/jWZH3nIhV338I1U55E10FikanWCJaSM=;
        b=G9Vpmb2qpnvTPfl7Xhf4xlEaVK+GTjrPSHG0WzVbnFRzo6i13QGERUQyNy4RvySyEm
         nvX0mko1bNEZ99eVyLk69esYMvluhzIexOJiBDxHavzq0tUwQnGlOlWR9AhIenqsmKBN
         JCPpawhUR+zakEursQBAUMUp3fLFv5vb8emAMX7+nXu2Z81AHFiKszbqmpqwYxb2aDP2
         ENjjjDQIIxAMJsQbM/6phrT9uLOwmY6ZeAj8CZO1EnArcuVr3JITKKFCOmMuGwV8nX8b
         Q9Q36kLNwxz3ga1bahkCb/mtPj/vaX3N9yNS5dCrEk63rOaPhVkKGV/AiwbPpQ/PZQSF
         XSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777467149; x=1778071949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kH1rfK/xXKO/jWZH3nIhV338I1U55E10FikanWCJaSM=;
        b=X8C73xezsdMCMO4XpfrPh2y3MfkTP3r+N7UulQCrdyK3PLBJUhEdHS8YNc6daQ40Lr
         8Ov9Ya14qmWygxz8iclsQLnHPvvgVzWJ5OZEarS1W1ayfeD0ORVjAx21YeAAGQ75euLw
         NW77G+/1zIHIWqGCFcDaK+5z8onOJL5LwYv4lkE7jB9voAEwxz70Ws0kd+zj+v+8ad80
         g/quPsF0sOZbFc5iA73DDas/83Qx8PE/dGlWxNZ5ZQ+xEklwcBtPqoTjn45BakwK3ef7
         mYyKRbqfu6UAPZaPvU6n6oxCGkAyV0DIZfNhYj0OKOniZ6g4NDnqv82CRuNH29KsftMQ
         JseQ==
X-Gm-Message-State: AOJu0YwHb3NfR+O6cFcM/wxT60kSr4eavB4OUUE0i15nRVP2jcM+pKD7
	j7BoALAwqhVvbPAoNxPL/reXlhKSOYjo2ssnB2UR6gTjpHXWuXrs5sA8WpeXzUZIZQ1LvF1s2Vp
	zH1yIknwS2fZ6kSA2lxvEcJTPFGVV7Tef/IyhlSKk5Iygs4adkCL7aN8CctxI4tGyNSVX7yzC/l
	qD1Ewp+9QmThNSUhXOszf8ewOr7HHzkgsU4qg+JUWEpU80NBFUeg==
X-Gm-Gg: AeBDiev3DAKq6Lrs+lXFMugT0wFzyUiIp8me5BfyTneOdd1gsfnlOSDOkHzdeqk+d8L
	OLy8r8/tMUsOI9bAKwLoBt0uEJUakB7LfuyJJacDRkuzq9Bi7hgUGxHZNdMOa/1incFvKPzRw+Z
	CnBwnLS7qg4ZX+ZLT2sGW/f6Yq4wzgC+OSNmbU4YB3dU2F/R1SbyrMO/4s1XvlGjdEruZxlQpEc
	qZXxkaN4sAhbLch86o7GotGtKi7xC2knVpV2ggz71MplSSQskolzuSvKDgJ3uhK95bBNUxRBxkH
	XKOw6K8pJISORDmkHjxwKctovk0IpUF9oGveKjwm6qZAmG5KmiTspQbxnUDmPuNnY0nakH4WFhl
	lpTQNmCp4rkfLarc+wmS9mFnsSQWcsX0Ahbsr0hw12edW2YX4zgZRKi3bE48i2sb8Vw==
X-Received: by 2002:a17:907:e118:b0:b9d:8697:73b8 with SMTP id a640c23a62f3a-bb801dd4214mr311171666b.22.1777467148756;
        Wed, 29 Apr 2026 05:52:28 -0700 (PDT)
X-Received: by 2002:a17:907:e118:b0:b9d:8697:73b8 with SMTP id a640c23a62f3a-bb801dd4214mr311169566b.22.1777467148074;
        Wed, 29 Apr 2026 05:52:28 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67b22166a6esm680526a12.25.2026.04.29.05.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 05:52:27 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v3 07/11] selftests: ceph: add reset consistency checker
Date: Wed, 29 Apr 2026 12:52:02 +0000
Message-Id: <20260429125206.1512203-8-amarkuze@redhat.com>
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

