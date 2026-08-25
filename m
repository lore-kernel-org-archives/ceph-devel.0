Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06A148D882
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694526; cv=none; b=qt3198dgp/2cPZ8zG0JPmEw1G/DAhACBFvwLfsbSJMwY5t8c2gIRtuP+gajJJcdtPqCFN3ee8Yc1IwNPYjwQ2IcyWqhUnhLS/Csj+x+vJpA3NuRD2vEzDXv5WQVGW1EjaIU4Mbn+nyB7fYWOXnHxKZDVsjvMJ6J4dUEL4+7UjgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694526; c=relaxed/simple;
	bh=vSoZyum0Vsl+GDr1/T/T4zqiTYAYOmc8D6bvEAuPl5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WYBRDgUgjpAjnDriR1Aw9YZ6Egsnfx1apWPsZtFcQgW3nsBHuZQOOy2X7qG56mLFvjDY0N6Gm2c0fbKVXpyl+Oto7wVP9V25N7e9MRiJwPypa+pawu3e80SvaKWJW1R4/cDIqgqjOF/F2Lv/07+oPqvGk5L5ZpylTIuhaLBP858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=KwQ/wre4; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=cO6Ecm9F; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="KwQ/wre4";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="cO6Ecm9F"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PKYVjn2488011
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=BQo6
	Kz3Eb++WJRZK//AEA3mbrkw8KHTwKx/5vIMt89E=; b=KwQ/wre4pdl9bSY99P2R
	Da7fuxj1N7teLB81U/hhtcsSPygaSXzHXbgy5vA1Ubwp+dLsNWzZH5WcFa/KB2qF
	vlSEocrqsMmgciQHDMpRWhnP9cVv5ojYfLl0+Ra7pHWICRPski3amWgWegeMEw4B
	AH2VNHy0yDOhLPc2C0kgGGVGQI3Hkjzsj7rNoJbdOGYgZMaSQBmwAqiBCZ8cOqrh
	47oZvG04iWJ1ZitllGKv5QWciD2YdN750LopovVQ/u7yiK7OjFl3iRsso6/IpbfE
	vPl1x+Baf9XsDI16ScTndi1lWxGAvwG+sQ9JomqdfR05PR2oLmuzhz+GfQVgFL8A
	kg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g9d6tbbuk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:33 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52d7b3adda4so3447051cf.3
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 14:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787694513; x=1788299313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BQo6Kz3Eb++WJRZK//AEA3mbrkw8KHTwKx/5vIMt89E=;
        b=cO6Ecm9FsVcdH9ZvhBoj2WU1XxJddt+lxYgKgiiYDJpZ7wKYh5dZyNRWosQLjjQkG/
         C9xpvok/nGsLr0k2na/6o14L3nquxXr9BU9o3g5mpDjMKYtxSuVmJEOlcRSWvfBbz3gq
         kp2ytuofEa+V5j/HDQVCCU0UAaiLi59Y/cL/quFG5/5hlq5YCh42jrtzmlRPjWRA0R+z
         2/BIsm9e4Y3vTvlwmRX1N1u6aeCzb3QZrpWpj0ChDDuPmYAT+atwfn+rf1SWKL8u0yWZ
         qMOXfdhGtfL/APp8Akz+AZI361Av6B4DAsK8KMVnkLDgoo1r0GiyPLYGWt0JlpscAZWr
         4L/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787694513; x=1788299313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BQo6Kz3Eb++WJRZK//AEA3mbrkw8KHTwKx/5vIMt89E=;
        b=PWAeBDD61bw7HGBeZO/u7knesmCC7htMSbhBIXvvsY6RIc7ruTmQLjCKRmZVpvMPch
         M7wjQ0ruya5uoqmuSRzAclyxRBNdZtL4SAlCZESaqXXZFbFeU3e8rmX0r9FWrHQNewgS
         wfSygp+cS4EEN3+/xcwsLn9B67hK2IF8avJthEbG/IG+fCdH8bcTrjZvWBY3xlzmesIw
         rYHzjnmThhHk+i4mlLJ88+2DvHjM3so7ssnkT6rv/39SGok2ix5KgOTeFQdQtqNxRCP8
         Jzo3sWYMHLZhErPguz1Rf6YUuPj7HFekZMPb+kyjHRyxIlJWcuVNTWSDcO9J63QKgdt0
         wZUQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro4okWaCwgOzS30Em6qoYof6Htvk94IO50gXUjnhKDssm/q47f+zWfkkCfws2RYQznvdNhXZdHWUl+k@vger.kernel.org
X-Gm-Message-State: AFuF++leeT9pWE17vZMQOd0RDJ+bUAHqWH123/ZFpoNPbz5uzBQwmGew
	Fanzc9yfK48qHA/WnEjOxpeD0Hm8QVnhQVtlPwprjZtHP3g3EQgUnAVznP6D/A6CT6tUuKVr5sW
	GUbPm9d4AF5MXxRlaKacklhPDu1hpikXJBgqsVxbgJ+7vzGhDqDYTyabnDvefzcDH0m2YVg==
