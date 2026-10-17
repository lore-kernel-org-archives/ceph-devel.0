Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A447F2DE
	for <ceph-devel@vger.kernel.org>; Sat, 17 Oct 2026 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792244429; cv=none; b=WzN/5amCl2E9U+/+ZPvSGScHLkctHXNRh2fwsXLjnUKVA6dVYYFYXc+h904Y3hnUKPeeGOVCjMj3k9UBTrADAG9lLVMuXTL9ahj+AHmH6+BEpNH9tvUPnLJo/MuFGVnRf3molK6do1ODxgpc2pxWooIRcgbIdC5gk9h4D/5Ym6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792244429; c=relaxed/simple;
	bh=pwOQdieYZCRLGlhC7xNMLdBqVcBUb45jf4HriGAEWns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2gd5ld2Xc+23MT7t1GPm6QPqsiguSTQ12w16lR4lHbyY7FtExZZgqhvDYXzpK3mobgQuf6YQHI8Dh6Plzo2wkiVlgbZXcFRxt3nDvfJriUwjZYEH0ikT2hyUb6lsgJizONmdYSYXGGrFTBElm9G9WFitL0JCodNhByC00DSkMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOFinY2U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UMK822WF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOFinY2U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UMK822WF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792244427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
	b=IOFinY2U4I2H2prIN44Fq7cVXdd6iwTZxdTgFkuXR2SMALvWQeyo+rG47b7Pb1HFXO+YX8
	JNnFEU/LoLxbS2vEVtJPWfOr3T6Badwd/cMim0O6equZpy8IyGXhDjR7u6etu+LUAQTSwZ
	vXqj/m0O0QVRNuoC+M81XkcI8uNrpWs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-Crlr3ZrIMFObFLWXOCavPw-1; Sat, 17 Oct 2026 13:40:26 +0000
X-MC-Unique: Crlr3ZrIMFObFLWXOCavPw-1
X-Mimecast-MFC-AGG-ID: Crlr3ZrIMFObFLWXOCavPw_1792244425
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6acb986a43bso824860a12.3
        for <ceph-devel@vger.kernel.org>; Sat, 17 Oct 2026 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792244425; x=1792849225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
        b=UMK822WF/nCTKhAxEKnrl2vdn/qvKxxfVrUJfvD7nExZqbebopTRV5D5MjjCzm6sHs
         CUfCizcBL9Z8AMk8dwpeDL4FwqsZCNFKcs13Ui4yxnFeaPNradi0BTH5zVHC5jW52ysJ
         JrU6flaIZme9b3inDHhODSteBdbzVaC/35JkXFmQhbR8K/FNisxCeDbjHK5QT9D/LPZw
         BdJoUsO3KVNxpxOAnILqkacQSxFOmRABuzP+0NVNvXWycNC2UTx2yokZctj6s/djIpPq
         KtLMLe8PDXxoQn1DcW/Z/4V2WgzOgWbbTwUp8pH2ZKzZROjFd/NVIDAeD2J37ivie0EJ
         DH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792244425; x=1792849225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
        b=0MpAJ9AE7n1cBwhBOLtdJeX/anwoJhS/hKOq8GnhrayBOIuIsPjnDXRX2sBIpv1T+P
         jpmuBaGxRg4spE9TB7W3xDE/EmVTpfibGkgsk8HiiK+HZIg5yqfAU59Op9TI2lmm4uZv
         Eol543tqP+i3HOH+ntrp+exxUmJstcZj8G/cqJ1DIlNgHGp1+OHrToIYzVGb2jrp31os
         bnL4tmFECJon3gzZf8k0dvwa0UcH2hL9HT9K3L0cYsZ0laSD2XhkKaTP1WibzUVW51L8
         p7kbhKPioQi5icRKCGeNB/nz28LcyJjq9SYaBwaCOunY1GrIFDBaw93oj/EB90PSvl7k
         jk7A==
X-Gm-Message-State: AFq9FYIx9BETm6ydXgp/X5c5rBGKyW6pBoyK+NlJ4beWLO7+z7j2i6cT
	Zn1qitcRALvi4NzmejE3xf+1MO96mKl20k8X83ZqQ4OyWeophLaqEvhrJ/Kry1MWzM1IRB1xPBb
	zxmPWNqjgmhY5hf+9gtuPeWrAHjUyUefzamullEvLPqGs4Yn6mX57B5JnTHzq3AQ1I/gEciGccI
	fpW0wyVPEj/XifSOFvnLznl9dkSICeTElnZuUNjFR5fVJaYGjYPg==
