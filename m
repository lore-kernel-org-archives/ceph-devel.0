Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD73E271468
	for <ceph-devel@vger.kernel.org>; Tue, 24 Feb 2026 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947506; cv=none; b=us4+pju1rmoZMWbDVy2NuiEreGZdEKq43c8SJiNBWNs2UvhsYFx2VT7bTwDKBSkleFCZF7BJmg56MJ/EhkJkWetJ7Ab3knznFfF8eB2Jys9g6lHvCwtlUgoyXG4FoqHVfbbHP41tTBR1aB7cV6R3GiaA7NucIW7WsFZDtGmXVxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947506; c=relaxed/simple;
	bh=vHKzfiORRyWqS9biG5rJUwHwelXLlZT4u838/ZduVuM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=CXqBxATwc1WYTQdyaxcm7EB6bvVs8qdM1K+ozjvFrXJj6JYhO5TR+yZfBCSVSsPEbd4T8ZBUYUcW+a1BjT9lc77iKXYQgktgfz7xBJaaYyxbazK5Fk0680DqpkdzxJYk39qXtupt6fZgJ0uEmkkcFdiozMpNzdWzvvgQfL0vp1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=gOjULxxM; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="gOjULxxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1771947495; h=message-id
 : date : mime-version : from : subject : to : cc : content-type :
 content-transfer-encoding : from;
 bh=vHKzfiORRyWqS9biG5rJUwHwelXLlZT4u838/ZduVuM=;
 b=gOjULxxMCoACAgO0dySkCQ/9dU/1tP+4miE5TbCfp0tznrpbHnsnrGhoW6EssftR9cZZm
 UcuoWDO6M+nwaNIZwANcXzvK46o6/egzC2FjpDXLy5mOOy9jPAQunMUp15oPmyTlMeA+kXG
 aiPA7lApXRD4J+ZhWdJcbwNsEcaZGiuGcyMnKrZzU5wnD9IVX8gSUD2mNzgUrmFm63Qxwd2
 tNOGAjA9c9SW2osjxOJfvfbmlxE5UdwSd0V7pRVKltOuLkAxigmgjYIk79q6oKTM7ySHYtQ
 rvn434Fw5ExuJmo0iG27Z9GiIQFDfNs4NkTX6xpuRFZLv2kgTCUCGGBdIvcg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id CF8086018D;
	Tue, 24 Feb 2026 16:38:15 +0100 (CET)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id B82125FA3E;
	Tue, 24 Feb 2026 16:38:14 +0100 (CET)
Message-ID: <95b6e21f-0bfd-4d39-93c1-757f3706590f@tu-ilmenau.de>
Date: Tue, 24 Feb 2026 16:38:14 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
Subject: [PATCH] libceph: Use u32 for non-negative values in
 ceph_monmap_decode()
To: Ilya Dryomov <idryomov@gmail.com>, amarkuze@redhat.com, slava@dubeyko.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes unnecessary implicit conversions that change signedness 
of blob_len and num_mon in ceph_monmap_decode().
Currently blob_len and num_mon are (signed) int variables. They are used 
to hold values that are always non-negative and get assigned in 
ceph_decode_32_safe(), which is meant to assign u32 values. Both 
variables are subsequently used as unsigned values, and the value of 
num_mon is further assigned to monmap->num_mon, which is of type u32. 
Therefore, both variables should be of type u32. This is especially 
relevant for num_mon. If the value read from the incoming message is 
very large, it is interpreted as a negative value, and the check for 
num_mon > CEPH_MAX_MON in line 117 does not catch it. This leads to the 
attempt to allocate a very large chunk of memory in line 120, which will 
most likely fail. In this case, an unnecessary attempt to allocate 
memory is performed, and -ENOMEM is returned instead of -EINVAL. For 
consistency, the type of variable i is also changed to u32, as it is 
also only used for non-negative values.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
  net/ceph/mon_client.c | 10 +++++-----
  1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index fa8dd2a20f7d..8ced3a9297b3 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -72,12 +72,12 @@ static struct ceph_monmap *ceph_monmap_decode(void 
**p, void *end, bool msgr2)
         struct ceph_monmap *monmap = NULL;
         struct ceph_fsid fsid;
         u32 struct_len;
-       int blob_len;
-       int num_mon;
+       u32 blob_len;
+       u32 num_mon;
         u8 struct_v;
         u32 epoch;
         int ret;
-       int i;
+       u32 i;

         ceph_decode_32_safe(p, end, blob_len, e_inval);
         ceph_decode_need(p, end, blob_len, e_inval);
@@ -112,7 +112,7 @@ static struct ceph_monmap *ceph_monmap_decode(void 
**p, void *end, bool msgr2)
         }
         ceph_decode_32_safe(p, end, num_mon, e_inval);

-       dout("%s fsid %pU epoch %u num_mon %d\n", __func__, &fsid, epoch,
+       dout("%s fsid %pU epoch %u num_mon %u\n", __func__, &fsid, epoch,
              num_mon);
         if (num_mon > CEPH_MAX_MON)
                 goto e_inval;
@@ -141,7 +141,7 @@ static struct ceph_monmap *ceph_monmap_decode(void 
**p, void *end, bool msgr2)
                 if (ret)
                         goto fail;

-               dout("%s mon%d addr %s\n", __func__, i,
+               dout("%s mon%u addr %s\n", __func__, i,
                      ceph_pr_addr(&inst->addr));
         }

-- 
2.47.3
