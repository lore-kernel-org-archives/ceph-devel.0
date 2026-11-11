Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413926;
	b=0VLEtgo5OAQqOIOOpxuVP9c8BbGuDKpqOh+E/VMqulldXkOssRiJBhm9lbwWAWnSMJDE
	 qcx2Yb813ddyDuU3FllkYBM5NVYBUgLSLXJ7Wd0Go7cksviZzXdW8JiLXrWeSY/23DUOW
	 FhFYPZVPD7wi1VvNWk4ZettoHiQvmbovgAHMzyAC0mm9Cq4OMTmYZBmxujKV8tmiIQ47Q
	 NMc2XM6ASJiJMrg8DUJgAQIeGPoBBZEu8JIYBDo5IsZiJd0FASOnWG1Ewh7ln5wZw2b2i
	 5PaL5TiHVEFojwNOdxiZ96YAWJOVx3hY3yUbcYxLgYqBpfEXmdv6n256JilRf/q5oMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zHAbfUofqZjzoaZj66J2AEb1qG75/hMFQRjc/fK5hjg=;
	b=s2wckpgmEV9oxl2xjJrnOdey5tq/zknqcJyw9LfLDbwMTfWliakEPfzBOEVUNWKd21DZ
	 LplviJ//1E4nBOKqMuNQARG73sHwRWBkbcZDG079aXhFSQ8g2nEROTt4SNTPEaVPIjKAI
	 2V086BGP//sbzhLXQPAad2Dcz76JQBNC61dZZrkuK4+DKawzttCZZZSglP3liOKr6mc9i
	 ngCLrO9xrQPEn1genHWIF0gdBuH6A5hVQjFwxEC/j38osyskBbh+LSf29XvAWTjc5TWyT
	 weuwy10XkC7DsHJjkd80d1GG+e5joIZRI2q8QVYtYsarqB0zuLQj16TOzqfcSxEEgiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=LcTx5C4X;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36BC60A5BD0
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 16:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E36BC60A5BD0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=LcTx5C4X
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-490f38e9688so2671136f8f.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 08:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413924; x=1795018724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHAbfUofqZjzoaZj66J2AEb1qG75/hMFQRjc/fK5hjg=;
        b=LcTx5C4Xz1FOa9eEWojWoGvMhDB2PhsCg6WivIIm1qYMMM8rfWlP/5meHeI35+lpZh
         UgorwTqXUHZkiDIlL7fM49fxcp5ENfI69dgARVMXoCgVEr8NC/5g4qJ3htMsWhAfyDP4
         x8m+KOzu3OPC8zo7xY3/fFfgDV95pGxjTRd8XVUZeCoz9xj1GLrzp4WoEIIXURb9CQNc
         MncoR2uje0y7Nh8z6w07tungs0ceMkn9TOCxfo2n+/W0OeDqJN0TLE7dbQ2kGcaqb+uE
         P+4W6DBBBheowZgoNWkwgPpF47xiwNALjlaQ+Ew7teA6V8ztu/nK1qXJzZz79bV+fQ7I
         gVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413924; x=1795018724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zHAbfUofqZjzoaZj66J2AEb1qG75/hMFQRjc/fK5hjg=;
        b=lvSHRu91qYjfXX+G5Y+tuPSxi7kZTmFbwsEOGfJzgSbwPiomAc8GAFVR4fpFOQ66cI
         6xkVrO/hXa4l1jgN2ZuFzOcdrzM9qTXrAkuUQDBUE9QZKiz863QhH0FSb7cIVdZUxdHh
         KBKRWclA6Suev3gym1pHaHU5J8ABlVoxZH2t4AcO8rL1gJQMx8n2velVehlBHXjg/0vK
         c//gbTV+1Jndd38ZAVgpM+FONuLEDqGu1LwEwyLsM3B5CMn/qFKomaMYWgwQMR+IPSBn
         hkzjRJDAzrAYXrWhkSGWYEMnOTmpZFhIi2KEWRUvXwFG2HeaP6e4Wjm/Q8R431TaVUMh
         /xNw==
X-Forwarded-Encrypted: i=1; AL+hErEy2/4q4a677tcisOem86AK2TWkBmParIz2yyWm5QDNdOaFrL8vjEAMgkhC9MoDnxbkMF2KJE2tyjSV@vger.kernel.org
X-Gm-Message-State: APuU4Z8LsJYpBZ9/6C9YmuBxeT8O1+/lMhhdsY1MuDGrJBIySVr5juy6
	FX1wfKoZigJeSECNpZZFk7yJo8o8H6f53JZwnQFusee7elCm4FiMQgMIIXE2TcmZlvY=
