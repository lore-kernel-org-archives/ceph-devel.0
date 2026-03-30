Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2DC3B2FF3
	for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860207; cv=none; b=q3XalBFS9LMK60Y0X09oJkG5mMLlKBSinfakNMi7pfgLd6uiabAdoVKG/jdkCrr88DpQWefNjWgO7P0aqgS6em/jXZ1wXi0BQp+iXfgPU49H+m2GlOT+A33KtBmA4rDjMijKb+tmMGs4Ouo/hNCzuCAabfgoMz9/ObhV6v6QnFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860207; c=relaxed/simple;
	bh=OOlsXudGqSHm3OwpfUdoZuF/A53N2s9ZFH3DhrVT9dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G70RdD+UD9re+Iax0NP/Z9QNQv5RzmYUx+nDqOFfFDCdCYmRatwuOMJRUzgim+cQEynNgYpke33veDZvM9go6pc7aLdzCi0Y9Py8FkOslrED6l44yu1BlSlEzvqpK6qas0nTI9nONswcU4tdETus7XHAJ20QNwkp9QB5xzZuhA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=OvzU3+g3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="OvzU3+g3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b41b545d9so4586811f8f.2
        for <ceph-devel@vger.kernel.org>; Mon, 30 Mar 2026 01:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1774860204; x=1775465004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UO0v74qmrXUTYDdElM5PYynacz0f0jvqBa24URvpyVw=;
        b=OvzU3+g37ya56YRTZeK0SalEi9+WonPkmrJ8SlWm7pdjQqQx9Lz6uH7xjBqCMynKIl
         Xs8ieW3eD0Wltmv2W60akIj6zZo5CwrXWVha1YFth8GzrwjkNy13l3a7/w+2aJQiYgVt
         oVi3BE1sRbpUkJ98jKZ+UGyMm8rwrF+s3RgjU+8qgsKartZRA+bnHdzDG3lXEq6a3SBc
         tLfAZu8a3OTC8AS81dyigAChn99uIcbSu3bQsjaD8pcvv5SqPsje3/lHDCBsM1Sbc5iM
         ifBd1OVQlJkTLejLedwzvmO1qyRXzcGABoQyopjTIg3IYLoKBmFLPqp9huxdXVk7yiJP
         nJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774860204; x=1775465004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UO0v74qmrXUTYDdElM5PYynacz0f0jvqBa24URvpyVw=;
        b=AqkkMdPM0GcpRDWAbCPc9XaqnDbwVKI8RgbhmY9imPZx6zpNlMcCJMp5+DrG2atQeb
         mSWEufDz4S6AMgKxplho9zt4tesdQ9Isb81dZ6pT+uQus9fNVAIgYb1CV9XPy3MkJKbs
         iMjSP9b9yNMp2IUv3NwCKSa6RFGmnIkGOVsdHg0zIpKBDaHYhyrnqa4QLTSNRhcctJ6f
         8zb2ARYvCW5xdACpGqBn3fiK6IVh1P5NvofsvIL4VYwe42vRJYF7lCCQ4R7PpftNLaRP
         5/Lms3Nm/1gv3zGvMiqU8PoaUfp4VYnp1SxgwWUCcpqJPbMXUCsrZBLT41kbpFrILAQa
         q8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNvbjd85YdeMVL0SyKnzMU+gZP+Ck1IANlP7meGW0QyyxhLCeJwruX7KhJIM0roWBufpPmenYiU88S@vger.kernel.org
X-Gm-Message-State: AOJu0YwXXH8kqu9V1VXEGRafSHno97zZUNoIT+hiOxp3lxrfzSZDn/Jo
	QyUuzdVyOmNHRlAqDIZe945KDn7FsvT4krhp+vcjdOwWz4HI91n9V7qe9RdxcjZjX1A=
X-Gm-Gg: ATEYQzzw3vknDL7Y3bXPfH5wsv4CvWf9fz8hDMlxagmpC2nzRuhSBSpiOTfjT65vjOj
	sFOeWpbADbbqPXXyYsgE33JFV4PsTLCqxN2+ZrmjDAI11lZVfzzYueCQvvnn+XSELouAIEhRFq3
	Y7bOLFR5raBwWKEcDsNIR52mk/OBNBC48I+ReqMzg0qaojcY3wMcTd65mY1ixPkQesbfVxMTyR0
	MyrJeX1LfPxjOs3eSdnQqynzOifG31jk56HJSdwxkILH7/pY3JrKeAW6MtJdKAlXI/mqc/lJ3+L
	nsJEbfNZb29d2HhwU6YHjWUTSp75+ZEyafTfLZqDwuCzEll7phH+zoShp3RsmRK/3upJRzZU7iQ
	hmokPBc5u3x0R5CpV25lwAY1dN4dpsvqd0jr53kxzVbrIcklAgoFbleVmgNN64vwJT1Xm2CiQce
	eeG5fhikA+66swOOkdpF96OqHqP9cyIwh5Re3a46gom6T9X7lQxTKdbGJVvW8iB7qWRqIazBtHM
	kfGUBz0FhpV1LYtvdMRaI167SudUDYJyKut/g==
X-Received: by 2002:a05:6000:2003:b0:43b:45d1:f438 with SMTP id ffacd0b85a97d-43b9e9da653mr19145390f8f.3.1774860203620;
        Mon, 30 Mar 2026 01:43:23 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f2b4400023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2b:4400:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e2a7asm19130650f8f.7.2026.03.30.01.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:43:23 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] ceph: clear `s_cap_reconnect` when ceph_pagelist_encode_32() fails
Date: Mon, 30 Mar 2026 10:43:19 +0200
Message-ID: <20260330084319.1357751-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This MDS reconnect error path leaves s_cap_reconnect set.
send_mds_reconnect() sets the bit at the beginning of the reconnect,
but the first failing operation after that, ceph_pagelist_encode_32(),
can jump to `fail:` without clearing it.

__ceph_remove_cap() consults that flag to decide whether cap releases
should be queued. A reconnect-preparation failure therefore leaves the
session in reconnect mode from the cap-release path's point of view
and can strand release work until some later state transition repairs
it.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b1746273f186..4fa471d9b3b2 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4956,7 +4956,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	/* placeholder for nr_caps */
 	err = ceph_pagelist_encode_32(recon_state.pagelist, 0);
 	if (err)
-		goto fail;
+		goto fail_clear_cap_reconnect;
 
 	if (test_bit(CEPHFS_FEATURE_MULTI_RECONNECT, &session->s_features)) {
 		recon_state.msg_version = 3;
@@ -5046,6 +5046,10 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	ceph_pagelist_release(recon_state.pagelist);
 	return;
 
+fail_clear_cap_reconnect:
+	spin_lock(&session->s_cap_lock);
+	session->s_cap_reconnect = 0;
+	spin_unlock(&session->s_cap_lock);
 fail:
 	ceph_msg_put(reply);
 	up_read(&mdsc->snap_rwsem);
-- 
2.47.3

