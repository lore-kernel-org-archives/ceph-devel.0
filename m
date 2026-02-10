Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BF133DEE9
	for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2026 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714395; cv=none; b=JqY4Ydaf1sO1Bt58CVpDHzxxwz9adOgd3FgHKfMXdhXkZiGpeHeEnZjR8yeOYVFg1hzTtDnbpx53weLJ5cbuTks+G8kMXcgziBHBSuWvl66ztHOXH2vJ8MgKGmmxKwCYx6cikrqz2odD/kGPYj3KFkeEaRkx7BjLBgmG5XGop7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714395; c=relaxed/simple;
	bh=jEtPD7lEnKueCK3nWUUFtqX+R3ZXhj/ui/f2Y34tw2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZZUTw8ubPtu00rQRtg1ey/lp2uJxC+pUsibXZYabyFQX5nyFhSyRXeVzo/Fwcg08i0Xbn0XDo2aV1sr63bxY8o8xPhxk5k6GCefWUw3CyzvCybY2D2RCpqYdsHQSyhrm9MG3pDgQQvGUEK452yJYbbssolwyAne1vU4n+zYf0MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZT/zzA2v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5mKwODy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZT/zzA2v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5mKwODy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770714393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1yS0XvdNLyxbdctac2U/Q3VqlV341oNKdWppclXcS7c=;
	b=ZT/zzA2vki1FCjhufvZpSz+2dYvAxMYlpC9yLKz8KWMRV1SSzfn6tyzFJiTcDLH5C8Mzu8
	wzOHdHfcDiot6DiyiQfr00W2hqb9nszv7omli/0XObKxnwV+uBaIdyRMcV5luU+Hzua6wx
	a2g7YNLidPHO8PlUrICW99x3CfQYSMw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-Rzmf4yhwNUOwcrtmUEfYpA-1; Tue, 10 Feb 2026 04:06:32 -0500
X-MC-Unique: Rzmf4yhwNUOwcrtmUEfYpA-1
X-Mimecast-MFC-AGG-ID: Rzmf4yhwNUOwcrtmUEfYpA_1770714392
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c5e166fb75so1637473285a.0
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2026 01:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770714392; x=1771319192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1yS0XvdNLyxbdctac2U/Q3VqlV341oNKdWppclXcS7c=;
        b=F5mKwODyZVlv2NhgcpmBSWfyWa0GwGAli2zfDMw0Q2+5VlxY+7idcmXWmeNvUFZBVa
         5+0RAud3YVXloEpqhna18qyj20OErAAZqDVJ5426G1Od11kPBMjrCUqO0ca0K3wnZ+S3
         t17DtMUa985Ysnszax0HQZj9lvrgUVeS2X4mPUFDXmVHsbcdB9kRf+SMtJDvicvyM6UR
         y4YEvHufPuG0e0lojYO9CEfDsAoJ3Ke+ovZUtCBCGmazKOh6mDvgzhAyRc1WHiUiDJLl
         2ovux2rnE9XYEwYS+nzmBP9nEVOMo0dBXFVWsL6Min5YTkEr7CXLxrGaimi8VNxj7Yc3
         e3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770714392; x=1771319192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yS0XvdNLyxbdctac2U/Q3VqlV341oNKdWppclXcS7c=;
        b=X+5eXhwHkWfTTd2nOPX3/Akxg0zgf+v7WTeuVrXDrXreeXpR0bWvSTmEAVr/VGrc2O
         B2NzVSwKUh2TMBGYNGiSJglM2c8oknlEyBkFQFrnZCZxz/mtdeaMZTjAkqoARHQ5YwtZ
         uLa4fAu3r1qUmHN5/RLvj/45LfwrlAS6Ud58GP7975bOt6TF2CC/60xS17ekRnlY1czC
         hP0dXh7E+tCHRkj0xRcXn6eUWbrKo4J+FEi7Y6iv63jh0Vd/fAv0y0vxxTYsT8s02KGM
         4+GQQ+L38snbL9ek+kMqax+QV0Bxd56GCI3bJ8prJzaO1l2/NTFys5LTCm3OeBnfqVI1
         8v3g==
