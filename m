Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521933E51F4
	for <ceph-devel@vger.kernel.org>; Fri,  4 Sep 2026 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538388; cv=none; b=Ko85yJYDokff2DRgnJdI/w9I3OZNTxXkTAHBjAFjUYzLWlWYtaCDgq3ksA6buL8OJZbdxa6Pcwu0ZZ2FUndNVdP56ozy8OwgpmROP3y934TOegwSFw2VAt0bk8h9XxjVhjEI1eIU+fmt1V+jgcwW9wEB5jMyTdx8KVBHAJgpyjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538388; c=relaxed/simple;
	bh=KwhjMSzCj8Usze6oZbMMBKdy/hj+QXfXthbq6FYpeG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YqBehUoUhTGhptSdCW/C+8r0H5MEHEYK+7G0MD7vQpG88ox+ggeO9LdI3KS3jnrlXAe8OAPKJGQROf11tlJDNFsq3/XWeuqPufqsexDkzqpzlGC+zoz86ictSkDJB9Ksn8SHggwnNm/JXuR4LVhPbB9om7Qrc+AFJieTe9/KLW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=FAqwIeFh; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Q6P+Yfz9; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="FAqwIeFh";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Q6P+Yfz9"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684GAHx82948643
	for <ceph-devel@vger.kernel.org>; Fri, 4 Sep 2026 12:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=DDwZ
	acc7LB/c1OHIIdPdt3E/hXnZakokhj7Yn+1XNNM=; b=FAqwIeFhaGbyRgazdV34
	LSRR0yJ8NzxLmFF5CYAToWcI25jOr9rYVdvZSZqRD3lbN9mkN5sIZM0haSsZ5XZa
	zcDFM/+eYZwMSTAKkNFOBDOx5Y8VQd/9g9SHLD8EYPz8Z0v2IBLCPN67SUmnb9Vs
	SKKMXjxQSHkNIwZv8PlpuFiYgolmD/4GsK0xGDlRPfp7CNw0bWGyk/uZX8TvtQ5f
	Ee2S5M761rMffrJNics+b2eJufcZeTCuz67S3sB1unJROp0BZ1hy2wILWHi4QKyc
	trcjhu3sxcJ7L0kwU16VFTgmYQcztxkfvNKPc/yPKoa46RIq8wb+Z6g0hA11RK8/
	kQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gfyvks0b7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 12:13:04 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939281526e1so95014885a.0
        for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788538384; x=1789143184; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DDwZacc7LB/c1OHIIdPdt3E/hXnZakokhj7Yn+1XNNM=;
        b=Q6P+Yfz9lWzjb/Sw1ZN+8eA1rvVcWjGot1BV12G24mEQ+HJpuDOkeZJBUDIgT5gtTS
         rhQcc9ZM833CyiGEZ6NWrrtCr8v/jXaE/+UeJoh9lEX+ckzzl/rZawaSENL/18QkH5x3
         3GbySIEoRWNulXFdeBZbPHj5eBJjHfKyed/7nHqc/KiC5H5QOC4UEI17aK/tQOtmX4ss
         H2PpvYSqI91WDDaNa0m7WobfVTTTuhZsV2pqcEvVa2mT+NMf4p8VWEPKkUAquI1VyCSh
         FnCCITfjUqCTmk9fPCDRB03pZm98j66WdP/nuMPG2md3c7zXgC96cGoDDzY+4vj0uzCu
         Vbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788538384; x=1789143184;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DDwZacc7LB/c1OHIIdPdt3E/hXnZakokhj7Yn+1XNNM=;
        b=MN2BgJu+ovyOFx1VoXxaaQ6yE4At7qoQkZo0ADgpLUp1+9r1VSkvLz5RL2ugqqP+uC
         7+HKQUJ7qYh1j9f1vb8EtekXQRn2FmJqoC9UiVaxEI9LIa970oGQ9DiOqDJoRw3VusSK
         BKfysdMLubVKGW/Nc585PJukqD2rMhm08AEG9sIlQBrenJwqHJpfbOwJ8YgDyKoXKBRg
         eQmlujs68Bp9H18Lx2B74dwdwQy0gW7OlY2lBriOpQznFiKgB1HvRRaifpO8wLsBiEnu
         SGQipVUqb1+qUjYvLA0cu6dbjZKqaH3F2prWwrF47AvRge16R/XXZGi2IlaYOqhDjOLt
         EjGQ==
X-Gm-Message-State: AFuF++md/nYpwwnbWnc8jkXKHSS0Gxzzdf8VGlpDNSOUvqPz/6dAj/th
	2B/V1HhFPEfEtUwwH4lQWOyUxBL98CbMwZ/IKrW8FpPrSExbS3+O4PZrY5NzWdqb9OhlANCv6T9
	9szhH/FMyxiOjcHxv4jNPLXK1wkUGzOhVDwBMJxMiayOQabODY3mGQMFGTyw=
