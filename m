Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107114399D5
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621299; cv=none; b=UMi/w+d7nuygAUQ44QHQNllK65mhV8uIh5JCBDgUomyasA6UbvRfMd+INcoHvjv0gfM5jIE66//GgUDY7cNYyLl1uUm999m2gjyxk4YmxC0iuL6oWjoegHOhwccmtia7UqTv4482ED1asSbg4MCPfESi47j3iMZAv7tMqDCaby8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621299; c=relaxed/simple;
	bh=ER1vjiejM5UmIsefjJY2m4flgrwRwZhTj7RV5RgEdK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bhKFNTIDot9TClTFQwl9Ax/j1Z6F6EBwh3Opy/95pI1v2Blph+W9u61aCmR6zVqwQStH4fDla7A8d1cAGglosN+lkRDpoJpmO1nbjDFyFPCMYvqcVaaScu9Gw4oMELQ+7GxGegAjm0zh0TlzlDrzoiUEx6ainFCaMOrKlfaPcKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=YfZwfaVD; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=x+zs0Q0a; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="YfZwfaVD";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="x+zs0Q0a"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D7tTX43193539
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 07:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=rVz7
	2GA+vdRIWxRQA10KvguyAguyaHOATy5QoCsghJE=; b=YfZwfaVD9pgYxW5dK5Sc
	d15tdSh3G2oDDYn4pWtYaX/gILjanbdkJW7ERmjP2bCWrwJTqw502aGxs20M1qk2
	OksuGS8MfsTVxcTXCn4HMa1+12YwkuTm2c0wEB5NACT/KVP5Ahd2y7ICjjJd23BC
	XrauzCRilEDCMWnRfJmgfBbSEYT/ZAwC26m4zNr5MlGtAJ0cxgoIQdOUXJ1i9aPQ
	HRMZoLnDEb2MTIYweU72QUXWlSlrWQz12U/7V+4rpTF6oLd+XRCedg2jUyHZWnEi
	EHojwLdoWLoZEHGBiBSonG6fqhMsjN/3FGI86Mp7y6QBIOw96jLXr0jDJadW75aX
	PQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g12gnhwmq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 07:41:30 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930edb4362dso59924985a.3
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 04:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786621289; x=1787226089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rVz72GA+vdRIWxRQA10KvguyAguyaHOATy5QoCsghJE=;
        b=x+zs0Q0ad5w4BxYTch/taFU7qgz662JY1OJ//UITmHAM74aw37touT3KXngl+QDEWy
         7KBgkRqcHAca9+bgRGRUH9H2es0qk72Z3Lw8TP3DZ4Tsn3ThOdGytsleRoEx002a3rcf
         j/1KNmVG3Ji1CKtI/Y7mcuv5t7y3ZNetDNg8u/Dryvo7muNH4bUGCRFlE88Rg8L/mOCl
         M6eomV40dVoQ7OVOz0JZi5haIyEGQ+DDZe5aqDKl9sn1dJUDLRNI8pHMfuI5Q9PqW7Df
         3VOGWSZxLjR6oECqs42Sty1vVV0niGbiUaLLIyqRINknycyShbLbT+Sq8/++WMGF3Ltt
         ui/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786621289; x=1787226089;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rVz72GA+vdRIWxRQA10KvguyAguyaHOATy5QoCsghJE=;
        b=f6sqUWM1iJdvZ5EdTl/XhDZaGYg/nmFMUBU9TIm7SA1cfSgcHz/xvg0Dvs9pSCL0f1
         C+uIPzZCUq83ex5WSo2tfpKx13NZ8v+BDXWqh5dyTQRpYrtlv8UgoqNUvMyebm4hhMC/
         il7zEAmhcuKHVPYVTcAQz+Hu3L+liLeK995tBobDAzM4tkmSyA8+JX1iAdnDIKY/aXs7
         qP1Du6b1QmU7Lx5K568BdIICsnh8K9VZv7Sitpzn5d+mRo1WvE4tB4C95tqusctyIVyj
         hJ0Tj4YbKAT/OKhUSzajeAuAtTKzrUXmTveDgNGmYyc4ShDkxLF2NXjG+5h3KtPf2OpJ
         AG8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr4ubWQAQXfYhENkoMxW1Fs+vI+zPyAw93rsd7IdGQInsPF98ee3pXmU/KbFrpFDggBJh5Na3w7azbh@vger.kernel.org
