Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F237F331
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994125; cv=none; b=V6qUVMyrbSOsJEx4G7/Ohi4ucVWLI4+Fp9XLdA08nbBfJI52kDBGFN5xugOUD5nUqLCBGZfFFbiVK40qHtOXe/Dv91Px3PHBveMIHbI1ixWtBlTCmP00iM8KNhVsL2ytCVBDGGvn+Kc+V68avES4fEp73DqRTRJnK6J6P5Pac0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994125; c=relaxed/simple;
	bh=O9Tsg2DIkPFDuC4WYkkc9VidXQakooPjbM/qwj4bX2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AeO38UQbLmfpGy7nC6w7qmLo3HW1STGKljDM73J29s/eKFk7vSw9EOKu7/pVyKIT3B/hoVjDh0lWWhnzGOqtKFo407S7WcxX6I3uhNlnYu1OGTQkvgRhENODJp5b3n4Ov64kQeZ/DGooZzz7392T9VsNyPSh02kyfO1/t2N9w5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Yq/lpFdX; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Cyr5OLD0; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Yq/lpFdX";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Cyr5OLD0"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIvh3m3766728
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=uS52
	otnHr2tR2+z+5rHsosAozZEXrniXB9g7aN7M4kc=; b=Yq/lpFdXqUaFQ55y/cvY
	twJMhBIiYbKbykI5gtEAqvJgymqbZgRI51csQSJmHKmq6f0Hm2tAuq3J3+CZhnr7
	YNGpEpY61YiVWnjhq7OXI4VuZDEDQdYw4+sTBqEgd/MeO3oX9QisFYZ0o87SQSrN
	UEmCGAiZGKIv5kSWOlY9k1Tk0yqApjzW4Oteetqj4li77Yp65tqtNR01hlnllYk8
	UEtk+H5+ZXqsam73z01OYNRFfXqmpaNDfwlAQ935bfMF9S7qnk1sMtHPSL2YCswc
	l/WKybsXR++Ol+b/w17QlS+o9wgmfJSnbq82uPFsirfcfB6E0V5KSW5kr2Rmfx1c
	nA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g481r85cx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:22 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e695a3b28so25523985a.1
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994122; x=1787598922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uS52otnHr2tR2+z+5rHsosAozZEXrniXB9g7aN7M4kc=;
        b=Cyr5OLD0mDuOw1zUsX55YgzluFaL498FQ9VKQyVfAsAle8MGpUlk9jJJvGd3DP6o73
         /sgjqwkm/u8WcSo/NI9HmvXS6dZ4QonXZCRaKR8ZXBkVZXZ8D6HThCTKeSxlrUIRRrS6
         VrdaDNuiEfyril/e10TUzoP1Fi5DNjFtq8bUAKyE5s8N14n9JmsFn0khfr1RVbft05VJ
         BenpxwVpmQsQS/7hzQg0BDl1x1/WMG45spNBB1prxUGKaAmpOYml3iAFYJRG/XlvaCNw
         5vT5h6FOs6JMwsdAzRYcrntwI4xJnVMS0LQB/ITRaamdifDgn1rkKylf3FaaM9a76UgW
         /R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994122; x=1787598922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uS52otnHr2tR2+z+5rHsosAozZEXrniXB9g7aN7M4kc=;
        b=WuZarlcD5X66fdikERjj7ZVae/7/W/ox3w2PALw9glhaMvGe0c8hZpCsAJsFAswu1b
         d9/YQ1HXO4OVg1nvwXVJbJi/dkEI0rCOJwmWIfN9PO5xZ5W8WgCfFug195mG8sC/zIEg
         J5otLUiRyTLZDuT8c1yddXc2xNQMk30SfrtFuwBN6/YVV80uI1lXqd/kR/owjCcoginh
         0JyV/AYKg3MFppkkxBxiQXj98oFKFziQup+pvQzGlfhgmd2j/j4/wWHvmErbDvmEAeQf
         hTecy6qNSjvA7QRnmyKnqstCP438DjDsyf0/rt5s+aElOL3fQB45thjAZBqAyvE00SFc
         olkQ==
X-Gm-Message-State: AOJu0YzKXkr9KtFyNeYjau6euKBUBE29gA7vRJn1mOvR8ghSMtG7oB5I
	BAA0hXrkBMaFtSJWAVYiqgaa6EcYmYTTlJUFIm0v2IkPFoRh1ENdiiUz9TRBpTJldO2EQzodYXZ
	+NVtx33up/m64YoyY/VE3o2FO+xocZkdY1uMYcaYCJyh7tjE2CDro9n0Q0IY=
X-Gm-Gg: AR+sD12iBeQtaWYrB5XAPU/mIo5Mib16accHDH+e9UvwQVhz3kTqdOh3/SyInBhuiSJ
	vF/NC53TVX0q/n3biJoFlv7Vu0L6cA4VWIB8MoXEpC1sMdUFMfq843CLRUt0sDlywqQIiyOvPsg
	RuNvE6BbFssYTu9qrKtumJEhnhEh450BkHCEG0q5BY0NiqTeWEsw3sldj11ziJVeLa/T6mQ9zVg
	6cqj8wUNSfP8YuzaDuPsvrUIAwkZxkDlp3KlUsZgR20EW15wPivgOPjMqAHSVXdA8ABpgo8D/XB
	6FLygovO97NoU+WxDqCQ6uiK2qMe1VVRmjYVwZnNIF5hTE+jlZ2gOZzAQdthPxF1sK3EAg==
