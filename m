Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890CC342151
	for <ceph-devel@vger.kernel.org>; Sat, 17 Oct 2026 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792244428; cv=none; b=V2QpVFdDNFMBVLG9SIB0tUd14YosMh2+w22n49DDgs1yG4Npx5BGm2r9blkb+d38bE1pVXeCsrWo3XgvmaaXi4SpJDpgRJ6FbC7rN6vExrFEKdJvPefFsQrmB2uzyOIQ/HJ9tVOGyRo6/gbTfh475TgMKuo92IIRQz3ArdEZn18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792244428; c=relaxed/simple;
	bh=L0SvlG0HgqpzEKFEwHq7wDfZkYZ0WTBPvieUdovJWzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KbiH97oLelriO9GqZGJZNIK247EzLJrgJMqzO88Hnsiqe1EmGQIzJAJDjLMoUKczIQb+NId5bzzDyMItJTYLWcfOHCi6w6e9NUpumjext2HbbQVf4y5uniThzoXPXcLB64KLKdCV+siYLMo39MyEHbhAhKZ4XzY2728biSlSbX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVWi+qVi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyUnlntv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVWi+qVi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyUnlntv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792244425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ycK1hfInrWAuob/OJzi5liuKRYAR110GQUd0Dl9JT4=;
	b=NVWi+qVi2G4ksjPapzfnA0sBP7SZDLW/Ovw4HYzxC7y+b6pLtmJ6Xz51Wokfk/UepZ283w
	FySd6rNa5ywsTzMmneXolEOkuUyx+FGSdyUBfYJNcEr+a42nW2e3XTYVjOmeTl0wTqf+Sq
	kPWN5NnrTESOa/V3ADVEfpU7LZSngkw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-ndyjHAADOkG0KzBqYNLoZA-1; Sat, 17 Oct 2026 13:40:24 +0000
X-MC-Unique: ndyjHAADOkG0KzBqYNLoZA-1
X-Mimecast-MFC-AGG-ID: ndyjHAADOkG0KzBqYNLoZA_1792244423
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6b1bc2e62d5so804132a12.2
        for <ceph-devel@vger.kernel.org>; Sat, 17 Oct 2026 06:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792244423; x=1792849223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ycK1hfInrWAuob/OJzi5liuKRYAR110GQUd0Dl9JT4=;
        b=XyUnlntvGLhTtVa4SSV6jfIrrEH2T1kOCiZ3wT3IlETiOOhk3wMCf6pndZWwVcXrJd
         cv5/9zwXe9pTYBBtOQYgVlGbbXcAb23Ihi3wkl9qfNttUZTcBqXjiepBFH5gELPHf63H
         WNxBHxGHRg6RgZAyxtFS/bSD96wOr4NcZlowC/R2RSKAHSAqtiICq01pJKHdSB9VN/EW
         S8h77T/bECy+zN35uDrVPW/ADn9y10FsPXYbMu+EQ8jESJ6TX3ZIJFt8DfsgJkx3JAuX
         YpRlu/DOCgjAWqF8q4cQmrhdUZKpZAPHRD0OrGg9WbkIhbAZFzZL7fTINM782+U0BLGm
         ZpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792244423; x=1792849223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ycK1hfInrWAuob/OJzi5liuKRYAR110GQUd0Dl9JT4=;
        b=EYFAPwMtys3tnq2NyW9CUeubLGVTfNd3T4YwtSgOCEjtTCHhOY97wjbyn8OESqYDLo
         oLyvpGsaiCHMdNdOu6sUAxWQS4UTlwCt3NM5ucqWQ0f/vR0Uo07ta0udKL/vz2ArQMtW
         GE1pBfSx77jQiJ2GP10g1vDJWqjPeOWw4D4/qpI4rPSym/Uxxp5CxRd418VeEH8F6N/Y
         8UA5aLEouZjq0BcSCtJM/5BCGipNtNFmk/j7AwWEHlPRQ3ngMEEM/sxSS/Pg9KDv4a10
         YnTLPFxohnCXj5gtCbBd9je5Qiw1ygJ90dL85PWDUSuAHN4aFUJq0HG0krEc7CxpPvuS
         hllQ==