X-Gm-Message-State: AOJu0YwGCfJjHku1mKd9uxfe1WV0rBsrpQ1/IKYOAvy6XKRXiaVjbYU7
	TPgcSAukNs+FCKzXN89KjQEEC0A2cj6kkpxdQdMVmMymm6vqEGFaHrfxPW+AOm4+BGx+p1gW1Bo
	uc7JXWBAEiM9dxVPFQ/ESY2+SzJGbtZspztcidWvpvkkEVNXLy4N2AXPvF0A=
X-Gm-Gg: AR+sD11AAFxD+QLAMT1hYz3TuFxcj4HiPaWcEA2r9a313C6Am7UNOtuYeSbq7XxTy/t
	rrLMIsqLJVLqyakyHr4HXYHkcGXdH5g6DYVlxo00z3BSacF0epkGo3BprZwesKOAMtafqwA8YsC
	CPEKFEJMZqetE5c5hecY024QNZ17QxK96X17m68+XtZvyhQU6H0yEWqgWJ4F2UjSHGZUooy9FmO
	/9dcgcEwLdpKdgb5QQldQ25i/1K9eUv6FhNzns1Qt+ssWDdKnSm3FVY2Ttx0rf3F+OAY2i4dFQp
	Ctu/8h8Nhju7gDHFYbTgok39G1qj3ehG/q4cF9rj7rDLn7DlkBptbH+OmritPHmv2xU9j1lPkIo
	zwALYMNbkqpRUlpwJu+BjAeyiUctruU0bc55bVOJrBwskgZkK
X-Received: by 2002:a05:622a:578a:b0:528:2c84:eab0 with SMTP id d75a77b69052e-52d73dff3bfmr54838811cf.33.1786621289481;
        Thu, 13 Aug 2026 04:41:29 -0700 (PDT)
X-Received: by 2002:a05:622a:578a:b0:528:2c84:eab0 with SMTP id d75a77b69052e-52d73dff3bfmr54838121cf.33.1786621288936;
        Thu, 13 Aug 2026 04:41:28 -0700 (PDT)
Received: from [192.168.0.165] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a5b6d20sm5089848f8f.30.2026.08.13.04.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 04:41:28 -0700 (PDT)
Message-ID: <636c10c2-298a-4d39-8628-938accf56ff7@columbia.edu>
Date: Thu, 13 Aug 2026 14:41:26 +0300
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: remove the dead dirty path in
 ceph_put_page_vector()
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260809-ceph-put-page-vector-v1-1-57ab2a08ec90@columbia.edu>
 <CAOi1vP9j72RiKGiwPo6oRe_sA1VjjORUPDvEYAsraLnH55pcwA@mail.gmail.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <CAOi1vP9j72RiKGiwPo6oRe_sA1VjjORUPDvEYAsraLnH55pcwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I8tVgtgg c=1 sm=1 tr=0 ts=6a7dad6a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=fiz2_hdFBI5Iw7qclBsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA4MiBTYWx0ZWRfX/4Yzf/i6HkkM
 mh8UHVH3PxBn6afHWjx48zU/NE+eIbo8MzlH7+VduX8olAlN9aucEMvuYkcFdIfp/ivpquHAmhz
 2X8tPqF5NIjuN/RR0vz6xakpYH54U+EHEcd/hTwbk8dYzfGDmdT/
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA4MiBTYWx0ZWRfXzZUc0htj1JcZ
 0PrvCZkQnr7eU1ZKWCu+oIkDHgEWPcitnTzviAI6YP/42uu0EOAAMkXanDyw5kDnJh2GnzIngSZ
 M1CBCDXcFziGBM2vv6cCYKIL71nKwGqNefDQpUWFcUIkvpbVJdqQwIfkpa6MQJN/Kn5z4RQsav7
 vLWGcaQUjLqf7O8o1k+rQgWJb8boIQFgsNSiHjUmMfyEbAM0LPSUvRb3Q9OuaWc/A1PccjCwDMB
 jaXWBh8LQLMXMUp1WwOPIxikv4KyZ2AHuvj2HY/TKPpHlwH2U1hZ8I3M1HfeGUcVXx6T5+Clip8
 1WfDKp1pfgxi7hqHmQeAQ0x6reXPOIy2q+DNpkmbfIb6+QIIYSMciBIgn+6QU0e11qDWQH2tCTn
 8+q7OhRCe5Ddy5JBjbQslFnyFaCY7qznZIAD/E5rPREsKfArPMCXnfvbfIDX401lNi8epOM/UbA
 hO3x3DrPMecJw0J9kpA==
