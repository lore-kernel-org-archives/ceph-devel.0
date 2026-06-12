Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E10D374E66
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283945; cv=none; b=f69n9q0l9N/gRqVvysr8U2YMLpJx/SVAQJ0kG6aGo/PTVELiZxdzSlwV96bupKvCu9MXQODBPkU/c/PkVM2vg3gRiITauNFzoFM43dtxzH69y9puAcUnfZzgG4R5jtH13CNJGaQb/dMG+fX3q3t11k9feTR5wk1qsFTL1Cf7KXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283945; c=relaxed/simple;
	bh=YPDuhKVfPAEljKsfayv1OltZXRXezi5hzreSz8ms5Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QpFsup9OL+QW0QxZzsyeJ3KCKPdpeKaG5duQtw3QSDypMnm+eWArNuXYi0199RYoh+2zCbm7V23mj1KYtAi62i62sME7jAEPTeWwhNqx0n+7L1LVHns9M4S3lswRBgkKZ4nbv243K9ctcpzf8fP8pUaH1SDhY/mmfROE0dtAj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=NTXQxE/Q; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="NTXQxE/Q"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490c1915793so10569935e9.2
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 10:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283942; x=1781888742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bo9G/t/0K/ePZvazpUVc0zWoS9ZiJSn1baVydLIWARo=;
        b=NTXQxE/QH6QxWL+Evos/MJ6Q8ksHCUvf+MOF+Dok9XyOPQo6NjJEOYNmC7c/b22sCB
         R2dUaI2hKV0Nr9Ihnoc8+v72nXcRAcd3p9Uuofrdh7jSZZ20zfJqIztWyaoenMfEAUJr
         05DMqzJbjDjmG9XRThKE36fG3Gm2tAof4+qbtWNQvp7a+xJw7ucVIQDXE9sjAN2IkiVr
         2x09mhQESV/WyjUOn9pwGaKhQM+xtftQAuy20M5czs+fFovs6LC57enUaapepko82lhI
         T00xJBtBhAxoDM4y7PkJMRBuY4DqmW493EHY9yxakxnmq4REBB+xX3NqlA6e7aFN/XKk
         iCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283942; x=1781888742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bo9G/t/0K/ePZvazpUVc0zWoS9ZiJSn1baVydLIWARo=;
        b=Wg5CTv+qIOku7vamNi3oudItHCIamr/rimYuafNB6mI5+/uBeUFEVpkGh+hQsavWI/
         XMd7aN5QDWuyh9MDR/1ReUg2tcHJKGXzra9ApvFzzZTqF2qcxh3inKFLb3pOCPMYB/d4
         Ttr+JJ/1h7xcfLrV2vR21IIw5EM2y4wK+v+9Vv+VsbbYP8Ry1Cn0BnTImQqJkLr1KGIj
         XaEVeGaPdRnNpQwjwljlC9U8dmIPG/2gfo7O6l4p9TbC234axFf9wmKhGVS914MSMLHL
         RF7vJChL39L+FCgMvAFRgf+LXhs54scCk2UTkGbimzKAQq19wFtKjK0g6lvsZx9qlAmX
         weAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4lvuHMT8Bl1WfTNil4EKUZInp+xjqBFyKtPpR2ACpQRUmHJhqYHh8dYOL9WAQueKuVb3/XMDRVFA3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg/Q1qlXSkGcsVgYxdcxReLkjU3+nMAOe4ZZS5xXmYlIlCGhRb
	WYSVnvU9pI62qYGvfMWJd5fEJ6GXkL/8a4ZWv+J79oM5vr9CetcWHH4hg505u19uxpk=
X-Gm-Gg: Acq92OGnvJCMw229Fy9LCHGlDK11uHWpY5db0vCNXlkST8mhPebs98SA3355CxgK3fw
	ukO0XOmwoZMsURtL5pW0uxa5BsENMQx/ImeWDKrfOt2k+x6fRGPQEA9PUcUoW2wYChvshmB0fzK
	79LfVQs40SFaIPHNWJItpcypxQdTuEGVuLBbeS3awFRA9ZrKxeYFB4FGBBeyO/O8jsEuzzX2q8x
	kbowXCsm0L/Hqik5iPvDlYobpl5p0tQwjfjK3tnBTaP6b77mPolpwj5UwkY4/pJKa5CGG6xlxQn
	CCpBu+V5di+UAb+zwIMdclOZJNP/XQpMEuoArcvUhJhRy/4BZMp2EIMYI3iCpJZqBO+P/motUcN
	+6COyPW1EIDaaUjX3bX3+zOl1La/2fmz2Jn0J/xo8jQtpZGEHxF+m5kWhottut88IqVVFZP5FZp
	Q3AUGTfNsQsJMcyictljcxBM8npCunq8UZgST6WP7TMTsd7oLq1VZgWFTNzk+Vz4+xtk0oYXGQv
	gBbA03xrCL4uLXF8UHCEHltFNPr5L17aJHjeA==
X-Received: by 2002:a05:600c:a310:b0:490:e1cd:ea25 with SMTP id 5b1f17b1804b1-490ec504b34mr33830975e9.23.1781283941704;
        Fri, 12 Jun 2026 10:05:41 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0c10sm7541814f8f.21.2026.06.12.10.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:05:41 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 1/3] fs/ceph/caps: make __ceph_remove_cap() static
Date: Fri, 12 Jun 2026 19:05:35 +0200
Message-ID: <20260612170537.92970-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's only used from within caps.c.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c  | 2 +-
 fs/ceph/super.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d51454e995a8..efa6a15c470b 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1119,7 +1119,7 @@ int ceph_is_any_caps(struct inode *inode)
  * caller should hold i_ceph_lock.
  * caller will not hold session s_mutex if called from destroy_inode.
  */
-void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
+static void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 {
 	struct ceph_mds_session *session = cap->session;
 	struct ceph_client *cl = session->s_mdsc->fsc->client;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index afc89ce91804..76b946116613 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1261,7 +1261,6 @@ extern void ceph_add_cap(struct inode *inode,
 			 unsigned issued, unsigned wanted,
 			 unsigned cap, unsigned seq, u64 realmino, int flags,
 			 struct ceph_cap **new_cap);
-extern void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release);
 extern void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 			    bool queue_release);
 extern void __ceph_remove_caps(struct ceph_inode_info *ci);
-- 
2.47.3

