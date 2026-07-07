Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B3643F4B3
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460556; cv=none; b=C042HQwiMBYLFGOjIBcfYlq/I16BhfRJwZaeQtd7Jzo6hXyZhj368ZodBtq9PcyIo8zDFc6U6/JJZXtlAjDjtfXnyZOqQc+iu/o0kQcEDmr0nKQINdKwldgafzZRohkXO8dm60+sQA/RP3DbKILx+BXmOrgY6SjTFy1Y8qnsHUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460556; c=relaxed/simple;
	bh=zSnKGAXUYKrxSN8e3ZX9H2W/sQ/pbShhAYN+qxSOEeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ag6hiBdwuyg/e1Lhefwl6Jy+h83ykISDPLIYebMfywIZrigXhmeoAkrG5IUMRVv4mbqgJOly6cH8qPL3pwR/uNJGHQt/+rkjsiVMlTKhF4QgawU2oeAdGtXQ3DyMS1lXbV4oSwLmm2cQ42LhMKsN2308/k8qhGvL6Snj6e1J610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Ra57FTmI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Ra57FTmI"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493e4ccccc2so3775125e9.2
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783460553; x=1784065353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fr34X1DQSGmN+02DaqdMQrFw+Hk4XAU6EmNPh+kwNxk=;
        b=Ra57FTmI8/mCYM7vVM7NidSEkmDQ3yF3jAqLfkbF/3Ji2a1dWV2BI1SzhQkIcUjHRd
         VN9U8ytSX4pyxT7wI6BikqXoE7zYeP2hce69K0FgFuO5iGQi648m9OYX+16UTtqlyHMs
         rh3jlSqvx82uDkdHUXm+HBfFPpyFjl93Juj7ewBXpf4/WGn0QaTs/5M5+w7LhUwo4iFW
         wEAXx9hIAnXHrLRH3uTgUFFWEQvVj/xrxj1dA5XbJUgegjt7N6qnL5vrn0nBAHDhwRsg
         u4hhUESFKu7Mj4Lj2AnVUVMyjrSYy1C70WTN2rU1GyUHcX5M0LK7ubSJWF+R6HI/cNcQ
         F8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783460553; x=1784065353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fr34X1DQSGmN+02DaqdMQrFw+Hk4XAU6EmNPh+kwNxk=;
        b=dg7RTlbGTtJ5gjREqK3ay+LK48ic2AYb56a3sSoS+mKQogIVnxtWmMYNLN53r6xfFu
         JzroBup1OkBuGu6oshzExb1ln8mYVQWZ+vw17OhOWVgb3AEuZTu5KHiWfltqt7JTuDyq
         R3eClKoEpSjz4VTNQtjHxLtixII4HOnDbK9L3Z1wjmaAH5yjIGZ+pMqtwd3KDbkaFkiZ
         hUpxv3Hef9sfvKDhS8Q3eQGrU/EoFuOG5KI85Av+crJxD/01uP1xiEjGMVvfsV9rD/2v
         XYudYhg40eywWePOv/DKjPZJxvma+vYln8ZSSm+IVVrJQABLXbzEntZ140s+5G+Ci0f+
         YZgQ==
X-Forwarded-Encrypted: i=1; AHgh+RrPq2NA325aUBtDSH9Di2Bd8/mgQFs1OQVLFUGXyzPqclK1SuOari+0i59bRculyISShjdp+8hBRau0@vger.kernel.org
X-Gm-Message-State: AOJu0YxSHNMNUeUgB4MOl111wj+PQV4qZPi5DXY3VMgV9JFFMnLFVBAj
	YOdzwVmk0C5vVGo5aNnyG0un5i5nF6kkL6BH/+j3l5N5yJqSIicUZvfAxHM4wcxKQEk=
