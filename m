Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AAE4E56C8
	for <ceph-devel@vger.kernel.org>; Fri,  4 Sep 2026 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534196; cv=none; b=YfJs9xZd3NITOwIznkIk4INVrIijnbligV+ZThcXCcxeyElCk3frGP6XQJgjiGBWyU/LlN5ToCHBKbz0HnPI4hgy0QWxcYe9gcKYKouYDr+cB7wpc0Jzp2olsoAyPJIfYefEQr6jDOKsqZ/8h3dpfr19158M+iEBvXh01h5RXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534196; c=relaxed/simple;
	bh=RaXX8VJyPOJNRhZBa3bCoTSLDAkhaKdHEayJvkI1wiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVyINbdafTUxB22c1us/66GHQCtFWt3RiW4veLRMCmzJE71sKmrnPwPoLbzWJEY8cVcUxwEZo5TLBFkXG42xwNCKn6bSCxEdgC0HOG0JwmC8yxKU7IfzGlvGKvAcBbK7JfkR07Z5lgb8qwmyTjA/oMtj1mBOe7aKSGPgpKGHYEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=bU+1iRh3; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="bU+1iRh3"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a5ded53570so1489603a12.3
        for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788534192; x=1789138992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wHU7q3pRFtkKql8fEyqkLOSTSzzZohiVwSCb3KFef/E=;
        b=bU+1iRh3L54e2zbgbo5LDZ6pzXO4k+4SdX7gTmzc26AWX/bocayi+xvPpIf+lKNuke
         IpJbRYD8Tsp6GvIVtmnksDXgxyHQJEU7GgzE4uTyAcrDNSzXPhZe0egZ2TJ6PB9a0FHl
         iL+EqkLDRvOxhGzD3XtxFl20kCAKkG6TTGYT0DaQYFs6hDf6m6usnWsmz6q5+fUb0mpX
         weY1GAvwhNl023jzuaN+gs7E+RE55b/HQGX8QPP4DF5R2S+PpTHHhMfFZLU66GobfU4o
         00mdiTSJVqm/c2suXs6T2UQq5svuwFkE/GOPKBe0MEIDiwwqqfkRwaJSs4NWnbsrW1S5
         hj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534192; x=1789138992;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wHU7q3pRFtkKql8fEyqkLOSTSzzZohiVwSCb3KFef/E=;
        b=egZfZ2j0lrSuH0AHU6jwy+aZtF1zxC7I1zghMVrT/etJKO8iHqtR+Edr5aDHEGKHaz
         NQF0wQeyZlSfBD2LEVwjoBvRMcyq98PqjVXKXSQ1fThlSbURVv8LKl1WAZOP64dlWZ65
         GC6NCwuUYzzrE4BWhlLPfZnsXLWHqlS8IhX1jHlSn3stm3NR08X6A2j8eaJlcWp7LDxw
         7knrNxBR8W102KT5k5V6yDdu5DL4OKUUj5hJ71d94NvwtEw6Uku7/mQeHhdC+AthF+VG
         D9mdzP0jYill5GrmGjGtbyvLzjyJLpCoFTXSeMrCc5E4zEYChsmL+LXcifMMFk7j4t4p
         SrzA==
X-Forwarded-Encrypted: i=1; AKwUvBzINgPwiCPxePgH/mBPIxDQ61Zi63C+VvcmxSrDv2JG0BuRxan83DTfuvoOuX5OCGKpAF0QFgJwfKV3@vger.kernel.org
X-Gm-Message-State: AFuF++mQaqeaOIK1uGxG/KUoaYjpIR4pApkR9rUaKXsoZ9h+OnHAoq4j
	VUNL3cVJ5tbJYJYtqyV6/F91NnJ6KJv1014OhN6bs6MMh+eZ8q7yOtfwAJopz5qSqU0=
