Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F20E403AEF
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283946; cv=none; b=t8ycpuEGCA5JK8gklUEyVMb3rcYCAVn4VI6PDSqt7sKOSsLkgnz+AewPGrGce+bKtPAgizZZcJRWa35Lno8va9cQ7Bm84Bg47dZIlqn+STm88dUBs6ntTWWvp+kEDtXIPOcXHkQkhNVTbp57WD+SwTJ7toFg7muKJFUa6tzp8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283946; c=relaxed/simple;
	bh=RSjXrwHkkddP1fCj1wS/0usfZqiCm1jPSSO2MCNNLLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GC0btW9Nh+A388vLXa9gdCg3d9PSuvSKsnOg3LoyUVtlpKTQ791LuLEKJKMlPjFeJuNxO4nZDwLhtf6r3qMwWxNHVPwdrI9P0G6zu9lNMcWhHHRqdjPB2q8W93rZzjX6JkfdO3IWkL7WjDc2pa7l55pmYpl9SVglwlfPo06sZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=OslkJQtB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="OslkJQtB"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45eecb8bf67so937195f8f.2
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283942; x=1781888742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yub7XSzjDB1jxci1f7s3cBnkY99ODuxhkCNRd+nmsY4=;
        b=OslkJQtBIPKZPKeErmt6v3gY12aH8Z+IRz7gzzwC+xX75/2p/dCj+Lt3I0ewnpKdEG
         Tix1u3RIWtDsrSGQ0VVs1W6lbVW8hdhQDrn6AK/50MAJKM4eNto3uJh/tGteYCVMtCWz
         SBmFwkkIPr9ONdIvEww4hEDIKKJi8i+U34VK9M8ff+3jW07NNBtUvX/IH00bMuf60weH
         GtpAC7yP6JlecnwHvOWqo/mha+iDaoRbZg3OPIK6k9LhD2mdQtQvsU+tv+uHMbJVm68H
         iTisgmaSfJI/Wk1mkEeO92dyHsshZgFtSZ1IrjL534i3JAASTfXGK2357uu0H7pqXiqg
         yAWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283942; x=1781888742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yub7XSzjDB1jxci1f7s3cBnkY99ODuxhkCNRd+nmsY4=;
        b=YN0zT4kLvJiJW0EmJgOPcQpRjp5F6YfOrFobgYom2JQVH5As3yrArgkp+8BlMvMKPY
         mRwBEkoDE2uGjsZ4O+lbKxYsz0J3/UJDIdSo0rSEv7NoBvjF4WKCvRdX5rslWqCoOu1J
         DJy9+I4Rq8LkC4vJl+2LxfALTGfD+1h5N8ROWtWxMuW0ZQd3aEpcWkW4n/rixUcRxDp7
         gNRZZfEtiG5I+6ewaDG66H12CLX8x137BPKmpYGHJSJUl+KSAEiVryROOXPAAIfFSJeQ
         SffRMBlu7+gxhYZFpyZ33AVaagTFFHMr3oCh2E5wv8395RF1A0IED4xApmKbYadzPnp6
         KmbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+QbJ2AUgqlulSLyjkf6O79Bm5CELXeZPQeUsfTCJP3k8SFydfZzm6nWqxI9r/ATlkIS7pJtr43rtmE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+K/vvqvE6+khlCsPJbE0DeeW1niwmzr6LXL9F8Sj7kCVlBOAZ
	IdCBFdaehMo9J7h9WALhrID+ch+kG26bmlq4ggNwyfGbm/W4zh2qLbAEFkmv5cxuiec=
