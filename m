Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DBE3EC6AE
	for <ceph-devel@vger.kernel.org>; Thu,  6 Aug 2026 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042707; cv=none; b=YwumKNP7/Ou9+YwYFiIvglfWQ7U8fCS6PuhX8GpIHH7hdHlLQNKWv184S39CSPU8/iRvHYp23ra5x5XB7zI0DcZRu0vtVowGoIcwavX1UjvIaykG2a8dKKLABrmsOq9xTd7k2QSZL2xSiFzKSOKFJfMyVRQBLenOa3KHaDdhRVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042707; c=relaxed/simple;
	bh=N9hw8Ri7IUbQtn8HTQRQ3CpuXmDT9HAdbE5WJ27I/2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tWpTaj229nBi1gDSGOkWkiooes/oFwVefwqCvtVhTcegHoq9xMziY870h4eR9B/esNw0hWjf00Cb6xnMsurVEE9L9LcrNiMJ+1HTx0W54Fhcy+s88goiDqmupoUShjwPOfk2oAzdcgh4cts8k7wuFIPF9nrYJatTZxlQCRAZra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=HUXP8HtD; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="HUXP8HtD"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IYgth449479
	for <ceph-devel@vger.kernel.org>; Thu, 6 Aug 2026 14:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=E4r/
	Kz62Dp3MnNegLcstylRZKtOlPDdEQUeD76T1NRw=; b=HUXP8HtD2W9xKBV9xfAr
	9LPpNCOEQJgXhH8rxQCaGu/K+rhFN0xajLHugIRl/cQmDxmd+NM9Zmo7q2X4PiGb
	Nwruq6hDE7L8gZeMrmu2ayb7U9IElIGtm7txA/vhPkW87XOwPS79xQuVdK2gusVm
	8TC5+tOqLKk45W1QeYkHYntfLL9kIquuGBFLscxcCSkQWbXv6sg2TrKUrX8RlZW+
	S9QHqB1IuYIyD3lQZYwJqpk05xIVAMJSXb5fXDr1hfTG47yp0ay4KOfHjJel3ZvX
	GYl0kuWf2gM1eucIRZZmEVCLFRV9IosDOZ/IuZ6XSQXtMD2G9pE4nJ8XrySm72Ni
	QQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fvy3s8e86-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2026 14:58:15 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5276aa86d00so25457191cf.2
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2026 11:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786042695; x=1786647495;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E4r/Kz62Dp3MnNegLcstylRZKtOlPDdEQUeD76T1NRw=;
        b=H8CrfUsvtn7IsJjxPCtpMjPmgGV/48VgwoUCG2xcDP4k9Yd8zDPdySsMYcwM5LYtfp
         vSveRV72HNmAdg/z9U1h+7Xr0JBBgt3Uao9uBROStHMZQclPyv9pCKNYHaQmIZ1r2YnX
         2h4QnhIiAsljhOmYC3GnnxYoJUfrYRiCUso5rHmc0eiXyNfiah0P9TRY73CnVK4U2Xi5
         hShqqZUwpksVYyw9FRNMcYkPEij0Kb6jpaYAM7dn44HSNzP6/p1IjO7Kk7s5xgcVB+W2
         BuevtoDSsx0yis80dbYhGB/FajzBnLLAYECfU9H4n5B+pcx6xuWQHGdXO4pE2V5fYLCH
         2mHA==
X-Gm-Message-State: AOJu0YxAvgCvmXmchUCrLyLYwfYHzME9zDFV2/NGEqT+fMWLUcU8xJ0b
	Rwwgi4UYGJsqpYb14nVgt6wEaB40e54UaKuIm9fwfgkGaZkacTIdt9Nc0ZFGXTANAHgwrySvRVp
	v0wn+eF2cvIFzpi86rCfrEncb6GSQg1Yefb4DNdikyv3sH54o3HfOGrHLlw4=
X-Gm-Gg: AR+sD12LeOGHx3B073t00DwVfavEZxHL50nkTAReaQbs9ctVOscX+DrAQDittCWEqP1
	8RYbm3Poa1s7AfSfduYGcV66c7YOP1nmzSEUFuAE1BRE2le19Iji3rdbqn6sZGD7Z2Lcw+nyutg
	FzebknyZxJmuZZ+MVp3hxz5LZE05mWApr0KBIZx51EBEF0WTjGTvgW4upCF7VaCc9fD78Eq6izy
	5E5P/VdKM+HPwhOrt/h/r+VSJKldZse7mDMHUxCh9HTe0CRA2ofcOoIvjTUIEHH6L8tEZRtAf36
	wp6xFMpwG60uE4RDB/PZs4gubXT0dfXYtN2/KgLT1hlhRYAOYlVwkaEtlETvtGi5riubc6XcSFX
	JL05z3kvwJlvRXn1XlHzwDgvpVrWMoBKBSjVYL7Nqv2vkXP6XbeP7/ChAcjkZ580J