X-Gm-Message-State: AOJu0YzVAXgi0UeY9iBK2oQ3vw9f9BDK1qoxlJiSXRtwUjZLNBRkBLbF
	C3uOK1Kos9v2ej4KHvr6LgAHmsPQufgvXAoJQ1rmEC+xuR3b0zkaRtwBObiOTpwzLzdUk0VHNbQ
	N8B3prPkvrJVKLgi5ViCYNzFMev1mOaQNHc8wNqodowd0sujh95UJjBuzJ8ciNbb7VzlPPMj+1k
	4ym32zGSIYMlHohU34NNIwsPEz307JEBRe+tc2NYY1sFxI7ZkP7gyK
X-Gm-Gg: AZuq6aLIYzAA5V4WFr9HzJSnK/lYFV1gzxWw4JDaZiZqIH+1B7Y2pIOwOZpAOl8Ykxb
	xEyk28R4NUu9Z/mrdZPY718/Cbtzd7dS/FdiKm8KWoFTS87uxDQJgxWtGEjyjcpUP/80hwxVCwg
	DPTWfVp0YeD9mmxVp4KZdm+wvjdoid44J6MO6TVXjTYHAiL0KIO3Y9GqY/vhd5+Q2C+edgZNoRe
	BQmLsfLz6qoK+i7Y3JYZpsj3ZD08G8UcZ6z9vSiYFHU4DJZLNwbrx+mCWXGJ9RG7XKnXbp6oxuV
	nPmzH7CnM75ef+yCi64XiCxitd1XOSwA/urGfcVzk0z7a5g0JyILzBvxAmp8fZaeAL1CJtWaM3V
	whaAIFUQvoI7m7XSBu2R/mHwErnck7eLLVtwYOiTP04hdMSugXh8CUXg=
X-Received: by 2002:a05:620a:44cc:b0:8ca:4288:b178 with SMTP id af79cd13be357-8cb1f74d6c1mr137811385a.56.1770714391614;
        Tue, 10 Feb 2026 01:06:31 -0800 (PST)
X-Received: by 2002:a05:620a:44cc:b0:8ca:4288:b178 with SMTP id af79cd13be357-8cb1f74d6c1mr137808385a.56.1770714391019;
        Tue, 10 Feb 2026 01:06:31 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c068292sm108053326d6.45.2026.02.10.01.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 01:06:30 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v6 0/3] ceph: add subvolume metrics reporting support
Date: Tue, 10 Feb 2026 09:06:23 +0000
Message-Id: <20260210090626.1835644-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for per-subvolume I/O metrics collection
and reporting to the MDS. This enables administrators to monitor I/O
patterns at the subvolume granularity, which is useful for multi-tenant
CephFS deployments where different subvolumes may be allocated to
different users or applications.

The implementation requires protocol changes to receive the subvolume_id
from the MDS (InodeStat v9), and introduces a new metrics type
(CLIENT_METRIC_TYPE_SUBVOLUME_METRICS) for reporting aggregated I/O
statistics back to the MDS.

Patch 1 adds forward-compatible handling for InodeStat v8, which
introduces the versioned optmetadata field. The kernel client doesn't
use this field but must skip it properly to parse subsequent fields.

Patch 2 adds support for parsing the subvolume_id field from InodeStat
v9 and storing it in the inode structure for later use. This patch also
introduces CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset
state and enforces subvolume_id immutability with WARN_ON_ONCE if
attempting to change an already-set subvolume_id.

Patch 3 adds the complete subvolume metrics infrastructure:
- CEPHFS_FEATURE_SUBVOLUME_METRICS feature flag for MDS negotiation
- Red-black tree based metrics tracker for efficient per-subvolume
  aggregation with kmem_cache for entry allocations
