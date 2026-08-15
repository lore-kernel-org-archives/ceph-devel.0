Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E11AAE17;
	Sat, 15 Aug 2026 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786830455; cv=none; b=VURpacc1E4TwTQfTtPbLKQ4A2a0u6J8xFbUXt4VYSLxPOUOjz6Me2n6zR+ayoc2aMKUtsIWSdnWOl55sRoHBcLpWKRyqZK1aD3iuytHs4Y2Uf79EGxRFywxEPw7JK3At4dI47BeDf6vXR4MLbVUQjcOAB8dTpMqpVn8XqADgpag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786830455; c=relaxed/simple;
	bh=HouKsMFIJ8sRiLHwkAQ0SwErECri/VP48EHO7lHubZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dPbW34RKkRIVHZ0LDEBpiOAOddO4zxayR6ddMnfM4ucYWc3RXQfc9cVSuvH32A4M0JlP9PvLtvdxoFPrAmHnHYPfMsM7rliQ48SuCE+rj2534tF2uyfJpcG/locvy66x5Z5zLVPlL7Upp0p6p6ITr7mzvgp7tQPkLC0rOkSg/Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=DaWwG4nL; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="DaWwG4nL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MJ82pnxCBak2LEmofTlMja6zrnfJnVH/u1eSuMJvJv0=; b=DaWwG4nLs1GWvre5Zwkewy39B7
	PLtPX/3qQS+hydTcyvYzkl3D9q53yAJ3Ei5+QTg2rES2Gigi00gwz+fw34gPR1XI8ntFt/NN3j/F6
	JZVVXzT5/wsdZmukM9ky6Ql0J+DNUqrOPMpBpsp9SL1mtxr8INW9ADnjWnKNqPTzLgfe3Dwzi4KgK
	HNjcrS2V61nt3RIviyVwAdQM+l32+IIXcnMt/91mk8NwhJqzVwccCsPTFwNEGqhSUwXkv2yx7uH3a
	R7TkRHIjYSq/mzVIbyU8pRIIjrOvA/jm4dN/9uUbAD70aeOsh6SIaONTMkZHVX4V9o0tvjeN5ScfN
	9GywxSmw==;
Received: from [151.115.150.205] (port=52920 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wvME4-00000006LiR-0Z33;
	Sat, 15 Aug 2026 23:47:31 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: idryomov@gmail.com
Cc: amarkuze@redhat.com,
	slava@dubeyko.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] libceph: reject buckets with mismatched CRUSH ids
Date: Sat, 15 Aug 2026 21:46:37 +0000
Message-ID: <20260815214636.269617-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

crush_decode() stores bucket data by array slot, and the mapper later
derives the per-bucket workspace index from the decoded bucket id. A
malformed map can therefore make one bucket reuse another bucket's
workspace by encoding an id different from -1 - slot.

For uniform buckets, the second replica selection expands the source
bucket's permutation into that aliased workspace buffer. If the source
bucket is larger than the aliased bucket, the write runs past the smaller
permutation array and can escape the kvmalloc'd CRUSH workspace. KASAN
reports a slab OOB write of 4 bytes in bucket_perm_choose().

Reject buckets whose encoded id does not match their array slot. Valid
CRUSH maps already use the canonical negative id corresponding to the
bucket slot, so this restores the invariant expected by
work->work[-1 - in->id] without changing valid map behavior.

Fixes: 66a0e2d579db ("crush: remove mutable part of CRUSH map")
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/ceph/osdmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index a4b0dd8672ec..9c89f6602dff 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -517,6 +517,8 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 
 		ceph_decode_need(p, end, 4*sizeof(u32), bad);
 		b->id = ceph_decode_32(p);
+		if (b->id != -1 - i)
+			goto bad;
 		b->type = ceph_decode_16(p);
 		if (b->type == 0)
 			goto bad;
-- 
2.47.3

