Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569D73ACEF9
	for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2026 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024357; cv=none; b=gnDFaUDffOE8pi4h/gjItw0+4YAsNUUVmG/CfuUHbplUEiWHN+YpiapjYnB6IpcBmXKPqbIS0Eh1TrI5w9q4rJQslUgu4BerKbF9UUK1JTTJcGKCEP52qtFS7omGSg7ukz6NEOLR+K2UXvHL0jgNQ9OvurZLdxRg9aFbZj4eNnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024357; c=relaxed/simple;
	bh=ezBckF0lKaSLAxOrpzSdbBHvUo+vPXQ5KvwM+WUDQsg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ncyBKanr7eJYA9VryBFL9BUe/Gml2LwhNMjGzYQk/8BsYwfbgEgXi89KCxcsH+bdtL8jpAzRuuajBoF8SjcwriZYEXPNswzhPvjxRv/sYJcEhLsTQHsw1bgE4irJiBLvZvaApQKPUA2eEa89STvcCQwEAxj+vwSvSi2KiugZQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cfw5ILS8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaVFhP8Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cfw5ILS8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaVFhP8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772024354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aOw9INrgxnxy1CMgrkfGNK7kVX6hvwU+ErGcKC9BW4E=;
	b=Cfw5ILS8IospIft5rtymaeJV3kkjTSEs7wdva/KOucir3+2zrBItiOtdQBi4L7k3RKxpah
	9SkKP5cdVRbJ//ULppRCIfyGaFjEBurTTHVV2cJx5annwO7SQDgZowE7YKd6fcW4wnyZcR
	VVatXYK01AdrsvoRP1c5CgN05mOfaEw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-2VXSn1MmPQ6EgVP9GNsWig-1; Wed, 25 Feb 2026 07:59:13 -0500
X-MC-Unique: 2VXSn1MmPQ6EgVP9GNsWig-1
X-Mimecast-MFC-AGG-ID: 2VXSn1MmPQ6EgVP9GNsWig_1772024353
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8966c2b187bso683307596d6.2
        for <ceph-devel@vger.kernel.org>; Wed, 25 Feb 2026 04:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772024352; x=1772629152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aOw9INrgxnxy1CMgrkfGNK7kVX6hvwU+ErGcKC9BW4E=;
        b=JaVFhP8QfU13GGFPMpEMJ9gLG9HpbGFLY9QO5uSssHoWYD5mfMt+0Ixv2n6Yij84TR
         TtVlIjM3DCQGbXBCUqUsuJEi0oEd2jFw7vnX0Pabv7ZYEUybrXb+e1BnPI+WVcSqhg1R
         2bwW0XF1z39ijwqER/vHefi1lHHnazCx1MzepC22W8a6LaN1KZa+sgn6N4xO/V3h3hwB
         EKPfzC9CMm4GC746DGXtRqyg+LFAwkF004iXdxpV5Vv8gSfIRjrSOdF5PGWROQ2JYnZk
         MRgCp/ZpC9poj7Du99teXgtO1yqwOJsMUlflOvVCBq3mQVkW7KhFJbymDa6Klk/MRbyD
         25Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772024352; x=1772629152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOw9INrgxnxy1CMgrkfGNK7kVX6hvwU+ErGcKC9BW4E=;
        b=dFKNXF+FBUex8VpXJCji/PsxZGyevzczf9VxYtWPKHRoysxpkHz4BGVrUJC6SSqPSt
         4ccH3niYYbkw4Q7w4qI/vIhdiQdjWW9KTEPwJdzeMDpL2n2jGhlhANEG/xmb4UjuliPX
         q2LrZCUP3w4upy/bE6bFoFiDO1aoMSTOP9HQuSej2jmgjtSdaESHAfP3QzQ0IGmapIPD
         EhZYTC9piUZGhZKrOqjhxM7QRNdmisoy9lhgi1rFXHdjy1URQC3Fs2bPIguNVo+G5WMN
         KTuhNXn5Z/1Ebch5hlGd5QFYB7wclEPbmzdA6BG82eUrU9CI5l6Cq6JQZ9H2aV82z6h6
         wyug==
X-Gm-Message-State: AOJu0YyKJPU8pT/p2RCyVMgp7HSB+VUrQJA7vVG4UuOmQW3xdb6HACbd
	zENzXl/dlwh98Y8Pd7XaKbjs919bngj62XFPkOKsLHN7/lv7WP6kKCPbNx1vDnriYXuDRPbisiJ
	5BC+JIUquK2cZSDZZENaH7dofB/xS9BxH5b84WvfHIW9t8czeqfLLXbNGizBczM01Bplxt04+rg
	EjbRsZXM0qZPAQL2dwqmnfkSIY6xUgcxyxib+gNnQ1JVUOPV14derx