X-Gm-Gg: AYBFou1+FzPZBmXLeOGc3r9lBARL+CMMlu10EHnqhgIoX7DpPwpmcz+Tpsw/GeVpsuG
	ktfOU1UPb9Ju+l5ByrRWKYXVeJLR/zhQ3FFVLxQbXa8pzOmPcKpOf6VJk3gxhuvNk0PaGvM9Sx2
	fVlUNFPE/fE6x+IZZGGfJh0Aw2Ic3+Ry5To/pCwRjie0zhNE4C3tA+1R7HZwtX/W8ynEb4okGUK
	5Xr+4yPcvIpE0X+JJWJPAfVBoMLVOmghtTcaY29dFmCJDMBpvTg8icYoWcRLAlyeAHECaEi2cey
	qOcXCP/nGsxRiKcgnXEmofeUXBUVN+72vWgD1glBlgEOyHnLx61Bu6blyrsHoTdaN/tMqKlghhE
	km6PtoHmzH7OYfYgfic3AQijZofQMZyPIgSNAbldxE6WWV+oW9Dq63vw3hzJj6AsZakfvXnY/5p
	r8LJVZVXayqebOK8cHxX+Qa8YeRrUBGoB+pacZ1KTPYiaXMkCFgllWaXOzAXUwBS5z1vBjwmRRL
	DUyrBK5nZ+PFb6rDUPLU/4RXEn+FymcLxVtQ62eFCTgQvkRlsR91cJzOuAiU8oiz1R81Jis1g4c
	vs//13lLByw39hOCs5gahH3FR7O0pcP8G7zCYP6atyhCM8oW7ad9u7MNw7mRzJjv0Qjx06MIjez
	e51KTRJF2Md9cCmqtxpXBankYtSXDXA==
X-Received: by 2002:a05:6000:603:b0:48a:f4d4:e1f3 with SMTP id ffacd0b85a97d-499c7648566mr5495254f8f.13.1794413924411;
        Wed, 11 Nov 2026 08:18:44 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:43 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 9/9] rbd: fix osdmap use-after-free in pool lookups
Date: Wed, 11 Nov 2026 17:18:30 +0100
Message-ID: <20261111161830.1336485-10-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rbd_spec_fill_names() and do_rbd_add() look up pools in osdc->osdmap
without holding osdc->lock, but ceph_osdc_handle_map() replaces the
osdmap and frees the old one under that lock (held for writing).  An
"rbd map" racing with an osdmap update can therefore walk the freed
pool tree, and rbd_spec_fill_names() can kstrdup() a pool name that
has been freed already.

Do the lookups while holding osdc->lock for reading, and copy the pool
name before releasing it.  Use GFP_NOIO for the copy, because reclaim
could issue I/O to an rbd device, which needs osdc->lock while a writer
may be waiting for it.

Fixes: 9e15b77d9af3 ("rbd: get additional info in parent spec")
Fixes: 30ba1f020221 ("rbd: make sure we have latest osdmap on 'rbd map'")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/block/rbd.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 96743c059d98..d287c4882ca0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6001,14 +6001,21 @@ static int rbd_spec_fill_names(struct rbd_device *rbd_dev)
 	rbd_assert(spec->image_id);
 	rbd_assert(spec->snap_id != CEPH_NOSNAP);
 
-	/* Get the pool name; we have to make our own copy of this */
+	/*
+	 * Get the pool name; we have to make our own copy of this
+	 * because ceph_osdc_handle_map() replaces and frees the
+	 * osdmap
+	 */
 
+	down_read(&osdc->lock);
 	pool_name = ceph_pg_pool_name_by_id(osdc->osdmap, spec->pool_id);
 	if (!pool_name) {
+		up_read(&osdc->lock);
 		rbd_warn(rbd_dev, "no pool with id %llu", spec->pool_id);
 		return -EIO;
 	}
-	pool_name = kstrdup(pool_name, GFP_KERNEL);
+	pool_name = kstrdup(pool_name, GFP_NOIO);
+	up_read(&osdc->lock);
 	if (!pool_name)
 		return -ENOMEM;
 
@@ -7100,7 +7107,9 @@ static ssize_t do_rbd_add(const char *buf, size_t count)
 	}
 
 	/* pick the pool */
+	down_read(&rbdc->client->osdc.lock);
 	rc = ceph_pg_poolid_by_name(rbdc->client->osdc.osdmap, spec->pool_name);
+	up_read(&rbdc->client->osdc.lock);
 	if (rc < 0) {
 		if (rc == -ENOENT)
 			pr_info("pool %s does not exist\n", spec->pool_name);
-- 
2.53.0