X-Proofpoint-ORIG-GUID: rr5UwKzPkN44MU-nCrC4VYWD8taftoye
X-Proofpoint-GUID: rr5UwKzPkN44MU-nCrC4VYWD8taftoye
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11873
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=10 phishscore=0 impostorscore=10
 malwarescore=0 lowpriorityscore=10 adultscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130082

On 8/13/26 4:11 AM, Ilya Dryomov wrote:
> On Sun, Aug 9, 2026 at 5:04 PM Tal Zussman <tz2294@columbia.edu> wrote:
>>
>> The only caller of ceph_put_page_vector() passes dirty = false, so the
>> branch is dead code. Remove it along with the parameter. This removes a
>> call to the deprecated set_page_dirty_lock().
>>
>> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
>> ---
>>  fs/ceph/addr.c               | 2 +-
>>  include/linux/ceph/libceph.h | 3 +--
>>  net/ceph/pagevec.c           | 7 ++-----
>>  3 files changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> index e2da3ab9f808..83752f3688fa 100644
>> --- a/fs/ceph/addr.c
>> +++ b/fs/ceph/addr.c
>> @@ -257,7 +257,7 @@ static void finish_netfs_read(struct ceph_osd_request *req)
>>         if (osd_data->type == CEPH_OSD_DATA_TYPE_PAGES) {
>>                 ceph_put_page_vector(osd_data->pages,
>>                                      calc_pages_for(osd_data->alignment,
>> -                                       osd_data->length), false);
>> +                                       osd_data->length));
>>         }
>>         if (err > 0) {
>>                 ceph_subvolume_metrics_record_io(fsc->mdsc, ceph_inode(inode),
>> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
>> index 63e0e2aa1ce9..3098306e6173 100644
>> --- a/include/linux/ceph/libceph.h
>> +++ b/include/linux/ceph/libceph.h
>> @@ -313,8 +313,7 @@ int ceph_wait_for_latest_osdmap(struct ceph_client *client,
>>
>>  /* pagevec.c */
>>  extern void ceph_release_page_vector(struct page **pages, int num_pages);
>> -extern void ceph_put_page_vector(struct page **pages, int num_pages,
>> -                                bool dirty);
>> +void ceph_put_page_vector(struct page **pages, int num_pages);
>>  extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags);
>>  extern void ceph_copy_from_page_vector(struct page **pages,
>>                                     void *data,
>> diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
>> index 858359873c4d..828b003aa2fc 100644
>> --- a/net/ceph/pagevec.c
>> +++ b/net/ceph/pagevec.c
>> @@ -10,15 +10,12 @@
>>
>>  #include <linux/ceph/libceph.h>
>>
>> -void ceph_put_page_vector(struct page **pages, int num_pages, bool dirty)
>> +void ceph_put_page_vector(struct page **pages, int num_pages)
>>  {
>>         int i;
>>
>> -       for (i = 0; i < num_pages; i++) {
>> -               if (dirty)
>> -                       set_page_dirty_lock(pages[i]);
>> +       for (i = 0; i < num_pages; i++)
>>                 put_page(pages[i]);
>> -       }
>>         kvfree(pages);
>>  }
>>  EXPORT_SYMBOL(ceph_put_page_vector);
>>
>> ---
>> base-commit: 30c0913a2b44a66dc17283a88489b3f3e12f4327
>> change-id: 20260809-ceph-put-page-vector-458bb3aa87f6
>>
>> Best regards,
>> --
>> Tal Zussman <tz2294@columbia.edu>
>>
> 
> Hi Tal,
> 
> I'd suggest getting rid of ceph_put_page_vector() altogether -- it's
> pretty confusing to use it to put something that wasn't allocated with
> some ceph_*_page_vector() helper.  It looks like ceph_put_page_vector()
> was paired with ceph_get_direct_page_vector() which is long gone.  The
> put_page() loop and kvfree() could be done in that single caller.
> 
> As I was looking into this, I think I spotted a related memory leak in
> ceph_netfs_issue_read().  On the fscrypt path, the "page vector" coming
> from iov_iter_get_pages_alloc2() isn't put in case of EIO caused by
> ceph_inc_osd_stopping_blocker().  Alex, please take note.
> 
> Thanks,
> 
>                  Ilya
> 

Hi Ilya,

Thanks for the review!

I'm happy to fix the ceph_netfs_issue_read() issue as well in a separate
patch by using ceph_put_page_vector() there (for backporting purposes) and
then inlining ceph_put_page_vector() in the (now two) callers. Does that
sound reasonable to you?

Thanks,
Tal

