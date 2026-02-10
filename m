Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E413233F373
	for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714398; cv=none; b=AKItvqe+41xcMYx0lCSA27sM9Zdg2BZomb1fXbMbwDvG5emuJVl7PERKokp7VTXw7Ys/5/K7YCSfowZz7giuDsbxcJc6ipSbPCL4rI+iVbbTbevvDIbC9A9jVL4QDtOh2ej5NF9wAV/aasTL2FDQKA2pnwQQnvlby8q+BCtZMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714398; c=relaxed/simple;
	bh=EnyeESgGKzUp4gDfnZECZTE05rUvCTep4deEFH+BrvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=APvSSp8KFaVuYWpVbTkGoSU6To6/tgbnzY1/6Cuar699GTaf0vClZE1XS4FFqFStmDZTZNustfNKuXHNcdBwKRNVRiNVLoETNftjmYc0yzR9DA6/I+NSV538TFIIqA11VhYCF0Gp5eKMJpxhceH54Ogq0WbXnaQrYQpmrd3DEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tf2j3bIK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JJ7LSzwE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tf2j3bIK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JJ7LSzwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770714396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nxnNZqrGvDVMu909TWbsK9n1HURtx1c41aByLTqi3l0=;
	b=Tf2j3bIKiTFg/qVT+xVHNUQNODwNbAvqbJ6iP0g8tNNBw/YhPqT0xTySbh9DkFT5tgt7Nk
	JX4VLR01x01JFjrO4dxqTBd/IrqNrlqeygv6wwgZaiksQ89Nd3Qjst1OaQTvvfUgrs5lBi
	jsago70swzzTNveLTxha7yfoXL0fpWs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-rTFF_R_NPVaonnb1kbytXw-1; Tue, 10 Feb 2026 04:06:35 -0500
X-MC-Unique: rTFF_R_NPVaonnb1kbytXw-1
X-Mimecast-MFC-AGG-ID: rTFF_R_NPVaonnb1kbytXw_1770714394
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8946f1b8691so18990566d6.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2026 01:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770714394; x=1771319194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxnNZqrGvDVMu909TWbsK9n1HURtx1c41aByLTqi3l0=;
        b=JJ7LSzwEf43zaLj01sGnayBFnjQw9k39yxThIHWjbokA4dZO+o8cMlUhzk6FsGsDmS
         xYwjkfYHl4FksV9LAS0vZJQATzLQj5sWyw9JVu4xgFRo0k+Rw4iECtMstTByTsQc3Q+q
         0Zn8VyfYhcIOA6HXOID3C664t7AuB7Q2izPap0dXSUANneGVD55ZG5n6K1rk/n9Qoj4q
         +iRpoXRcz3q/Vk6nNrCa2x0gze8/vvtjhaOdLm2ku8rjIwnZThfufov9i96cLOrn53wn
         Itc4ABHHsarOg51zmBE1jKZyA8J0Tf/KuQyo39LcUfqusOrReBiV92kWRCE8eEwjbEEw
         8TfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770714394; x=1771319194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nxnNZqrGvDVMu909TWbsK9n1HURtx1c41aByLTqi3l0=;
        b=ikPTZNL5Rk04bDOksqQX5BeBJTJEY7vyGEH6pzfVLUR0/PjLDA+U58AYEhuSNfXon0
         BQFcnmol5KUsS2yj+adoq3KyUvzuqEuTB656jQLd0EC1M/Pn3troDDalGbuLYgrX3pzo
         lRk77E4WaAqG09wCn4+Rqt+JvtMsVqC85MPSVb7PWUnXGei6y178uRnmjL3qvh5/YEtk
         amQlsqGuWb9gz+bHjaEDZyrFsJMcyB7gvMVgckSz9cLG5Ik5GD2WdS60QDizuWEK4xs0
         lQc1F8CawoJTC5uMfK8Z9cTuUW800Ikt6ePxC+GPqJMADWiYiggp8ra+Kpqr/foodqqS
         iX5A==
