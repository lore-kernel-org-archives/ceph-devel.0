Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBA83BE174
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596568; cv=none; b=Q06rcLnOADOKu1u1b+NbZfBVNmqsRomKxhE4qlXZdS6woCZu6jPqbmLs82Yhk8a0vLdiUYqSaDbzO7rqMJeDr3WnMzozxx8qM4g57Jy5AyWVdcfKS86A1JJF2Tg4eSvBtl3dRSt/JqbIOQ/6WUJgZD/ODVwzzFxVEP3cs1ILXT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596568; c=relaxed/simple;
	bh=fX7fFsPfEFC3JMips9J8bHVCCgmHkm5jA9KcnfjY+8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNeYfH68t4zDczBRZwRGXMgj/a2+i5VA4jn5sAeLUsinS10061MtvUnL1dWQwAn2uD51UOsYHgGS2zmQIfAVl8A9MkWVYTcTI1QkH+aRZpsiqS4u3BlsHyLcPYxdqsiJRtJylGUItCQP1zVOm0vGsNOXGwJXCu0II7tdm8EOBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwCstpsJ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwCstpsJ"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5174a3d9598so9451791cf.3
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2026 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780596555; x=1781201355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX4HzXJ3JGZjJL5r8tJ9uzkaLb8khgmN8CTpb058st8=;
        b=jwCstpsJWJ2drukiVKXlyhm02GTMHoz/lPbmvi0p96clarOMmkDLIJE+pIgpGviwIo
         uPk0m4WHDzMa2i1nY+hQ2HSL3yvnmgiVRruhlTOxr7Fdk6IVDq8sDVOsHfKJNcEiGLcK
         KcYqc20zaGvwsJ5KiQe0iSgRYARAeDFzJreZjTmPPOpd0CDe9GpxSgqZek7E3qmoZxKs
         utKAjX86hvcSHUEIAY6mlEVm69djfFLqDPn+9jMGflvKUjr2p1yUnIjXbPH6bc/LsQQM
         TKA7hLjQmjV5o3Bu74Q2ASWIRtqh5THhNz4C/a14kQAXrH2ia7NU2nPo9G55TXWmEd2o
         +pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780596555; x=1781201355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BX4HzXJ3JGZjJL5r8tJ9uzkaLb8khgmN8CTpb058st8=;
        b=JgU6uoMGhw6wE8PYUZzsWzFmKuGM3EGktCSxlLNbK/85HMD5vs99wMt+AfVdixXcJb
         W/MaEEE9del3G+7zSoHXQ2OafCaebqVoxt3PaeKQSJRQKAwJnPUwQxoDQy7dF0YKSNAs
         kpz7QaH6kkuaQweP0ZtyMTwY/OA0lQAUzAl/kcGRj1MZQk0+tXy1MNCtYTYxUAf/PCCm
         dLciCC945bYfHwtoXgDZ/elkBa67jPRd3ie3mU53a2vz/X8BoyKxDVnmvXh0rXjILCBi
         omX0sJww7Bou6zIyQrQs7rFBw3SpacIiXKqHWIrzv7Jvo3si6rpGMhrZ782jaWKhbGbC
         41Sw==
X-Gm-Message-State: AOJu0Ywot30T9iFjsJBobQQR3mAGpTwM+wE6IjipszWwdzIl+tjL+s3W
	YZaNTa/QdsiFRY8BO8LG51qsN6HHY2eQQVSANIc8Zp5uqQuth39AVV/QckN17O7CBPs=
X-Gm-Gg: Acq92OEKy0cT2S129CWFnDrkIU79a2OBrzE37SixqDXeqqL1V3EacvenqW29kWDsDZ6
	1w9cuMQI1ApjcArUWxLA518xqVM8ZAFnRSzlqZTg5g8d3/6z8QYjMNFDE6YtTSI2h3xrU5H7Bzi
	3ECQ8m2B5+DLZvJExRXveqH8+W7claGvzSnRIPuyK786eqv+6P6x2kmRJ6izzHPIeI11GRBtEp4
	3wOau2263Zfn7YIG/k4bdH+Ccxrg5eIITioEjFbEWTytgpWKsUIpH+7nUcUSJfFOg1DWUK93oWZ
	5hFOK+oPzDeKLO612mnEqXfjUqQhHf+swK0SwsmzmSuyVpyxq7yZNahUcppjSdsjfkJ2NY4V8ZE
	kgo2t71wIxKXWvofrA5JoE0cusYg+7X1hehIO+1sWbyuPl9OH4/i8rJEs2UZRS5rZtOpuQrrPuB
	UdL3ZXEEOa/4RX+63AKWMWa6P3uxemsLdErFMGVnxUd0mnAVmVjaT1HktcQt049nUgiYT/Ko3O3
	aOkuHo/xD+OQD5w+5wKgbN1pZXaMyfYyz0cBrmBaA==