X-Gm-Gg: AfdE7ck+CKsky/pUlGeqmJM8NE8vBqLAVa9Iuwr48sKPxQ89ou80pzGIsQByW2g/v5r
	K4Zs0LPX64wgWxB2wPjN7Fy60cWCKy9mfCyApM3GowpXVW6T+iGeK6lyQqKYKAC6L1H2zTNHFBK
	IIj7ZJEJtunpXQZ6HybUiGa595aFX+iqwd+TKPexueZafd9ALcvythLz+Z1tGzXW2LIKKAt585h
	OZExubnwfjlyB/jTO67xr9NBPqdRdHjb0LBDXGibwsRkaE+sH0hqm9GG7BSrU5Bk3rwbjDfCnFl
	Dy+passYMEqdy4zmRDWjBtebs9/fjYOFP9eyRZYWxyWAEEtl5EiX7PN5GAYIhnwisKDOMnVL1Kt
	cCjFmJ6Xs0/3A1BOLubmzDfT1ct0x1amOUV4ZX2A16d/7dGrSgJJiA9eSq6UsbrgZgAOX6mpyYB
	QfMmjN4K4gqMGcWqcAtD90mgHvOGBXCTQDLWmTWAS8dM2U8y1mUSkqRltxFcsl5+8I1+pfQBk3k
	KIWfyjK2KpbVOxa
X-Received: by 2002:a05:600c:548d:b0:493:c478:8744 with SMTP id 5b1f17b1804b1-493df0644a7mr78150655e9.18.1783460553100;
        Tue, 07 Jul 2026 14:42:33 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d843csm36076615f8f.14.2026.07.07.14.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 14:42:32 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ceph/dir: do not repeat ceph_trim_dentries() if no progress possible
Date: Tue,  7 Jul 2026 23:42:28 +0200
Message-ID: <20260707214228.10769-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_cap_reclaim_work() re-queues itself for as long as
ceph_trim_dentries() returns -EAGAIN, which happens whenever a lease
walk exhausts its `nr_to_scan` budget.  This creates a busy loop that
consumes CPU without making any progress when there is nothing to
reclaim: with no cap pressure (`count==0`) and every scanned lease
still valid, each pass runs the full scan budget down to zero and
returns `-EAGAIN`, only to be queued again immediately.

The dir-lease walk made this worse.  When `expire_dir_lease` is
`false` (i.e. we have no intention of reclaiming dir leases),
__dir_lease_check() returned `TOUCH` for every valid lease.  `TOUCH`
moves the dentry to the tail of the list and resets `di->time` via
__dentry_dir_lease_touch(), so a walk over N valid leases pointlessly
rewrote the list, refreshed the timestamps (preventing them from ever
aging out) and always drained `nr_to_scan`, guaranteeing the `-EAGAIN`
requeue.

Fix this in three steps:

 - Return `KEEP` instead of `TOUCH` when `expire_dir_lease` is
   `false`.  If we are not going to reclaim the lease, leave it in
   place instead of churning the list and resetting its timestamp; the
   walk then terminates naturally (or via `STOP` at the first fresh
   lease).

 - Only return `-EAGAIN` from the first (dentry-lease) walk when something
   was actually freed.  A full batch that frees nothing means retrying
   the same list immediately is futile; fall through to the dir-lease
   walk instead.

 - After both walks, bail out with success (0) when nothing was freed
   and there is no cap pressure (`count==0`).  There is no reason to
   keep retrying when we are not over the cap limit and made no
   progress.

Under real cap pressure (`count>0`) the reclaim path is unchanged and
still retries via `-EAGAIN`.

Without this patch, I saw 500 ceph_trim_dentries() calls per second on
our web servers.  This is very visible in `/proc/lock_stat` (5 minute
capture):

              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg

 &mdsc->dentry_list_lock:        126180         128218           0.04        8063.44    15986965.20         124.69        1573354        5296812           0.04        8291.28    74164526.48          14.00
 -----------------------
 &mdsc->dentry_list_lock         111736          [<000000007b11e319>] __ceph_dentry_dir_lease_touch+0x7c/0xa8
 &mdsc->dentry_list_lock           2631          [<0000000050597999>] __dentry_leases_walk+0x64/0x2c8
 &mdsc->dentry_list_lock           3878          [<00000000c0022f62>] __ceph_dentry_lease_touch+0x5c/0xa8
 &mdsc->dentry_list_lock           9973          [<000000002f27cb6f>] __dentry_lease_unlist+0x50/0xa0
 -----------------------
 &mdsc->dentry_list_lock         123621          [<0000000050597999>] __dentry_leases_walk+0x64/0x2c8
 &mdsc->dentry_list_lock           1822          [<000000007b11e319>] __ceph_dentry_dir_lease_touch+0x7c/0xa8
 &mdsc->dentry_list_lock           2720          [<000000002f27cb6f>] __dentry_lease_unlist+0x50/0xa0
 &mdsc->dentry_list_lock             55          [<00000000c0022f62>] __ceph_dentry_lease_touch+0x5c/0xa8