- Wire format encoding matching the MDS C++ AggregatedIOMetrics struct
- Integration with the existing CLIENT_METRICS message
- Recording of I/O operations from file read/write and writeback paths
- Debugfs interfaces for monitoring

Metrics tracked per subvolume include:
- Read/write operation counts
- Read/write byte counts
- Read/write latency sums (for average calculation)

The metrics are periodically sent to the MDS as part of the existing
metrics reporting infrastructure when the MDS advertises support for
the SUBVOLUME_METRICS feature.

Debugfs additions in Patch 3:
- metrics/subvolumes: displays last sent and pending subvolume metrics
- metrics/metric_features: displays MDS session feature negotiation
  status, showing which metric-related features are enabled (including
  METRIC_COLLECT and SUBVOLUME_METRICS)

Changes since v5:
- Rebased onto latest kernel (resolved conflict with inode_state_read_once()
  accessor change in fs/ceph/inode.c)
- Re-added InodeStat v8 handling patch (patch 1) as it was not actually
  in the base tree, making this a 3-patch series again

Changes since v4:
- Merged CEPH_SUBVOLUME_ID_NONE and WARN_ON_ONCE immutability check
  into patch 1 (previously split across patches 2 and 3)
- Removed unused 'cl' variable from parse_reply_info_in() that would
  cause compiler warning
- Added read I/O recording in finish_netfs_read() for netfs read path
- Simplified subvolume_metrics_dump() to use direct rb-tree iteration
  instead of intermediate snapshot allocation
- InodeStat v8 patch now in base tree, reducing series from 3 to 2
  patches

Changes since v3:
- merged CEPH_SUBVOLUME_ID_NONE patch into its predecessor

Changes since v2:
- Add CEPH_SUBVOLUME_ID_NONE constant (value 0) for unknown/unset state
- Add WARN_ON_ONCE if attempting to change already-set subvolume_id
- Add documentation for struct ceph_session_feature_desc ('bit' field)
- Change pr_err() to pr_info() for "metrics disabled" message
- Use pr_warn_ratelimited() instead of manual __ratelimit()
- Add documentation comments to ceph_subvol_metric_snapshot and
  ceph_subvolume_metrics_tracker structs
- Use kmemdup_array() instead of kmemdup() for overflow checking
- Add comments explaining ret > 0 checks for read metrics (EOF handling)
- Use kmem_cache for struct ceph_subvol_metric_rb_entry allocations
- Add comment explaining seq_file error handling in dump function

Changes since v1:
- Fixed unused variable warnings (v8_struct_v, v8_struct_compat) by
  using ceph_decode_skip_8() instead of ceph_decode_8_safe()
- Added detailed comment explaining InodeStat encoding versions v1-v9
- Clarified that "optmetadata" is the actual field name in MDS C++ code
- Aligned subvolume_id handling with FUSE client convention (0 = unknown)

Alex Markuze (3):
  ceph: handle InodeStat v8 versioned field in reply parsing
  ceph: parse subvolume_id from InodeStat v9 and store in inode
  ceph: add subvolume metrics collection and reporting

 fs/ceph/Makefile            |   2 +-
 fs/ceph/addr.c              |  14 ++
 fs/ceph/debugfs.c           | 157 ++++++++++++++
 fs/ceph/file.c              |  68 +++++-
 fs/ceph/inode.c             |  41 ++++
 fs/ceph/mds_client.c        |  92 ++++++--
 fs/ceph/mds_client.h        |  14 +-
 fs/ceph/metric.c            | 183 +++++++++++++++-
 fs/ceph/metric.h            |  39 +++-
 fs/ceph/subvolume_metrics.c | 416 ++++++++++++++++++++++++++++++++++++
 fs/ceph/subvolume_metrics.h |  97 +++++++++
 fs/ceph/super.c             |   8 +
 fs/ceph/super.h             |  11 +
 13 files changed, 1114 insertions(+), 28 deletions(-)
 create mode 100644 fs/ceph/subvolume_metrics.c
 create mode 100644 fs/ceph/subvolume_metrics.h

--
2.34.1

