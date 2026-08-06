Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449638AC75
	for <ceph-devel@vger.kernel.org>; Thu,  6 Aug 2026 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786045910; cv=none; b=PmpkF92eig8OOP7XGdzJ89v5RKuYLPywqWRngUBvWhrH8yy7RShk9IJP+ycEDQSoFAzKj5016m2rXmpBHgEUFZkEMTO1fNZWFKGbqwcbeb29nERks/XvInjFcmOz3kP6eLRzx9DAg3L0ZND+pZDMpUUYOLNHjKURl8gWBVBaIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786045910; c=relaxed/simple;
	bh=lTTpjODhYHba5wOLeu29fKL9Vo+uC5X6ugh4lCvBx3s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UHP9PzIAdWiqva1+Je44QUnPKfnsFv8TsW5ggBth1mSz+SkdyVP6zeyYMyk26Qk+EKz5ZEdutLSnGZbSJEGEz++PWpzv2k+hLTQyAuwjgEHxcmjd6Nh1is+9tr0if2nnFmFVFGLG6wcL4TC8MKTa33RZTXhRfyK+yAU/Wxl5fII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=YxHt4sU1; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="YxHt4sU1"
Received: from pps.filterd (m0167069.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IYLcs3435394
	for <ceph-devel@vger.kernel.org>; Thu, 6 Aug 2026 15:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Zkma
	NtQ8BSIkFCQ/5kE6NoXn5l5qzjWnoHIHZn2DAkI=; b=YxHt4sU1bLe939IWOhZb
	iVMmeBgmLwWs7T31I0opvtRBd0Nipn73SR99bDHGSlepuLOnV0Qgyt4RI5h5RRrV
	NA6iRkzhwa0faVOYd94hoCW+jnQtUot0zZqwgoU5fmQeZjZyXNDK0VMBcBUOCTH7
	fwoUbvzoe1Ai/S1oI4Xj246I/6m3WDt95ZjM7EdrFgnsKcV8n5D1snn8JJOCmaHK
	4fYcWO1QlqRfRcd0F4Pk+5P6bqZHXNEr4IiwDayCqCMUMoDyb0jppMuqUuny+xVb
	rXFOEkWflxcTfPBs60DV1RZFaeUdravsdMUMrVZE6Vg+8fGhl8wrqP+iFWRkszAA
	yA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fvy2xgu6a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2026 15:51:41 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52b4f6ac06aso40908981cf.1
        for <ceph-devel@vger.kernel.org>; Thu, 06 Aug 2026 12:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786045900; x=1786650700;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZkmaNtQ8BSIkFCQ/5kE6NoXn5l5qzjWnoHIHZn2DAkI=;
        b=TGQValM7sEKBT7wz3GPBpoUMgaXZ9p6ptyjOsysA0pjv0/YLcRRFC8Y9YKdER6zZHC
         VvT41XAxrmUSBhldyH2+d47kbQ8k+40OQhPS7MYfgjILDWOhQlFm04VJT7UxOf/2ZBQ5
         b87T/yvbF20eJQZqimH3awW9TtuJe44QLyO20lNmwWhMvdc1b7U9OMSqVoEinWdl4/iO
         VSFs6hOo5jpTWdnijfcrPdPtqf4yMdshiq4Ak4ONB+a19bvO0fhdRvjfkbrrVm/BySQT
         KbbnZtIoSBjrIXhx/7w8xjJsttFSoSQgmEdoFXkBkezRZ2ushGjAzOrZDgUaCZmXzVNf
         rKEQ==
X-Gm-Message-State: AOJu0YwNH2EmrAKPQ4/ZhbMeUwqbspr6T+zY4rQL6eNSpgJZGZaoYKF1
	x9rtQXY6iMUxe2ltrww8P0TnMBsXoyuCk4k//cVMhrNZqfsi4GPBKP4IYKuMj75MIUlAxy8+YHJ
	PvkpcTqhsknazo1LToJUqrk4PFGaj000ccN2JF76zRqq3/kidwIg6MDTaJFQ=
X-Gm-Gg: AR+sD12ll0qVqfRaOj5iULIuehIgGYDdlD2iLr7Xn8Lt4avzSn4EgBrj+FXlhBiSLiJ
	6cD3Ov3WHW61EAMF4bSchjWMtDlstdcf4ZvUuQpxXIswCB6Y34t3eYelHx+osTKtd+3OF0V16rS
	EIMpR8y3oojJXimvIW8KvYwhOtDpXo/9fDWxa6ASZca6lCiGC96UG0M9ZeaSIURoI9duXjro8bV
	e1OXXSwVvxUH3cG7PAXxkQmPOH//c+ukDtg593WelSQEHGTMMB3JWahJ7xMtV/1yL6PfiSbDo1T
	z9C17qtyn3C5EeESa8pMQE4hHm+81pyVs6WnzIsbVS0enh2TNLRJxajqxi2EM4Hygk6a7cM9Lv0
	Jyhsqa4uzo/jOmo+P1Xl05BghWuMBINIsL2gv5zzETMsUUVl3gc2XHxKiBLzP/x7q
X-Received: by 2002:a05:622a:261a:b0:516:d83c:edb6 with SMTP id d75a77b69052e-52d0b06e247mr51577041cf.12.1786045900653;
        Thu, 06 Aug 2026 12:51:40 -0700 (PDT)
X-Received: by 2002:a05:622a:261a:b0:516:d83c:edb6 with SMTP id d75a77b69052e-52d0b06e247mr51576641cf.12.1786045900174;
        Thu, 06 Aug 2026 12:51:40 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:782e:b593:3821:1a47:8a5e? ([2a00:a040:199:782e:b593:3821:1a47:8a5e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b529fsm9689344f8f.12.2026.08.06.12.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 12:51:39 -0700 (PDT)
Message-ID: <43fbe30d-54da-4bcd-ad2e-5391b327b642@columbia.edu>
Date: Thu, 6 Aug 2026 22:51:36 +0300
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] ceph: convert ceph_submit_write() to folios
From: Tal Zussman <tz2294@columbia.edu>
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
 <f835fc25-7841-47ff-bb2a-7f91b534dec1@columbia.edu>
Content-Language: en-US
In-Reply-To: <f835fc25-7841-47ff-bb2a-7f91b534dec1@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE1NSBTYWx0ZWRfX8msox662u/17
 wEy5tyBI8XeQ3fxJwPHnRnK12YTirZmMS3JyFVOZwWbV9k4tF9sHQwT4cp0NUTfZW7zqVvfRJz/
 BkD+9HT2TnD8eQ8Wtbq8FIy31Laee0Umhryn1oIaw51YGMLfNM2kdgFlt4VTasjsSQY+k0pKa0O
 c8cEisGiheYr83b/OVra+8XW7A0iD5r8psMjODogtlqayVTObBQsYEj4nwLuWPpjYqARmBlYW4z
 plWoNtVGpte+Qt4zADy+1aDLs496ws+WQfvOHYhB965tNj7uElgbT1FA+EqxkMhPtvZJ7WXmxPI
 lOzbBLRuYSfpPky7OsXNFr9pU9ae+ATr3uuMX+t8zsDDQzG4L4N1G07afH8M32tQDeOZrY5fOI5
 4S20IBThj7ja18TbYe6+4PQCIJIq6BYqhjqFke7O7w+E7XR1sS8cOKVtfeMiOTSFyt2FYIoF56T
 HCB84LWt08JUqy5CESQ==
X-Proofpoint-ORIG-GUID: WHaLchi6JUbSlLHyp2SuecBpbYEFTcFq
X-Authority-Analysis: v=2.4 cv=bP8m5v+Z c=1 sm=1 tr=0 ts=6a74e5cd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Da8U98TiO7q1upZEImrf:22 a=JR4YdQiviy7OQf72WyZ1:22 a=b_efBAy1TN-SQDnTdmkA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: WHaLchi6JUbSlLHyp2SuecBpbYEFTcFq
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE1NSBTYWx0ZWRfX56VGC9Lux1Z6
 Kx3kH8/dG5GrOe/Y+kPw6zblnN/BdBRsBHZx8Zccg6nbqabJCWlzNSWBLqk+7eU9qGd084qyD4h
 e2BzNAf7Mz7HqMl9E+kk3eHYaKDAhO1obL/hIUrn+20uXxAokIkj
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11867
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=10 impostorscore=10 spamscore=0 lowpriorityscore=10 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060155

On 8/6/26 2:58 PM, Tal Zussman wrote:
> On 8/4/26 2:52 PM, Tal Zussman wrote:
>> @@ -1436,14 +1445,14 @@ int ceph_submit_write(struct address_space *mapping,
>>  	struct ceph_client *cl = fsc->client;
>>  	struct ceph_vino vino = ceph_vino(inode);
>>  	struct ceph_osd_request *req = NULL;
>> -	struct page *page = NULL;
>> +	struct folio *folio = NULL;
>>  	bool caching = ceph_is_cache_enabled(inode);
>>  	u64 offset;
>>  	u64 len;
>>  	unsigned i;
>>  
>>  new_request:
>> -	offset = ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
>> +	offset = ceph_fscrypt_folio_offset(page_folio(ceph_wbc->pages[0]));
>>  	len = ceph_wbc->wsize;
>>  
>>  	req = ceph_osdc_new_request(&fsc->client->osdc,
>> @@ -1467,29 +1476,28 @@ int ceph_submit_write(struct address_space *mapping,
>>  		BUG_ON(IS_ERR(req));
>>  	}
>>  
>> -	page = ceph_wbc->pages[ceph_wbc->locked_pages - 1];
>> -	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
>> +	folio = page_folio(ceph_wbc->pages[ceph_wbc->locked_pages - 1]);
>> +	BUG_ON(len < ceph_fscrypt_folio_offset(folio) + folio_size(folio) - offset);
>>  
>>  	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
>>  		for (i = 0; i < folio_batch_count(&ceph_wbc->fbatch); i++) {
>> -			struct folio *folio = ceph_wbc->fbatch.folios[i];
>> +			folio = ceph_wbc->fbatch.folios[i];
>>  
>>  			if (!folio)
>>  				continue;
> 
> This, ...
> 
>>  
>> -			page = &folio->page;
>> -			redirty_page_for_writepage(wbc, page);
>> -			unlock_page(page);
>> +			folio_redirty_for_writepage(wbc, folio);
>> +			folio_unlock(folio);
>>  		}
>>  

Actually, Sashiko points out a deeper issue with this loop:

"Could this unconditional folio_unlock() crash the kernel?
Looking at ceph_process_folio_batch(), folios that fail folio_trylock() or
are already under writeback are left in the fbatch array without being locked
by the current thread.
Then ceph_shift_unused_folios_left() shifts these unprocessed, unlocked folios
to the start of the batch.
If ceph_submit_write() subsequently fails the ceph_inc_osd_stopping_blocker()
check, it iterates over all remaining folios in ceph_wbc->fbatch and calls
folio_unlock() on folios we don't hold the lock for."

...along with 5 other pre-existing issues.

Seems like the folio_batch loop here should just be deleted? But that seems
like it should be a separate patch with a Fixes tag...

>>  		for (i = 0; i < ceph_wbc->locked_pages; i++) {
>> -			page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
>> +			folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[i]));
>>  
>> -			if (!page)
>> +			if (!folio)
>>  				continue;
>>  
> 
> ... and this check are unnecessary. ceph_fscrypt_pagecache_page() can't
> take or return NULL, and ceph_shift_unused_folios_left() compacts NULLs
> out of ceph_wbc->fbatch. Will remove both in v3.
> 
>> -			redirty_page_for_writepage(wbc, page);
>> -			unlock_page(page);
>> +			folio_redirty_for_writepage(wbc, folio);
>> +			folio_unlock(folio);
>>  		}
>>  
