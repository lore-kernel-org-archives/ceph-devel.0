Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64564854FC
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076725; cv=none; b=HAcDJBGdvJbS1AC2WN553U8Bph32wzFlcqPAl/o1XYwkafp7f8INrsKEmoFdorv1NH/ddaYaJphOA77ihFJMDtcvGNJS8JDl0deWCmldhSMQQlnT0CD86p715bVWX81yV26/VK3hDB8wlM/yqmcq4Nd0dBLELE6qH8WJWXzVj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076725; c=relaxed/simple;
	bh=vZ7gRo95tF/kqgzTVygqtXNVLMo92lelt/8iAfWrtpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6I7vwpyaCkTTEvUQHz1VLurFKOji28mWXr+xCShcajoB1xC2EDY1kkOmz25VVHt9wXSrPve5+iB3E6UCHBZcdMjY/8zzs+IqLo6h5G3+b0XvG4BSHrsMk2VbVRIrNPLoOOuKgjk/PQ2GtVIFYN5FXrS5IoKSzDN2E+Md0g1uCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hIABmypc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hIABmypc"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f633e6058so89430f8f.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787076714; x=1787681514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/h3RiEJriMYlQ3k6GEtIrqFIdNALC21eRy/CEabRiBs=;
        b=hIABmypcrZFHZYpB5p6+mi7fJfg53bEUlGFnbSd6Mi9S7SBckXO7fLnKJnWqad5pkm
         Y+MZWIFKVThSdXT3rx7ictXaycUmtHHEM3oAIazhxaQlYM4IH1xdFkfCM+ZyKFB5an/e
         4uIxdtagR92tQdqpmGCjeUvABnFNmZVGfS8wf2sWcld1J9ERaXMJ3ItNNupqf3Ckkc0m
         MsHx4GsoieNFTcbp3/WSrQC9Cic6UyEOZHL6Rqi664QpuQhTDLYSbVgwyRfK3Znho4IL
         99WBYw45AeaeEOG7kNW2DyMelaXZ+Hm2XjSGIw+l0AJa08ddTLkLfCVOkTzqDV6TkCER
         pcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076714; x=1787681514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/h3RiEJriMYlQ3k6GEtIrqFIdNALC21eRy/CEabRiBs=;
        b=pdGCGEFXAmY6pCi5SD9MRPJvIvtrt+CPhK0TWtpuFqM3nVDdC4F51V+7NahFM7Z/6l
         Z3Y5QJfKv9muYJT76EMz2Wg/xMqk1sLgkeWFLZ4mSJs8OYzbOrWfJSjLcH+1ziynzaEv
         InDRBIRKIoCeJk8PJSdSpcVUz4NOHgG8vuZQGXC+NTGqcxIFZmi7yKnnCiNTuM97uZSB
         8Wa01O4f+B9Ur2MWf7BOOXZGwU5FFL9PTopodWuAFl9V9Tr3SNDFP1oVN67IvU0QC1OE
         TtDEKiulQvOji4MkZDEvrkf3XoFafYbTQ26DYjQlO7i3FhAcqmCL62INKzpU04RsoXxA
         UMwA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+kigjbnw/VTNXnQ8jluDH7W8lO3jG/QF18qsCS9P1r7rCYIeqdm4lY4AgT1TX48At0MeM0GxCO+H6@vger.kernel.org
X-Gm-Message-State: AOJu0YwZbCt2O7ohU/SQ58jf+y8RQlLGn/rg/+s0bi7/Yt0AN7i1D8m3
	B/rXYs+NukMFNC1XPn0n+LSrgNhTHDhc1QxGuXk4UXgVSYdIUuW7Q+IKHUT6wkuliiY=
X-Gm-Gg: AR+sD11W0sYqbYE4GFcEtOtuY95msSmuMIb0M/JD+X8F01+Jat6KjIieUZ3YuSzRY8V
	kjcTk+07cRiMsY7wUQgd8g9vpur/CblpsaTCfGJxbpAZqF+RKDVnTzvXDSq3XWbZg9cjtgpDJTb
	KeK0I+PUnAbx8rSFYAzqNyugJh7YoSbIROT+rRVabW7131Bo/ApSB+qHJ4GuemBwE6yrLwxrmMB
	lbYEbhOOHWoZlNrkzNmHtvpOJVyjO3R3Eh14ZRUZzxg8MDTm3RfyCkBMVp0j5lIcxJtA5/a81ro
	EDEteC9fBDjpfvE0pO237JVODSkXyFfBhjfrHk3E/RowZMu8dntqyw/zReuAGvESMB+FVSg//KA
	JbvIabhutK9atDUasgYm4ao8uz7TGxoxpQwaoCY8mduDngQjcXQCPbN69tSgHzUCnHjXGwS1LKU
	7lpAdZAdaGUEHfPs0FqydZ5jEL7QzBueNqpqlcUXHj2mlTFY1C+w/bPTEkIX2Glq6fyTc+Hvvjp
	oYSpGo8U7CLvfDzK59fugqN5EuJxcQu0Suj6eKbUphK03HOe9AiAxKxnXk8EQq7
X-Received: by 2002:a05:6000:601:b0:47f:e721:1f77 with SMTP id ffacd0b85a97d-4816075ebdbmr59122030f8f.13.1787076714244;
        Tue, 18 Aug 2026 11:11:54 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14302641f8f.16.2026.08.18.11.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:11:54 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 08/12] fs/ceph: remove i_truncate_mutex, use i_fragtree_mutex for both
Date: Tue, 18 Aug 2026 20:11:40 +0200
Message-ID: <20260818181144.3541770-9-max.kellermann@ionos.com>
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

`i_fragtree_mutex` is only used for directories and `i_truncate_mutex`
is only used for regular files.  Since these two fields will never be
both be used on any given object, let's merge them into one.

(This is a minimal diff that defines a preprocessor macro, to avoid
refactoring all code lines using these two mutexes.)

This reduces the size of `struct ceph_inode_info` by 8 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/inode.c | 1 -
 fs/ceph/super.h | 6 +++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index e79ba09f2cdf..1f65aa387008 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -677,7 +677,6 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	for (i = 0; i < CEPH_FILE_MODE_BITS; i++)
 		ci->i_nr_by_mode[i] = 0;
 
-	mutex_init(&ci->i_truncate_mutex);
 	ci->i_truncate_seq = 0;
 	ci->i_truncate_size = 0;
 	ci->i_truncate_pending = 0;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 05452bc7eac1..35399689f0c1 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -466,7 +466,11 @@ struct ceph_inode_info {
 	unsigned long i_last_wr;
 	int i_nr_by_mode[CEPH_FILE_MODE_BITS];  /* open file counts */
 
-	struct mutex i_truncate_mutex;
+/* since i_fragtree_mutex is only used for directories and
+   i_truncate_mutex is only used for regular files, we use the same
+   field for both */
+#define i_truncate_mutex i_fragtree_mutex
+
 	u64 i_truncate_size;       /*  and the size we last truncated down to */
 	u32 i_truncate_seq;        /* last truncate to smaller size */
 	int i_truncate_pending;    /*  still need to call vmtruncate */
-- 
2.47.3

