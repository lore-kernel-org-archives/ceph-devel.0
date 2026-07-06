Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C9E3D7A16
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323512; cv=none; b=op9X2iFgXW08OMu5wteYCdYJjjlsBM90hrFLAMlwRDEO8dR6dUcCQWcW5P32+EVAgm1Mzl1V37hFXqPMgfeMYCf+U7/awYSExQBHO8CzEr7A+Yw+9S/3WyDv9yUUMbRYem58lluq2CHDsTGpZLjX0G0lvigse7aQDhQpoVxqwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323512; c=relaxed/simple;
	bh=0q66rVPiB6wYvH6QGLn599GshpRlA1a1mXX41mVOwAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3wzDzSNs0lnI3lsVU8Lbb5vq9DwqRfoGT2W3n7E9QyZSElcGLMJYGq3D7dO92CsyqYO9JBkfHY1aLsVX3G5XfA/PCTxdI6/WFrQw4H9eLC9oel7AxZko3kSVz0ju8ggd1oGtVb3gnTWvBjdbUcRgHxstlrrysiTImWcdcpnmWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Dodfy68w; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Dodfy68w"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-475881b9a4bso2296395f8f.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783323499; x=1783928299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m5NAfX7bUPbqWXx47VHAOQDAdfI+leEUeKDSWi7QVvw=;
        b=Dodfy68ww6nEE0ffGLJPvNDN1CXfnLIlmQxrRqHd3qXpBmrh9S/St8393wYh3u6Hyc
         c2lTPcdwNAceTJlK2QBGHXaZ0ViGUffTwiqLumUq46L48Y3SFITvQI14IZes8KeUJ/v8
         91CheODdteQTngMT6TF5BY6zz56V1vl6n6mfestDXthsjxiHyu/s5apBsDJO5GRDl6M3
         IjQnECa/5tyGJVnUCMl4Fz5bnW3KjY+5/3CSqOtdchXfsmsJUFfIg2L3R89Bp3RD4wTP
         /EPAp1wb/IX3qhNUh9YacwaWEz1S/7GqFHrM2BLrzeZvontNqyoCwLrCD3RIVrgdBL1U
         KxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783323499; x=1783928299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m5NAfX7bUPbqWXx47VHAOQDAdfI+leEUeKDSWi7QVvw=;
        b=e29rUsvqJiK3b5+ip8xKBaU+UkTiE/dhEQHPVbxIZKS2jFmRgQ+97Tr0AHo72muOui
         l0rKntKdra/bc6xwHr3yCNkY28tYX8446SsMYLhipOViZq/bwNaPCuV2n8hJmAE1VVbz
         jTZVnsEqZZzM2PjTHvrMkjA18Ca6iu2x/Y2f20yrDDsqC6vJAP674OZkqT8nUGHdBpR3
         Op24qWn906idWInQUnmronxckkiL1oz+sFNKjZRAJSbmk5YgQfqTcRzNv7mlK6jThSk6
         kzoOXZzSxm7tSvsQR1oaa7yBIK3UGBKszn0cPuVf5W1R62XU8MBNI4WfgWQZQqBbYJU5
         IIpw==
X-Forwarded-Encrypted: i=1; AHgh+RpKbWMseG8fb/bTJSAq/Tq+9MIUBzR5oV4UePb6PO5EcidtMuqsovnt7VDTlGnJbCGb7InqkUJE/8+g@vger.kernel.org
X-Gm-Message-State: AOJu0YyZo/qUVR0H6+hHi5WpWvgptPojmANU0nAQcRQy4MlIqI41xs9S
	8Ky4EB8lUvqG2UfzHW6mWZYsL21tOuRvEQ04oe4+JS1i56HU0iL7POatAjtnbY/l5dpskBeOAc3
	uK1H1vK0=
