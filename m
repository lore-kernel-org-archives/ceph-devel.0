Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624B481FA0
	for <ceph-devel@vger.kernel.org>; Sat, 17 Oct 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248531; cv=none; b=N0RSY4JmEIeMKIrU5LY6q4HrJYjYHv1N/44wvQxYlEsIfwMuvRRPcC2KR31u6Q3zK0IIu3j3S6w/H7hl+05Y6vWUKfpx3jMjsJMsd39Odr9auOiA1UpOVvvzno7InE03789w6dDKG8vKhO9QFOubVDw7NoOA4yzjPvoCW5BP5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248531; c=relaxed/simple;
	bh=pwOQdieYZCRLGlhC7xNMLdBqVcBUb45jf4HriGAEWns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZjZXC5RzK4NwoQE0k5YIHO0QcszKcwL7tUpKY3NrovUdxwM7k1UyvCn7dC2z+KH+wfNAOE+D2+M8IittsQ70h5GGxemG46J6BqSaMl4Hp+rzV+vLyhTKCYtnbBvPGIoiuPOGiang44CqDCIpghOuAe3251F30O0Ws+j0RFiio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F8MF7gx1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tqPUZBsm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8MF7gx1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tqPUZBsm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792248528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
	b=F8MF7gx15OuvnNoLhhflFfDFfxRYZ82e+28hhKMb+J6ATwFWHIjK4Rn8knf4JfOXuJtQof
	7iVgUntpnruzPeORioHQ8nnCVgNyhuII5x2feQQN9m98Wpjqq8CaRTt2xJgD9CKiwqwqkC
	AA4YtA7ClmIIWo8DUUSN4lAglm0qJok=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-8RdsXQroPzWqQQSRs_k7wA-1; Sat, 17 Oct 2026 14:48:47 +0000
X-MC-Unique: 8RdsXQroPzWqQQSRs_k7wA-1
X-Mimecast-MFC-AGG-ID: 8RdsXQroPzWqQQSRs_k7wA_1792248526
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c40aa03ded8so83055466b.2
        for <ceph-devel@vger.kernel.org>; Sat, 17 Oct 2026 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792248526; x=1792853326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
        b=tqPUZBsmTg7aJJM6/5CjWQmiC251vJXik6dXD5PdGMhJPNmeid4yIA4EyuhKceyPBf
         WnCCPYT3Fn2rS1zFRORKUp/+WEirMLtRGcI1z37Io8bQHpL8B47OoPRhoaEFO/+yTLgZ
         sPjIBKoxW+8qpOm2aUkzrrldoMA55LK5M23yuwPkZ5iPpFEpfOoYQCXOczcL6qG94CsS
         EIObTig8uBesGxWy4yrQBEm4LC9/wt6lm3Rg+W/gjQMpFFddOX71LOEzog5VKFZf6TRs
         Pe0fStoRI43jzQpOZNCtJF/ndxYnmhFohA+MBVOJSflm+Jrh7EzD2a/uha13Fr32lvbH
         Vpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792248526; x=1792853326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=naqyP/7sa0WIDSkQeO1oWhp4/Qc8hwdzJAyRvlL0fCA=;
        b=Lep4lwBVDyaNnZEMvPHVvXejkD+F96COM6D6Pm1JQmUo1foLPgP8y1UAdDnhisrmMc
         9NXAGTFPJR7Qfs6D/ugg/FMX4Z+JHrz7HVU4e/tOhG6SBu5Xgjr6qtvZdy/hDNnJjk3x
         YbRtFsUjLCzNMTiylzrkLoMR5mG3pR6uSTAREnt3qzuImFSbl6dF/Yuhp135BYuab6H9
         6xKYOv6IP1Lu2Vq8xhCwM/mHKTgxEwue5SrHQz0atZwfvxK+GQe5SOqougAGFQhdScWd
         fAiGrZz61FPisA9WMiYImNGu4iPi/d0QoeDau++XtEhbdkOCN7HuD6bYgRBJH7aH2qju
         gLbg==
X-Gm-Message-State: AFq9FYLGVQky9wUrim2waSTU1ukfETlGwVPIUfpzPC8cjbLPaxysZ2X9
	/pVtHY2tbLgDHgrdxM+zhMsFHilpKac9nqUAh8CmYeObnRcch+M6VMTs8Sbz9fFdoiNq5oBiAHY
	1ja7ZEheFWg3LfKO6AD8Jt//pdw7/uxZvh2DLsvWXJ3Q6Vi5UXRsY7br7+QvgHXkt6CMRS4l9/N
	ZvzivzGv2jcb13KhQJlopm2e5JYhFFXnzli1Pm9tRsft2z9nzUCg==
X-Gm-Gg: AYBFou2h+sbUT+kJ7oAAUX5UbV5w5nfyFn1qyksSc2x33FHnBapQ18qiE8lducOKQXL
	Vxh98pAmGDUT3OOsk0m8fXWIkxNrQYFWXbKgAgTYE1HWOclr1KQ3PR61sjI9Ubn6KxA93EycZXA
	1Tv2qfESgkWavD4Os6bqsLtygm+YfzQTVcF3vgMem+Un1A0ohCDDFLTM8PyHWMoEY952kyJIxZS
	Fg9l0GVW+auMbF7WCkh1WettK6ABUVZ44yyGke03mrL09mwfz+65IVUVWi7LHfKL2kMPySECnpW
	cpIoDzYFy+9Y+PbhrR/9GjzUmyKpoBoalEAwlzZOlbyL4rwrXVVkAdiBi+MfL/YSSrhymZn8+yQ
	nOKcl5BGpR8Bj8hClx+CKeYuNZHUsAutQSIye3zEX6uCh/Z7HdAIlHbb/7XI/G4NxPbjo+qEzXx
	PWExUtjX+/NQJJV2iNmPP1XmSmZv4/98yA0GfcO8zFsRWZDHUB5+bVnut8VlHQi+EVvYh8O9VMF
	34=
X-Received: by 2002:a17:907:94cd:b0:c34:83c0:b92b with SMTP id a640c23a62f3a-c419e0372e5mr222274866b.23.1792248526286;
        Sat, 17 Oct 2026 07:48:46 -0700 (PDT)
X-Received: by 2002:a17:907:94cd:b0:c34:83c0:b92b with SMTP id a640c23a62f3a-c419e0372e5mr222272566b.23.1792248525896;
        Sat, 17 Oct 2026 07:48:45 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32878bsm181645366b.12.2026.10.17.07.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:48:45 -0700 (PDT)
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
Date: Sat, 17 Oct 2026 14:48:37 +0000
Message-Id: <cb850797b3efeb8f2a911779098bbaf0187e87a9.1792248177.33a6e2db0a.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792248177.33a6e2db0a.git.amarkuze@redhat.com>
References: <cover.1792248177.33a6e2db0a.git.amarkuze@redhat.com>
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