X-Gm-Message-State: AFq9FYKwyOuEHoSDhxz6knDwi7kpAzaZmo7+pXnBrOKdbkUX5ZjxJeLH
	0dAJW4COzBrhL3zsE9+G9hXAECV6A02vtLQ3rv4ZjQ746eoQhISbE8sy6/D9rmmu9QINvEpEgim
	pgHRFOj4zMxJ5A+MLuG5882cUm134+Y1YlMeO6dLa3P+/u1ilBOx7vtmOJzfQZWVsD0mDA7jZUy
	xT1kMfg5Vf7LFYq0JnqyPrjQkSojkK2+ZiEF1mH4LinU4bynFW/A==
X-Gm-Gg: AYBFou0Zusoe+muV7otzGJJjJzWaxZtuv6e/OFqIxyFVZ/uQnh+4t0n1o7DIBfmHuNZ
	ABZnqUYf+H3y1luelCausRaBWd1jdVp2qHtzBWe+rGFUNvGiDhwGdNGB2rCb4DWe55wOzj1eKLU
	wuDGsFPoXqIE6pOsru1HFzsQHVuiKegx+vwWgSfEv3RgBRSe45xAWbLyrFnxZ6xIfLFjeuqdeBn
	4N0tVKkPPdfw2vnXYvesHBijaTocWNl+TIafjK997ufEm+Xgduz2NAMjLPrSyspgKtlwAhlwtmn
	DxECrIXWvaLHtewpX/3c5CcfgGTOBaqpDPWHJth6e48aGQCd4Uo4hY0GaUzT3OZChezhv0NK9Xj
	tTfHYX3gMD1G9bnBzewxiDkWooGXcrvfrE1HkMzEkfkHdYE2vIWrkZ4eal6F1v2EfuKtRvxbtqL
	9EFQV7kv4CE9edTz/ldSCRgC31r5bg9HPGibLp2yifJvB8EH1EQklYG7iJLMEKzdmIpkte4BPyL
	jQ=
X-Received: by 2002:a05:6402:4510:b0:6b1:ac0d:6f77 with SMTP id 4fb4d7f45d1cf-6b3a80cea6fmr1729593a12.5.1792244422994;
        Sat, 17 Oct 2026 06:40:22 -0700 (PDT)
X-Received: by 2002:a05:6402:4510:b0:6b1:ac0d:6f77 with SMTP id 4fb4d7f45d1cf-6b3a80cea6fmr1729571a12.5.1792244422538;
        Sat, 17 Oct 2026 06:40:22 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b113dsm1913032a12.10.2026.10.17.06.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 06:40:22 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	idryomov@gmail.com,
	xiubo.li@clyso.com,
	slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/4] dcache: export d_find_alias_rcu() for modular filesystems
Date: Sat, 17 Oct 2026 13:40:13 +0000
Message-Id: <f93b4a902ed00af44019ca88eeffbf686d920e2c.1792241577.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792241577.git.amarkuze@redhat.com>
References: <cover.1792074165.git.amarkuze@redhat.com> <cover.1792241577.git.amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Ceph subvolume quarantine ancestry walk needs to find a dentry
alias under RCU without taking a reference. d_find_alias_rcu() provides
these semantics, but it is not exported, so a modular Ceph client fails
at modpost with an undefined reference to the helper.

Export d_find_alias_rcu() to GPL modules so filesystem modules can use
the existing RCU lookup without changing its lifetime rules.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610171220.i77KPiw5-lkp@intel.com/
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/dcache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b1a81f10da6..13ba553081b3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1248,6 +1248,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 	return de;
 }
+EXPORT_SYMBOL_GPL(d_find_alias_rcu);
 
 /*
  *	Try to kill dentries associated with this inode.
-- 
2.34.1

