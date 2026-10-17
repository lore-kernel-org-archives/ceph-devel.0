Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB99394797
	for <ceph-devel@vger.kernel.org>; Sat, 17 Oct 2026 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248533; cv=none; b=kDlU24zc3HbiJCp/2VtQMIWh1usivtbE7k3rcCbXGD+YoP5G+kUpm59nRTBRuWLsFTD6/5U68h9vP6quvYeMRLrtVrw44QZqPkFvrJyDzWnhq70Zi5chop5jiHtfKyznxXcvpabNZxX/iTLBBOBEJPyzXKWfVENZTgR+IpuCfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248533; c=relaxed/simple;
	bh=L0SvlG0HgqpzEKFEwHq7wDfZkYZ0WTBPvieUdovJWzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SMDXaIiulOwfv2rGZI8QIrUJfQQS4e8UubzlgA1zJErGmK3AM/Bak3XXbXn8a4nvJHawTevTqudTP1qyIDV5kB5L4pKPqTUrRUsooEPm6nFYcotyFxpTtZalzXGxuLDKa7UDY+bgu6OrrQZG1Fh4YVwmgUMRcEMXev5gPZsUjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8YYxhvZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mwR2yhB8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8YYxhvZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mwR2yhB8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792248529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ycK1hfInrWAuob/OJzi5liuKRYAR110GQUd0Dl9JT4=;
	b=h8YYxhvZ+klqO2wsS7SCsuKxytgdin8TEDC3hB7dO5hcJRv8ApVNr00ASYXuIhZ4FVWIOk
	JWM6i+mrOI6nL2pKMtrirNtqrf+rdCQI9YDMnCdC4EZuzsMKXoiBaVBAJRzJgi6Q7Ar5oC
	fhhrB99UAbVOKU7RVPt5Sez1+VvqoSY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-pv_LoIaWOv-awdwgWQSdWA-1; Sat, 17 Oct 2026 14:48:47 +0000
X-MC-Unique: pv_LoIaWOv-awdwgWQSdWA-1
X-Mimecast-MFC-AGG-ID: pv_LoIaWOv-awdwgWQSdWA_1792248525
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c42f98f354fso1256466b.0
        for <ceph-devel@vger.kernel.org>; Sat, 17 Oct 2026 07:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792248525; x=1792853325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ycK1hfInrWAuob/OJzi5liuKRYAR110GQUd0Dl9JT4=;
        b=mwR2yhB810IIeuLh271hyganFDEGKE/Imjam/DWVtpOjvNl/peSCXOovdayhhoYECC
         iR23dn0rrRItdLRzwtZpYsQQrCpRhAFZcMTmh+k81EtLg6j40+lVUP6yHDmVgj5xoLTl
         CCV362uHbBEyMNZx0HIcb509GsMnYdBNgntZfcUcpNpCGqHfDC5U/zQ5L2+EyVQFFdQD
         JSvYsjNlErEHqv6kSi/Tf3Ei/iAIOo/RekZBGlDjvSNZ791XOFR5Ump0D/5o0fGW/M21
         6eCKWDnPAAmSrtVFxTmzDTWnrLJ937LukuJvZyKebtex7FbYSd0U2yQKER6a2dMS/ZZo
         m4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792248525; x=1792853325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ycK1hfInrWAuob/OJzi5liuKRYAR110GQUd0Dl9JT4=;
        b=hZs5YkhrGk5Xg8TD47U5EYdT4iaf0IIu7Axf+MUkaj1R9qxxBsf4dhRPSSI4NqzmA/
         o6bLpYMfJlHwpxwHSWeQgMDN3o9vJI0Tae5QGlR5ITteFEx1Cp18LFEjkywgla/+CPm6
         f8ozElsy08rH3JnKg+0LrPcuTsmFtTS6+ZBJnJa1OrQsUE+LoLyt/JA0VduYTOqyrCFk
         U2RatVlHzuBhWj8KXKMdLes9cxk6wO2qD9toXwidC6kIoa09+ARNa+uVMKpMlwdOvueS
         q6DNVzmAbaMZKpTqtZSLl8tPQr+kINwsmNmsr1stMt3vQ2wfTdiM9uD1keBu1zLAkZo0
         U9hQ==
X-Gm-Message-State: AFq9FYLSnmLIM9IdRGbofjgcIj38QxufLsAHIC1I0yrLIAuLIvnhHRaN
	c4U53RgM8LQ4FnpqGgan+RiLQ64ZQFtKH/3Ka90Eatv/gek8mF6rP0FZoXgdJ97OMm8ktT6V4v8
	ChMF3S7RD7PwZGxi8oUWeDlP7ARLIS+ZUY2PhfvKY01H7/YcBo/LXwYn8R3XBI15ySXqdY5USjX
	BEBHnT9hfArYbyOS17BUkRvzfVllsi+z0dnIc7v8O7ATzed5aleA==
X-Gm-Gg: AYBFou3os09mxk2e/PG2rP79HyBNjCkET4UNBSvsgaEOWWGkzUBa7K/oVkGQBp60RKl
	bNZHpAtQSIA3SccUFJdGdHoCPpCNwzmv6+8O2facrEmK+i7dY3COtyHyjRRECyZTYRumzLlZhts
	EJy9WBvlGACdt9Gvf4dA3ucEMGmUsKVIwtNXrt+5TdDmMQgsBx+Y4rlhkYLTI8vmgcJJFsyYwpQ
	ktpF7XQX9E7Aq6p2t3Jtry3IST05oKf0K3Mr8AcaDg7IhegRpn8i+rhIlDXi7OxLYE0yXpU9x58
	XL+sZvJBGywHdvw+veZF63lJaCT+rSAwi91wWRegVKAicK36Mklsv0REr+S0GxtfWaWfpP4xRu6
	thk143kLkSdzjH9a/IVrMyzfrJnYA02uGFI4pRDvim5MEw+JwDVxmz3DjXB44RlsbUtPwz6aWhZ
	dCEWejkRdeu7zB2ZWZCGEduMMny5oNwtOUR+Nnb3dwKKwuRNNhd/mSg3htOPJN1oBfmS6zLJoyv
	Vk=
X-Received: by 2002:a17:907:c00d:b0:c40:80eb:c541 with SMTP id a640c23a62f3a-c419a05d6d0mr181164566b.2.1792248525320;
        Sat, 17 Oct 2026 07:48:45 -0700 (PDT)
X-Received: by 2002:a17:907:c00d:b0:c40:80eb:c541 with SMTP id a640c23a62f3a-c419a05d6d0mr181162766b.2.1792248524879;
        Sat, 17 Oct 2026 07:48:44 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32878bsm181645366b.12.2026.10.17.07.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 07:48:43 -0700 (PDT)
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
Date: Sat, 17 Oct 2026 14:48:36 +0000
Message-Id: <f93b4a902ed00af44019ca88eeffbf686d920e2c.1792248177.33a6e2db0a.git.amarkuze@redhat.com>
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