X-Gm-Message-State: AOJu0Yz5fmF9FYjArlffCrK+Otm6taOxj8Hxrsg1VfRR8IGY4S1qEssQ
	aK4vJEpB4/78KYBO//zUq+jLPd9gdFKzk4i0dCPBLqpkB9MqTj4FNR7neamfle7l8M9ZlRPZpUH
	GaKI+S/YJIfRH7O6PzkfMgBJsYFzOYCW0PWTF1n5euanXThHCBK2Ig1f0hFTNmbh5X2FfGiCnPR
	LHLFV/KAedWoTZOdOLqiYdd1+VuTvglIn2GMOp6QCAzjsrl9JaAYLc
X-Gm-Gg: AZuq6aIXENDkZ/UU+F4yvXlrUnLJBbfiu4D36ofwT0zZDIrTmcBMtbq+a7JBw0pkMoB
	3nlDvnsq3j7S9fnwYBedNyE+v32tgpzfBQlH/6gO4WYDr0Oi+DmFKxk9A4ATT1A/xjY/hZpI9hw
	IvsBTugWCuplyxKML+HPWY2gh9L9blq14MLwS5aWa8m4524LuUzVuHTwF/djdTFteR+7jM3CLep
	GSo60qTt1l8PvQGLCuUTrvzGq88RQS7bsZWPiIz9A+QI/OYClRPjWBcoHLB9p/tJ/lGkitxCp3a
	PCd6pLR8KmMjNpCZhs4XvrmPwVuIatV1qYyfvo5KVJIvs7CcJv95bShOkKLJW1x0Q96jY5+7ZRH
	faUdOuh4orhH9+0maDxXGwGurhsz+vz0nDOK/NnCofXeIXV0wOsOk/cY=
X-Received: by 2002:a05:620a:172a:b0:8c7:f61:fd77 with SMTP id af79cd13be357-8caf0d3d0e7mr1789648385a.58.1770714394437;
        Tue, 10 Feb 2026 01:06:34 -0800 (PST)
X-Received: by 2002:a05:620a:172a:b0:8c7:f61:fd77 with SMTP id af79cd13be357-8caf0d3d0e7mr1789646085a.58.1770714394086;
        Tue, 10 Feb 2026 01:06:34 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c068292sm108053326d6.45.2026.02.10.01.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 01:06:33 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v6 1/3] ceph: handle InodeStat v8 versioned field in reply parsing
Date: Tue, 10 Feb 2026 09:06:24 +0000
Message-Id: <20260210090626.1835644-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210090626.1835644-1-amarkuze@redhat.com>
References: <20260210090626.1835644-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add forward-compatible handling for the new versioned field introduced
in InodeStat v8. This patch only skips the field without using it,
preparing for future protocol extensions.

The v8 encoding adds a versioned sub-structure that needs to be properly
decoded and skipped to maintain compatibility with newer MDS versions.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index c45bd19d4b1c..045e06a1647d 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -232,6 +232,26 @@ static int parse_reply_info_in(void **p, void *end,
 						      info->fscrypt_file_len, bad);
 			}
 		}
+
+		/*
+		 * InodeStat encoding versions:
+		 *   v1-v7: various fields added over time
+		 *   v8: added optmetadata (versioned sub-structure containing
+		 *       optional inode metadata like charmap for case-insensitive
+		 *       filesystems). The kernel client doesn't support
+		 *       case-insensitive lookups, so we skip this field.
+		 *   v9: added subvolume_id (parsed below)
+		 */
+		if (struct_v >= 8) {
+			u32 v8_struct_len;
+
+			/* skip optmetadata versioned sub-structure */
+			ceph_decode_skip_8(p, end, bad);  /* struct_v */
+			ceph_decode_skip_8(p, end, bad);  /* struct_compat */
+			ceph_decode_32_safe(p, end, v8_struct_len, bad);
+			ceph_decode_skip_n(p, end, v8_struct_len, bad);
+		}
+
 		*p = end;
 	} else {
 		/* legacy (unversioned) struct */
-- 
2.34.1

