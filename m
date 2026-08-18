Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4248424C
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076712; cv=none; b=HLxAeNzSer04A97H8fUbscH0c1QfnYf0W/S67NsHKvmzjCGJHkUt6q0nveqlKyMmmfY3js9oNP4E8OqnDygTibhY9mOq1vl/tTXAPrmnoXJW3bYaE7az8IWXaEXflgWr3MocLceEG5rdm4gFpRREB05gLDeeaInzJXFNPye4Uto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076712; c=relaxed/simple;
	bh=rECAuaCU+sisvFAxlz4wBECy3Fjxf/Y512+AyaTPnw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcN87gVVwYGgvqWQ2NzN36bijnVBJEoSR+sVIGkRc1uB/auj2yDtfwg5jofexqfWvxuiGZLqa5A1+x4YxN+4FeCDxTauLmiIVVTpOmhO5ZjRyOoF2VW9gGDVex1VAeSg2Fd7JoIA7YqLGw+Q/UPEZxBgTO7OHM8xmDDPpwW7H+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=H7mOArhN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="H7mOArhN"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4956869750eso766625e9.2
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787076709; x=1787681509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sXE4QLrQi2i/4sxK4k31CjHlNpeUbWys3Ip47/zk/0g=;
        b=H7mOArhNyfL4eJjQXrXGT6rA2G3kwM20Mwg2jE5/AEJf4EJn8ZeAPNu9hyYbWj5x17
         9r2662D1wNVeHbxDkZZFnTYBd/sK+23abniSjoViag6pE0e+pCg5Nr5zIxTtzt/N+GUN
         CCsFuxSdtHaD5QfD6nZjz+tswFctfa5SqdPnKnMHqWjaRv5tseHi32nSdOxJyoC3tUwg
         8ziYp0iJSXmvdr8M2Q8Sj7B7KzqMB8FQ/IA7f8E7UU0gdObwiXILp4o9RlrCMr0j29if
         IIKQbdeWJfKx6J1OyIvOmY96WxoIO9s0wiw1FSlXRJTdxulZqGpWsJIqAKSt5BptdVu0
         r1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076709; x=1787681509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sXE4QLrQi2i/4sxK4k31CjHlNpeUbWys3Ip47/zk/0g=;
        b=KimulQqj4JTyY5cQ+36Zsw6XcimqC7x1Wl4g7mGl79MdcSdLz9X6PhMePEuN3h7IPN
         13iDDvCi+LxhK9RaTMItxJw68GAywSRDnHzHp+M+i+sY1iTH5nxx5UEXjiOTSdY8p9kc
         HBD0ODE4uKvPSI9flG/9swlKT4i0MryngT6LshCjjjeMq3ozXkkvIRcvqtdV+iifbcf+
         mlGoxNP8j5YPt1ljrSGLJdhXcvM5fZyfUfnbqD7pA8QZFTSxDP2qS45lEYXSByA8qMBN
         XRNVMspdUezsRqboz4YKf/zFsQBlB2jTzy67xgt21RdvTtreJNohM982cZmKZ+VTfdoY
         ib/Q==
X-Forwarded-Encrypted: i=1; AHgh+RoTizjQkIe06hR6+yb+LfJtM7WwMcmVLIUUybIDsLt7Trm3RS3V6Y1r6EEYO/uzuBPdZ8YEHH5pawyI@vger.kernel.org
X-Gm-Message-State: AOJu0YznoqLJtJBmtowns8JdRwH8zc+ZUf7tz5iDQPwLenK16ND+yH7Y
	EOLPzdWn22m8nY+QWbaI80m/1uk4jJ8mHqXeWU69a+jofmhSGxUtnrSKJqCji3gkXf28+gJ7AO4
	OvA/EZCY=
X-Gm-Gg: AR+sD115HmOx3y1khHr2diAJ8FcqiFn8oWgFIqIQsO1GBUqPWAinhpJjGyZ5u6htxuL
	c31/DdsQTnJyxWeauOEfzRIqdL8Nn7Pmo/twFVhTvB5eDEkkFhgSHFeA1ZsQg/457SoLv11FAoF
	IHTwwPb5D821cfPeHkTYtwb5sNnxRbGuDw85G6jbz9s72utnhoVf7ddQsM1WBwoz9RDgl4QexsS
	HFmKTi0cLaqJ215R54hll8FqJ+HpVf4dZNeHoLEow4fE3frBS0tY+YEVDmeZG8G5VEJDkWH5Hnh
	4rEtV/YzcRPOpaKpSnZQV/BuHLvCkRHWkaCfmtCZ9asTCtm+8oU1US0NQ2hnECeQZ5s1+PvLTpj
	OO5XMo4JQceXr7nJxAxlyIGC1sNblOGT+t1PFGZSljSEuXHL1z24D+V6xFS/7dgjQC3itH1B9T4
	8sZR4IQfFhvS/MISeLU4YSJsDX4JBf+wnEPkSZOUTmm/c1ZYLfPwLfNZn6sM19460TvAKuiJc3G
	VJTUwxKDCMPHzbvT7EGdz09Q9IvNWfq3XrsIWlkpnqXfYJmsAvxVkQmzfVDG9Xi
X-Received: by 2002:a05:600c:8209:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-4998796f497mr622649295e9.13.1787076708718;
        Tue, 18 Aug 2026 11:11:48 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14302641f8f.16.2026.08.18.11.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:11:48 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 01/12] fs/ceph/super: remove unused field `i_cap_migration_resv`
Date: Tue, 18 Aug 2026 20:11:33 +0200
Message-ID: <20260818181144.3541770-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818181144.3541770-1-max.kellermann@ionos.com>
References: <20260818181144.3541770-1-max.kellermann@ionos.com>
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
index 1d6aab060780..3cbd320b49a8 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -450,7 +450,6 @@ struct ceph_inode_info {
 	wait_queue_head_t i_cap_wq;      /* threads waiting on a capability */
 	unsigned long i_hold_caps_max; /* jiffies */
 	struct list_head i_cap_delay_list;  /* for delayed cap release to mds */
-	struct ceph_cap_reservation i_cap_migration_resv;
 	struct list_head i_cap_snaps;   /* snapped state pending flush to mds */
 	struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head > 0 or
 						    dirty|flushing caps */
-- 
2.47.3

