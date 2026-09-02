Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74494A3870
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 14:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788359654; cv=none; b=oPfyzxZoIw31xQnG0pb32QZ4NtQTkQHvKsxRRFq4yHXWkuju219arRotQ0nEzmSfys8Ni5vVh5a54m6MM1Jxt7fUYMRPxeCmzNvocs1sVModkvFrVlUkWmFEmsaEmhuHFn8tygcOiW/cdoGj88jXEhie8BsVSN2dZis66P0R6Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788359654; c=relaxed/simple;
	bh=FiIj8Mu/M5MlHNmrXdICXLmZM0g6OmS6W32hmfXxyIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbMEMTG9gpHCirQwOzairhN+ci3p+s5l9oUC7izcl8SPiMGjPi9GvkSR8Okfl7ltykLypzQ7gVkOLPOPBOmhNG0lvn6VXoUEAA/gN0zN71QbguTTHKyb9lo2+wAC5ISTAe6CWvNz93ofnnaLX25/msM+wLxYYZ4Zz5ZDYDUUqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=leWXjE2R; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=dUr/+Xbf; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="leWXjE2R";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="dUr/+Xbf"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682DnGpY4075617
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 10:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=5nq8
	F0xboXei8La9m4xhYCwKh6IJ8CtNFoD7hWN6IF4=; b=leWXjE2R9OMgS3Kr0MGQ
	pxvMVDL8XeBDSu8+tM3NjwSGeKHPK/86EjabJLTaUdwjcOSc6YCNjyAw59bFet6l
	slMFCA2Jbtpu453vxYOn0S9QBcmFmrc0gq4P2iBRc8CsONhhH153FBkBoZHUFWU0
	hED/3nH+IC68PvBWJUIgOET0yyDcdzYF58uAeJ7UfWnpaQtEEoHFhzSrg/QLPDKN
	w1CROv6PeuNr3zPiAYkl3wMFIyaai93LdbcTcmAiDFBqkgXQWZKAFtxMJ+2N9LIM
	C86ETTwNnCaUqH9PEa3+OitF6/CUInUyrWuWzu72yWxkfSI1+kMD94DLaI3DqLPM
	xw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gefkbj8w6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 10:34:10 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e820609d9so237810285a.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 07:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788359649; x=1788964449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5nq8F0xboXei8La9m4xhYCwKh6IJ8CtNFoD7hWN6IF4=;
        b=dUr/+XbfuBEt2LF5IWc/mFLnFmDAfMiMZCRrbsXWFytAWN3IzGaAjEDsueovAfPlB3
         DRQRLftPzybocsdBHzxA3YM2e6EK4iSwGxIEgLqtYHkozEXCJQKy5PUCLz/N8UaWy2Ca
         4rv20H+g33z/7Kv4fV7SYOs9Q+0n6TrsRPryvJt0Gfm+fxuvtLfMrRIG7n3RJyZ5L8yn
         AwSz/l5lVHIXM+94DHu7hHr5DlrnPP3bziipMRTnHJleqWGu7zQXBrG80DNHqzgirTA2
         FHTX5MEZ7Qfv5NV34Cfej1H94mZLE99kRP/bbIzrOuCnKPhklKTCtv43iY+km/U1fWVv
         mEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788359649; x=1788964449;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5nq8F0xboXei8La9m4xhYCwKh6IJ8CtNFoD7hWN6IF4=;
        b=izeQtQX6KIOZF8K6wWiEdXuGPjjm1Bjmrs7SGhneFnmQfmd1b+WEiOJw5sYK87RKYr
         fG9Q+VnKSM3981DdOVpv0ke3M1R+zBzo0T1rcg/RfIXJf2mCz+mHO9B6vfVmNjTELunY
         4r6kYZoswFgTFJMZIc7tg/fIGa+jhDQvl+NVHWG7wCzsXfr8lJthNYaDS97hq/M52j5I
         mnU60h8crDvy2NoWQTC/zFkFmWx4PpY3pNQYgvmNrbL13ol14BHCgdu1Zv74o5spI0Wd
         7zUNDKFIUKZg2TgjSC7Q1NlTqBHwFD5UoWzTLhcJX7wBFdPVT4M1V6EsFMQoAcnIM2Fe
         45Bg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/CJatn+Yxc/B8w4WpkeTth5uKvirjyO1EBGsDy+dNjiW+Bqxlhyjiguzc1YC93uEXiqcZvxe2LV1N@vger.kernel.org
