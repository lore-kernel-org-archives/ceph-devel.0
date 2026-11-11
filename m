Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413917;
	b=o934CuHf3e2U8tx3aZKOMYan4JYqJQpBq48v2VlTWrcdzuE4KHOXAZkZtjfc+UsuOd+W
	 9x9u3jVD+u9+YB1wuPyt6oBSpmFWZnJ05mkJiUNzgdkC4ueJ+M623UEIZVMoWd7WN8nns
	 upZ5nH7y1q8/qpvTAATk+fU+g0wUvIVonP/Cs8kBI1PZM18ROORp8HrDksBk//0J89GQX
	 MyX9255LGu5w0aAB9KezSDiuaiCUonBfGDK7F+8WjBpQykx23AtjYCbNBNzLLZydvpcng
	 Ry2rNt2OT3WPmSOyrnN4FBTHLyCqNCL2Ye6i57ce9ilGhT8mPWYCLfSo/ts8CLw0BdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413917;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PywhPEppgcWI+Me/jVt+CP7Qe/6FQfOUGlT878EeRYg=;
	b=EKNmYJs2ZmEy1QWdO0LLaxOjqE2oGK5d01gJRmeg3FlTBtRhkIbmBo0r+EJBZdtB9x3/
	 u0D3x45APzhlLmqzjfPX/0/o5epCCPS6pEJUbLLRovh6HI6Zdrneunmjm2aPN9fbXuG5s
	 O2QruToBxhLWshh2eceXfZJ04EjHIsc9Go9bqmgPm9U3Wl6lJnP+66aMKzrfGuxx2Vqej
	 SIgjE2WS68JFRxxwVky0FUjg/HCGYiwbL4wwKXWUTL3G/1fwkXgY9x+vTXyeT8bgVLii0
	 auF6J6kCZj8Ts8suxqKgMsL6xqAZt5BFvtSI6gJ9KGWY8R9PG1Z5t7QMuUs5tia79Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=MAULci7y;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5DF606A32D
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 16:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA5DF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=MAULci7y
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a215e64962so37528845e9.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 08:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413915; x=1795018715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PywhPEppgcWI+Me/jVt+CP7Qe/6FQfOUGlT878EeRYg=;
        b=MAULci7y91YTKEUFyO/XThAFj2Pe9m5tWcxpxxpPKFaUanSCNrn4fBmKilzd34WSVy
         F1Rl+ozGWD4G5Lrf1+qZs/31vD47Do6X0Px+St1/m7+GMjp3+b06PHGA4G5TDoTHc/Jk
         PlHZOdI0PvQpwMieLqh8X1C8gG6fSmoMHQggRwuvU52FLa5qfw0OX9eY0mWZP+o9x/P4
         7JTJKsWSfHwz1gtTy4+jlmc2v9A4mBHhfHPcwH7NN3ZzhsfHHyk0JVkRMgcdvvnDj6p+
         EmpBTZrZwmTtWi9pjEBzEpowQ4p+LvPs+JzZi0RuNSyAKMd8KZPs4UGDT1678uLXaDDS
         HFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413915; x=1795018715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PywhPEppgcWI+Me/jVt+CP7Qe/6FQfOUGlT878EeRYg=;
        b=QL4+z9ilP0OERqYk54XDfFalLGXU01l7gRWOnT1/SiF98fxCL389G7yj2voch1Wgnh
         XHTUtNqsk7sh7otRdFCWqhaPu7gS7pjJPzUWxgm9MCkarDhkcY98KThZ//ut1y0SMFXa
         RB2g/UXi1Aop/X89r2O2ylemr4KbDesZEdzL4kmCU/KqOA77xFzNLBIVHYInqup3cSqr
         ZwB8AHbvQIgKavwdpQJjr6tqbnXPEP51HOSar3B9n9zKdfpXj6dX3F9rRyT3jfz5WGyi
         PFBjduXnFWNxCqLllkerLXia8l48b7mkYfResQxKlN7Ig9x0uSu8WYrOlsLF1PbPAc8O
         MWyg==
