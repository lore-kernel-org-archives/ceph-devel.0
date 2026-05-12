Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0EF40B6F6
	for <ceph-devel@vger.kernel.org>; Tue, 12 May 2026 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778570997; cv=none; b=OSYVxJ6Z78k8xFeGfmQiWOsLBIBfApDOT045spvRMKyf4LgCT/vc7JFmWvH9C5llchIO2NiXR1QsbWKYpplxD1ddHrSkEMIs6cv/xwAmeEVyyJfAKpa/i32BUFEoqe4ShHe1WMImbcWRrNrmogKIXqOrs7BdULfn0vvZaeGCAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778570997; c=relaxed/simple;
	bh=sQGGUBWjyMyKoPn4laR0S4T6pgQGPiqKdw5XV2g6T6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hZJRYwTZe6+KaDpFdV4Q4AaK7e9tIV43TfPFCz9qI34amK9yeLuwh29329/OGbNnL6hijSZXu1cw6w/3MEI4xqiyoYeiFAqiT4vQz9/WWtkDprXPmyryOgADcRjp0ibfywut99eTKjcXj9K0ubZ9n4Ngfdbv0I4Opc9yZSl3XX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=nbnyn30l; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="nbnyn30l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1778570989; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=sQGGUBWjyMyKoPn4laR0S4T6pgQGPiqKdw5XV2g6T6s=;
 b=nbnyn30lM9er+fZTxQboJQuJUbZH2CxZRWpT0iWmPxUoQj9cP6Wt5VwczOujaz/KE6P2h
 kot7wUuJbwCWWFvQwtfqjOYcqNIySUysVoURiKEAfr3XAr89dPDedIpBEoCv2vKOKgU/7ib
 rkbzm3VJx+tLVT+uXvhUNKfEjq/Ar9S7wll3CHJecIj+mKqJ9nBBzjPiChEQlhUa1NZmMnK
 pXPoc4C9J5dG9j4ZSfvVs0A8TT/eBkEG/b4zrA1qE0WkmVEkyEXxA8uOv1YCM1t6zIlLUJz
 TbKBvKU4SZy2BRWV1EljvSnhb/tCRheRtITIypzqFl7jv7HEeH0UiFHibYtg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 93E6A5FC43;
	Tue, 12 May 2026 09:29:49 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 422F05FA3E;
	Tue, 12 May 2026 09:29:49 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Use non-asserting rbtree insertion function in decode_choose_args()
Date: Tue, 12 May 2026 09:29:30 +0200
Message-ID: <20260512072930.1366034-1-raphael.zimmer@tu-ilmenau.de>
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
insertion function and rejecting the message if the insertion fails.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/osdmap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 2095e73ccf6c..0752a3808b91 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -392,7 +392,10 @@ static int decode_choose_args(void **p, void *end, struct crush_map *c)
 				goto e_inval;
 		}
 
-		insert_choose_arg_map(&c->choose_args, arg_map);
+		if (!__insert_choose_arg_map(&c->choose_args, arg_map)) {
+			ret = -EEXIST;
+			goto fail;
+		}
 	}
 
 	return 0;
-- 
2.47.3