X-Gm-Message-State: AFuF++lfq46huguhtvXoJYva/vZeHzxrAGJ4Z7/Ti+AKYvp4hCszz4S9
	Mm2EI8mQ2rSyqlAdiAlios1r+8nJl2AUZm39L64Yilc22UXiK6fIInGbmNPsWocE/odJGc5aaYv
	tHXb6EmqYWA/CeV23YM4xmj2LofxENwbdO0bj53WdLQtUpglKvfj7/UwrP8Y=
X-Gm-Gg: AR+sD13WRci2XWdeb/CNSlKqXF1w2/gP9ovfA9Rwdzrh4zHrXJXiI5IAuEpyetvuif8
	xgBJmYwJPsB0xI2T5XAGTT1h/HQvb/8nqxTGEdCdgqR25ZEiNSWt6xVyVwAyHe42CFRoatSPpq9
	nJ1kKgordSnaawgzAHTEOhn6slG6cA01tABpT8mcl4otVD3pLZdfI9g0b1SrCbvPew+pugWIlb1
	yJFrQhiZR2lanzTOQ6oDG6i57YS7osNrwIlBmb1AzKYzu0Cc4tz8pRWTe08W5nHndFS8PssSr4w
	Uv86ZhEKX8u3kpr1uiSuzUWM19kENekyJXfmb3y2YtWmciho/HJHyVpsXHFBA7a2/M9QiLPdBpZ
	vIpE2VkbSfRW7L2U7f+B/af1OrOpwGxlPxf+HwHbz6UJE0Xwfdfu2CW5lHg==
X-Received: by 2002:a05:620a:3196:b0:92e:71bb:d1c0 with SMTP id af79cd13be357-93960dea964mr622058385a.15.1788359649521;
        Wed, 02 Sep 2026 07:34:09 -0700 (PDT)
X-Received: by 2002:a05:620a:3196:b0:92e:71bb:d1c0 with SMTP id af79cd13be357-93960dea964mr621987485a.15.1788359646377;
        Wed, 02 Sep 2026 07:34:06 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d043e6bcsm152362966b.61.2026.09.02.07.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 07:34:05 -0700 (PDT)
Message-ID: <dac0f543-4687-49eb-87ae-500ecf32112d@columbia.edu>
Date: Wed, 2 Sep 2026 10:34:01 -0400
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] ceph: fix error handling when the OSD client is
 stopping in ceph_submit_write()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko
 <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Sashiko <sashiko-bot@kernel.org>
References: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
 <20260817-remove-wait-on-page-writeback-v4-1-0e5e53d47eb0@columbia.edu>
 <CAOi1vP8SCZaFTodwm3_c9cFfc4UB5X8J8vF-sxh+4TuhCS8iog@mail.gmail.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <CAOi1vP8SCZaFTodwm3_c9cFfc4UB5X8J8vF-sxh+4TuhCS8iog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 32qawOHlBTNmVfScEmdCvGxIUEn3zJOq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX96fnjh9wicIV
 GWix1DYRjK2DuWCN7tRyTAFcWRgvLSuOo5j4XG6+5Y2l2+jlr3BF9dpYmSt+MB72AouVzQ0fqBn
 ZGrxiR5sevANzY29wXPIWhO5m5M66dm9VwzK1VfcsGUIBhbB6xzp
X-Authority-Analysis: v=2.4 cv=aIzAb79m c=1 sm=1 tr=0 ts=6a9833e2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=uherdBYGAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=TZ2kbKYv5CYyi6T0hQQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEyOCBTYWx0ZWRfX3+3O/AbykKpl
 zW21PSRELogFerspZT+37/CU15ymDl38kJtkirSB2XOT1Smi3GNUmC2fTHUQQUlAyDi545EyFnG
 URxi7gFiTK87MoKI+crZkIHX+uhhc0If/gDkbXwNj+k2neqQVcCzvFo7nScG0w0x/0KRz/tWgMz
 VvuJXWK0iqqIR1+x12EX6unrsIZL2bNXhA3mDnEFcG+IjV7kgxW7ovHq6fE8OjIDz7WpVkPeMyl
 4KA4VYGwRSHuYy5Jc2SgqRwN+YgDwodGsqWR5cJLop/1kxCDVDeiJuiE4KIUKC269V+IgWtY6B8
 p3Y9Gy8L6r/QemZXjAx47d8nGBUYuSxeMBE1taZi2DyC/7FkULFg9XgZDLI+cgQmrtR6e7P4C0I
 byWS4/9LjAnN80HQaIi8fXJPGrqh3DbJEKu3+9UpIFBzXsqEDkaTwjn+VMKdDjJMhVYZwoq/P1Y
 /A0IS9stU8gtCZxn8TQ==
