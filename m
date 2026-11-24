Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.24.179.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540456;
	b=ao/EUZp7V0+vURHsMBt3owM72DopSfEEvRWwRMtvDlnVeFn19U0L9QQJuOB2nV6qBXQv
	 U/PBoOiCBtwvn/YRes44xhRg0WWPeTa23lNSUjMr/b8lYm3g0GadwA/yQ4kALteXcmshv
	 YUh/pT6YMRwym6y9pU/y6uERkGIHtCSBJv5GFcUPtx2Xz6dRkN01NS3iuQh9wTXospHC3
	 OxPEtqwzk6+hsFfkv/rxHef5C7qRfHZFwCaCh2qkaWraHhcM00XM+VfUywGSsuigh/JUb
	 P3H87nGsZ+vo8h2S/l2CuVyV8DYjZ1YKQZNbsHgxjhyQGawp6W3t6oDL+X7Le4LDvOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540456;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fan0saFP4w/1UtFKr5XdGFfwdaOOnh1MR0ouc5mn++Q=;
	b=wboFZ7MgiF8nZa/xF9Q3kY3ZHIhy96SmB8uHj+q2gCIFkXqV6qLIdextsaQy74/EjJfK
	 VwXLIxidY1DNMhM9PdefSuseJLSJX3dfCqQQ7DvJFncwt6zuvnAWFsW+10MmTafDQaQmR
	 CEoxKBWnbZJ83DSQLrhAmAvt95Zb8n/Vu102wMug7jZv9x8x/dg628517gUwkVE/kZvGB
	 cn6E+LGYjVFG6pgW1opnR0vTcOBsBNa80ArWxVv/1YxZ61Bc7oxKHM0Ea901j7OtVAngm
	 dsOsHzIYflZ6WWojVV/dFrL40uV6cLJUN60yL9I0VB/UtPvsXBcLsSWHD49506ti3Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=tu-ilmenau.de;
	spf=pass smtp.mailfrom=tu-ilmenau.de;
	dkim=pass header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.a=rsa-sha256 header.s=tuil-dkim-1 header.b=E0E6fMP5;
	arc=none smtp.remote-ip=141.24.179.34
Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D10A606A680
	for <ceph-devel@vger.kernel.org>; Tue, 24 Nov 2026 17:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D10A606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.a=rsa-sha256 header.s=tuil-dkim-1 header.b=E0E6fMP5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1795540454; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=4EOz1+2RN4s7MkrbiDpFM4nHh+lflLCcEvl8Z25UP8s=;
 b=E0E6fMP5CDSpiQgybDiiteevDyX4+HlnTkpD7OMKXG8IdVLo/r2dJBPq3ohBo6Ip/iJwD
 MIgEcbUptTNl7XNpAQNG3Z+39NwMFmtQOSIoVLy4xyCv+5yLuGv0MdgscRhh9JWQk4Fm8TD
 zcAqIWUP9zrc5aXIYjmyeV9u9PlcbDXoue/yHWZrbVt8GbTvbM5gJYUju9+ZjTqLmYuUuWL
 MBIRSJrIdh217nI12VZSk9oxItMMZvGnyBAomgdBTDwiRI7rcaNsUH2zQwvG7PIhLWFi6tW
 yTZALVY7zL5xk4bEaXtWnmSV02DhUL9AOE+0Nr30PTXA672Gv0bz+4VvV2hg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id CB35B60036;
	Tue, 24 Nov 2026 18:14:13 +0100 (CET)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 2CB8C5FB0B;
	Tue, 24 Nov 2026 18:14:10 +0100 (CET)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] rbd: Fail rbd read request on overlarge result codes
Date: Tue, 24 Nov 2026 18:13:29 +0100
Message-ID: <20261124171329.387727-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
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

This patch fixes the issue by removing the rbd_assert. Instead, the
reply is treated as a failed request, and the request is completed with
-EIO.

Fixes: 54ab3b24c536 ("rbd: get rid of obj_req->xferred, obj_req->result and img_req->xferred")
Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 drivers/block/rbd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 1f1c2810f6ee..52933d04e35c 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2898,9 +2898,7 @@ static bool rbd_obj_advance_read(struct rbd_obj_request *obj_req, int *result)
 			if (*result < obj_req->ex.oe_len)
 				rbd_obj_zero_range(obj_req, *result,
 						obj_req->ex.oe_len - *result);
-			else
-				rbd_assert(*result == obj_req->ex.oe_len);
-			*result = 0;
+			*result = *result <= obj_req->ex.oe_len ? 0 : -EIO;
 		}
 		return true;
 	case RBD_OBJ_READ_PARENT:
-- 
2.47.3