X-Gm-Gg: AR+sD10IjlxnBa8X5RDtnmDAgSNXwmgWj2jDP3HWs49TkaBvlEzO7xhSZveT1WBZSUT
	obCvis+CPM31udIo0A+4K4yuDd1zYy34D96rwWecyC5R7nNaWA0S5JywKTbLFDNa9jQCK2s670y
	lGb19vXd4ktdV6o8SYEtCPiSIpbaagliK7Xdjax4uso4Hj9vl7zf2pcIDEZu4HVaLIKNDlZy3Db
	TL2hKY/JMKG7nZxbqLwWnWwsNr86oj9ruWwFOrfqhZEPcAEDL6l9JS+FJ8cLEYr1JMrgACiJ0Fc
	G9eyoQz9SJ/Uj2Nlb3Y4huntnoI3a3J0nYi/hgpK0YDpc5tFNKDYao5EeH1s3n4f0bk4bxx7svI
	PGA9UGq+2JA==
X-Received: by 2002:a05:622a:1249:b0:51c:c6c:9d65 with SMTP id d75a77b69052e-52e42234b3amr24874091cf.1.1787694513394;
        Tue, 25 Aug 2026 14:48:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1249:b0:51c:c6c:9d65 with SMTP id d75a77b69052e-52e42234b3amr24873551cf.1.1787694512881;
        Tue, 25 Aug 2026 14:48:32 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.157.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9ef8ffsm139207566b.60.2026.08.25.14.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:48:31 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 25 Aug 2026 17:48:08 -0400
Subject: [PATCH 1/6] ceph: use a folio in ceph_get_caps()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ceph-inline-folio-v1-1-d2366fade152@columbia.edu>
References: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
In-Reply-To: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787694507; l=1061;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=vSoZyum0Vsl+GDr1/T/T4zqiTYAYOmc8D6bvEAuPl5Y=;
 b=nT71pPd8lX66WApDAi3QJ0bVlpSv6RbgGtplYwXLDHq+cJVq8kS4ZDC85+PSm+LQ+2sIHVaHm
 Nzieqfx0ybYCDgESOH3TpqHSiH1AbppnRZelHpKgMhzJBHe3M/h/RYr
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: PZIJwqALrBIr6-q0G-3guRUxbC7dKJXB
X-Proofpoint-ORIG-GUID: PZIJwqALrBIr6-q0G-3guRUxbC7dKJXB
X-Authority-Analysis: v=2.4 cv=T528ifKQ c=1 sm=1 tr=0 ts=6a8e0db1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=VsYqNs1x6zyujO4rtox2PQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=7pwb4K0tqOTcqFA6WXsA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX2a+B2hA+7eDh
 C/rBbVgWRvm0tUBsfQVI/HJGfaaCbLhwTtf3qlvG20adxCvuQou48vpK6vX/7AE4gtbgAh4n8SG
 VrB9HRbAvms9AVYk7VXTGHiSVhTu7T7Q1nR6kpdLd6d5xwEWe/EGKdseZw9KJVH13ULixSWOH/l
 7g0wXamz19lAJ2ySX/KXRjHKXM+TbCd+/+3uQsHNT0h5yY2RqoEUzu1Vx/xBNO64QX/lvrD8WHm
 y7nwpaf8otILAFYCzZzfEXLmS7q9MWL2I0+KtySMeMyqNv5xQWPCek4gIrbcF+ILMj5/VtpoYOA
 qaltu9aKdlCXf3CN+c4o49Vsa5zYCSMHZ+AiSLWuy+sFSpxYb3b6ldq4o/fimUh0hv8HqK5H09C
 SzRviYE73XbLu1RNXkraF7rulAxZhqiWiwD5BwZkD2J28PLSx9xtHDtDnS3ny3fYekam8Lde2Cd
 WKazoEKdxR3I2JJKvUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX4nTgs9gRdaIz
 ZqN23npK3JRC65q2RcUFeQZyWtgzscooybJ8HEBG3pEvAPtCWikvPpd4dkom6j1tT/7SSf8J1Ng
 Uc0VCuelZay6LwCJk1xfSfxr37H5RvWNIacTOLt/6h9csMMO108s
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11886
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=10 priorityscore=1501
 lowpriorityscore=10 phishscore=0 malwarescore=0 adultscore=0 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250185

Convert the inline data page cache check to filemap_get_folio(), which
returns an ERR_PTR instead of NULL when no folio is present. Saves two
calls to compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/caps.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 6466e11ca783..af2aa098f553 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3250,12 +3250,12 @@ int __ceph_get_caps(struct inode *inode, struct ceph_file_info *fi, int need,
 		    ceph_has_inline_data(ci) &&
 		    (_got & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) &&
 		    i_size_read(inode) > 0) {
-			struct page *page =
-				find_get_page(inode->i_mapping, 0);
-			if (page) {
-				bool uptodate = PageUptodate(page);
+			struct folio *folio =
+				filemap_get_folio(inode->i_mapping, 0);
+			if (!IS_ERR(folio)) {
+				bool uptodate = folio_test_uptodate(folio);
 
-				put_page(page);
+				folio_put(folio);
 				if (uptodate)
 					break;
 			}

-- 
2.39.5