X-Received: by 2002:ac8:5881:0:b0:517:82bd:46ff with SMTP id d75a77b69052e-51782bd4a4fmr96126461cf.26.1780596555207;
        Thu, 04 Jun 2026 11:09:15 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dbd2c9sm59020961cf.23.2026.06.04.11.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:09:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ceph: cap delegated inode count in ceph_parse_deleg_inos()
Date: Thu,  4 Jun 2026 14:09:00 -0400
Message-ID: <8f25e9ac54cb3c408d061993a5a797186aa50506.1780596023.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780596023.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

ceph_parse_deleg_inos() decodes interval sets of delegated inode numbers
from an MDS create-with-delegation reply. For each set it reads a 64-bit
start and a 64-bit len with ceph_decode_64_safe(), which only validates
that the eight bytes are present in the message, not the value, and then
loops:

	while (len--) {
		xa_insert(&s->s_delegated_inos, start++,
			  DELEGATED_INO_AVAILABLE, GFP_KERNEL);
		...
	}

len is fully attacker controlled. A malicious or compromised MDS can send
a create reply whose interval set declares len near 2^63, driving an
effectively unbounded loop that performs a GFP_KERNEL xarray insert on
each iteration. This spins a kernel thread in the reply dispatch path and
exhausts memory; on a client that has negotiated CEPHFS_FEATURE_DELEG_INO
(enabled by default) a single reply is enough to wedge the mount.

A legitimate MDS delegates only a small range per set (the userspace MDS
prealloc window, mds_client_prealloc_inos, defaults to 1000). Reject any
set whose len exceeds CEPH_MAX_DELEG_INOS (1M, far above any legitimate
value) by treating the reply as malformed and returning -EIO, consistent
with the existing decode error handling. Normal delegations are well under
the cap and are unaffected.

Fixes: d4846487870897 ("ceph: decode interval_sets for delegated inos")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 fs/ceph/mds_client.c | 14 ++++++++++++++
 fs/ceph/super.h      |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 4f36ac73305dc..0a084c4f3aae2 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -633,6 +633,20 @@ static int ceph_parse_deleg_inos(void **p, void *end,
 				start, len);
 			continue;
 		}
+
+		/*
+		 * A legitimate MDS delegates a small range per set. Treat a
+		 * count larger than any plausible delegation window as a
+		 * malformed reply rather than spinning while(len--) and
+		 * inserting unbounded xarray entries.
+		 */
+		if (len > CEPH_MAX_DELEG_INOS) {
+			pr_warn_ratelimited_client(cl,
+				"rejecting oversized inode range delegation (start=0x%llx len=0x%llx)\n",
+				start, len);
+			return -EIO;
+		}
+
 		while (len--) {
 			int err = xa_insert(&s->s_delegated_inos, start++,
 					    DELEGATED_INO_AVAILABLE,
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index afc89ce91804e..43a9b075f344c 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -634,6 +634,15 @@ static inline int ceph_ino_compare(struct inode *inode, void *data)
 #define CEPH_MDS_INO_LOG_OFFSET		(2 * CEPH_MAX_MDS)
 #define CEPH_INO_SYSTEM_BASE		((6*CEPH_MAX_MDS) + (CEPH_MAX_MDS * CEPH_NUM_STRAY))
 
+/*
+ * Upper bound on the number of inodes the MDS may delegate to a client in a
+ * single interval set. The userspace MDS hands out at most a few thousand
+ * (mds_client_prealloc_inos, default 1000); 1M is far above any legitimate
+ * value and guards ceph_parse_deleg_inos() against an unbounded loop driven
+ * by an attacker controlled 64-bit length.
+ */
+#define CEPH_MAX_DELEG_INOS		(1024 * 1024)
+
 static inline bool ceph_vino_is_reserved(const struct ceph_vino vino)
 {
 	if (vino.ino >= CEPH_INO_SYSTEM_BASE ||
-- 
2.53.0

