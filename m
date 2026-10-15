Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429A83E63B2
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792080754; cv=none; b=FU6lo9Fc4RwDVEaaiWkHUKeFnNPQ9Qkn8LAXulhmm6Ts+0o8kie1OiHPljxDzCZdi1mtTpy7gEHMy52qKHCX2xeuYevqoDfsvaZLFsXuzQwfhaZ34QbeIRHRcTXVhHYpJocw6wdMW6n8Hczz1nlQSBHnPSttT1V00/hnKuJ4Uy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792080754; c=relaxed/simple;
	bh=pwOQdieYZCRLGlhC7xNMLdBqVcBUb45jf4HriGAEWns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RX7Ae3X2AZDnBoPFkIBnO0ArH0rzAXL4LDELpq+FyrxaOUkAtpM0h4CqGhQBpfaHkv1Gl1rvkI8G4oP83UCwv2PtToFXM7ZAaiTlJn2lhD3IWvP5A6j4wbyyvGGa9v5J23JUJH0B3lSA4T6c9H/PhfNhDSvJXQ2zEIs1EHBbmW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nfp2IWYn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A8zBHmeJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nfp2IWYn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8zBHmeJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792080738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
	b=Nfp2IWYnmt6Fd8zaBtCBrUAQQQ/UeinQCZCDGTM9Rn+Kik+kdxy6uVA7J3/dCkJ8i876OA
	NtFf2HaFcNyYt/23g/fvxpdBqsl+Ku76LkiJ4NV3ZTPC5CEyKV8M2HuOOJ5jUNAcKCJlP3
	wXMsmyfcJ7q6lPkNTUlQUi2Ie6BfNzE=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-0I5YiGJDP6qNlgPtztCvZg-1; Thu, 15 Oct 2026 16:12:13 +0000
X-MC-Unique: 0I5YiGJDP6qNlgPtztCvZg-1
X-Mimecast-MFC-AGG-ID: 0I5YiGJDP6qNlgPtztCvZg_1792080732
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3580c07911eso14128268eec.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792080732; x=1792685532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
        b=A8zBHmeJx6t/ucpeH0Nzm67eQdJHYeusQLj8jPPUAjE4VR9D9c1kHv2smiqvKr5bhZ
         Rf1cKDE+7Ir2oSOpztcFHndi/UM7H8hZWaW8mzX/r3WeqYOcVNPdMDZvLRzTWxUXmR8z
         JMMGwTYaBeLZoPhOc4M1bejSpLCQ9zQ6cdb4ZONSK81QPWkQz9VoCAIwjidGqvV4VK2n
         arx0XUS1FpG9M/REppR/IN/7pLtHa+QKEDkuwzOAx9N2oGuu2RCh/EzXSx/s1MGU5sUL
         Xz/pv0WIk+AgnGtO4srh1B3ybbuI2Dq7TLjacV/6qactZ65zPx6Mkh/gKnIU4690liwr
         wAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792080732; x=1792685532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
        b=1RiT7K7Ozv0fRnsFNFcJQvNsXUJHDEzm0W2yqYLeD4jIFmoLH4jvvnqNAjVKMvudBI
         VaN0HWtEZAP+BD9kbOfQ9UFc+4TaHg0zzMIxJ1qa7G+r6m9gggAsr0e3fA2zFPPkwnWE
         qJOKJVEnNlPcmPkE60xv+b3JWZs4qfTO1+0hem9qVVfNb1zRXsFIEAIV7Vz9ORZK01Ae
         7c7AU37pnA8ln2nz6tiq5kZeO7KIIoCUlRReQnMljZuctOFQPSgyZJmejdYvGtrsnTWr
         1HAxRpggS4mgrI07bTBmVHBox5YNPJbsRNvIjq3tJb273BhYRt1vLpOBM3pVgY6FeIKE
         VdSg==
X-Gm-Message-State: AFq9FYI7QoF76nUNUS0TVJyAIt0AAdNF6svFnBqg+CejmdeBfMb9Iao7
	z6uFtK3gTGFBfR0SlJt7eRqPatY40ZQgiHi88qseVhXeJROHTg7l3OhhtN3k75UEYNwwBQjMwnS
	wMc+saPJwrpObDpLsL0ijld5k2+8gc3wExbptVUppFAaKzNqrrxsWdSYuVSkbdFBww2LtswSg3l
	CwgF1migvKpd95OMUVtNXiO1akKIKeuumdUpAbf3dt95P/6vM1Gg==
X-Gm-Gg: AYBFou1nwLj71QonvDMCiEqYfTOGtg4OeKTnmTi2M1I5xgc4+FMl8jRi2ciGC2No8Ux
	ywMi2Ee4LEoA4b8gQkFmNGS4lSBLuGmv604v5LV4NYOyea3/HrDyQBUfF70uQh447Gbt7uYT0v5
	HG72cXr3LFDlQwsve8CVDbqUWDy+BPFnuJpbve0V07A1BsJkbzppY7ALQBNnd6veMIjJmfXS9+E
	sSfoeU8/3rB9U/8E7hHwDjTZ+AQNs9hBPtyNisoI17H8JiusEodOB4McvCM68nIfiCCKKnt6LMs
	te8bjZs+2JNEvtI44qnTlwJfP1Fbz0A1E7SH/AoclG+xlwqhuhzc7oeEBFPzdL7wGcDPmwWwRlY
	li/3sRWE4k8G4j5YMRglGqgvPQNC0gB2Z2JF+dpMUcnF7DsoLkERzRReFL+zR9BQ803npAY8jwK
	dr2wMEiXMkePt/qg==
X-Received: by 2002:a05:7300:d18a:b0:35f:a2ad:5ef with SMTP id 5a478bee46e88-35fa2ad064fmr1830934eec.10.1792080732264;
        Thu, 15 Oct 2026 09:12:12 -0700 (PDT)
X-Received: by 2002:a05:7300:d18a:b0:35f:a2ad:5ef with SMTP id 5a478bee46e88-35fa2ad064fmr1830896eec.10.1792080731456;
        Thu, 15 Oct 2026 09:12:11 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm49961933eec.11.2026.10.15.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:12:11 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ceph: add subvolume quarantine wire definitions
Date: Thu, 15 Oct 2026 16:12:02 +0000
Message-Id: <16cfdee842339f09eb5c16c24d7e288d86f0b274.1792074165.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792074165.git.amarkuze@redhat.com>
References: <cover.1792074165.git.amarkuze@redhat.com>
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

