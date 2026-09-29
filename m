Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019A33D3008;
	Tue, 29 Sep 2026 02:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650510; cv=none; b=OqiRH2JdvktD6o+ADiwo9I0W1FiGpzKuVqsn+u/oXIdRYI2n7rugQu/ChdLmFLfLXEA2tprupDzvY9nvBn4N9VMcMN//Z/M06BU5R7VxZJhth0YNB3QrODL4Ge6bF7fSxhtlLwpot5R/6nmRaB/0j6oPsw6hwJXpYbFr1K2osts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650510; c=relaxed/simple;
	bh=sygQ06F2hFXh8XvZXrqQftl4LAj2t2bf5goVwfVGotY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqZUoUj5noyObTdBcPQ2Jj3/y+tXrzInr5IoAe4wYL94L/Rz1R7vAIylGA2BOCwAAsP1dEillDhKMDdMHphkuOy4czG7eiSpFB1ddYmYVJubYdKYiDoFxzunbyeeekZYnrFkXtjzNZuebtg4Ou+VNzSUhnq56x8PN1618jy3cbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Q9ID0y6T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A/+loNJq; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Q9ID0y6T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A/+loNJq"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 06EE17A0159;
	Mon, 28 Sep 2026 22:55:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 28 Sep 2026 22:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790650507;
	 x=1790736907; bh=Y2CAaOSvL2LG+otuqBqsqfPGtGbUIxG8hhL/7mv+bGA=; b=
	Q9ID0y6TMl1EcToUZ8nv6kclZu/N7s7sSav21h6dV9MxNTbUwGIBUVpwSGp1Abw0
	1zoGOxemjKCtGbJnQfDqtwyzL0W7tnBiGkBbyasLUPUXdPx6Uk6Bnc1XAVYki3JJ
	htVWJiH4q/pN4ljBamNZ24hnruYyPtZSVvac5LaouqT6V/coY3LEWHrNJBBZTxii
	b1CgB02+OtDKdexKHIHoHNYkBHldU0uxCcLdD4Oq7TD8OfUErnB9NPfP+WFDelW+
	nOj7GDNK6HPoaOByBBOInuUt4G78lgbPTtkt+FlD4tYNJFst0t1NezQeSVkR+UYX
	Pr0XHr0BPEtGlM2UIX3h0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790650507; x=1790736907; bh=Y
	2CAaOSvL2LG+otuqBqsqfPGtGbUIxG8hhL/7mv+bGA=; b=A/+loNJqazHlXMZ4y
	5VlHaAUC3hH2Eqr86oE9YQXbabg+Rdzo6WrJygBRvPvUlON0gCDNxYxlq85BZC37
	zNskR099JOig3DDP5VsvqmRiF8Mxsdta6nhtkf/r5JRu7aAfg2/0Ynwj7VQ4gTWt
	VWMpaEwyeMCOyuQbTPA00HfXRXJf9jCy2CetZ6FqT/HdpvcY0xIy/EXo721KNqCs
	KSQzRQkMnLCwarx4utBxdl/N1V/5XieMKC6loJZHTOn3hqq4HGvIhkFqJWnDIVgx
	72o+p/CGOqR1qN25RfnxsmyKuaanWPND1Hdza8c3a6nmWYZF/8Tvzo+FaiVz00bB
	ZmOkg==
X-ME-Sender: <xms:iyi7agcib3Usx4utcaJVg9gHGL3af-70mlmJheL3mIFslfIr_sBaUQ>
    <xme:iyi7agdN0KvCX-fKmybEBjivqgS_zgMmiqZywCM6GWh-Euj3PnQtNsyUrNHopDWRI
    _tkM096Ov57CO0yUrAY_-Fc5UAM68Pm8n55U-_2yhPdDFx-xeA>