X-Gm-Gg: AfdE7cmNwIvVoWft1Jv9Xv0Q1zB6MKMyoY25cq7IQA8IwHc+Ry/HkMEi6folZb5nDAN
	Iegf0ACdjk023kWDdESJirOgW5oCcyw/Nzw2+VDMFwjgvJWtmwmJtFvU6ToKcnkKKOsovExu4Q8
	mY88EOmPb1CHqU2rli/QZQ9UFGPRfywYXy0lnl9ZKnnqJsuGLjaCWk07FEvOiTwdkFO8p/ByQts
	ywRctnJiAsoi+XNBVAzgIy3DDpxeVtGd/053uf0LowtUoSRiQTpp+SG8flfshRvSJJ07WnsuXSm
	ZcInthuIqX3rOa1mbS09fhLGN9cY7D0YmDi15Wkh9wsLU8P7BP3qEDjsnJHQ9/0TJF4VlzY5ztD
	OOClZSoMKo38BI9X1i7O5OekzF/VlVgl/kMGkFZ8FwuNGbGfgFAxj/wm4eHD+Vhz66uNJX2cJAv
	a2/zRPMK3YuqrHrW3YDnRN5qrRdGcM0viZQ45gtPWEdFYQB9jH5XruIsx3iwFxkm789YrAHJOTH
	Fll7Jf7GxK49xtL
X-Received: by 2002:a05:6000:46ca:b0:475:f100:35fe with SMTP id ffacd0b85a97d-47aae69c8c6mr6580259f8f.59.1783323498778;
        Mon, 06 Jul 2026 00:38:18 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm22248585f8f.3.2026.07.06.00.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:38:18 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 3/4] fs/ceph/caps: mark cap remove with RB_CLEAR_NODE() instead of ci=NULL
Date: Mon,  6 Jul 2026 09:38:11 +0200
Message-ID: <20260706073812.3922732-3-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706073812.3922732-1-max.kellermann@ionos.com>
References: <20260706073812.3922732-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ceph_remove_cap() erases the ceph_cap object from the RB tree, thus
it seems natural to use RB_CLEAR_NODE() / RB_EMPTY_NODE() for the
removal check.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2:
- move code to new patch "add helper function ceph_cap_is_removed()"
- add locking documentation to ceph_cap.ci_node
- fix data race by calling RB_CLEAR_NODE() under s_cap_lock

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c  |  7 +++++--
 fs/ceph/super.h | 16 ++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index f6f3e817b712..a6a59bc91b79 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1157,8 +1157,11 @@ static void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 		cap->session = NULL;
 		removed = 1;
 	}
-	/* protect backpointer with s_cap_lock: see iterate_session_caps */
-	cap->ci = NULL;
+
+	/* protect removal marker with both i_ceph_lock and
+	   s_cap_lock, so either one can be used to check for
+	   removal */
+	RB_CLEAR_NODE(&cap->ci_node);
 
 	/*
 	 * s_cap_reconnect is protected by s_cap_lock. no one changes
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 628d153601a5..509839c1db0b 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -203,7 +203,19 @@ struct ceph_fs_client {
  */
 struct ceph_cap {
 	struct ceph_inode_info *ci;
-	struct rb_node ci_node;          /* per-ci cap tree */
+
+	/**
+	 * Per-ci cap tree.  Protected with
+	 * `ceph_inode_info.i_ceph_lock`.
+	 *
+	 * Clearing this field with RB_CLEAR_NODE() requires holding
+	 * both `ceph_inode_info.i_ceph_lock` and
+	 * `ceph_mds_session->s_cap_lock`.  Calling RB_EMPTY_NODE()
+	 * (via ceph_cap_is_removed()) requires holding at least one
+	 * of these.
+	 */
+	struct rb_node ci_node;
+
 	struct ceph_mds_session *session;
 	struct list_head session_caps;   /* per-session caplist */
 	u64 cap_id;       /* unique cap id (mds provided) */
@@ -1280,7 +1292,7 @@ extern void ceph_add_cap(struct inode *inode,
  */
 static inline bool ceph_cap_is_removed(const struct ceph_cap *cap)
 {
-	return !cap->ci;
+	return RB_EMPTY_NODE(&cap->ci_node);
 }
 
 extern void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
-- 
2.47.3

