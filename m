Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF7A3C9EDD
	for <ceph-devel@vger.kernel.org>; Sun,  2 Aug 2026 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689621; cv=none; b=YvsiyYHgSfOOhEhciuN+hlxYnUB3dEqxPViaHBljl8MiH/9GZSjgY8AMEBRdIeJUJLCDi0c4qSXqEG/ECKR5ij/eBUjUlkIxCJ9jMDSWD4u/9Ym074w1Jn0jTl0urvgE3bh1Q4Z6XWzh0boDdqEYRtFabGqFN1yFS0Mmo5ZRfoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689621; c=relaxed/simple;
	bh=2VkgDhoLJZc2rtRUaEo1H+FE+H647yEoceZpR1wCk5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fG5HARgGe/cr2JgzLfM5pbTGN0fgwfATOkQ9g29A85Ohyx1m1V/BJMDqYuFd6St6AMkuNXXd8lK5HrYfTUnufaRZEDuEqSlL/xLqoA2eajSzS7qriL3ZyUWvRMyO2juJA1lLPzAbAJVs4MyskgBuVTD6abshgEzm63uCKMhin6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ZiAxOXOQ; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ZiAxOXOQ"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672CZ0YL3408101
	for <ceph-devel@vger.kernel.org>; Sun, 2 Aug 2026 12:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=iXtH
	coi8cVlKLUHZRCUmBtHXjzieXyTC4IDYVelJs2g=; b=ZiAxOXOQ3C5l4e5uF4z6
	qf860eJMZ+uFHA/DGWEFHgkHs06bLW/WI9JvjPDgwqRmtv3akXM8M2t4dQ0d4sHZ
	LDwA9H8xKpBXfBZmHgdurZDBdVO9mZRSvjz14TBpcaPL7oUD/ZZ/Ha3YqSSCzk85
	HROLuAGoTH2MFGWls7o5GW6zZJossm0QmOkRvZxBjaQGrsgapg5dob+RAWPYjVKe
	I/DwPmS6nU2zRow2146FpSc0ywFMFlHtA1b+ZY8K3BzHzV+CVxDmUKbeipqony73
	tf33GiAkxC9ykvzGHcm/wbWM2UVmeXDSYhDgm5U9y9+QURrkhIJ0xuFI0v/nr32f
	rg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fsdrgneqb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sun, 02 Aug 2026 12:53:39 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bff5c7035so55099151cf.2
        for <ceph-devel@vger.kernel.org>; Sun, 02 Aug 2026 09:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785689618; x=1786294418;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iXtHcoi8cVlKLUHZRCUmBtHXjzieXyTC4IDYVelJs2g=;
        b=bS6JWsfDU5d/jhjdeO9Vo+cPnbpxOnhhslKisJMjtsj3nh1tm85m9sFladAq3G3aSV
         m00OtF6a3yIj9qAJ+TvnCGrWab6Wf7QXnk6jEoja9P6NT7DoNYsP0RCmYV+euRl+Bpnp
         68aitG2Se53dPhW51p5uhe5udxpreBTSLCBFonh9hsmP3UjuHjwtBLYjfJHVtSdHtDel
         +6gaIHEf2OZ0Bm4pXDUsj0S2OFOSLhR49h3J6gvJxYbyNT1t3uc24tsanRlNubDl+kji
         bvKs1E38DtdD65INGvYRaJHxBIE7xuULl9WmJGF/0EQ4rdrkuPsdacD5cXEpD5N3940o
         3hUg==
X-Gm-Message-State: AOJu0YwXBcCCmEv0vsFPn3d6/sUy/vwCKRadSGkPCuOHA3qjgQLKUw37
	hWxAAcjv3YsBH3zRIQumCxahGbQcZHWKE0YHDefKWDRJyyR7+vP319+zwfuu1eRwWrYRV5+lY58
	acXCdTdyZ0HpJw9t5s6ZhU48wfJrIQSlsgdTDeHBmjPU+P+GRESsAYPedXnY=
X-Gm-Gg: AR+sD13AjURskcVYuQghbz11JHqzDFXxgzJF5PhBcJulnYAtqL3QTGfCpY5q4u6mWLs
	UP3YR/qnUtRbYXkadIB/nVN0TnSZ653H/987z8KQk1DkLowrFHS+Le5ZWeFBRW0NFL9eBIGqkZE
	4HqUV13bb7TjF2vEWT/fAKP/4Y0BfklLVkYRc+zT/EL3thtSv0/S4GgXUUmgdYJlG/6bExYqZFf
	3eVZ7vMUhiSrMMvonZLNaWwsS5dxHuuaSq+nD0XjNriODF5luFTbwIEd/j+darCmB4JmOx4EZkS
	ZSVYQG1nzJP5bbFDQrWQ8mmWK//1gNG/3noakqZFNH0s2+F4ZtnuVEUSHrDZMkLq2Q7aLrunz1Z
	FhMbne5+GYucE0iGgLL+vaPAOiHG+m00QAOmgJwh5+yplabhx66Q=