X-Gm-Gg: AYBFou3PO4HYqvuHKy/MxvAK3PlI6YYA8/aRjqNn5rS5LoOU5YfhWwuRxUlmxLtjCTZ
	QSZrhXrdMRiaJY59HBVVTjWInEbFpGYQ0gPrpplDJT6PyEENqsF5qwmJC5H9FQIWzCvg7GH0KAw
	7G0sydstMVSPA3f6w4B05M9cm0Btm2AHg7lFwtvKtUSadDslEDExujN2xS5vZ79VeSspaQcQzdC
	aignBhSUcYOGerPBdxHhbHOvImTz2rIO4YmBG0gsWbXfpeSMHHKRPx7k/tS5L/uYnwprApUn8A+
	57bmI2u2odSSNVGNAcnmsMaJWWPlQakSu7ArwQ04qMSokIGmAXWLZKojqhypokI95Gg/u0NqoOx
	ajwfXRa19rdmpyNgZK/srTwEGD9WCvkZ5SmRjB5QjhD9XVD/4ItZXmpTrLmQuNI/vgtjVsUumsW
	XYTzw24xRgXwwMeR6nbvszzCMv3k4Mee7XyTRt7yvcOdLRalGHaUfPV+zvdNMeuOhe5BmH4/Ve/
	8M=
X-Received: by 2002:a05:6402:1ece:b0:6b3:bcb8:8afe with SMTP id 4fb4d7f45d1cf-6b3bcb88ed0mr314066a12.43.1792244425441;
        Sat, 17 Oct 2026 06:40:25 -0700 (PDT)
X-Received: by 2002:a05:6402:1ece:b0:6b3:bcb8:8afe with SMTP id 4fb4d7f45d1cf-6b3bcb88ed0mr314053a12.43.1792244425039;
        Sat, 17 Oct 2026 06:40:25 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b113dsm1913032a12.10.2026.10.17.06.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 06:40:23 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] ceph: add subvolume quarantine wire definitions
Date: Sat, 17 Oct 2026 13:40:14 +0000
Message-Id: <cb850797b3efeb8f2a911779098bbaf0187e87a9.1792241577.git.amarkuze@redhat.com>
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

The MDS revokes a quarantined subvolume's caps to PIN and reports
-CEPH_EQUARANTINED in MClientCaps v14. This wire errno is 1000 and
must be translated to EACCES before returning it to applications.
When quarantine is lifted, MQuarantineDisable identifies the inode
whose local mark can be cleared.

Add the errno, message type and packed disable payload, and teach
ceph_msg_type_name() the message name. Advertise the session feature
only after the client can enforce quarantine on cached access.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 include/linux/ceph/ceph_fs.h | 13 +++++++++++++
 net/ceph/ceph_common.c       |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index d70bbce1a1b2..5afccfa891cb 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -154,6 +154,7 @@ const char *ceph_con_mode_name(int mode);
 #define CEPH_MSG_CLIENT_SNAP            0x312
 #define CEPH_MSG_CLIENT_CAPRELEASE      0x313
 #define CEPH_MSG_CLIENT_QUOTA           0x314
+#define CEPH_MSG_CLIENT_QUARANTINE_DISABLE 0x315
 
 /* pool ops */
 #define CEPH_MSG_POOLOP_REPLY           48
@@ -921,4 +922,16 @@ struct ceph_mds_quota {
 	__le64 max_files;	/* quota max. files */
 } __attribute__ ((packed));
 
+/*
+ * Cap oserrno used by the MDS when a subvolume is quarantined.
+ * This is not a VFS errno; applications see -EACCES.
+ */
+#define CEPH_EQUARANTINED	1000
+
+/* MDS -> client: quarantine lifted for one inode (ino, oserrno). */
+struct ceph_mds_quarantine_disable {
+	__le64 ino;
+	__le32 oserrno;
+} __packed;
+
 #endif
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 67e88f30409d..cc3d21fd7d5b 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -83,6 +83,8 @@ const char *ceph_msg_type_name(int type)
 	case CEPH_MSG_CLIENT_CAPS: return "client_caps";
 	case CEPH_MSG_CLIENT_CAPRELEASE: return "client_cap_release";
 	case CEPH_MSG_CLIENT_QUOTA: return "client_quota";
+	case CEPH_MSG_CLIENT_QUARANTINE_DISABLE:
+		return "client_quarantine_disable";
 	case CEPH_MSG_CLIENT_SNAP: return "client_snap";
 	case CEPH_MSG_CLIENT_LEASE: return "client_lease";
 	case CEPH_MSG_POOLOP_REPLY: return "poolop_reply";
-- 
2.34.1