X-Gm-Gg: Acq92OGHC8+KWcLJbLmcVbXhSHuaZRaQ8CyAdU6Cp8HiYKss6t1m5bd2XxFZVhNdAgj
	Gt9V2SI7tw7SyN7+1OMHgZDur/rnNsJpMJGXJrMEmvOdG8jP66EQpX8OzqWq8Vzxj4UNtnfxZGv
	n3kLcmo9BnU+LAsA8lNDLkgdiz7blLBLt85bdvFIV8LmyDn27ZKv1/rqJgFZg4E/TNu1QjOU04e
	jCT09X1HbkTEK4Bvm/UUo4HBXfORf059/G7NIM4yPWM9KJ2SZQYquXubR0jj8SrhdYZn+HcSeBQ
	HNePBUJ+rhkicNBXDJ+/Oud6HEendfMlPvckwcSNj2abZVloE3m+W3y2j06Xkign53YOWUp2ypA
	Uxuq2AiVIDC8//d6g7Ki1bN8q9ye/UQSkcNj1xIqAxXpuFOfvfMyfldDsc/jCTf1uDqfimgghuq
	dZJ5ihFmIA3+7ORy9LUlgm2XpI7v9l/JwqruQ60MnsDLeRscnj/jgZc8+hxg/d8n7xYPKPB1GMd
	mRebmqhdur1Gdpj+QfDCD9ijGU=
X-Received: by 2002:a05:6000:4818:b0:446:96b1:f53 with SMTP id ffacd0b85a97d-4606dbad462mr5107122f8f.26.1781283942351;
        Fri, 12 Jun 2026 10:05:42 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0c10sm7541814f8f.21.2026.06.12.10.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:05:42 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 2/3] fs/ceph/caps: mark cap remove with RB_CLEAR_NODE() instead of ci=NULL
Date: Fri, 12 Jun 2026 19:05:36 +0200
Message-ID: <20260612170537.92970-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612170537.92970-1-max.kellermann@ionos.com>
References: <20260612170537.92970-1-max.kellermann@ionos.com>
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
 fs/ceph/caps.c       | 11 +++++------
 fs/ceph/mds_client.c |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index efa6a15c470b..9e7c76a66624 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1128,8 +1128,8 @@ static void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 	struct ceph_mds_client *mdsc;
 	int removed = 0;
 
-	/* 'ci' being NULL means the remove have already occurred */
-	if (!ci) {
+	if (RB_EMPTY_NODE(&cap->ci_node)) {
+		/* this means the remove has already occurred */
 		doutc(cl, "inode is NULL\n");
 		return;
 	}
@@ -1142,6 +1142,7 @@ static void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 
 	/* remove from inode's cap rbtree, and clear auth cap */
 	rb_erase(&cap->ci_node, &ci->i_caps);
+	RB_CLEAR_NODE(&cap->ci_node);
 	if (ci->i_auth_cap == cap)
 		ci->i_auth_cap = NULL;
 
@@ -1158,8 +1159,6 @@ static void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 		cap->session = NULL;
 		removed = 1;
 	}
-	/* protect backpointer with s_cap_lock: see iterate_session_caps */
-	cap->ci = NULL;
 
 	/*
 	 * s_cap_reconnect is protected by s_cap_lock. no one changes
@@ -1201,8 +1200,8 @@ void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 	struct ceph_inode_info *ci = cap->ci;
 	struct ceph_fs_client *fsc;
 
-	/* 'ci' being NULL means the remove have already occurred */
-	if (!ci) {
+	if (RB_EMPTY_NODE(&cap->ci_node)) {
+		/* this means the remove has already occurred */
 		doutc(mdsc->fsc->client, "inode is NULL\n");
 		return;
 	}
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index ed17e0023705..f092960953a8 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1900,7 +1900,7 @@ int ceph_iterate_session_caps(struct ceph_mds_session *session,
 
 		spin_lock(&session->s_cap_lock);
 		p = p->next;
-		if (!cap->ci) {
+		if (RB_EMPTY_NODE(&cap->ci_node)) {
 			doutc(cl, "finishing cap %p removal\n", cap);
 			BUG_ON(cap->session != session);
 			cap->session = NULL;
-- 
2.47.3