X-Proofpoint-ORIG-GUID: 32qawOHlBTNmVfScEmdCvGxIUEn3zJOq
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=10 adultscore=0 malwarescore=0
 bulkscore=10 clxscore=1015 impostorscore=10 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020128

On 9/2/26 4:44 PM, Ilya Dryomov wrote: 
> On Mon, Aug 17, 2026 at 9:15 PM Tal Zussman <tz2294@columbia.edu> wrote:
>>
>> When ceph_inc_osd_stopping_blocker() fails, ceph_submit_write()
>> redirties and unlocks the folios remaining in ceph_wbc->fbatch.
>> However, none of those folios are locked at this point: locked folios
>> were moved to ceph_wbc->pages[] and removed from the fbatch by
>> ceph_process_folio_batch(). Unlocking them triggers
>> VM_BUG_ON_FOLIO(!folio_test_locked(folio)) in folio_unlock(), or
>> unlocks a folio locked by another task.
>>
>> This error path also returns -EIO without fully cleaning up the folios in
>> ceph_wbc->pages[]: their references are never dropped, fscrypt bounce
>> pages are never freed, the writeback congestion count is never
>> decremented, and the pages array is leaked. ceph_wbc->locked_pages is
>> also left non-zero, so ceph_writepages_start() loops back around and
>> hits BUG_ON(ceph_wbc.locked_pages).
>>
>> Leave the fbatch folios alone, as ceph_writepages_start() drops their
>> references when releasing the batch, and unwind ceph_wbc->pages[] the
>> same way writepages_finish() would have. Abort writeback in
>> ceph_writepages_start() instead of continuing, matching the handling
>> of ceph_inc_osd_stopping_blocker() failure on entry, as the OSD
>> client is being torn down and further writeback cannot make progress.
>>
>> An LLM was used to verify that the cleanup was comprehensive, and
>> suggested aborting the writeback instead of continuing.
>>
>> Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Link: https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260804-remove-wait- 
> on-page-writeback-v2-0-81f0ab065284*40columbia.edu?part=5__;IyU!!BDUfV1Et5lrpZQ! 
> WQ0-twAxqcZ2nQ5MBrBDnqIxwPV4RXuFNZvUldEY6jTQafdUjhi46Zgym70Ltd8gwAKpSl92mam7YO- 
> tlU-7hw$ <https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284*40columbia.edu?part=5__;IyU!!BDUfV1Et5lrpZQ!WQ0-twAxqcZ2nQ5MBrBDnqIxwPV4RXuFNZvUldEY6jTQafdUjhi46Zgym70Ltd8gwAKpSl92mam7YO-tlU-7hw$>
>> Assisted-by: Claude:fable-5
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>  fs/ceph/addr.c | 36 ++++++++++++++++++++----------------
>>  1 file changed, 20 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> index 1f77aec8e960..d5a349daf4d0 100644
>> --- a/fs/ceph/addr.c
>> +++ b/fs/ceph/addr.c
>> @@ -1482,27 +1482,28 @@ int ceph_submit_write(struct address_space *mapping,
>>         BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
>>
>>         if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
>> -               for (i = 0; i < folio_batch_count(&ceph_wbc->fbatch); i++) {
>> -                       struct folio *folio = ceph_wbc->fbatch.folios[i];
>> -
>> -                       if (!folio)
>> -                               continue;
>> -
>> -                       page = &folio->page;
>> -                       redirty_page_for_writepage(wbc, page);
>> -                       unlock_page(page);
>> -               }
>> -
>>                 for (i = 0; i < ceph_wbc->locked_pages; i++) {
>> -                       page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
>> +                       fscrypt_finalize_bounce_page(&ceph_wbc->pages[i]);
> 
> Hi Tal,
> 
> fscrypt_finalize_bounce_page() was removed in 7.3-rc1, so this one and
> patch 8 need to be reworked now.
> 
> Thanks,
> 
>                  Ilya
> 

Hi Ilya,

I'll send a v5 today.

Thanks,
Tal

