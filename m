Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9AA23EA89
	for <ceph-devel@vger.kernel.org>; Mon, 11 May 2026 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510471; cv=none; b=tt49MffaqUVyvUxLDiRyOlBJqEgcp90rAlUi2ypi1PXjcVP7TV/Fq8rPCGavXec0LZLa+nzR698M9XQQoBstMrRAKAHik90Tqd3B7kJp2ko65qap67sHQOTEMRxp7bnDO627uCJG4OTyHvvXk1gqoKUn8aOPwHHpQ5JU3o0Ta40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510471; c=relaxed/simple;
	bh=I39xEGvkeaPmDwya7D4AzT6W/0V0V5Zi5HohpzlcU+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhdXqGZsLZ77c828ZkEGPVNjcW1vRheZjiMFkc29BtKWnIXqistEmdl7gBH3lMb3d8ncFNRrwiaoBWcgZ8kNmI3ThaTgCH2da3dRoX8UBUDRtM8Z6FYpK5zWE1yJbIJKbJR+Mpk3KEQuQWTsTcuQJiOS4Dx8sT2H3JVjz6mfytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=zABDMCAJ; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="zABDMCAJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1778510459; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=I39xEGvkeaPmDwya7D4AzT6W/0V0V5Zi5HohpzlcU+8=;
 b=zABDMCAJ4rQQkPZnGHUoN8F//wEcJecUSaKBXapuPfXs7Mw+xOE4daGMccKITnT6XLsOZ
 EHLNo3DpbNQYdLWlaKXVKfqVybiuOGnXT+s4lXQmrCEu7tag1hiSAstGraQjanGQsj0iF39
 NCATNC7Q4mcrTpjDrmQsVwmwsEmg0pCQaAFhdz2CMfOqDr/NyFQ3JTMlwdFjGfrWRtFAJfL
 wxQXXLLt6M+Yuhcgs8gEr2UaT+7eDPe6Q0corjogJKbIDj//nU8p9crNEii50qkW68HoO5w
 io+pHY7y4/JbnBYtNiC0RsJZS8SY4l6GQcPbgvqIHUh7Q3a58M6XCrxXG9iQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id B2E595FB7B;
	Mon, 11 May 2026 16:40:59 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 4D3985FC03;
	Mon, 11 May 2026 16:40:58 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: Use non-asserting rbtree insertion function in decode_choose_args()
Date: Mon, 11 May 2026 16:40:24 +0200
Message-ID: <20260511144024.1267287-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A message of type CEPH_MSG_OSD_MAP contains an OSD map that itself
contains a CRUSH map. The received CRUSH map may optionally contain
choose_args that get decoded in decode_choose_args(). In this function,
num_choose_arg_maps is read from the message, and a corresponding number
of crush_choose_arg_maps gets decoded afterwards. Each
crush_choose_arg_map has a choose_args_index, which serves as the key
when inserting it into the choose_args rbtree of the decoded crush_map.
If a (potentially corrupted) message contains two crush_choose_arg_maps
with the same index, the assertion in insert_choose_arg_map() triggers a
kernel BUG when trying to insert the second crush_choose_arg_map.

This patch fixes the issue by switching to the non-asserting rbtree
insertion function and rejecting the message as invalid if the insertion
fails.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osdmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 2095e73ccf6c..d160c7663aca 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -392,7 +392,8 @@ static int decode_choose_args(void **p, void *end, struct crush_map *c)
 				goto e_inval;
 		}
 
-		insert_choose_arg_map(&c->choose_args, arg_map);
+		if (!__insert_choose_arg_map(&c->choose_args, arg_map))
+			goto e_inval;
 	}
 
 	return 0;
-- 
2.47.3