X-Gm-Gg: AYBFou2kL1jBnUd4R67jTKImaJ1DhmGz5dhVD0MW8mbuX/UN6909tyUagMuBu2b520g
	RFZWQJvYbJ7t08uGFw/rxu41oRj/1Abtiq7NUoDk167FGAtJn3gGL0oQK/kRRsO8N0c3MyWhE0q
	1UAMdpZYZo7vQ6HCPVtTai8WetL6n9apPYmu0xoM1Ei0EQ6/tRzSLc4dILjb/7kqID/xo5dmYJS
	9WTJM0dEUZhIqeWWUUuJJ2tjW4/nkZGzMMCYx0eYTQFUzs6amlQ0HLc0O/y/5USWrM/+V99ubMZ
	Jzu2ZXEzpnzRlppm/NxzYTpMBNrpBd3XFvzozLZgDcvtLzrAxKzGbRMz9EmHd+IiS2fd/P0VGH9
	7OVy7vEAR4kVHL/TnwOPKOtDh/Xez1FvnvRKVlexf3yoluJqJ
X-Received: by 2002:a05:620a:2988:b0:939:85e4:44dd with SMTP id af79cd13be357-93985e447b5mr415266085a.36.1788538384163;
        Fri, 04 Sep 2026 09:13:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2988:b0:939:85e4:44dd with SMTP id af79cd13be357-93985e447b5mr415258285a.36.1788538383468;
        Fri, 04 Sep 2026 09:13:03 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-177-158.net.columbia.edu. [128.59.177.158])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fafbd99sm241625085a.7.2026.09.04.09.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:13:01 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 04 Sep 2026 12:12:39 -0400
Subject: [PATCH 2/2] ceph: don't clear write_congested when collecting
 folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ceph-writeback-count-leak-v1-2-d41b070bac9b@columbia.edu>
References: <20260904-ceph-writeback-count-leak-v1-0-d41b070bac9b@columbia.edu>
In-Reply-To: <20260904-ceph-writeback-count-leak-v1-0-d41b070bac9b@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Milind Changire <mchangir@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788538376; l=1249;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=KwhjMSzCj8Usze6oZbMMBKdy/hj+QXfXthbq6FYpeG8=;
 b=S5EL/6dvYjuQmqUCmU7KQ2rBRVdSJPRuj4CpTzLx2BYgGJzbvS7kSlHCTMq1NJnHgUUEcWUIR
 AdSndhx/AyYD9b+HJ5VeWZ2OjiQyHytZXCzI70t/L19JsFdEZc8DDab
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0NiBTYWx0ZWRfX+C1R/J1k3rwv
 gkO7aga5n8KEdpONB7B+4R4lQhiDmlfH/7bbc3NLeIligb17cns6wv24eiVJTJ4jMln0kE9XSoj
 Azk8hSl+LxzkcGRN4OTzcmFFYoMTS+sg9LA5h5KL7Hgz3jED/5yz
X-Proofpoint-GUID: 17NMPGXzoCt5qkuY0zUNEJp2zOZniWkO
X-Authority-Analysis: v=2.4 cv=JoLBas4C c=1 sm=1 tr=0 ts=6a9aee11 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=tLges04aSNaZGVAfhBIy2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=9UOJAgXYUBxK1CrQbdIA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0NiBTYWx0ZWRfX97NSnb02lIIn
 aCnWwnE1U585Ez8oLFXVvn6Rf1VkG1blDxHQpTrSrC1zlDrN6komCJN0G38xcsN/jrFIbj+gBcT
 hPf3o/m+wpvXyinfi2RlWR9PFA8ka0hJmEMlD84mN8g0YrM9a8sPZ2rIZj/zdR6qKUvSCJRo3a6
 3L0GwcKwIyF6U2Ip7edMhPuULj+PCBlyGpsWGVsTsZoZJRqyp7vts4I+xl+oqc/0z4aupBFfokH
 YgdSPzwYnelt+cl4DHt+/LD7+LPBIGcymW9hwLj1fWH1Zwgua9zilolTgDETSEeR8oN2JZDb++b
 gBJwL3LmZzxLJoqSmUG09OHZ43sp/ZUpVgsc872UjOgu4iaTuEw+8ZUrxLnPmYnF1ZkWtox2ZPY
 nYayWGDD8zaN8NOygqwJwiyscy6Ua24YOTBrkUG056Sc+JH+v6ugNq6btah6yBD/Had9FUtPkEF
 cq9y9r51nR2YVCIlE6g==
X-Proofpoint-ORIG-GUID: 17NMPGXzoCt5qkuY0zUNEJp2zOZniWkO
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11895
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 bulkscore=10 lowpriorityscore=10 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040146

ceph_process_folio_batch() assigns the result of
is_write_congestion_happened() to fsc->write_congested for every folio
it collects. The code it replaced only ever set write_congested to true
here, leaving the decrement paths to clear it once writeback_count
drops below CONGESTION_OFF_THRESH. The unconditional assignment means
that a sync writeback that runs while the count sits between the off and
on thresholds clears the flag on its first folio, and background
writeback resumes early.

Only set the flag here, as before.

Fixes: ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method")
Assisted-by: Claude:fable-5.1
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 69f2c4c8498a..7c9508fdc41a 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1469,7 +1469,8 @@ void ceph_process_folio_batch(struct address_space *mapping,
 			break;
 		}
 
-		fsc->write_congested = is_write_congestion_happened(fsc);
+		if (is_write_congestion_happened(fsc))
+			fsc->write_congested = true;
 
 		ceph_wbc->fbatch.folios[i] = NULL;
 		ceph_wbc->len += folio_size(folio);

-- 
2.39.5