With this patch:

              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg

 &mdsc->dentry_list_lock:          1203           1215           0.16         408.88       33082.88          27.23        4320501        7357389           0.04         500.64     1961578.00           0.27
 -----------------------
 &mdsc->dentry_list_lock           1029          [<000000003c9aea8a>] __ceph_dentry_dir_lease_touch+0x7c/0xa8
 &mdsc->dentry_list_lock            169          [<000000002038c577>] __dentry_lease_unlist+0x50/0xa0
 &mdsc->dentry_list_lock             16          [<00000000c991106d>] __ceph_dentry_lease_touch+0x5c/0xa8
 &mdsc->dentry_list_lock              1          [<00000000612fe15f>] __dentry_leases_walk+0x64/0x2c8
 -----------------------
 &mdsc->dentry_list_lock            158          [<000000002038c577>] __dentry_lease_unlist+0x50/0xa0
 &mdsc->dentry_list_lock            858          [<000000003c9aea8a>] __ceph_dentry_dir_lease_touch+0x7c/0xa8
 &mdsc->dentry_list_lock            182          [<00000000612fe15f>] __dentry_leases_walk+0x64/0x2c8
 &mdsc->dentry_list_lock             17          [<00000000c991106d>] __ceph_dentry_lease_touch+0x5c/0xa8

__dentry_leases_walk() is almost gone.  The total wait time is reduced
by a factor of 483.  That will give some latency gains to
ceph_readdir().

Cc: stable@vger.kernel.org
Fixes: 37c4efc1ddf9 ("ceph: periodically trim stale dentries")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/dir.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 27ce9e55e947..45cdb611fe2a 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1759,11 +1759,11 @@ static int __dir_lease_check(const struct dentry *dentry,
 	if (ret > 0) {
 		if (time_before(jiffies, di->time + lwc->dir_lease_ttl))
 			return STOP;
+		if (!lwc->expire_dir_lease)
+			return KEEP;
 		/* Move dentry to tail of dir lease list if we don't want
 		 * to delete it. So dentries in the list are checked in a
 		 * round robin manner */
-		if (!lwc->expire_dir_lease)
-			return TOUCH;
 		if (dentry->d_lockref.count > 0 ||
 		    (di->flags & CEPH_DENTRY_REFERENCED))
 			return TOUCH;
@@ -1790,7 +1790,7 @@ int ceph_trim_dentries(struct ceph_mds_client *mdsc)
 	lwc.dir_lease = false;
 	lwc.nr_to_scan  = CEPH_CAPS_PER_RELEASE * 2;
 	freed = __dentry_leases_walk(mdsc, &lwc);
-	if (!lwc.nr_to_scan) /* more invalid leases */
+	if (freed > 0 && !lwc.nr_to_scan) /* more invalid leases */
 		return -EAGAIN;
 
 	if (lwc.nr_to_scan < CEPH_CAPS_PER_RELEASE)
@@ -1800,6 +1800,10 @@ int ceph_trim_dentries(struct ceph_mds_client *mdsc)
 	lwc.expire_dir_lease = freed < count;
 	lwc.dir_lease_ttl = mdsc->fsc->mount_options->caps_wanted_delay_max * HZ;
 	freed +=__dentry_leases_walk(mdsc, &lwc);
+	if (freed == 0 && count == 0)
+		/* no progress possible currently, retry futile */
+		return 0;
+
 	if (!lwc.nr_to_scan) /* more to check */
 		return -EAGAIN;
 
-- 
2.47.3

