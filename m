Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959581F4181
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2026 23:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886423; cv=none; b=YUvdAQUyYW7lfjGOJs3c/n+JAOogSB/g9dkYabyjHakDv8kWjbq/Wz+usj7zpepnhJNi+2c6b3rZSZLUyBrJRcU6ZQCnEVo82y79k8Q9KalqeX3v6tJ28whlcxuzsv+RBAhjCFkMO8c2hFbCrobHpQxJZtazYz5dVq3oN+HBnOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886423; c=relaxed/simple;
	bh=6T7v1hzF9YXNjAUxl1yFby5yNPcZRt7DY8JF/ulqRyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AbAwGeyVv0rWqXURIlrqRde4yFDVTV9XBS1gMSvcyl038ihyXljuSN6gOxGycFlZtFfwqccZM/FAh0cbmAoq2lecYur+7rhpVpODYMEs4DsmrKL7B6ks4uioaTSPKvPuFCpC5E5OgFeNRQjA4EPfgJPykr78XjsRHLwKBiHxEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=e5vywcvT; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="e5vywcvT"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674MnNHH2808852
	for <ceph-devel@vger.kernel.org>; Tue, 4 Aug 2026 19:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=9MJn
	2efyYx+aesbUzNhwwCfbZijkW5RJZCFgDwcElxc=; b=e5vywcvTTA/6436SInVl
	fh4GPAFFlzbh13Di6M3azfwc4Kdd/id49TzXyk8HOp9qbv+kKN7K7uuBjSAb9Mzz
	Ha23tt9rZQKSBR3C3T5yb1OD9dSELc61LwFL/eu3I/xSClWsSkgqdzEOx3wyHxcL
	Y5EJgfBihjsgKa51KjZuNlA2wjZFMMmEgpQucGP8zO8NrljKbNy73K7zVS2EDwiK
	gL3w8hHJTB3fzaEO4+qpiAaySGzAVnaMyZXb5r+ATS7NvscoG68CvqjBI8w4ENLF
	pRDN9f2HObDurJgkVTCojapDlretvOmu2bjD1iWvfj7201eT0BWKxqCBi1A1M45f
	vQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fuhh7bx99-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 19:33:39 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51a8b0a08d2so2706851cf.0
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 16:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886419; x=1786491219;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9MJn2efyYx+aesbUzNhwwCfbZijkW5RJZCFgDwcElxc=;
        b=M09MTLhnTG/QhPnusUe/35rbFld9HusWyJcr5aYaxFTjgmB7nMuhVFysYVHFeREsmz
         qdTExMbb4pbJTliM6sF9e8+PDNhKxbvXbCKHjahb7MuAvbpKVjp5L2Qy0flZ+59rvWuf
         5HgbsEWrPEQdfzsjueIl3x/9Vv7CBnk1t+Ju75BMO0T58gJLEFjR4AY9xw69CwPhoKky
         KG28GxWxE/vzY86hZ7CKQc/QbR23Vwq9FxPg9PaJPk3bRf3RHwcbV5i0fMoFKFNC0Nzn
         tgXqucMbllHoVO48C8mmJLp90n5s4O6ir2FVJlBVDtU+L1EOZSRjsYjcpCDKKxVuGLTZ
         fpsQ==
X-Gm-Message-State: AOJu0YxQnAshxqKD9Mdt+qzaFHMtta57jwWwIokgUHvtlW+ty3MmqXpm
	c6t/KgazH5Z94+d1uPWvW7jQ0D54+h1eACRjn1zCDu8dpbAUlEkzO8fFIirhqdYYRJLeBYw5RBN
	tcfnBXZrqJIzbb/soYVFlzm26QTM/jFTTre20lkSARKbvCVwGRBOB2O1fPdY=
X-Gm-Gg: AR+sD10KEkLuz7yAyURi/M83fuLiqynd+zxXp+uQFEQTqaUME81Xsv7aujb0rplZk+K
	GWKeMYsyB0RLj49AV7Aah16UQxiH4OYhQs+pLxjcd7RFv5RNJMgUYif8eO05Sjrit0iVeswU2LJ
	oAp1Gvs50toqj6VnTcZ2UeO0FneCzewXkE6mdvlIsbIRya0W9TtKMZL86+Ag8QLPXUGkR9OXaxW
	6PnZGbzwMHWFxzvca3Ph/9Zr5IscLSyE4aB3w615wQv2+szGW1KmSZEUCjb5XWwtueWemdcRbj3
	7xgMQFRF8Aj6LUGZUWEBLHo/VMEliE4yqe4TcyVHDEy+ETwFPzOarTlC+Snpah822yT60tdMtrN
	E5Fw/1FmQzJ8h56qesmpiXYjYmSPgCNFVpX5jFKsaXeesudKR2f+MRJUF4hlQQHtG
X-Received: by 2002:a05:622a:1650:b0:517:8011:3a4d with SMTP id d75a77b69052e-52ce60d5147mr28750681cf.20.1785886418766;
        Tue, 04 Aug 2026 16:33:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1650:b0:517:8011:3a4d with SMTP id d75a77b69052e-52ce60d5147mr28750181cf.20.1785886418238;
        Tue, 04 Aug 2026 16:33:38 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:782e:a06d:5a37:92fe:4fac? ([2a00:a040:199:782e:a06d:5a37:92fe:4fac])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec23e533sm3873005f8f.28.2026.08.04.16.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 16:33:36 -0700 (PDT)
