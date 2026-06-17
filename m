Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818F141C2FD
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708440; cv=none; b=WQLcdtppm97dktcjO0PrMbhcc0ICxmgDommduewq6uyE9BCLSlZ46/wSY5n3iKTMB0pJKtbJ7mY0nYiwr8ZnRy6vazNxHNQAxG+6M7/AHb/XLFmc+orZ0/Ls+bb2jRCX5+w+3R6eGZzoK8cD9k4jEhET0bh9BAheuRIPAluReyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708440; c=relaxed/simple;
	bh=x70pi7Rp3h0u/ENLEeZhNPOitEbP8ztc3+w62aiEYGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GUiLuDyw1c2O1tbvProCeY+2G3oQ3lmQCk4ghIU5On1ogDrA8Hny72IXor/O+MzfEjJ+Ad2/rH5NBMTnkMZq0jENtflAUrzq4i37Ar7Fsa40Mvh8obyn2VLYOD/f47y6LFIeUFe7VB/0026VBDPCLj6fLxq8mZY/78OBnbBF4Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPomxmjS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kqXSBwk+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPomxmjS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kqXSBwk+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxl13maPiKUVbQ3hOyrikNqTKn6BH1VinXqCXHqUd4A=;
	b=fPomxmjSHddXj/ZySHsbRAQvDMSDrLBaAqPX4tzoYZRbA751MpZPLABZSWOwAa6ET6TfHw
	JIcvIaezmi7vJt0yw7CViJoHafpGTMjmN+zPa/1sLf2cgQO2la5E7YOvqoTCtqLSsipKAU
	omdDS8yUTYVxu1hwYJL2mBAymWF3RPk=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-BjJ2Q-hfMmmaNnUJA-f3nA-1; Wed, 17 Jun 2026 11:00:27 -0400
X-MC-Unique: BjJ2Q-hfMmmaNnUJA-f3nA-1
X-Mimecast-MFC-AGG-ID: BjJ2Q-hfMmmaNnUJA-f3nA_1781708426
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6e385508bso6503096a34.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781708426; x=1782313226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxl13maPiKUVbQ3hOyrikNqTKn6BH1VinXqCXHqUd4A=;
        b=kqXSBwk+LjoUJFBFwNoBmSNwDtYP7SFwQ1J8m77lAmgJRrecnJWgtTXMTa2MCK6mFT
         c0fDOfBQIsPPFU9EkTLSousT/Dfxe/LMO/ZQHyBBNTkc1qAu23Ck4Rd4Y4IxyihWtjdW
         Cv8csRGuy0WDi1oc/ASFWVOnwcjQpqfuPETktLD0bejfwn55cfE439RLyFGGZ1jb1vKK
         a/jhxrndoT+wYz7Z6mpQgWTFdC31C3zIdy/mwc4sAGffvQCaQ8TU+8+fkboJTdmVuUY7
         uSnfObe1J3aAYeqovQSzLUEHnlLZrpN3KCS8r9/gezXoGR42CxprUN/rqDcrSK6ZTDXz
         vbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708426; x=1782313226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jxl13maPiKUVbQ3hOyrikNqTKn6BH1VinXqCXHqUd4A=;
        b=TTNYn+savUamyNc+isdjKFczuJUpu+X2TblS5P47OLjKJiAIizfjHM3aMbGpAi6aNW
         t+DJLV8gJAExkHKVUiXDQ8J8TWqAOlTngK5Jngt3WhuJvo1am9xW2Y6KCiZRMY+rA0QX
         sACTBKyOiGb+riz7wFHhSveXJzO6S/7rAgyqNXESHffLVZ215HOWyzn+ZP7VDtUMZQ2W
         lYRTovMuq2G1KOjbSSFZSbVTVoMLCNM0+4tDfRinbkYIFXgl94Hh09Eq5XNijuxwrUUe
         9M+4r+FO+0qco1R508QzL9lvCFha36Dnu/BHv1uPlwdX+mXR4uyVIx7VVy3jjuL1BA5h
         gfQg==
X-Gm-Message-State: AOJu0YxhzER2ggSWwmi19uOUaoXOPBlWSJuRZWq1+IQZ7jQu+YGjdNdx
	Z3qVcD3VslfErKWj9BroXPv1spCsOG4PQEJ8xLZ/X+WYsK13SeTQF0XJLAWxnPTfadiLZfUOwOt
	yj0QKdNr6UfirfH9RTj5s4KrjCFkpxM/4BIv+sUjIZlu/bq9q8jFIQhoBHAmjxiZz6jry0ZCHXr
	5b5+vqjHt8hIHxGLopmHYKO+UnJW9eSoDBxvjAlbmceQ4NyjlD6w==