X-Received: by 2002:a05:620a:990:b0:930:9cbc:7121 with SMTP id af79cd13be357-9370652b374mr113514185a.3.1786994122270;
        Mon, 17 Aug 2026 12:15:22 -0700 (PDT)
X-Received: by 2002:a05:620a:990:b0:930:9cbc:7121 with SMTP id af79cd13be357-9370652b374mr113506985a.3.1786994121673;
        Mon, 17 Aug 2026 12:15:21 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:20 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:18 -0400
Subject: [PATCH v4 02/10] ceph: wait for pending fscache write in
 write_folio_nounlock()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-2-0e5e53d47eb0@columbia.edu>
References: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
In-Reply-To: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=2448;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=O9Tsg2DIkPFDuC4WYkkc9VidXQakooPjbM/qwj4bX2c=;
 b=5KjgFa4rHDDNlNqr+ukt0N/yZwdNnaIHVZ5dUE/zMfXBKfQved4VywnPj/KcWF7B96dD2zhN4
 DZ9pOPzoGwYAjgco9ug4gnjGQ+YsGH5kko0oyjpSRbqsGnH5dvb0sGf
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX8v9Mhn7Sk2bM
 4o7Yvsub51u/cyfoZgBut8r0gYjj7bg9/YJZ592GbOiWxf6HVaiVXjdUnnbnNmIsgb4TcCte6iz
 XND54QgwWvWCzsT7JNjC7PIDGxKv2j0ijBw1JqQ9UI5bb2LOGNDyvwYeLmit3Juqrde1yjuY1wx
 bA9syoxwsdPzGwkWVfeKNJnn3rUT40LOd7ekl0/ZqRSq5RDHecWFWKfs/AseVRXgWMJm4tbBK0v
 f57ojl0hPtjDZWNwp3L4Hah5Lvoa4HEpYF1F6BbXZMNzdvdMRBHMuz+eFbvfGwgsBxjg9+dJ6L7
 UIoUrj8MNnTaOEwt8lPbdCHPtFp0n6Q7z/KcHuyMENEsheuYjTv7MXAAi4nedn7C4SvRgrwRm32
 ZwwC88ooQbDh9SWTQ/NRtSKU5KlQIhnCuii9BlDbUQpadj2YpECI18z8izATTy93s+cJBu2ou0f
 FRwsPa6BWrHfTpq/GJg==
X-Authority-Analysis: v=2.4 cv=PKw/P/qC c=1 sm=1 tr=0 ts=6a835dcb cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=zYp62tllrndxtlEyWVMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 29-XPU9K2Smm_HRnst9ZsYq4dOTF7UAy
X-Proofpoint-GUID: 29-XPU9K2Smm_HRnst9ZsYq4dOTF7UAy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX9BbYIK5cC/HL
 UUrnFDauBakqU4akYgTwetpIzaBQKIK9qYL8JdUf09Uc2FBVlpUSc44je22ceFpCWDuTw44mkg0
 8yyxEAXCWIFa71qqMsrUaaPii+PqbmsUyyoBh2IT9wG9+KVIfjNA
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=10 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=10 lowpriorityscore=10 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170147

write_folio_nounlock() marks the folio with PG_private_2 via
ceph_set_page_fscache() and starts an async write to the cache via
ceph_fscache_write_to_cache(). PG_private_2 is only cleared once that
write completes.

If the OSD write fails, the error paths return without waiting for the
cache write. On retry, ceph_find_incompatible() would wait for
writeback, but not for PG_private_2, before calling
write_folio_nounlock() again, which would trip the VM_BUG_ON_FOLIO() in
folio_start_private_2().

Wait for any pending cache write before starting writeback on the
folio. Do so before bumping the writeback congestion count and
allocating the possibly mempool-backed OSD request, so that a thread
sleeping on the cache I/O does not hold either while it waits.
Add ceph_folio_wait_fscache(), a wrapper for folio_wait_private_2(), and
use it.

Fixes: 1702e7973410 ("ceph: add fscache writeback support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284%40columbia.edu?part=7
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index d5a349daf4d0..f1f4caa8f9df 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -559,6 +559,11 @@ static void ceph_set_page_fscache(struct page *page)
 	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
 }
 
+static void ceph_folio_wait_fscache(struct folio *folio)
+{
+	folio_wait_private_2(folio); /* [DEPRECATED] */
+}
+
 static void ceph_fscache_write_terminated(void *priv, ssize_t error)
 {
 	struct inode *inode = priv;
@@ -580,6 +585,10 @@ static inline void ceph_set_page_fscache(struct page *page)
 {
 }
 
+static inline void ceph_folio_wait_fscache(struct folio *folio)
+{
+}
+
 static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, bool caching)
 {
 }
@@ -783,6 +792,9 @@ static int write_folio_nounlock(struct folio *folio,
 	      ceph_vinop(inode), folio, folio->index, page_off, wlen, snapc,
 	      snapc->seq);
 
+	/* wait for a cache write left pending by a previously failed attempt */
+	ceph_folio_wait_fscache(folio);
+
 	if (atomic_long_inc_return(&fsc->writeback_count) >
 	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
 		fsc->write_congested = true;

-- 
2.39.5