Message-ID: <c0cc3539-be7d-47e0-82b7-9d7239c37907@columbia.edu>
Date: Wed, 5 Aug 2026 02:33:34 +0300
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] ceph: convert page cleanup loop in
 writepages_finish() to folios
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
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
 <20260804-remove-wait-on-page-writeback-v2-8-81f0ab065284@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260804-remove-wait-on-page-writeback-v2-8-81f0ab065284@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE5MSBTYWx0ZWRfXwlr0wdAnyDPm
 tT92xvz+7CWoKC1L1ygoEO2KDdTRsVUy/nb6axZ4fdPoo+5r9Kfxc6ER1yxH3y5RnFP9vWT3Fx/
 9Y467szNgcmTGdYEwZRLbV4AKJa1ItdaB9wXwE1syztia2Kx4mQv+lj+y+NxQobcZcdlK0IpWQX
 8h4LfXa7s5lwKsac6sTi49VPkmKuIX2uHMhg6i5yEYzruGVxj+ScJrSY4tGSdrLl7+gesk/rOnb
 Uf/muVSPFFp0D+Rl8J0K6JbQhJ1UG4n+OtwAaHzF0tlYDzZe5wM+S75xhC+8pKmi7i//qHDug59
 K59W9ykBji60+CifQg3ue7Wvx3tlB53lmZAPDovh36zEA0Oj/YEO/qco05+kVa2dGVfulT6ia1r
 mECAUjAWMjyK29V4L8pDxBemk9eimbkUXFS4rAdW5qZLJs3RBHtidsI7ygcgXUjMw9C6jnCS3gU
 Iz4YpMrGpjVNYYf+LyQ==
X-Proofpoint-ORIG-GUID: Cb0xBkSrlFgmEyoGJ8vr2RNYZbdSb5qH
X-Proofpoint-GUID: Cb0xBkSrlFgmEyoGJ8vr2RNYZbdSb5qH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE5MSBTYWx0ZWRfXwY67r4uTZIkX
 Slw5onQdoNLOIKpR3TGXCseZ4I4hHXxIH1TiqaJ2q42CwcMPXV+VJ8K1sGl4woCqVT5XDSvwhRE
 S53ZhBwaoCoNmM1r+sbIGeXS4GfVl+Z/QjEWUV5Dqp2vlv2HVeEr
X-Authority-Analysis: v=2.4 cv=PYzPQChd c=1 sm=1 tr=0 ts=6a7276d3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22 a=wrtZYR0IVx0RtIOIqSwA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=10 bulkscore=10 priorityscore=1501 spamscore=0
 impostorscore=10 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040191

On 8/4/26 2:52 PM, Tal Zussman wrote:
> Convert the page cleanup loop in writepages_finish() to work on folios,
> resolving the folio directly after fscrypt_finalize_bounce_page() has
> replaced any bounce page with its pagecache page.
> 
> This removes a use of detach_page_private() and five calls to
> compound_head() per page, while adding one back via page_folio().
> 
> No functional change.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/ceph/addr.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 59e559bdfdff..eaf5b3f6d13f 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -896,7 +896,6 @@ static void writepages_finish(struct ceph_osd_request *req)
>  	struct ceph_inode_info *ci = ceph_inode(inode);
>  	struct ceph_client *cl = ceph_inode_to_client(inode);
>  	struct ceph_osd_data *osd_data;
> -	struct page *page;
>  	int num_pages, total_pages = 0;
>  	int i, j;
>  	int rc = req->r_result;
> @@ -943,31 +942,33 @@ static void writepages_finish(struct ceph_osd_request *req)
>  					   (u64)osd_data->length);
>  		total_pages += num_pages;
>  		for (j = 0; j < num_pages; j++) {
> +			struct folio *folio;
> +
>  			fscrypt_finalize_bounce_page(&osd_data->pages[j]);
> -			page = osd_data->pages[j];
> -			BUG_ON(!page);
> -			WARN_ON(!PageUptodate(page));
> +			folio = page_folio(osd_data->pages[j]);
> +			BUG_ON(!folio);
> +			WARN_ON(!folio_test_uptodate(folio));

Sashiko complains:

"Since page_folio() invokes _compound_head() which dereferences the page
pointer, won't this cause a NULL pointer dereference before reaching the
BUG_ON(!folio) check if osd_data->pages[j] is actually NULL?
The previous code checked the page pointer before any dereference occurred.
Would it be safer to check the array element for NULL before passing it to
page_folio()?"

The BUG_ON can just be removed, as fscrypt_finalize_bounce_page() cannot take
or set its argument to NULL as constructed, so the check was unnecessary
to begin with.

>  
>  			if (atomic_long_dec_return(&fsc->writeback_count) <
>  			     CONGESTION_OFF_THRESH(
>  					fsc->mount_options->congestion_kb))
>  				fsc->write_congested = false;
>  
> -			ceph_put_snap_context(detach_page_private(page));
> -			end_page_writeback(page);
> +			ceph_put_snap_context(folio_detach_private(folio));
> +			folio_end_writeback(folio);
>  
>  			if (atomic64_dec_return(&mdsc->dirty_folios) <= 0) {
>  				wake_up_all(&mdsc->flush_end_wq);
>  				WARN_ON(atomic64_read(&mdsc->dirty_folios) < 0);
>  			}
>  
> -			doutc(cl, "unlocking %p\n", page);
> +			doutc(cl, "unlocking %p\n", folio);
>  
>  			if (remove_page)
>  				generic_error_remove_folio(inode->i_mapping,
> -							  page_folio(page));
> +							  folio);
>  
> -			unlock_page(page);
> +			folio_unlock(folio);
>  		}
>  		doutc(cl, "%llx.%llx wrote %llu bytes cleaned %d pages\n",
>  		      ceph_vinop(inode), osd_data->length,
> 