X-Gm-Gg: AYBFou13l7Cx3QduRYgZS6v008+XubQ7AJKsQrdP4Hoc0+td7sKs51wmCCmDg1k8OfL
	hBoSfP/pv/AvjYJJYpqs4G1NnY9x11RKUw4FpR5NvCbIA09+N/dLmzCitz0WyrCEJSQp37z4cKH
	c3Ip4qdhdmwOJyNdTHzS5b8xxFvwzU5HIXAttIBjxMOOsyZRBwjfOjxn4BUbSMosIQgOwKkaaDn
	8Qx074Q0CsZJVFZbj2dbpAr4O8ZfqTTNV9sPlr1nOcKNfaCmtRy1Uu/csgALnKFJKTDlT6JQjHf
	rzmhnlv1xZGERUCr/n9gJHbhQMwR+S30dAsZS+bzqg0bNM5vtBZM+koqoXwJURuTOLkXWQ9ui5q
	QZzCrAo5xfnwoimljsM1bbYgZxhJVJng9b4rFwUCxH7qqCvFYs2/okPrBEBGbVipPQgsRuNWQHv
	nklFNG+NTsNqBYiy+BjaKNZor1QjcF1FTL+3w1N2YvhW+G044hxMjlMt1lzzTsZNWNV3z3V5L57
	geCkoOfp4MIB8hwOqY0CVjwxa/1zvqoH+kSrZ5WpFN0EeKzYFm4ZKufV/VZEjjg
X-Received: by 2002:a17:907:3f95:b0:c25:ee8d:99ff with SMTP id a640c23a62f3a-c260cb45800mr321415566b.21.1788534191627;
        Fri, 04 Sep 2026 08:03:11 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d6e1c93sm122438866b.63.2026.09.04.08.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:03:11 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/3] ceph: stop checking a stale MDS map after dropping mutex
Date: Fri,  4 Sep 2026 17:03:03 +0200
Message-ID: <20260904150304.49104-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904150304.49104-1-max.kellermann@ionos.com>
References: <20260904150304.49104-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_new_map() drops `mdsc->mutex` in several slow paths.  Another
map handler can install a newer map and destroy the map being checked
before the original invocation re-locks the mutex.  Continuing to
dereference newmap after that results in a use-after-free.

Use the `mdsmap->m_epoch` field to identify stale maps.

Fixes: 2f2dc053404f ("ceph: MDS client")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d36a114747ae..86d592f06196 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5844,6 +5844,7 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 			  struct ceph_mdsmap *newmap,
 			  struct ceph_mdsmap *oldmap)
 {
+	u32 map_epoch = newmap->m_epoch;
 	int i, j, err;
 	int oldstate, newstate;
 	struct ceph_mds_session *s;
@@ -5887,6 +5888,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 			ceph_put_mds_session(s);
 
 			mutex_lock(&mdsc->mutex);
+			if (mdsc->mdsmap->m_epoch != map_epoch)
+				return;
 			kick_requests(mdsc, i);
 			continue;
 		}
@@ -5898,6 +5901,11 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 			mutex_unlock(&mdsc->mutex);
 			mutex_lock(&s->s_mutex);
 			mutex_lock(&mdsc->mutex);
+			if (mdsc->mdsmap->m_epoch != map_epoch) {
+				mutex_unlock(&s->s_mutex);
+				ceph_put_mds_session(s);
+				return;
+			}
 			ceph_con_close(&s->s_con);
 			mutex_unlock(&s->s_mutex);
 			s->s_state = CEPH_MDS_SESSION_RESTARTING;
@@ -5921,6 +5929,10 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 					       "mds%d reconnect failed: %d\n",
 					       i, rc);
 			mutex_lock(&mdsc->mutex);
+			if (mdsc->mdsmap->m_epoch != map_epoch) {
+				ceph_put_mds_session(s);
+				return;
+			}
 		}
 
 		/*
@@ -5936,6 +5948,11 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 			mutex_unlock(&mdsc->mutex);
 			mutex_lock(&s->s_mutex);
 			mutex_lock(&mdsc->mutex);
+			if (mdsc->mdsmap->m_epoch != map_epoch) {
+				mutex_unlock(&s->s_mutex);
+				ceph_put_mds_session(s);
+				return;
+			}
 			ceph_kick_flushing_caps(mdsc, s);
 			mutex_unlock(&s->s_mutex);
 			wake_up_session_caps(s, RECONNECT);
@@ -5991,6 +6008,8 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 				       i, err);
 		ceph_put_mds_session(s);
 		mutex_lock(&mdsc->mutex);
+		if (mdsc->mdsmap->m_epoch != map_epoch)
+			return;
 	}
 
 	for (i = 0; i < newmap->possible_max_rank && i < mdsc->max_sessions; i++) {
-- 
2.47.3