X-Gm-Gg: Acq92OHx3Xot6xkx6SooOYl1Hm6UK+sR4YONsEwQ7TvleKuJ2kyt30JzQV5Ts39gsC1
	GcYcME2ktbh/Ps5wwD/wZ3dVC22GOSS3TQKlfvAfXjRmjCbA7SOGAlJ96vK9ORUM999DgVXbPKr
	R54er1H0BGIaNVTsh5A3/CmfXTTLjgKxC+W6VW0j+rZnRmZ6yXqDf1SIlXeJ8Aona5D9ta+RkUJ
	8BPFC4iDJptVZap7NONhngJlrVvT07KjJwpx+wXSe+kpHIVQ/QUgTShOYR+Rpd66TqEFTG1hu+T
	mom+t9d76lTVMAyfcbrwLBZq+W6EnGWke8RKICcorJSQG2+kBGqgPG9bowypWz8Al5keg8l+1Oi
	G0t5GzIhohaUjoo78yx/o48sYaUiW7Zt7kAkd0v3FYUHE
X-Received: by 2002:a05:6808:1b28:b0:44d:bcb0:1409 with SMTP id 5614622812f47-4894460b1dcmr2817053b6e.22.1781708425443;
        Wed, 17 Jun 2026 08:00:25 -0700 (PDT)
X-Received: by 2002:a05:6808:1b28:b0:44d:bcb0:1409 with SMTP id 5614622812f47-4894460b1dcmr2817018b6e.22.1781708424670;
        Wed, 17 Jun 2026 08:00:24 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm10101847a34.6.2026.06.17.08.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:00:23 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 15/15] selftests: add Ceph BLOG smoke test and collection helpers
Date: Wed, 17 Jun 2026 14:59:45 +0000
Message-Id: <20260617145945.1912736-16-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617145945.1912736-1-amarkuze@redhat.com>
References: <20260617145945.1912736-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kselftests: blog_smoke_test.sh (dual-mount isolation, enable/
disable), blog_collect.sh, blog_analyze.sh, and kselftest wiring.

Add F: pattern for tools/testing/selftests/ceph_blog/ to the CephFS
MAINTAINERS entry.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/ceph_blog/Makefile    |   7 +
 .../selftests/ceph_blog/blog_analyze.sh       | 124 ++++++
 .../selftests/ceph_blog/blog_collect.sh       | 116 ++++++
 .../selftests/ceph_blog/blog_smoke_test.sh    | 363 ++++++++++++++++++
 tools/testing/selftests/ceph_blog/config      |   2 +
 7 files changed, 614 insertions(+)
 create mode 100644 tools/testing/selftests/ceph_blog/Makefile
 create mode 100644 tools/testing/selftests/ceph_blog/blog_analyze.sh
 create mode 100644 tools/testing/selftests/ceph_blog/blog_collect.sh
 create mode 100644 tools/testing/selftests/ceph_blog/blog_smoke_test.sh
 create mode 100644 tools/testing/selftests/ceph_blog/config

diff --git a/MAINTAINERS b/MAINTAINERS
index 441b556b9671..9a7265ce7de5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5909,6 +5909,7 @@ B:	https://tracker.ceph.com/
 T:	git https://github.com/ceph/ceph-client.git
 F:	Documentation/filesystems/ceph.rst
 F:	fs/ceph/
+F:	tools/testing/selftests/ceph_blog/
 F:	tools/testing/selftests/filesystems/ceph/
 
 CERTIFICATE HANDLING
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index ab254ae793a9..d7e0138fcf3a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -7,6 +7,7 @@ TARGETS += bpf
 TARGETS += breakpoints
 TARGETS += cachestat
 TARGETS += capabilities
+TARGETS += ceph_blog
 TARGETS += cgroup
 TARGETS += clone3
 TARGETS += connector
