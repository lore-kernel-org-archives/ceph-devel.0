Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924CC38887E
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596937; cv=none; b=Z9EHSTOQz9RkKUBKfzZr2a9Gs1KMqdY/ijdADdAmaGtosdFNi3oDteWzmiCbfr96hZZwZmcweXAh1dKip450wbFcUST6kaEOE3SiUJSzt5gS6RRGQynI11P8ax/FD//ID91CeD8W4+vOLhprOTG5XNCeG+D1irFfMhZMfJR6u+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596937; c=relaxed/simple;
	bh=sxxzBpRiaRyofA6uPpa5Cfs5wYLvy8Bsjn4excVGr+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LIIT88fIPdHxZkoEFW0pREW8VljCkWScL3MFODZAyuuINP13i8aaidJ65qxle6Xci3Wi5CsMitIYdr1lBiDM3X/asYfzguyTBEIjHiDp1OpH6us5hVi4bxCuq1p52gT184f3E8OhqZ7kb7g/5XpRhXdXqg2HjXeciOmBh35VeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=E7QdtdfS; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="E7QdtdfS"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c169ae1cb26so38779466b.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 11:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787596934; x=1788201734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tDTEVPij87eFXhlKecR4a0GN+N1xkI0QIa6z8RjNM10=;
        b=E7QdtdfSTcRzzzqnbyTPCzVuU3RfhIRxSMscQtlqb02WsfGxgYpIy2uBWejN9oVNIO
         UgevXlwC5RH0Y898jKDtvH1PDEb2sqgDcnjzRe+R6+6FGZCipJKQNAZi55NULtt4tt2v
         BuDQfnLcHoRm1lOxGLpBd3AEzU+Rn9KGHKIMOd4Eht+nnMnEElans4ZBWkB+tP4RaaMF
         7f0cyY025LuumRkIECTs8ZZs/NkVhCsifpAouSlFYBnPz/9dyNpA4y38zDvx3X9bSg8f
         agSX3saf5X8HJO0+YCvnKOYaU1yGvo7igPHIULDaiOF2KvFLRSz9HoFo+x2BeY9kIts/
         ZYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596934; x=1788201734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tDTEVPij87eFXhlKecR4a0GN+N1xkI0QIa6z8RjNM10=;
        b=jXb+TSMDVcDHK6w84LXqK6ePVlhE5U63ql4CEiEYMPML4ghLPD/ol8dMxfURpJKYxo
         S6HtHPmUNkhn6ZOG1MPHh6MJurRF21yiP5G6GbaxCj/qBBgYuwv8PMc0fcZc8FFPUYlr
         vF6R6GTmDTrSrT7xAJo3t/Nc10SRon+8AR55IgPIWblWQrFAjdbnOhMNiwCXXfjNVQpf
         keevu1FlpRxToUgsXaTO5XNNwR6ZN1r3arPp7o4HO3bjmIfJWXtZCQeRmPuu/Vz8utJp
         6sQZZb2vYFkdk+ECtu0kV9GqtoLSaHRpJPBC1QC3vdlQxlEKUBYmBVxXYDdth3HlEVQG
         WVFw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9kBRd1blmiQ8TP9NgRR7LHhzrzliTZ7lssZflcYEK2tcdFKlj1nB6Jb1qpBv8K7vKokI9iFLLnuAj@vger.kernel.org
X-Gm-Message-State: AFuF++nniW3UX+qYjKMY+MyCuboxgrDH1VvhOjwkgpqQIG5RXsfHFz0F
	tym8Us/q+2+Zh/ZVWb40EMObwzs7+sc3u+pwVBOAoem7aaLYEzCZsu4fVRizs547heU=
X-Gm-Gg: AR+sD13f02Tixjh9hUhmmWmsqvEM1pVnWnLodU2JCArdrLREU1x6Wr8dicYPly1eOvw
	MYRvFX8X8gog6X9xSgQesD2arU4G9aEQWuUAYDR8uvhOBAtWQRQsolBdOdiGoizZHhxeiE9dFi2
	V5ArAEB/3S1To9q5bMs2pI2CPvM9ayOOHKd75bcXEowno1XdljUxbQYUiCu+WvO8Fj8rAJHDsXx
	nJHbxy2naTXPjUH9LrNq5Z1N+Tr6U/1WRpDxbfF2Pf+LOWR3Y/s6Exvnp3bkJf48Lk3u3wtBEJb
	OpfOB4w2jeByh7lmg3LxDhzLWO036jWHzttYw3C0yOB8+8KRHQozexCw5WPAdHwThb23z4NOZ8Z
	HqegsZseFuy1H/oouXydrPH+XOnDf9xj+puwhGA2Dw1fA19idWNwbKgvOuS3+n1LUkbgjfcb8Yp
	UDy7VRGPcRaIQ5qJUwp7ZKkzpyBustEgkvQu1zmmeC/LNR1RVAotjt7zzIe1EuSxLbnKn+MOR6P
	rdQrrv3x4aCUCBY138qP1Fsw7cIjaBLuIoEQzYTS1UemJPM66O6LZYZB2lwBPej
X-Received: by 2002:a17:907:a088:b0:c21:4698:ee9e with SMTP id a640c23a62f3a-c24e2d6905bmr74078266b.7.1787596933796;
        Mon, 24 Aug 2026 11:42:13 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1533526066b.8.2026.08.24.11.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:42:13 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 07/11] fs/ceph: remove i_truncate_mutex, use i_fragtree_mutex for both
Date: Mon, 24 Aug 2026 20:41:55 +0200
Message-ID: <20260824184159.240821-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260824184159.240821-1-max.kellermann@ionos.com>
References: <20260824184159.240821-1-max.kellermann@ionos.com>
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
 fs/ceph/super.h | 7 ++++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index ce793ff934d0..a7cf9a7df756 100644
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
index 05452bc7eac1..beb7009f793c 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -466,7 +466,12 @@ struct ceph_inode_info {
 	unsigned long i_last_wr;
 	int i_nr_by_mode[CEPH_FILE_MODE_BITS];  /* open file counts */
 
-	struct mutex i_truncate_mutex;
+/* since i_fragtree_mutex is only used for directories and
+ * i_truncate_mutex is only used for regular files, we use the same
+ * field for both
+ */
+#define i_truncate_mutex i_fragtree_mutex
+
 	u64 i_truncate_size;       /*  and the size we last truncated down to */
 	u32 i_truncate_seq;        /* last truncate to smaller size */
 	int i_truncate_pending;    /*  still need to call vmtruncate */
-- 
2.47.3

