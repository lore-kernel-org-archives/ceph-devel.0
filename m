Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E574239D3DA
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322712; cv=none; b=kIwyDRDg8dZNmH33q2gPJZ3DjGjHiYNMVFw+hYIV2YD2Zqj6+LI/P9OaX+wecv0khQD8jAYIxme9DacageqYtgj7tHw00TcaDht1IuHSZHGSv1UtIijPe64FpjXnets3rsk1KLcEmW63aRtpxKaS4w9d3i0+PISY4XVZfFOldtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322712; c=relaxed/simple;
	bh=mh3Wvp3erJw6hgEc0BaFtMvIaRlm0xL2iUvFtRAjH5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTHM4e9RDbSoWTnPp3zinGxOQaQYMRWg8J3yosPEtzatBRDK+X4NzZwsCqZv/g8dGgZa+5a19tPPJKUn1e1T1uHj6OB5LSZRd0/a9evg9O6H0pQXtaKkX5i7ZmlpwLbV9pq8ozhRfBbOBQ9ScbT6pE9AmnnQCOOjkDnZDDxCPfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WpadWh9y; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WpadWh9y"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4758bd3731bso1804987f8f.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322699; x=1783927499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYD6EXdc3EA1wjI8XloWJSr9upDOkRMjp4PLGykUXfY=;
        b=WpadWh9yvMFmgqxKpvg+PVjJzy7tO5ksg5l+gWqlxi+XZtWgdho3ssLaIDlNUKNxXX
         GyiHLBrmMlznOTlvGo73POAqFl6HTsnQWM5P1RxNIMtfwZi9knwWrFFJ5nk7dRq1g0pt
         eEejZ/V8Sb41aEpC4ESspym1gdymEIt6ROx0uOx1W3NPySj4dqTPgKL98L57/nomy5rB
         8fsNaHzDQK7wlgIAepzXKnqtnyjHkrOYHi/mBNd4CtGBVT1IicsMWuXdWNrDQyLWq//J
         6x4tB3J3CIeys5tZPv4XSg5TmHivlWaLnm/jui+BTvLIvumvW50UEGYEHBWsH2cw/p80
         5Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322699; x=1783927499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DYD6EXdc3EA1wjI8XloWJSr9upDOkRMjp4PLGykUXfY=;
        b=J+HQq7P6QqS/eLP8v7o+M3uC9kAjmdsNdGgHRQkweRrJ+tjTe7neibckAC71yOA+kz
         LTyeVzpuUD3rk3jsnDFKRPgrANUHGriFX6ahA8ALJ/pICvG8Jyb6VaKusRQzElPE8A7f
         4h9OGSPu9nOWr8st+ZKSiYdiD43O0860ysNf9ey7Rr5bHwv79vu9HpThWt7vmSQRGFP1
         XPSTABWS3ZphUhPjV0lwbSPE1292sc6pJMxOiWmBZbPDyFAvD0YkYtbgyDwnR/aKkYWQ
         B/xJM/mhjn2C5ursI2V6QxcDaaxM0ncu9yj2lLaeSvOsDBSdcdSCEfOVcfq5wZ8G8K/R
         mYgA==
X-Forwarded-Encrypted: i=1; AHgh+Rpv4l75qSgbDnsiuOoMJPGwy0SMVryFY//7WhrZgsmsZKQfLJzuqzzRnv4Hwi37nnHCNLkwq+boB2Dn@vger.kernel.org
X-Gm-Message-State: AOJu0YxqMK1EbsK5sMN+xFsX2gE8NSdLw1Rc5dyJ4oOIrFqfQ6lnkXoy
	pHK8PEupFNcXXYCZIFlUnTWV3tDcL/omETU679VWM5BFy4I8O2DVBtYZhhJb4SdilfY=
X-Gm-Gg: AfdE7ckfN8qchgUIOhiKQyfQ0CfLB9THtYSrD8JFok4ABz3cHRWYUiNMlUa4hYZKjK1
	vxO3b2uAic7Tv7zotp6qyUY4jZ5XiCBg1z18MBCB+zvj7UcxjdaM3wwJQQSD0XDQDuD8QbS6v+F
	rgtq3Cvvy1wjVPCmYucpSbttsuWJcpcmGDPBdZHPQFbY4Wiy4bGWVQ0Z0YDy4NXtFnY/cgvQiPC
	I3gWEBWRqDm4j7MVFnvUX3yOENlWSOt6u5QLhH7o11S/KZM0Yn+yTwnnN4/fbWWoxtYsZL96ReH
	XDC3LTCmJIxpw3IPTLEtJqVK0HGf02eJ1hCZsF8wuTcWrZigpH9Q+6JTyt0WyUfXIYXz94ORQO9
	nDI1mKpEFJR/MKCy6JddJgHl6Lssby5Nwa+zcpUA5Aw7lIsWhoJnSchY0yL6QgBnmxXBnRvNKU8
	usPCSSHh/+2QvUdlHBh7abAUyti48fJld9EoOZWr9feb48Dv7gOpHeSYSoL19+jrC88G3q6TDfu
	R6d7Rltts3u0B8/+tnI0rP54MQ=
X-Received: by 2002:a05:6000:2404:b0:470:b344:22e3 with SMTP id ffacd0b85a97d-4793686017bmr16644716f8f.18.1783322698925;
        Mon, 06 Jul 2026 00:24:58 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:24:58 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 04/18] fs/ceph/super.h: convert ceph_inode_xattr fields to `bool`
Date: Mon,  6 Jul 2026 09:24:35 +0200
Message-ID: <20260706072450.3920010-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706072450.3920010-1-max.kellermann@ionos.com>
References: <20260706072450.3920010-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reduces the size of `struct ceph_inode_xattr` by 8 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 7023af704e14..a3dae2c0bbee 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -320,10 +320,10 @@ struct ceph_inode_xattr {
 	int name_len;
 	const char *val;
 	int val_len;
-	int dirty;
+	bool dirty;
 
-	int should_free_name;
-	int should_free_val;
+	bool should_free_name;
+	bool should_free_val;
 };
 
 /*
-- 
2.47.3