X-Forwarded-Encrypted: i=1; AL+hErH2+6GYs9/LhMA0KxFdoem2e5469fE6lfXv8fKnUmaiHlHkAI0CpYrD53cUopqUK/OsXKghWEvgtGcS@vger.kernel.org
X-Gm-Message-State: APuU4Z/dN5+djXua07di9Li/4yiLOY7E8C+rwyAt6RKEObA9rgR52kFM
	KZB4OPyGDp0k/bZ+DDjNcy7Wfqtaf+EXyx5m9MSZy09pN3sDrWsP2Hx0oM6kvKJgxTg=
X-Gm-Gg: AYBFou2U2+vJ8szH+mz5PWQpqhsd8EXtpQHusG7jfrUM6NJPx9C5K1hxBD2OBRQURjg
	w/UpIY2tj7AVRtr1XotngH2w54AMpVgGaaGwg0a42pmxNK7bscDCGtavtkXptW4JRnzDkOtjTyW
	CbsH0Vu9QYP2n5Stv6eJHsu8a3bqtxP41RTbZI52/1y74Uw56cmHDqmirgBsMeojA4F+1b1cXKj
	rap1vLy45SynEa+8rDnv2ULR2RgTgxgKwKNBOhjhK9ytKG27dWuVkJLqOxAXp/3nrsKWfOefSAS
	8fQvrAIvcm2LkDN/ZPBXSzzuGh39emPYUa4epmq/VEKkjCrH511b7KBHTuWOKUn+tPf+4d6rOuV
	kFybEx3ZjyyHzN9sXYz6vRnwd3bmvzfVaRfN1HO/7DyRsAUyWRHPbaFRmoz4d1VhRpd/z/uRGWU
	d2unpGqg8ffZRafQvGLfFUbVUyx/67xWnauhQP/P6IroXDTv9RJYAEqFFwDq6160VckGYOaoQJJ
	hI85iNf8is/Khwssi2yLwerHyXd+7C1ZtB3SCHxPccyy2+YiikdzE6TKeZk6psBApXjm2eoioLP
	UCENnKLbTy/Ngk/x7aBDJVISIwL0nScVlbNVCdl3xzqFPTF4pJTsbjag8W/wK2Uny3aGEmHKiqm
	tYPiJ0RnRT32WfUJjvS9/F51tibAjkQ==
X-Received: by 2002:a05:6000:2008:b0:48e:d88:55f4 with SMTP id ffacd0b85a97d-499c38bce0cmr5171391f8f.2.1794413915273;
        Wed, 11 Nov 2026 08:18:35 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:34 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/9] ceph: fix mdsmap use-after-free in ceph_statfs()
Date: Wed, 11 Nov 2026 17:18:22 +0100
Message-ID: <20261111161830.1336485-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_statfs() reads mdsc->mdsmap without holding mdsc->mutex, but
ceph_mdsc_handle_mdsmap() replaces the mdsmap and frees the old one
under that mutex.  A statfs() racing with an mdsmap update can
therefore read m_num_data_pg_pools from freed memory, and then load
the m_data_pg_pools pointer from it and dereference it.

Any user can call statfs(), and mdsmap updates happen whenever an
MDS changes state.

Read the data pool while holding mdsc->mutex.

Fixes: 06d74376c8af ("ceph: more accurate statfs")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index bb5591c1e154..01f92d77ef45 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -64,6 +64,7 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(d_inode(dentry));
 	struct ceph_mon_client *monc = &fsc->client->monc;
+	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_monmap *monmap;
 	struct ceph_statfs st;
 	int i, err;
@@ -73,11 +74,14 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 	ceph_blog_enter(fsc, &__ji);
 
 	boutc(fsc->client, "begin\n");
-	if (fsc->mdsc->mdsmap->m_num_data_pg_pools == 1) {
-		data_pool = fsc->mdsc->mdsmap->m_data_pg_pools[0];
-	} else {
+
+	/* ceph_mdsc_handle_mdsmap() replaces and frees the mdsmap */
+	mutex_lock(&mdsc->mutex);
+	if (mdsc->mdsmap->m_num_data_pg_pools == 1)
+		data_pool = mdsc->mdsmap->m_data_pg_pools[0];
+	else
 		data_pool = CEPH_NOPOOL;
-	}
+	mutex_unlock(&mdsc->mutex);
 
 	err = ceph_monc_do_statfs(monc, data_pool, &st);
 	if (err < 0) {
-- 
2.53.0