X-Received: by 2002:a05:622a:8893:b0:51c:f8f:13d with SMTP id d75a77b69052e-52ce61bd900mr186870261cf.37.1786042695453;
        Thu, 06 Aug 2026 11:58:15 -0700 (PDT)
X-Received: by 2002:a05:622a:8893:b0:51c:f8f:13d with SMTP id d75a77b69052e-52ce61bd900mr186869731cf.37.1786042694934;
        Thu, 06 Aug 2026 11:58:14 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:782e:b593:3821:1a47:8a5e? ([2a00:a040:199:782e:b593:3821:1a47:8a5e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995bb88b41sm7274825e9.0.2026.08.06.11.58.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 11:58:13 -0700 (PDT)
Message-ID: <f835fc25-7841-47ff-bb2a-7f91b534dec1@columbia.edu>
Date: Thu, 6 Aug 2026 21:58:11 +0300
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] ceph: convert ceph_submit_write() to folios
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
 <20260804-remove-wait-on-page-writeback-v2-5-81f0ab065284@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260804-remove-wait-on-page-writeback-v2-5-81f0ab065284@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=UY9hjqSN c=1 sm=1 tr=0 ts=6a74d948 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22 a=5poVChmWhSypMT2yhmcA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: lEBOls9E3cvnOwBYQU_1m0lyHkeXkKbr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0OCBTYWx0ZWRfX4wbk3g87wuey
 ahSDAjM9WZONRApHxLR9/hHpGNX1KDn1MFrzM/5gsj+5V8QA01EwrQtp7SYfO9WALFb+u7BxpBz
 ICTgWAwgMrKmg+sfpGh5FDg0u4aah/PoPmacAXG0OEImInXXBGoG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0OCBTYWx0ZWRfX3hen8D5hw8L/
 hQlUoCNHvVI5SLoF7qElEqMOix+J76+BLFAx3KbqM0UWhGRuhvbwqbpg+u1RXAWDcT2u67w9xNp
 4v6R2S9ARNsDeOKYHXj7HORSLSTcsa8ovIASp6yB72wxaWJUKgAG3BMe6z92rZAFA5VxgQs6H71
 c+QYOTMUm5iZB3QPnORKTTtmgyc7iYdkzWMFgG2r4GDCeLzBvQaVYqkvUj7Fe9mOZinfFCqQLcM
 4Uf3QV228Rv6hHPd/TlF4BX9+NjuryTlfgQtkkTuoC+cnAj5otS6kIk5dItBw3Crswf7f6xKdH1
 NPaVxdcJyfaCiYeKNhhl3DVTkEkNXQfr+slfgKE4gfC9j6x7GZR7BTx2he3XoRZ61PLO1BlvRXi
 E2a1+97dt4S0/MUWcnsohFR22GKSjfkn4UOW6RE6vJFH3ORBbIF86NM3AJ58x7wwqDCZjJutuNi
 vyXy3j1+dEc1uLu9uvw==
X-Proofpoint-ORIG-GUID: lEBOls9E3cvnOwBYQU_1m0lyHkeXkKbr
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=10 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 lowpriorityscore=10 bulkscore=10 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060148

On 8/4/26 2:52 PM, Tal Zussman wrote:
> Convert the request assembly loop and error paths in ceph_submit_write()
> to folios. This drops ceph's uses of the set_page_writeback(),
> redirty_page_for_writepage(), and unlock_page() compatibility wrappers
> in the writeback submission path.
> 
> Add ceph_folio_start_fscache(), a folio counterpart of
> ceph_set_page_fscache(). The remaining caller of the latter in
> write_folio_nounlock() will be converted separately.
> 
> In total, this removes nine calls to compound_head() hidden in the
> page-based APIs, while adding four explicit ones via page_folio().
> 
> Note that get_writepages_data_length() must still be passed the
> possibly-bounce folio, not the unwrapped pagecache folio, as it checks
> fscrypt_is_bounce_folio() to round encrypted lengths up to the fscrypt
> block size.
> 
> No functional change.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/ceph/addr.c | 44 ++++++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index c81e9da42df9..a96986c503bf 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -553,6 +553,11 @@ const struct netfs_request_ops ceph_netfs_ops = {
>  };
>  
>  #ifdef CONFIG_CEPH_FSCACHE
> +static void ceph_folio_start_fscache(struct folio *folio)
> +{
> +	folio_start_private_2(folio); /* [DEPRECATED] */
> +}
> +
>  static void ceph_set_page_fscache(struct page *page)
>  {
>  	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
> @@ -575,6 +580,10 @@ static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, b
>  			       ceph_fscache_write_terminated, inode, true, caching);
>  }
>  #else
> +static inline void ceph_folio_start_fscache(struct folio *folio)
> +{
> +}
> +
>  static inline void ceph_set_page_fscache(struct page *page)
>  {
>  }
> @@ -1436,14 +1445,14 @@ int ceph_submit_write(struct address_space *mapping,
>  	struct ceph_client *cl = fsc->client;
>  	struct ceph_vino vino = ceph_vino(inode);
>  	struct ceph_osd_request *req = NULL;
> -	struct page *page = NULL;
> +	struct folio *folio = NULL;
>  	bool caching = ceph_is_cache_enabled(inode);
>  	u64 offset;
>  	u64 len;
>  	unsigned i;
>  
>  new_request:
> -	offset = ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
> +	offset = ceph_fscrypt_folio_offset(page_folio(ceph_wbc->pages[0]));
>  	len = ceph_wbc->wsize;
>  
>  	req = ceph_osdc_new_request(&fsc->client->osdc,
> @@ -1467,29 +1476,28 @@ int ceph_submit_write(struct address_space *mapping,
>  		BUG_ON(IS_ERR(req));
>  	}
>  
> -	page = ceph_wbc->pages[ceph_wbc->locked_pages - 1];
> -	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
> +	folio = page_folio(ceph_wbc->pages[ceph_wbc->locked_pages - 1]);
> +	BUG_ON(len < ceph_fscrypt_folio_offset(folio) + folio_size(folio) - offset);
>  
>  	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
>  		for (i = 0; i < folio_batch_count(&ceph_wbc->fbatch); i++) {
> -			struct folio *folio = ceph_wbc->fbatch.folios[i];
> +			folio = ceph_wbc->fbatch.folios[i];
>  
>  			if (!folio)
>  				continue;

This, ...

>  
> -			page = &folio->page;
> -			redirty_page_for_writepage(wbc, page);
> -			unlock_page(page);
> +			folio_redirty_for_writepage(wbc, folio);
> +			folio_unlock(folio);
>  		}
>  
>  		for (i = 0; i < ceph_wbc->locked_pages; i++) {
> -			page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
> +			folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[i]));
>  
> -			if (!page)
> +			if (!folio)
>  				continue;
>  

... and this check are unnecessary. ceph_fscrypt_pagecache_page() can't
take or return NULL, and ceph_shift_unused_folios_left() compacts NULLs
out of ceph_wbc->fbatch. Will remove both in v3.

> -			redirty_page_for_writepage(wbc, page);
> -			unlock_page(page);
> +			folio_redirty_for_writepage(wbc, folio);
> +			folio_unlock(folio);
>  		}
>  
>  		ceph_osdc_put_request(req);
> @@ -1506,8 +1514,8 @@ int ceph_submit_write(struct address_space *mapping,
>  	for (i = 0; i < ceph_wbc->locked_pages; i++) {
>  		u64 cur_offset;
>  
> -		page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
> -		cur_offset = page_offset(page);
> +		folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[i]));
> +		cur_offset = folio_pos(folio);
>  
>  		/*
>  		 * Discontinuity in page range? Ceph can handle that by just passing
> @@ -1540,12 +1548,12 @@ int ceph_submit_write(struct address_space *mapping,
>  			ceph_wbc->op_idx++;
>  		}
>  
> -		set_page_writeback(page);
> +		folio_start_writeback(folio);
>  
>  		if (caching)
> -			ceph_set_page_fscache(page);
> +			ceph_folio_start_fscache(folio);
>  
> -		len += thp_size(page);
> +		len += folio_size(folio);
>  	}
>  
>  	ceph_fscache_write_to_cache(inode, offset, len, caching);
> @@ -1556,7 +1564,7 @@ int ceph_submit_write(struct address_space *mapping,
>  		/* writepages_finish() clears writeback pages
>  		 * according to the data length, so make sure
>  		 * data length covers all locked pages */
> -		u64 min_len = len + 1 - thp_size(page);
> +		u64 min_len = len + 1 - folio_size(folio);
>  		len = get_writepages_data_length(inode,
>  						 page_folio(ceph_wbc->pages[i - 1]),
>  						 offset);
> 