X-Gm-Gg: ATEYQzwdFBeeemuxBnz2tIph2qQOJBsHDEtiiQzbaSEr27PCs0qAL82DuHpl/sXyAQc
	m8RL5JSLY4r67o78vXhmb6w9nzO0YiKRlgT7qutzU9Mc0PfNCq5gJr4XJB6mUeCf/+LtSWav4FI
	A8rJ1OZmifJFxKeEd5zfLaRWea7SfTMS0GR6iLa7jJ6t8hfxcNyZh89pMBKzSt3xpVP5Ry/XlbL
	LXbjReiUC8RIMU24AishMXfPyXKIRRkUlZ+wNCoOzsaF6u30PFCU9z0WkIN8588qRnwHRVh19YW
	x7O9QsNt+O9VuFDFLQW5lSAkJv/f0n/YJZhD30S8Rt70Kdv5AGe6UoUfDIjwycGy0C9Bz23SRk7
	BfdzutrIZUJkoIY9pmHm4UkP5LkkXC1dyUWqDCDIU0MG3cLi9ul9L9MM=
X-Received: by 2002:a05:620a:28c8:b0:8b2:eae0:bbf4 with SMTP id af79cd13be357-8cb8c9f59f1mr1840183285a.19.1772024352420;
        Wed, 25 Feb 2026 04:59:12 -0800 (PST)
X-Received: by 2002:a05:620a:28c8:b0:8b2:eae0:bbf4 with SMTP id af79cd13be357-8cb8c9f59f1mr1840179485a.19.1772024351879;
        Wed, 25 Feb 2026 04:59:11 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d046055sm1514219685a.8.2026.02.25.04.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 04:59:11 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [RFC PATCH v1 0/4] ceph: manual client session reset via debugfs
Date: Wed, 25 Feb 2026 12:59:03 +0000
Message-Id: <20260225125907.53851-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In production CephFS deployments we regularly encounter situations
where MDS sessions become stuck or hung, requiring a full unmount/
remount cycle to recover.  This is disruptive for workloads that
cannot tolerate the downtime or the loss of cached state that comes
with unmounting.

This series adds a mechanism to manually trigger MDS session
reconnection from the client side without unmounting, exposed via
debugfs:

  echo "reason text" > /sys/kernel/debug/ceph/<fsid>/reset/trigger
  cat /sys/kernel/debug/ceph/<fsid>/reset/status

The reset lifecycle:
  1. Operator writes to the trigger file
  2. A work item collects all active sessions and initiates
     reconnection on each (via send_mds_reconnect with from_reset=true)
  3. New metadata requests and lock acquisitions are blocked until
     the reset completes (120s timeout)
  4. Session completions are tracked via a per-session generation
     counter to handle stale completions from timed-out prior resets
  5. Lock reclamation is always attempted during reset-initiated
     reconnects, regardless of prior CEPH_I_ERROR_FILELOCK state

Patch breakdown:
  1. Convert CEPH_I_* flags to named bit positions so test_bit/
     set_bit/clear_bit can be used in reconnect paths
  2. Make wait_caps_flush() bounded with periodic diagnostic dumps
     to aid debugging hung flush scenarios (independent improvement
     that surfaced during development)
  3. The core reset implementation: debugfs interface, reset work
     function, request/lock blocking, tracepoints, and session
     reconnect completion tracking
  4. Rework mds_peer_reset() to properly handle all session states
     and integrate with the reset completion tracking

Open questions / areas for review:
  - Is debugfs the right interface, or should this be a mount option
    / sysfs attribute / netlink command?
  - The request gating in ceph_mdsc_submit_request() is best-effort
    (no lock serialization) to avoid penalizing the normal path.
    Is this acceptable?
  - Should the 60s reconnect timeout and 120s blocked-request timeout
    be configurable (e.g. via mount options)?
  - mds_peer_reset() rework (patch 4) is substantial -- would
    reviewers prefer it split further?


Alex Markuze (4):
  ceph: convert inode flags to named bit positions
  ceph: add bounded timeout and diagnostics to wait_caps_flush()
  ceph: implement manual client session reset via debugfs
  ceph: rework mds_peer_reset() for robust session recovery

 fs/ceph/caps.c              |   7 +
 fs/ceph/debugfs.c           | 171 ++++++++++-
 fs/ceph/locks.c             |  24 +-
 fs/ceph/mds_client.c        | 577 ++++++++++++++++++++++++++++++++++--
 fs/ceph/mds_client.h        |  33 +++
 fs/ceph/super.h             |  60 ++--
 include/trace/events/ceph.h |  60 ++++
 7 files changed, 879 insertions(+), 53 deletions(-)

-- 
2.34.1

