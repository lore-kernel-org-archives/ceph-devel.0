Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9E45FFB4;
	Wed, 23 Sep 2026 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195180; cv=none; b=AhVYFBw+ZnZozfQ2UVjXgSt64FpaZTFFe9fAV0hC70VL5tQg+vnHFDjJ843/z0boxn9L3MQyx/LOxvQKuj8CiybI044xdXSnBFTFdxzRZ6GiSOnz7Z3fjJz5uILp1gHf+VO8jg2LFHyaBLnClurH2CM/DmyxaPNcc9NYqlXZoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195180; c=relaxed/simple;
	bh=BeUJaTCfgIj8BZ6FdXr9MoLlNObkrT122Fjg8/KYXwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sAiqi9PVCyrWWwtZaAKkDXTUSFvlLVKKEKPNpjw01er/uesLORrp/MUd2F3tgwPmhDb4bcoWxO+0mHcAxB+8sTtDtjdBMdZr1y3vi//i4oM5fZJeqy8zpmXe21ndKSv6UV82zki+ucXcKJfkRWOJkh811E+Yxsvp5tXHeNwEWXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=oP502kg6; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="oP502kg6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=a38mzazAkyWMrrDIKKlmnfGoWOos0nEFEWd07GEaWcE=; b=oP502kg68kppMPysRUBKB0Gu7I
	48E+HVnZMYwQlM1gIlMp8fkYDcbFHqp57kRVQs4nPKOdpWaMpyKeia/FuXRV6LuxzPiQuKSIPnAou
	jnI6VZcRFOn5Lr9pQWiTcw1ooZjIBE1+TATb9ADL/YtcwiO0m+1qAq/93TAlRHN9cXbAHBGgkfU/Z
	UvskNKE0dL2mpllUOR9hRtLzYvCpjb4nIwwAntZy7ux4p1sVc9un2pZx2aikshj36ZL6zFAvmCb0N
	JeAyQCwgIy/AK3n88Kcg9c5zgXU+H/I0jE+cIZpSn57UJ74k0mD7MnjZAqaoJf90rcUHG4lNgevAK
	sWv/2law==;
Received: from [151.115.150.205] (port=41082 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1x9TXh-00000003FQb-38Wp;
	Wed, 23 Sep 2026 22:26:11 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] ceph: fix 32-bit overflow in readdir reply count check
Date: Wed, 23 Sep 2026 20:25:34 +0000
Message-ID: <20260923202533.2229953-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

parse_reply_info_readdir() checks how many entries are in a readdir
reply by computing the end pointer of the decoded array. That pointer
addition can wrap on 32-bit kernels and let an oversized count pass the
check. For example, a count of 0x40000000 with 156-byte entries wraps
to a zero offset, so the decoder can write past the preallocated buffer.

Check the count against the number of entries that fit in the allocation
before publishing dir_nr. Reject oversized replies through the existing
error path.

Fixes: 54008399dc0c ("ceph: preallocate buffer for readdir reply")
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 fs/ceph/mds_client.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 085ae0c..cd928fd 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -479,10 +479,8 @@ static int parse_reply_info_readdir(void **p, void *end,
 		goto done;
 
 	BUG_ON(!info->dir_entries);
-	if ((unsigned long)(info->dir_entries + num) >
-	    (unsigned long)info->dir_entries + info->dir_buf_size) {
+	if (num > info->dir_buf_size / sizeof(*info->dir_entries)) {
 		pr_err_client(cl, "dir contents are larger than expected\n");
-		WARN_ON(1);
 		goto bad;
 	}
 
-- 
2.47.3

