Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29F948BD51
	for <ceph-devel@vger.kernel.org>; Fri, 21 Aug 2026 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787323418; cv=none; b=PNOL2j2i8WoRAQdGvOGc7ufDSOjIuHazCsAlxICLyjcio8ukoqm9tqnr+tbE3Giv45YvHUh0bcuH2L2dZ8tzeaf2Nt2aWuigjR+gry31TGQQ3W1jKFKLRGSo/Q5Ox7kZ69/QKqnJSq11nIGGF9+9d2EN0qjrsR9jcOuF6/dX2rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787323418; c=relaxed/simple;
	bh=dUjnDIh+EPPi0jNNexkxustlsejlPKjbUqBsKO4pBGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q20bN3zaXuJbvD3yusW+FJl/eebZJpfWdX5OHuTsqJr4pcMYTxXHGQeLfTbkGbXwVo9LN808+7Tq3u9OANbfjlF/KTPruVWUQHBTKU2g+pbB/2egLiQcHAYAs9Q6jPrApxfCrgvey0cJzUx/Kx9Qc8ShNgwuDCrYJ9S206HE/tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mg4rwei/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mg4rwei/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787323415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=diHx+7gEskOQcUcM4jLEzuiEx5++PzT8+hoKTy9o7GM=;
	b=Mg4rwei/MHE/aK60nooMYeyi5rc9K5HqIDl752yIZF1xeud/zaDDMZ24SrDcRkKdxtp20w
	ku9mRp8wVnLt8hYBYyZiXcWOMOKLyzW4vUaXDhZdv+Cmr7/TJOTDFsN6WXI1xyRxbVrUFw
	AAJwcMi8UQMHxgcgz7aBaD28v3SjHwI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-24bfmF5bMaWuH4DF_9fbzQ-1; Fri,
 21 Aug 2026 10:43:32 -0400
X-MC-Unique: 24bfmF5bMaWuH4DF_9fbzQ-1
X-Mimecast-MFC-AGG-ID: 24bfmF5bMaWuH4DF_9fbzQ_1787323410
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1ABF418052CA;
	Fri, 21 Aug 2026 14:43:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.162])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A2C53002D34;
	Fri, 21 Aug 2026 14:43:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Eric Biggers <ebiggers@kernel.org>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] libceph: Re-establish the FIPS keylength check in the Ceph code
Date: Fri, 21 Aug 2026 16:43:22 +0200
Message-ID: <20260821144323.776371-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When the Ceph code had been updated to use the libcrypto hmac_sha256
functions instead of the "hmac(sha256)" crypto shash driver, we lost
the FIPS key length check from  hmac_setkey() in crypto/hmac.c.
Since libcrypto won't support this FIPS check (it should be done in
the calling sites instead), add the check now to the Ceph code
instead to make this code more FIPS friendly again.

Fixes: 27c0a7b05d13a ("libceph: Use HMAC-SHA256 library instead of crypto_shash")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/ceph/messenger_v2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 05f6eea299fc0..378493d5d7155 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -12,6 +12,7 @@
 #include <crypto/utils.h>
 #include <linux/bvec.h>
 #include <linux/crc32c.h>
+#include <linux/fips.h>
 #include <linux/net.h>
 #include <linux/scatterlist.h>
 #include <linux/socket.h>
@@ -721,6 +722,9 @@ static int setup_crypto(struct ceph_connection *con,
 		return 0;  /* auth_none */
 	}
 
+	if (fips_enabled && session_key_len < 112 / 8)
+		return -EKEYREJECTED;
+
 	hmac_sha256_preparekey(&con->v2.hmac_key, session_key, session_key_len);
 	con->v2.hmac_key_set = true;
 
-- 
2.55.0