X-Received: by 2002:a05:622b:89:10b0:52b:6543:d8a with SMTP id d75a77b69052e-52b654316e8mr58751311cf.26.1785689618601;
        Sun, 02 Aug 2026 09:53:38 -0700 (PDT)
X-Received: by 2002:a05:622b:89:10b0:52b:6543:d8a with SMTP id d75a77b69052e-52b654316e8mr58751081cf.26.1785689618191;
        Sun, 02 Aug 2026 09:53:38 -0700 (PDT)
Received: from [127.0.1.1] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd45a0c8bsm24064574f8f.34.2026.08.02.09.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 09:53:37 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 02 Aug 2026 12:50:04 -0400
Subject: [PATCH 3/4] mm: remove wait_on_page_writeback()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-remove-wait-on-page-writeback-v1-3-6c35d6b3ad36@columbia.edu>
References: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
In-Reply-To: <20260802-remove-wait-on-page-writeback-v1-0-6c35d6b3ad36@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785689606; l=1337;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=2VkgDhoLJZc2rtRUaEo1H+FE+H647yEoceZpR1wCk5A=;
 b=7I8Fp8rUC2g3MzaZ+Eu5F/2t4vVqj+514clw9LyKXp/jE+0VmFnNxeE1hGpUOS8CgVyOCh1FG
 mTjLIEvkVwqBiGVtq5g14hyqpkS2MRwjm6LTEH52tIQWJPW6dN55Ram
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: xo8T2VRGML8AhihdIMFW5oEbem4EaAaN
X-Authority-Analysis: v=2.4 cv=WMxPmHsR c=1 sm=1 tr=0 ts=6a6f7613 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=mRZAEA7ckj0XMcVDBXoA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX3SVtOGy6T+re
 3MdN7Qpitfmx+tAl4ff+EVgxs2sMOEhEc6JI5Y7WGtywnYqlhg3Ei8xdvGKVl1XMovIg0T3oswx
 4sb0j9XJIh6cGjuUzmuApixVl3Ulx8kigwbe9tYtqhPPaRSHu3SOyWRAz4PHJoD3yy2jwP4HsmI
 kVj7EaEPlqsgaLoXKYHKnjX0TJ70Zt0gDsxfIp0lY2jCoWR1iihalWDbVY+VGdYp5SXwziVRf6y
 mvP1Wg9Y3oVAFwFJgUpxApCN1D8iWIRTWqgUQyQ/f/81nMOG0syP4wvmLApggmNl4508JmzeBzD
 cofXUXTAXZ7NXgj9dqb9dD+KMY2fzJQRGo9EJaeEknc0HTCfOiX7Pk8yVuREXQmhkl7bXm5VwKj
 nL2BstGPhGj10JdCQtG9tpGBZaiqA1s4okMsC73WoYUB+hUFGcXK95B67V+EDWxeAbajPkgtKbT
 3LF1exSJub6YSrAmFQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1MyBTYWx0ZWRfX9w/VuKIZm0xX
 Yr87dYFESNZ6uxCE1unBMAq4ToHTChp0cGxrNIUYvktDWexqWpJtTa2T0sM6P8plsRfOAXs57fQ
 mMMIaQ3Ji9CHlxyNup0Z283up/2EzY/jvIvBcxNpfshLJz/3Wezp
X-Proofpoint-ORIG-GUID: xo8T2VRGML8AhihdIMFW5oEbem4EaAaN
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11863
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=10 malwarescore=0 adultscore=0
 lowpriorityscore=10 clxscore=1015 bulkscore=10 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020153

The last caller was converted to folio_wait_writeback(), so drop the
wait_on_page_writeback() compatibility wrapper and its declaration.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/pagemap.h | 1 -
 mm/folio-compat.c       | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 4e8b2b29f6d3..c8666fd14d3d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1335,7 +1335,6 @@ static inline int folio_wait_locked_killable(struct folio *folio)
 }
 
 void folio_end_read(struct folio *folio, bool success);
-void wait_on_page_writeback(struct page *page);
 void folio_wait_writeback(struct folio *folio);
 int folio_wait_writeback_killable(struct folio *folio);
 void end_page_writeback(struct page *page);
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index a02179a0bded..ae0271591d37 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -23,12 +23,6 @@ void end_page_writeback(struct page *page)
 }
 EXPORT_SYMBOL(end_page_writeback);
 
-void wait_on_page_writeback(struct page *page)
-{
-	return folio_wait_writeback(page_folio(page));
-}
-EXPORT_SYMBOL_GPL(wait_on_page_writeback);
-
 void mark_page_accessed(struct page *page)
 {
 	folio_mark_accessed(page_folio(page));

-- 
2.39.5

