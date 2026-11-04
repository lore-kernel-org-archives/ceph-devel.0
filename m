Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.24.179.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806682;
	b=kOL/AaAw3FKgy6rJX61B6EHg9rc+qcQsUTXGvMI3vxjwQbZo5c8aWN2mI32+AlaBMJsN
	 kGvupby0YyaRzNu2NWlI9fBaaqxOUWka3uwr93TkarzvIgqTYaXAkMzWDfzEBDvvAGc1h
	 nC0eoFi+t0OY/ucleQX9GcrfMm+Q4Jecnhec9h/LQynkQlkQnStiawCzxROjUdnD9s+eZ
	 SjFgmkg12i+pi9ozaUoK5vhvh9iC6JAVpFX84KosBjI9n460fOP7iFNtDY3r61EhaOLJ/
	 suxj/ABkoqpfvdb9aCriBbMWnPyEd4W61lDzkosQiYiEkBBc5fL4QlA1BbEtH58MuMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806682;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QuK7mgvejOOJCQBlyl/41nI1hQaCEa/xsqXySh7IhyA=;
	b=zXBBqD7eP/xEF/BUGBi2covpZYvDF8arNWfQkzKLzV2hvpn+sfh/dCF+HKnpNZEBXw1S
	 7Nu957wHdmLHyTH8ZOG0oBU+Rw8ZGmkUI3D49BcI9WiRc1v8oDve5K9YxEUP3uMSO+KQW
	 GSF4dorifAQm48OD2E336qOOkINaGfRRmZEl+ciPOIW9j8SJA4fOnRHyrR2kewR/InCjn
	 W9Qokl2Ix/zl482vm5W2VsN8c3JCV5bTXgdZj8gKBiZNHtpCm6rydQVijEthh25bs+0Vq
	 +azYETB3gR8N7GgWu9RfnUHWZmkzpV4Stwie+dopIZ57a9JuDy8UhJvO1BAmMw48QLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-ilmenau.de;
	spf=pass smtp.mailfrom=tu-ilmenau.de;
	dkim=pass header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.a=rsa-sha256 header.s=tuil-dkim-1 header.b=wTrYWAuw;
	arc=none smtp.remote-ip=141.24.179.34
Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846B606A339
	for <ceph-devel@vger.kernel.org>; Wed,  4 Nov 2026 15:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8846B606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.a=rsa-sha256 header.s=tuil-dkim-1 header.b=wTrYWAuw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1793806672; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=1HmsgZSSnC8ugzVfFMOYHCNmUo4yPqYxAyws1IVWADk=;
 b=wTrYWAuwRTgrMZ1yd4D7QFyV4/SICm3f0gVyhK0yHrjqpKuKzyw/tVbO8uCczTdwcL+wo
 CcKF6q+BKgIyEc4TGGpkWLBCESelOvi1AW/C2HzU1yGXP296thvWszW+PZG7BP2URfa9ePQ
 IhQHGYCSDBWfYs945r6kDNUYsvx5niU5enFCjroVc1yyLhb9PbFJ7rwzpa4YUONwZmVW8L+
 mT+gwH7EorAtAbdH9Psd4sXxtZ+igtc6h+yZ/Av6FeN5o7Y7upVKbgVmHA8L5yZNWrFtPKj
 UsXwNopn1hMczUae/fifjk8YAp9HpFPYJwbxabJpBVbm3v0MjOqr86EsFKHw==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id B50225FD95;
	Wed,  4 Nov 2026 16:37:52 +0100 (CET)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 932F95FB57;
	Wed,  4 Nov 2026 16:37:52 +0100 (CET)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] rbd: Handle overlarge result codes in rbd read replies more gracefully
Date: Wed,  4 Nov 2026 16:36:59 +0100
Message-ID: <20261104153659.1117700-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <282b8983-82c7-430b-9c92-d3810bbb765f@tu-ilmenau.de>
References: <282b8983-82c7-430b-9c92-d3810bbb765f@tu-ilmenau.de>
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

In a reply message to an RBD object request, a positive result code
indicates the length of the data payload. For reads, there are two valid
cases: 1) smaller than obj_req->ex.oe_len, if less than the whole object
range is included and the remaining part shall be filled with zeros, or
2) equal to obj_req->ex.oe_len if the whole requested range was sent. A
result code greater than obj_req->ex.oe_len has no defined meaning and
currently triggers an rbd_assert. Consequently, a malformed message can
trigger this assertion.

This patch fixes the issue by replacing the rbd_assert with a
WARN_ON_ONCE and subsequently treating the reply as if the result code
were equal to obj_req->ex.oe_len.

Fixes: 54ab3b24c536 ("rbd: get rid of obj_req->xferred, obj_req->result and img_req->xferred")
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1f1c2810f6ee..609723920c7d 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2899,7 +2899,7 @@ static bool rbd_obj_advance_read(struct rbd_obj_request *obj_req, int *result)
 				rbd_obj_zero_range(obj_req, *result,
 						obj_req->ex.oe_len - *result);
 			else
-				rbd_assert(*result == obj_req->ex.oe_len);
+				WARN_ON_ONCE(*result != obj_req->ex.oe_len);
 			*result = 0;
 		}
 		return true;
-- 
2.47.3