diff --git a/tools/testing/selftests/ceph_blog/Makefile b/tools/testing/selftests/ceph_blog/Makefile
new file mode 100644
index 000000000000..39f6d0c8990c
--- /dev/null
+++ b/tools/testing/selftests/ceph_blog/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS := blog_smoke_test.sh
+TEST_PROGS += blog_collect.sh
+TEST_PROGS += blog_analyze.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/ceph_blog/blog_analyze.sh b/tools/testing/selftests/ceph_blog/blog_analyze.sh
new file mode 100644
index 000000000000..1f0bf049fbb9
--- /dev/null
+++ b/tools/testing/selftests/ceph_blog/blog_analyze.sh
@@ -0,0 +1,124 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# blog_analyze.sh - Analyze BLOG trace snapshots
+#
+# Parses the output of blog_collect.sh or blog_smoke_test.sh and
+# produces a summary: entry counts, source-file breakdown, timeline,
+# and per-client statistics.
+#
+# Usage:
+#   ./blog_analyze.sh <snapshot_dir>
+#   ./blog_analyze.sh /tmp/blog_snapshot_20260413_120000
+#
+set -euo pipefail
+
+DIR="${1:?Usage: $0 <snapshot_dir>}"
+[[ -d "$DIR" ]] || { echo "Not a directory: $DIR"; exit 1; }
+
+ENTRIES="$DIR/entries.txt"
+SOURCES="$DIR/sources.txt"
+CLIENTS="$DIR/clients.txt"
+STATS="$DIR/stats.txt"
+
+echo "=========================================="
+echo " BLOG Trace Analysis"
+echo " Source: $DIR"
+echo "=========================================="
+echo ""
+
+# ---------- entry summary ----------
+if [[ -f "$ENTRIES" ]]; then
+    TOTAL=$(wc -l < "$ENTRIES")
+    echo "--- Entries ---"
+    echo "  Total lines:  $TOTAL"
+
+    if (( TOTAL > 0 )); then
+        FIRST=$(head -1 "$ENTRIES" | awk '{print $1, $2}')
+        LAST=$(tail -1 "$ENTRIES" | awk '{print $1, $2}')
+        echo "  First entry:  $FIRST"
+        echo "  Last entry:   $LAST"
+
+        echo ""
+        echo "  Top 10 source locations:"
+        # entries format: "YYYY-MM-DD HH:MM:SS.mmm [file:func:line] message"
+        grep -oE '\[[^]]+\]' "$ENTRIES" 2>/dev/null | sed 's/^\[//;s/\]$//' | \
+            sort | uniq -c | sort -rn | head -10 | \
+            while read -r count loc; do
+                printf "    %6d  %s\n" "$count" "$loc"
+            done
+
+        echo ""
+        echo "  Top 10 most frequent messages (first 60 chars):"
+        # strip timestamp and source prefix, take first 60 chars
+        sed 's/^[0-9-]* [0-9:.]* \[[^]]*\] //' "$ENTRIES" | \
+            cut -c1-60 | sort | uniq -c | sort -rn | head -10 | \
+            while read -r count msg; do
+                printf "    %6d  %s\n" "$count" "$msg"
+            done
+
+        echo ""
+        echo "  Per-second entry rate:"
+        # extract HH:MM:SS, count per second
+        awk '{print $1" "$2}' "$ENTRIES" | \
+            sed 's/\.[0-9]*//' | sort | uniq -c | \
+            awk '{sum+=$1; count++} END {
+                if(count>0) printf "    avg %.1f entries/sec over %d seconds\n", sum/count, count
+            }'
+    fi
+else
+    echo "  (no entries.txt found)"
+fi
+
+echo ""
+
+# ---------- source summary ----------
+if [[ -f "$SOURCES" ]]; then
+    echo "--- Registered Sources ---"
+    SOURCE_COUNT=$(grep -c '^ID ' "$SOURCES" 2>/dev/null || echo 0)
+    echo "  Total registered: $SOURCE_COUNT"
+
+    if (( SOURCE_COUNT > 0 )); then
+        echo ""
+        echo "  By file:"
+        grep '^ID ' "$SOURCES" | \
+            sed 's/^ID [0-9]*: //' | cut -d: -f1 | \
+            sort | uniq -c | sort -rn | \
+            while read -r count file; do
+                printf "    %4d  %s\n" "$count" "$file"
+            done
+    fi
+else
+    echo "  (no sources.txt found)"
+fi
+
+echo ""
+
+# ---------- client summary ----------
+if [[ -f "$CLIENTS" ]]; then
+    echo "--- Registered Clients ---"
+    CLIENT_COUNT=$(grep -c '^Client ID' "$CLIENTS" 2>/dev/null || echo 0)
+    echo "  Total registered: $CLIENT_COUNT"
+
+    if (( CLIENT_COUNT > 0 )); then
+        grep -A2 '^Client ID' "$CLIENTS" | \
+            while IFS= read -r line; do
+                echo "    $line"
+            done
+    fi
+else
+    echo "  (no clients.txt found)"
+fi
+
+echo ""
+
+# ---------- stats summary ----------
+if [[ -f "$STATS" ]]; then
+    echo "--- Logger Statistics ---"
+    sed 's/^/    /' "$STATS"
+else
+    echo "  (no stats.txt found)"
+fi
+
+echo ""
+echo "=========================================="
diff --git a/tools/testing/selftests/ceph_blog/blog_collect.sh b/tools/testing/selftests/ceph_blog/blog_collect.sh
new file mode 100644
index 000000000000..9401724bf43d
--- /dev/null
+++ b/tools/testing/selftests/ceph_blog/blog_collect.sh
@@ -0,0 +1,116 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# blog_collect.sh - Collect BLOG debugfs snapshots from a mounted CephFS
+#
+# Finds the Ceph BLOG debugfs directory, snapshots all files, and
+# optionally tails the entries file for live monitoring.
+#
+# Usage:
+#   ./blog_collect.sh [snapshot|tail|clear|stats|sources|clients] [-d blog_dir] [-o dir]
+#
+set -euo pipefail
+
+ACTION="${1:-snapshot}"
+OUTDIR=""
+TARGET_BLOG_DIR="${BLOG_DIR:-}"
+
+shift || true
+while getopts "d:o:" opt; do
+    case $opt in
+        d) TARGET_BLOG_DIR="$OPTARG" ;;
+        o) OUTDIR="$OPTARG" ;;
+        *) ;;
+    esac
+done
+
+DEBUGFS_BASE="/sys/kernel/debug/ceph"
+shopt -s nullglob
+
+find_blog_dir() {
+    local dirs=("$DEBUGFS_BASE"/*/blog)
+
+    if [[ -n "$TARGET_BLOG_DIR" ]]; then
+        [[ -d "$TARGET_BLOG_DIR" ]] || {
+            echo "ERROR: BLOG debugfs directory does not exist: $TARGET_BLOG_DIR" >&2
+            return 1
+        }
+        echo "$TARGET_BLOG_DIR"
+        return 0
+    fi
+
+    if (( ${#dirs[@]} == 0 )); then
+        echo "ERROR: No BLOG debugfs directory found under $DEBUGFS_BASE" >&2
+        echo "Ensure CephFS is mounted and CONFIG_CEPH_FS=y|m" >&2
+        return 1
+    fi
+
+    if (( ${#dirs[@]} > 1 )); then
+        echo "ERROR: Multiple BLOG debugfs directories found:" >&2
+        printf '  %s\n' "${dirs[@]}" >&2
+        echo "Select one with -d <dir> or BLOG_DIR=<dir>." >&2
+        return 1
+    fi
+
+    echo "${dirs[0]}"
+}
+
+BLOG_DIR=$(find_blog_dir)
+echo "BLOG debugfs: $BLOG_DIR"
+
+case "$ACTION" in
+    snapshot)
+        OUTDIR="${OUTDIR:-/tmp/blog_snapshot_$(date +%Y%m%d_%H%M%S)}"
+        mkdir -p "$OUTDIR"
+        for f in enabled entries stats sources clients; do
+            [[ -r "$BLOG_DIR/$f" ]] && cat "$BLOG_DIR/$f" > "$OUTDIR/$f.txt"
+        done
+        echo "Snapshot saved to $OUTDIR/"
+        if [[ -f "$OUTDIR/enabled.txt" ]]; then
+            echo "  enabled:  $(tr -d '[:space:]' < "$OUTDIR/enabled.txt")"
+        fi
+        echo "  entries:  $(wc -l < "$OUTDIR/entries.txt") lines"
+        echo "  sources:  $(grep -c '^ID ' "$OUTDIR/sources.txt" 2>/dev/null || echo 0)"
+        echo "  clients:  $(grep -c '^FSID:' "$OUTDIR/clients.txt" 2>/dev/null || echo 0)"
+        ;;
+
+    tail)
+        echo "--- Live BLOG entries (Ctrl-C to stop) ---"
+        # Show new entries by polling; entries file is a seq_file so we
+        # re-read the whole thing each interval and diff.
+        PREV=$(mktemp)
+        CURR=""
+        trap 'rm -f "$PREV" "$CURR"' EXIT INT TERM
+        cat "$BLOG_DIR/entries" > "$PREV"
+        while true; do
+            sleep 1
+            CURR=$(mktemp)
+            cat "$BLOG_DIR/entries" > "$CURR"
+            diff "$PREV" "$CURR" | grep '^>' | sed 's/^> //' || true
+            mv "$CURR" "$PREV"
+            CURR=""
+        done
+        ;;
+
+    clear)
+        echo "clear" > "$BLOG_DIR/clear"
+        echo "BLOG entries cleared."
+        ;;
+
+    stats)
+        cat "$BLOG_DIR/stats"
+        ;;
+
+    sources)
+        cat "$BLOG_DIR/sources"
+        ;;
+
+    clients)
+        cat "$BLOG_DIR/clients"
+        ;;
+
+    *)
+        echo "Usage: $0 [snapshot|tail|clear|stats|sources|clients] [-d blog_dir] [-o dir]"
+        exit 1
+        ;;
+esac
diff --git a/tools/testing/selftests/ceph_blog/blog_smoke_test.sh b/tools/testing/selftests/ceph_blog/blog_smoke_test.sh
new file mode 100644
index 000000000000..1623630261c2
--- /dev/null
+++ b/tools/testing/selftests/ceph_blog/blog_smoke_test.sh
@@ -0,0 +1,363 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# blog_smoke_test.sh - Per-superblock smoke test for Ceph BLOG
+#
+# Verifies that BLOG stays disabled by default, that enabling BLOG on one
+# noshare-mounted CephFS instance only affects that instance, and that a second
+# noshare mount remains quiet until it is enabled separately.
+#
+# Usage:
+#   ./blog_smoke_test.sh -m <mon_addr> [-k <secret>] [-n <client_name>]
+#                        [-p <mount_a>] [-q <mount_b>] [-o <output_dir>]
+#
+# Environment variables:
+#   CEPH_MON      - monitor address(es)
+#   CEPH_SECRET   - CephX secret key
+#   CEPH_CLIENT   - client name, default "admin"
+#   CEPH_MOUNT    - mount A, default "/mnt/ceph_blog_test_a"
+#   CEPH_MOUNT_B  - mount B, default "${CEPH_MOUNT}_b"
+#   BLOG_OUTPUT   - output directory for collected traces
+#
+set -euo pipefail
+shopt -s nullglob
+
+MON="${CEPH_MON:-}"
+SECRET="${CEPH_SECRET:-}"
+CLIENT="${CEPH_CLIENT:-admin}"
+MNT_A="${CEPH_MOUNT:-/mnt/ceph_blog_test_a}"
+MNT_B="${CEPH_MOUNT_B:-}"
+OUTDIR="${BLOG_OUTPUT:-/tmp/blog_test_$(date +%Y%m%d_%H%M%S)}"
+
+TMP_STATE_DIR=""
+DEBUGFS_A=""
+DEBUGFS_B=""
+MOUNTED_A=0
+MOUNTED_B=0
+
+RED='\033[0;31m'
+GREEN='\033[0;32m'
+YELLOW='\033[0;33m'
+NC='\033[0m'
+
+pass()  { echo -e "  ${GREEN}PASS${NC}  $*"; }
+fail()  { echo -e "  ${RED}FAIL${NC}  $*"; }
+info()  { echo -e "  ${YELLOW}----${NC}  $*"; }
+die()   { echo -e "${RED}ERROR:${NC} $*" >&2; exit 1; }
+
+usage() {
+	sed -n '/^# Usage:/,/^$/p' "$0" | sed 's/^# //' >&2
+	exit 1
+}
+
+while getopts "m:k:n:p:q:o:h" opt; do
+	case $opt in
+		m) MON="$OPTARG" ;;
+		k) SECRET="$OPTARG" ;;
+		n) CLIENT="$OPTARG" ;;
+		p) MNT_A="$OPTARG" ;;
+		q) MNT_B="$OPTARG" ;;
+		o) OUTDIR="$OPTARG" ;;
+		h) usage ;;
+		*) usage ;;
+	esac
+done
+
+[[ -z "$MON" ]] && die "Monitor address required (-m or CEPH_MON)"
+[[ $(id -u) -ne 0 ]] && die "Must run as root"
+[[ -z "$MNT_B" ]] && MNT_B="${MNT_A}_b"
+
+cleanup() {
+	info "Cleaning up..."
+	if (( MOUNTED_B )); then
+		umount "$MNT_B" 2>/dev/null || true
+	fi
+	if (( MOUNTED_A )); then
+		umount "$MNT_A" 2>/dev/null || true
+	fi
+	[[ -n "$TMP_STATE_DIR" && -d "$TMP_STATE_DIR" ]] && rm -rf "$TMP_STATE_DIR"
+}
+trap cleanup EXIT
+
+assert_eq() {
+	local got="$1"
+	local want="$2"
+	local msg="$3"
+
+	if [[ "$got" != "$want" ]]; then
+		fail "$msg: expected '$want', got '$got'"
+		exit 1
+	fi
+	pass "$msg: $got"
+}
+
+assert_gt_zero() {
+	local value="$1"
+	local msg="$2"
+
+	if [[ "$value" -le 0 ]]; then
+		fail "$msg: expected > 0, got '$value'"
+		exit 1
+	fi
+	pass "$msg: $value"
+}
+
+have_kconfig() {
+	local pattern="$1"
+
+	grep -qE "$pattern" /boot/config-"$(uname -r)" 2>/dev/null ||
+		zgrep -qE "$pattern" /proc/config.gz 2>/dev/null
+}
+
+capture_blog_dirs() {
+	local dest="$1"
+	local dirs=(/sys/kernel/debug/ceph/*/blog)
+
+	: > "$dest"
+	if (( ${#dirs[@]} > 0 )); then
+		printf '%s\n' "${dirs[@]}" | sort -u > "$dest"
+	fi
+}
+
+find_new_blog_dir() {
+	local before="$1"
+	local after="$2"
+	local label="$3"
+	local new_dirs=()
+
+	mapfile -t new_dirs < <(comm -13 "$before" "$after" | sed '/^$/d')
+	if (( ${#new_dirs[@]} != 1 )); then
+		echo "Expected exactly one new BLOG debugfs directory for $label" >&2
+		echo "Before:" >&2
+		cat "$before" >&2
+		echo "After:" >&2
+		cat "$after" >&2
+		return 1
+	fi
+
+	echo "${new_dirs[0]}"
+}
+
+mount_ceph() {
+	local mnt="$1"
+	local opts="name=$CLIENT,noshare"
+
+	mkdir -p "$mnt"
+	[[ -n "$SECRET" ]] && opts="${opts},secret=$SECRET"
+	mount -t ceph "$MON":/ "$mnt" -o "$opts"
+}
+
+ensure_blog_dir() {
+	local dir="$1"
+
+	[[ -d "$dir" ]] || die "BLOG debugfs directory missing: $dir"
+	[[ -r "$dir/entries" ]] || die "BLOG entries file missing: $dir/entries"
+	[[ -r "$dir/stats" ]] || die "BLOG stats file missing: $dir/stats"
+	[[ -r "$dir/sources" ]] || die "BLOG sources file missing: $dir/sources"
+	[[ -r "$dir/clients" ]] || die "BLOG clients file missing: $dir/clients"
+	[[ -w "$dir/enabled" ]] || die "BLOG enabled file missing: $dir/enabled"
+}
+
+read_enabled() {
+	tr -d '[:space:]' < "$1/enabled"
+}
+
+set_blog_enabled() {
+	local dir="$1"
+	local value="$2"
+	local actual
+
+	echo "$value" > "$dir/enabled"
+	actual="$(read_enabled "$dir")"
+	case "$value" in
+		0)
+			[[ "$actual" == "N" || "$actual" == "0" ]] ||
+				die "Failed to disable BLOG in $dir (got '$actual')"
+			;;
+		1)
+			[[ "$actual" == "Y" || "$actual" == "1" ]] ||
+				die "Failed to enable BLOG in $dir (got '$actual')"
+			;;
+		*)
+			die "Unsupported BLOG enabled value: $value"
+			;;
+	esac
+}
+
+clear_blog() {
+	local dir="$1"
+
+	echo "clear" > "$dir/clear"
+}
+
+count_entries() {
+	local dir="$1"
+	local count
+
+	count="$(grep -Ec '^[0-9]{4}-[0-9]{2}-[0-9]{2} ' "$dir/entries" 2>/dev/null || true)"
+	echo "${count:-0}"
+}
+
+count_sources() {
+	local dir="$1"
+	local count
+
+	count="$(grep -c '^ID ' "$dir/sources" 2>/dev/null || true)"
+	echo "${count:-0}"
+}
+
+count_contexts() {
+	local dir="$1"
+	local count
+
+	count="$(awk -F': ' '/Total contexts allocated/{print $2; exit}' \
+		"$dir/stats" 2>/dev/null || true)"
+	echo "${count:-0}"
+}
+
+count_mount_clients() {
+	local dir="$1"
+	local count
+
+	count="$(grep -c '^FSID:' "$dir/clients" 2>/dev/null || true)"
+	echo "${count:-0}"
+}
+
+require_timestamped_entries() {
+	local dir="$1"
+	local msg="$2"
+
+	if ! grep -Eq '^[0-9]{4}-[0-9]{2}-[0-9]{2} ' "$dir/entries"; then
+		fail "$msg: no timestamped BLOG entries found"
+		exit 1
+	fi
+	pass "$msg"
+}
+
+snapshot_blog() {
+	local dir="$1"
+	local tag="$2"
+	local dest="$OUTDIR/$tag"
+
+	mkdir -p "$dest"
+	for f in enabled entries stats sources clients; do
+		cat "$dir/$f" > "$dest/$f.txt"
+	done
+}
+
+run_mount_io() {
+	local mnt="$1"
+	local tag="$2"
+	local root="$mnt/blog_smoke_$tag"
+
+	rm -rf "$root"
+	mkdir -p "$root/subdir"
+	printf 'ceph-blog-%s %s\n' "$tag" "$(date +%s%N)" > "$root/file.txt"
+	cat "$root/file.txt" > /dev/null
+	stat "$root/file.txt" > /dev/null
+	mv "$root/file.txt" "$root/subdir/file.txt"
+	ln -sf "$root/subdir/file.txt" "$root/link.txt"
+	readlink "$root/link.txt" > /dev/null
+	ls -l "$root" > /dev/null
+	rm -f "$root/link.txt" "$root/subdir/file.txt"
+	rmdir "$root/subdir"
+	rmdir "$root"
+}
+
+echo "=========================================="
+echo " Ceph BLOG Per-Superblock Smoke Test"
+echo "=========================================="
+echo ""
+
+KSFT_SKIP=4
+info "Checking kernel BLOG support..."
+if ! have_kconfig 'CONFIG_CEPH_FS=(y|m)'; then
+	info "SKIP: Cannot confirm CONFIG_CEPH_FS=y|m"
+	exit "$KSFT_SKIP"
+fi
+if ! have_kconfig 'CONFIG_DEBUG_FS=y'; then
+	info "SKIP: Cannot confirm CONFIG_DEBUG_FS=y"
+	exit "$KSFT_SKIP"
+fi
+if have_kconfig 'CONFIG_CEPH_FS=m'; then
+	modprobe ceph 2>/dev/null || die "Failed to load ceph module"
+fi
+
+mkdir -p "$OUTDIR" "$MNT_A" "$MNT_B"
+TMP_STATE_DIR="$(mktemp -d /tmp/ceph_blog_smoke.XXXXXX)"
+
+capture_blog_dirs "$TMP_STATE_DIR/before_a"
+info "Mounting CephFS A with noshare: $MON -> $MNT_A"
+mount_ceph "$MNT_A" || die "Mount A failed"
+MOUNTED_A=1
+capture_blog_dirs "$TMP_STATE_DIR/after_a"
+DEBUGFS_A="$(find_new_blog_dir "$TMP_STATE_DIR/before_a" \
+	"$TMP_STATE_DIR/after_a" "mount A")" || die "Failed to identify BLOG dir for mount A"
+ensure_blog_dir "$DEBUGFS_A"
+pass "Mount A BLOG debugfs: $DEBUGFS_A"
+
+capture_blog_dirs "$TMP_STATE_DIR/before_b"
+info "Mounting CephFS B with noshare: $MON -> $MNT_B"
+mount_ceph "$MNT_B" || die "Mount B failed"
+MOUNTED_B=1
+capture_blog_dirs "$TMP_STATE_DIR/after_b"
+DEBUGFS_B="$(find_new_blog_dir "$TMP_STATE_DIR/before_b" \
+	"$TMP_STATE_DIR/after_b" "mount B")" || die "Failed to identify BLOG dir for mount B"
+ensure_blog_dir "$DEBUGFS_B"
+pass "Mount B BLOG debugfs: $DEBUGFS_B"
+
+assert_eq "$(count_mount_clients "$DEBUGFS_A")" 1 "mount A clients view is local"
+assert_eq "$(count_mount_clients "$DEBUGFS_B")" 1 "mount B clients view is local"
+
+info "Phase 1: BLOG disabled by default on both mounts"
+set_blog_enabled "$DEBUGFS_A" 0
+set_blog_enabled "$DEBUGFS_B" 0
+run_mount_io "$MNT_A" "disabled_a"
+assert_eq "$(count_entries "$DEBUGFS_A")" 0 "mount A stays quiet when disabled"
+assert_eq "$(count_entries "$DEBUGFS_B")" 0 "mount B stays quiet while mount A runs"
+snapshot_blog "$DEBUGFS_A" "00_disabled_a"
+snapshot_blog "$DEBUGFS_B" "00_disabled_b"
+
+info "Phase 2: Enable BLOG only on mount A"
+set_blog_enabled "$DEBUGFS_A" 1
+set_blog_enabled "$DEBUGFS_B" 0
+clear_blog "$DEBUGFS_A"
+clear_blog "$DEBUGFS_B"
+run_mount_io "$MNT_A" "enabled_a"
+
+A_ENTRIES="$(count_entries "$DEBUGFS_A")"
+B_ENTRIES="$(count_entries "$DEBUGFS_B")"
+assert_gt_zero "$A_ENTRIES" "mount A produces BLOG entries when enabled"
+assert_eq "$B_ENTRIES" 0 "mount B remains quiet while only mount A is enabled"
+assert_gt_zero "$(count_sources "$DEBUGFS_A")" "mount A registers BLOG sources"
+assert_gt_zero "$(count_contexts "$DEBUGFS_A")" "mount A allocates BLOG contexts"
+require_timestamped_entries "$DEBUGFS_A" "mount A entries deserialize with timestamps"
+snapshot_blog "$DEBUGFS_A" "01_enabled_a"
+snapshot_blog "$DEBUGFS_B" "01_enabled_a_other_mount"
+
+info "Phase 3: Disable mount A, enable mount B"
+A_BEFORE_B="$A_ENTRIES"
+set_blog_enabled "$DEBUGFS_A" 0
+set_blog_enabled "$DEBUGFS_B" 1
+clear_blog "$DEBUGFS_B"
+run_mount_io "$MNT_B" "enabled_b"
+
+A_AFTER_B="$(count_entries "$DEBUGFS_A")"
+B_AFTER_B="$(count_entries "$DEBUGFS_B")"
+assert_eq "$A_AFTER_B" "$A_BEFORE_B" "mount A entries stay unchanged while mount B runs"
+assert_gt_zero "$B_AFTER_B" "mount B produces BLOG entries when enabled"
+assert_gt_zero "$(count_sources "$DEBUGFS_B")" "mount B registers BLOG sources"
+assert_gt_zero "$(count_contexts "$DEBUGFS_B")" "mount B allocates BLOG contexts"
+require_timestamped_entries "$DEBUGFS_B" "mount B entries deserialize with timestamps"
+snapshot_blog "$DEBUGFS_A" "02_enabled_b_other_mount"
+snapshot_blog "$DEBUGFS_B" "02_enabled_b"
+
+echo ""
+echo "=========================================="
+echo " Results Summary"
+echo "=========================================="
+pass "Default-off behavior verified on both mounts"
+pass "Enable-on-A only behavior verified"
+pass "Cross-mount non-interference verified with noshare"
+pass "Enable-on-B behavior verified"
+info "Traces saved to: $OUTDIR/"
diff --git a/tools/testing/selftests/ceph_blog/config b/tools/testing/selftests/ceph_blog/config
new file mode 100644
index 000000000000..7c5706ed8be8
--- /dev/null
+++ b/tools/testing/selftests/ceph_blog/config
@@ -0,0 +1,2 @@
+CONFIG_CEPH_FS=m
+CONFIG_DEBUG_FS=y
-- 
2.34.1