X-ME-Received: <xmr:iyi7aq1Zp1hn8FAdRJ4IJfQKNVaMSIRg5qpRVgcvDNEbi1btgC4XLJCqL0XecvQdsH3kstdfyouRswK-ZEp1lffW-aOSxa0>
X-ME-Proxy-Cause: dmFkZTFiR4XwcF2PjlJD6ACpJ0X71uQ668i1UfQsmZO8oiQ07LGkaOjKpM3sR5BMN4ENKd
    qeRriSl/f5Vk1m42XRODgz3VYoU8DaRJQdCrNxfWWOzEvoC5JGIqNjRI+CKxEibVDMtTNM
    DvODvmmLAQ+yj7DePu0cDCUv7wnQM4GireeYcl84nZ+UjXZPy2J5tNpHpGwU/Qr2Ob4Vq9
    FfHvdC80cJAMr1ZhJ8354YIhQOtRwDgZucxNxrxMrCU9uv8UsO7nRFntLonCmk5QuWC91X
    83S/E0DIgDH9L70Ch7GTvxkEs3nEKcjK86TVStV0HOB43Ehde69jZrIkl2ecTeNr/J+gh5
    8/a0g5YpoxGFU0PRzBW0JhscFHywsUPJhpNwin2xh6NNMBW4RLf7u9OwaC/sHZCAdgaaN6
    qYqNnCp20IZNXRXs4h9PnUu7GFtf2nQXdF60vsmAh6AJ321yXX1k8zxr1A2YsYW76R19Lv
    LP1GPledBwt3dHWrkWkGxa31XYg634RRxt4oid3+0PWKg3dY5FP7Qqnhu2CtHBr67ZCdZ3
    l82LIfSSBB6uaeJCIS9dp95a576ciW4TxLflptq5dA8Z6aBCKb+41nYdY8MRR1BZ3uvt7k
    WHzHgFpgTcjPZtpiEcPqsO3VzZsoFhAsHJSq55DYK68mqMcf3eCMJ0NPjLXA
X-ME-Proxy: <xmx:iyi7ao9vM8JHGPNk9QafNSnqYfBe6NWRvLb-rTJtzTmbjulhTZLpOg>
    <xmx:iyi7av4UwI_S8wHtgEVE0TbeH4Ut2JCkd3TUlBmoRCXKdZJJVvV8vw>
    <xmx:iyi7aguP_iLAxVJf4VYF57xz7QpXyURxpUN84GZkfofORd4uILc2Dg>
    <xmx:iyi7ah0DXMs1dK6RzxGE_EHx_kXgSJUCR9E8ORkCEZKLql4R22LcIA>
    <xmx:iyi7asxepMd_XcNJSoKtBGFqs4i9G9GL8R0-i_B3uF5feZ3lzieTQPxm>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 22:55:04 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] cephfs: stop using d_add()
Date: Tue, 29 Sep 2026 12:47:41 +1000
Message-ID: <20260929025331.1436824-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260929025331.1436824-1-neilb@ownmail.net>
References: <20260929025331.1436824-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

d_add() is being deprecated in favour of d_splice_alias()
So replace all uses in cephfs.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ceph/dir.c   | 4 ++--
 fs/ceph/inode.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 2e5c0ccb1b34..35c18020d0f4 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -779,7 +779,7 @@ struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
 						d_inode(dentry->d_parent);
 					if (!parent ||
 					    ceph_snap(parent) == CEPH_NOSNAP)
-						d_add(dentry, NULL);
+						d_splice_alias(NULL, dentry);
 				}
 			}
 		}
@@ -853,7 +853,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 			doutc(cl, " dir %llx.%llx complete, -ENOENT\n",
 			      ceph_vinop(dir));
 			if (d_unhashed(dentry))
-				d_add(dentry, NULL);
+				d_splice_alias(NULL, dentry);
 			di->lease_shared_gen = atomic_read(&ci->i_shared_gen);
 			return NULL;
 		}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 01c468a509e2..07868fcfc6cc 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1813,7 +1813,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			} else if (have_lease) {
 				if (d_unhashed(dn) &&
 				    ceph_snap(dir) == CEPH_NOSNAP)
-					d_add(dn, NULL);
+					d_splice_alias(NULL, dn);
 			}
 
 			if (!d_unhashed(dn) && have_lease)
-- 
2.50.0.107.gf914562f5916.dirty

