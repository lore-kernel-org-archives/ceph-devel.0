Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868463563EA
	for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2026 07:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773126348; cv=none; b=Ke/yt+HPtjGBY5lbCWxKMoyeNa4Eh9ZW1aU3izsuSnelgmOuU56it722nr+ClT2Hbk/6ALF+camGLm9yp+O1bxFjE1qGzDLN03dovlIz0RbDrRV+y7QtHtqgQsJC9xFG20dFfZul6f+AWSGXWH5DbpkBQXNEMUfipoipISPStRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773126348; c=relaxed/simple;
	bh=iggtEXoHUNyekxUUQG/KpQRX0M8T7/qRaKgbu6CYIrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p//3pHUEhL3+V/7ga5fORNaVQkkzGAXHAzx4ir3pUcg2tzz/NC7dzKz4pksR5IH+AHMDVFzXM+BtjxgR/HgNkU/RsI71nseK0tKRGLjR6qrJVNTUv743sNxbx2qqrwutpXD1OkC4+LSY66V330yZdql+ZdnfM9xhzas3GhC6VsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bdsDmVim; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bdsDmVim"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773126344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kmHhk2tAsraAOwIlwoml7RJD/p5Cs1noCNuqu8RhOgw=;
	b=bdsDmVimxc8PdRRu0yU/+3SSUEJHr2PSR/pYupqFJiYrkb69KS53bW7Lg+LU5IgaNFaYHv
	jDCS3NPk5WQAaIkCFsJ2grjAc+gs2JH/VaopP7iFlaIussZFdCWSiwn3w9x/f8TOuCSOUa
	wOLZFNsAlEhPhZIlyNeRtVKiu23pWkQ=
From: Dongsheng Yang <dongsheng.yang@linux.dev>
To: idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH] MAINTAINERS: update email address of Dongsheng Yang
Date: Tue, 10 Mar 2026 07:05:14 +0000
Message-ID: <20260310070515.518225-1-dongsheng.yang@linux.dev>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

My easystack email will be unreachable soon, update my email address to
linux.dev one.

Signed-off-by: Dongsheng Yang <dongsheng.yang@linux.dev>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 55af015174a5..0ba9a0509cf0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21955,7 +21955,7 @@ F:	drivers/media/radio/radio-tea5777.c
 
 RADOS BLOCK DEVICE (RBD)
 M:	Ilya Dryomov <idryomov@gmail.com>
-R:	Dongsheng Yang <dongsheng.yang@easystack.cn>
+R:	Dongsheng Yang <dongsheng.yang@linux.dev>
 L:	ceph-devel@vger.kernel.org
 S:	Supported
 W:	http://ceph.com/
-- 
2.43.0

