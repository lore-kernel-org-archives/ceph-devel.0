Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547533FF8A5
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283140; cv=none; b=GIde8vJ2Z9s3GiKiztl/dsHkEmt9iKhNtn/PSH9MxLNHGP8PBwq7pAymyIMYi+M1ovJUXSyvhFVHjmMPoddfTBtIfYzRyyCakk1FrWDJmal/crjfK809S5cOVNCdULaiP3Xl4TrJbkOTzMj+yXTAf46uZSU+UyYGn5M1owwmabc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283140; c=relaxed/simple;
	bh=BMIDiV/lISIhJB2/es3asMzV3PjLqes7F5EcL8F/7D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z37w1ZhUGMmQkO+Bf98UaWwtSIPfZnb3dbNIS+cEcCZ6ICOV58wmI6XKkLdFXnVabDNbJk3DdrSX3dvu9j9zxKIDB50FH++PFe0F7wHOGB/nNQ/c7l4uW7IOtOiyf0O90QU41yuDv0le8Na5o8/vHbVN7wnqLf63eT4in4rJH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Vgz3tgns; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Vgz3tgns"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490aebf33e9so5831355e9.3
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283138; x=1781887938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HAMyO2cdrDj08BVchpBNTjwq/NOaewQmzgGnxSSzjM=;
        b=Vgz3tgns/PfmVU4/4WuouJa/HvsJ/a3iug+mnuHizG5rPWCTtDNucu1OZyh6Bq3iqH
         audJ5fK0XDy+59YNztg5xAQUEIyNh6Evxu6OozqPqba90aZAU91py7q01l94vSrp5+OY
         jEiVgLGw/PZQl6tGzhenY4YrlXd2LhRt9jXK3/TDteR51bihWSjt2AVhFc5+ZmALE+OO
         Lld7d6+U2bvWoTPh62HtZBF/7o6PoEUdN5X3m3XI0sCphpb9kcIDQGhUvheAoJOYQ6d3
         wLVkR36FUDi0vIAmnc5aLQBj4Fd/4y0u7roJYDwHfm17KE4ofkWGHRkeQSlYALh5WttT
         H+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283138; x=1781887938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0HAMyO2cdrDj08BVchpBNTjwq/NOaewQmzgGnxSSzjM=;
        b=mdFE3On+P8lln0NPbRZzS3vRmC9Mj2lmpB4BvmFR1wzMNC/h0TXI+NZhFXEEZNzM81
         BwWxNb5SIZekh0uvoUjQmI+SLl2yD8Oxhce/FRqKFAfujxVFlcPSbRCdG0OkwzyAqQtM
         mta31rrAUDzV4+M+cCq+tUmonZ1C5FYmWmSRuV/JslpD7chy6rY/A3rIv67hhU9qkdnn
         XuBaSGy98J+SAJJ2k1K+QjEWAWjT90nggorcIyF+SsUh6Z4W0KhX1h91HMi7iX+qbC21
         6uYx0rgDa9jtA16dw2II4ZUxDOhWUbZ8x6s4a8PdPXjPOR6CIGEmHrOZxhjoAQyGWhs3
         p8hw==
X-Forwarded-Encrypted: i=1; AFNElJ9Ti5yq7E2fis1SUTdi1Lj3SPkJuHpBy5N8a267+7OqhmiiI/hpG+GrmRI2gNyNCLNaRul+X+hGkadz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2jayczj/Zy479LiTR1v6BUvz+hVc9F3ky7k0qWfULv2pTS4YO
	3x3bHTIjZeLYICpQi0zBhyRtx3LeGRSHx+c44WA9nxCHKOQShkTZuvGCtjO6ojYjEgc=
X-Gm-Gg: Acq92OEAoJThLTQvDuPRLzj7biVKw0iF9BgBQIScrjToKj/14lu7ykpHMvaRPGXWBA6
	wDdu3BxFB3+rs1YLlJvnkOkOlfO4wqPalbfuMSaIMezWmL6PwYQbX7iGiKfbflTpzFnRG5lus6W
	buexqthwfp9mdrfY0nG2lu7d8q4qVwX9KV753XGhMLLHMyhJVB9lQLn8vNXSLjErvngdaKYQHUL
	0SFTWIMn1yGYrLayXerkAFxz5F/YQfqVSnCYJ+TlN5ju8M7PNAXBOILEfxw3MxJR4QN0zSKIhRt
	f8s6RcQG0ikA8FHW0Q4VPUVSPt8N4utOEaSPakbrY01mjoi7e7A0SCsxSn9ugNrLOtBls0gKvga
	UKotx+RWEGpGbBQKUek6TXQ3r36MpJoXjX4VyM/HpJhP3XuJvjjvQgV1mIXte1oeLzYaK/eBY8R
	VWShCMXIcgiQWw8zqnKUr8ExUJlHjpM1+BqOTl2iMRR9wErlCZjJMikwBvXsCbM9xo1sgXEVrjy
	36yTk95d8X+ddt4De5Z7+fSJqc=
X-Received: by 2002:a05:600c:c059:10b0:490:cf76:dea4 with SMTP id 5b1f17b1804b1-490ec4bfa54mr37347455e9.2.1781283137728;
        Fri, 12 Jun 2026 09:52:17 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7807377f8f.11.2026.06.12.09.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:52:17 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 01/12] fs/ceph/super: remove unused field `i_cap_migration_resv`
Date: Fri, 12 Jun 2026 18:51:53 +0200
Message-ID: <20260612165204.86137-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612165204.86137-1-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This field was added 17 years ago by commit de57606c23afd ("ceph:
client types") but it was never used.

This reduces the size of `struct ceph_inode_info` by 8 bytes.

Fixes: de57606c23afd ("ceph: client types")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index afc89ce91804..6aec40955387 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -448,7 +448,6 @@ struct ceph_inode_info {
 	wait_queue_head_t i_cap_wq;      /* threads waiting on a capability */
 	unsigned long i_hold_caps_max; /* jiffies */
 	struct list_head i_cap_delay_list;  /* for delayed cap release to mds */
-	struct ceph_cap_reservation i_cap_migration_resv;
 	struct list_head i_cap_snaps;   /* snapped state pending flush to mds */
 	struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head > 0 or
 						    dirty|flushing caps */
-- 
2.47.3

