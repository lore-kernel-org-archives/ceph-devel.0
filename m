Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FBD31E857
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322736; cv=none; b=HMwVfAPe/NLiUSld/zrXEEeSfW03YUI7jZgJpYkThTYTZ2Xn+dbWRtgM7/8JXtoXw8ukUSmQzTsrTcJiOsTTBDAcTdduTSbY15Erz40UhC1lkZPxOSd4lTP1ZwNyWDnhAUJG/kQCVbEjU41J8S4woighZIHV2VosJdT4HLlcaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322736; c=relaxed/simple;
	bh=gWPsRaLN0/Z9FscdbZZaG2mXk8DCpBMHst9ZNv/NMfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+d5bbSJM/Ne2FB9Cxi9LHs2vNJusZMvpWmqQal6Ii37IEZRRWRssxOoXenrDMoJGC4383NnsetbBzNi8bHVsJlrJhWxShz1hc4bYGkZPFE0sqmwzRFI32mzW/Lvlw5nnBzCn4WfIyRmZurGOy65QsZi7mAD11yeFVsPanSRNJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NP7Py1d9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NP7Py1d9"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-476d8e647e9so2253803f8f.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322705; x=1783927505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yG2bZbfTqb60xAU2+z5iyz4DewPVNnpAb2LXc+/zpfk=;
        b=NP7Py1d9CGhrPM+sZE8JLkYgIhm5neAFy4507aEAdtshARk2J7splUW8l+OkwFA1uY
         ER61ut3BWHfscodiT021QU1vJzHDW4MzJKVO33WkCS1w/kBuMQjOEVqf3sWT6d8+8Vcq
         cxgBVHCT+59RDPnV/HtFMtycsim/UW8aTzvFNRp2FI+B+tJWKfgKp94XB5G5l1nyUwhf
         p4Zs9xJ4sCn+7M2QKGBDTE2EuG6sVKApeMp/pNBRcxs3se1RGxqwVPhioSAxUtdNOAP8
         f9qswAftJ8Bqg9WhQRAbC76urP0l2TTQ0JgZjwC4ujjWLNFIRgww0YWR+HRFaL0ScwfL
         DeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322705; x=1783927505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yG2bZbfTqb60xAU2+z5iyz4DewPVNnpAb2LXc+/zpfk=;
        b=XzmyTF5FyoMFM5HMbHx/WKxK9/SyGkjk+7IQ5Qvy33IRPPVfHzC9vdIaXd2sWOkJnb
         4bA0M8Xpw2dtv4ftVjrARkTXEz2k4A32SDS/RdVXUsEnZcGQ8KLZ70SIP60xuKFLsuI/
         bwIqSvILlgbvvu7u1j+9VEZAAbd1+IBgn7Pchb2Uus4ehfMloDBAnIECjN8LNiS1nYo+
         dM+/WCgHwCgP7Ew4A1Jv+XtWC3mNStDIm3aI8rGC8Dx76to/jR5zJqCqq/oj47Ix+7/M
         byDRUecVxoYCgdwmvutTerHEENO1mYjMZV6YXx31wXzl/vD1fdteND5iLliMm8HqXcav
         R5xA==
X-Forwarded-Encrypted: i=1; AHgh+RqBLeExksizGbMyZDNGa9VChOC/s879MA2SjD7nPLnRXCukmG05zri0iEhh7Mfxw9zkqPjQUSgTjzNt@vger.kernel.org
X-Gm-Message-State: AOJu0YwOxRpYGr9No2nrQM2vSwDkp3AFhz1PtipMKtWVCnVLp/ysdQrY
	BcTFj1wqm7/2fv82Vtzn0F3nxcuRTWJ6ouG4p3VHGYiEj1jV7MOfW5m4BvmAZ5XREek=
X-Gm-Gg: AfdE7clwj3qMXHecRxkn6kuk1W1UX1TBzeI+JefAUGreSUygpIzf3cj5nTAr8+Y4ws6
	LLytVURSGO6GhNwSm0p1Glg8VT8TCZbZQDyHg1XbMnw6YH5pTeYLLgt5gTpHo/Mq/re6hvo03ZN
	FCKLxeBQDh36bvRIR6MiultNyCbwxnporOXbGINLvdxT4svlfJvGhnbFs7hglNSr4R32VORiBpS
	4EYV3ksPtrsJC8A35Rzy+OJRdVWqiSxGHmH2c4X2PndPwVKw3d/aKOX2sKpDNj9u2MoAE+2nRDo
	FVxXxhql88GDSpNMJ5OjqR3PTsIpKEhxjt04xxu2M//AGZfVsgprWX+eThU542Y/BshxLiyZZpO
	8JaMGkKvzhWaO6pX9bXIIfCv3tlhbvEaZmDs0atZBGAJPul3aHFm+dWzXl1qMwNtiHtWcAn9BGd
	KuyktwGts6lGRUw/t6Kbu6tZrQ8PHeZ1dJN6CGV69rmLdCwbCtuPivpAYnjGDUnDqDtfXJimNSv
	fRPnJnEsYo3/rAP
X-Received: by 2002:a05:6000:29d4:b0:474:6301:3e3d with SMTP id ffacd0b85a97d-47aabb4d052mr7285081f8f.11.1783322705204;
        Mon, 06 Jul 2026 00:25:05 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:25:04 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 14/18] fs/ceph: convert ceph_cap.queue_release to bool
Date: Mon,  6 Jul 2026 09:24:45 +0200
Message-ID: <20260706072450.3920010-15-max.kellermann@ionos.com>
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

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c  | 6 +++---
 fs/ceph/super.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 00ef37312a79..7b0125d6df0b 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1168,13 +1168,13 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 	if (queue_release &&
 	    (!session->s_cap_reconnect ||
 	     cap->cap_gen == atomic_read(&session->s_cap_gen))) {
-		cap->queue_release = 1;
+		cap->queue_release = true;
 		if (removed) {
 			__ceph_queue_cap_release(session, cap);
 			removed = 0;
 		}
 	} else {
-		cap->queue_release = 0;
+		cap->queue_release = false;
 	}
 	cap->cap_ino = ceph_ino(inode);
 
@@ -4593,7 +4593,7 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	if (do_cap_release) {
 		cap = ceph_get_cap(mdsc, NULL);
 		cap->cap_ino = vino.ino;
-		cap->queue_release = 1;
+		cap->queue_release = true;
 		cap->cap_id = le64_to_cpu(h->cap_id);
 		cap->mseq = mseq;
 		cap->seq = seq;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 4916faf54915..abe403eff0bb 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -219,7 +219,7 @@ struct ceph_cap {
 		/* caps to release */
 		struct {
 			u64 cap_ino;
-			int queue_release;
+			bool queue_release;
 		};
 	};
 	u32 seq, issue_seq, mseq;
-- 
2.47.3

