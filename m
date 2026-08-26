Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44493BBFA5
	for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787738532; cv=none; b=GOpcxyD/nS584m6gdMQNYHWpceIxx4pptplznp/0H02IiBgdwLYylR9zwah/EZV8rFaV/f8va1KYx3jRQCgI1lC+gbGdpE75Pu1Lc+sZ2e4/H2c09uLL+8z4nOivoTx3D5ZtLLpd38dI7hyC2FqRdDJ3w9x9aKIYreqp6ndODBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787738532; c=relaxed/simple;
	bh=5LisEUK/giSujYDQjHUgKl1goz22Q3SNMIIB0q35Je4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmZGAQ+g1tSpkfq+PuT/zBx+wIIy7erD7cbYlFz//a/Afn8AChaNCg5yvEWhoZbjPsaB//ukASzVUX2TFyr1nfGxO/2AtOwsivZjyBaj4bLOQ/D+YR5VMKClTNorS1EZJ3k+XT1UYHNgoPyDAzCeqUow4U4rWKpYO4X/2XgWHkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Xb3zwTd3; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=MoYJRsDE; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Xb3zwTd3";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="MoYJRsDE"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q8vpdV3884287
	for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 06:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=1BFQ
	WlVuW7Dq36i7gO59DJjeODGZO1vfguxwwfEmyEM=; b=Xb3zwTd3+WXdjNaF8MR1
	66nX0RTH9G/R2QlrnFBMRTAmaHy912nw7NlaxtGIAvLMyvlMghHjJIu24zzX7NVB
	6wfWJc2auDaUlm0a12ESdBtKKWCE//VL0iipmSqcIflRUbyXOs1jivt9+DEY+aeT
	eut4SwXr51iLP6b9CLbalFFuMjGXdA8pXDCi8dH4IMatayhNU/qo2ArAHoopf5Ia
	oQY/FbtzeWfttyQZJog0iIJmRQVgWFu7DeqlF9EyHAdsdIWKWcvmuS4HzrFdNoja
	0Vim/SQTKfNX9R5Ato8yj0D3LrRuhYMC9fdTx6T0k7KQwlCpv5905uXpHdJT8ij7
	PA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g9pgr149b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 06:02:09 -0400 (EDT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-783b725c8c8so53985137.0
        for <ceph-devel@vger.kernel.org>; Wed, 26 Aug 2026 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787738529; x=1788343329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1BFQWlVuW7Dq36i7gO59DJjeODGZO1vfguxwwfEmyEM=;
        b=MoYJRsDEp3Np9ZcIgNZK96FZhgHInhBCGLcKZa38ththBhFHVkQ53hVGoHnRpn1UB5
         xUmrGpCw+bByJjFcoky8nFIkdj3lEp20nRanqJLV8a6g+rmGVOBuEhIzvpIKknzne154
         37nPfpe36dk+rhpmUDT3uBQyrQcrplVmYBdR8zAb0Jbpw2MibchRvHg7SsXKlgSA+KQ1
         WBsHomDiL9PKIwLvjs7dGGFJCIgUmHVK97v42sSyBn85tHYAAZLu9MRBqp1eh6nCGb1w
         //lC+RVth0K2ClpbR1OUpP5Rf13BRv5eihuhwVcYC/ICZNUPzJqbk+GzQub4ZmD2pqwd
         WNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787738529; x=1788343329;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1BFQWlVuW7Dq36i7gO59DJjeODGZO1vfguxwwfEmyEM=;
        b=Jb/cNwsdgWJ4xmi5wR3Nrk+16+K1/Yq21OmS7DLp3wsJHxsIStd0u4saL8vojza6g3
         EiqAXwks6BrdeLTFT1jcMKatijLYX3shcPuDxB2z9J4KJCtdieeJDiMJBz1cJjzKzyDe
         NUFA60qG5aBjQEw32gyO5elYzlZ9mFXT7vTt8J4B6/TnroHv3P0otl0THqfpsiNaNDN4
         RsRtjoumtq5wq7k7/l3WZ6ZoUJnggZ7p0s3Iyj2ilT6O8UXJ9Wz1eEfWgo/8Fmzmy0xv
         I64kdVlB4ZatRaK7ImX7Boq2XHYn6MgOcYHiEOifnte387/1Y8jiCDbCjRNNwiXIU0K8
         r3Zg==
X-Forwarded-Encrypted: i=1; AHgh+RrESAyfq43UOaCHQDvROf7KSmaHOK45FOOtJa73QgGzyWnHsZSbj3BIUPGaGFsJ3ERrfFxsWsROrF1q@vger.kernel.org
X-Gm-Message-State: AFuF++kfYBsns8woV/46RD28gVLC8EzQyq6oO1rtg6SUhJl0qQ0BnoYD
	rmWMPbuJ1ZXIj/uClI6yC9V2ZE831x1cEyeIuPQ0mBTSr8nxBvM7/z4RL8heaKv7W9VfOiekdvi
	eHvhJPFr/QWC6GJEA/N32qIbs78MkLxLV7W+hofYOOp1YIpkW9EQBr4Ruu/E=
X-Gm-Gg: AR+sD115IQ8vaTQ+T3AeTrb9V6iMwxqQbaMKhkCUkR3mrp59og1efeOygmWMKE9+ncW
	PJBfYv7wdc3EYUapGRTq7naCLxIDy7UVofTVqzcnyJuKYl3G1kSZKqxweXoNMykVBSXGGDGlrSu
	sdwvw7Ejm0EqRyAvXvMWpmrjqiAjUB+uJah2K9WwNMReMYJFp0YldEpLUDSgzkTDFzpa+Trl9Ef
	SzMceZjtKSEbYlorj+k5nh8JMVuvefBK0HFQw/3/Wr09SFAk/wZeKg+6otvQYMVdsQ4U4JvhEKZ
	Tp1Q81qdnvVqzgyI8l1a9UqSty18JNVggznY99Kn21lktMQO5Uk0bePGK36wI6o6P+W/4BQRUaj
	WAFLy+OQ9ruQe2orZJoiJ+iz3cBH7smRccef46+UBRHXovlo=
X-Received: by 2002:a05:622a:4297:b0:52d:89f8:4f8 with SMTP id d75a77b69052e-52e42235693mr50740151cf.5.1787738492841;
        Wed, 26 Aug 2026 03:01:32 -0700 (PDT)
X-Received: by 2002:a05:622a:4297:b0:52d:89f8:4f8 with SMTP id d75a77b69052e-52e42235693mr50634791cf.5.1787738461836;
        Wed, 26 Aug 2026 03:01:01 -0700 (PDT)
Received: from [192.168.0.175] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a5deb030bcsm4815324a12.31.2026.08.26.03.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 03:01:00 -0700 (PDT)
Message-ID: <5e2381c3-1578-48bc-996d-364350afb140@columbia.edu>
Date: Wed, 26 Aug 2026 13:00:58 +0300
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] ceph: use folios in put_bvecs()
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
 <20260825-ceph-inline-folio-v1-6-d2366fade152@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260825-ceph-inline-folio-v1-6-d2366fade152@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: DWbyNxXtIwYJb8EC5GGwtyCTi8R1Wwyw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA4MyBTYWx0ZWRfXywzawJpQlYgU
 RL/PxL5Ox3JWM5tJvQWX0gUqKTjR5X9vqJXz3ZNq4HVIJhsF7+PtxF9qFLnkWK+W6qQXUdR1hOz
 W7XWT1CuLwZZuHAI28oSCaQ6XQTSq3oYWz72Qnm99+0jUy4FU0JXInhwn5USw8ACB05LxjZemFh
 I95tyoKKcOWqt8vqOSsmpBpMEWCaRwWDtEbDkoGevt214pmo5vPaYVqXTyLmkvPzPc1K4WIJ5Gz
 zFZFvCjsNUIjQQtcUUV/2Ffr5JVz2RuCkswGRuqXA1kmCj36yuX8rpkJbk+1jKQbx/Ezd+Db2ub
 L5l6dwrl+eaESYQowpMVrXMdnm9hir3bE60LuwXxgcA8i9Tz8NhVhXvNTydrYGFiaA0R7f+s4gm
 HPHS9qXj+3xAd8C3J+R2Vir5kuqmZJ7FHdciSPNSU/3YdPkc1lVdRNk7VC9smpmr2liEamlASrH
 VQ0J5fJU3FAny+TAwnA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA4MyBTYWx0ZWRfXynzHJmjmk5lt
 znBHjfx/nAaROQAo03iIpvHho0NHdUzUFTij1JysVircaYlAVgas9Rb1l+z4CIfVTDM62/n+Tpa
 dvD35rQOncuhc81RPL2iKpKR/tGoGcUlfGdDpAscrtUYNsDu5sHG
X-Proofpoint-ORIG-GUID: DWbyNxXtIwYJb8EC5GGwtyCTi8R1Wwyw
X-Authority-Analysis: v=2.4 cv=TrrWQjXh c=1 sm=1 tr=0 ts=6a8eb9a1 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=Kw6sVik9EhTZWiEy9CoA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11886
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=10 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=10 phishscore=0 spamscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260083

On 8/26/26 12:48 AM, Tal Zussman wrote:
> Use bvec_folio() to dirty and release the pages as folios. This adds
> one call to compound_head() per page, while folio_mark_dirty_lock() and
> folio_put() each drop one, for a net saving of one call per page when
> dirtying.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  fs/ceph/file.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 0b6921293f27..89233c5905c9 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -182,11 +182,15 @@ static void put_bvecs(struct bio_vec *bvecs, int num_bvecs, bool should_dirty)
>  	int i;
>  
>  	for (i = 0; i < num_bvecs; i++) {
> -		if (bvecs[i].bv_page) {
> -			if (should_dirty)
> -				set_page_dirty_lock(bvecs[i].bv_page);
> -			put_page(bvecs[i].bv_page);
> -		}
> +		struct folio *folio;
> +
> +		if (!bvecs[i].bv_page)
> +			continue;
> +
> +		folio = bvec_folio(&bvecs[i]);
> +		if (should_dirty)
> +			folio_mark_dirty_lock(folio);
> +		folio_put(folio);

I was overzealous here... Sashiko found an issue:

"Does this code risk a reference count underflow for slab pages?

When the VFS or block layer passes an ITER_BVEC pointing to slab-allocated
memory (such as a kmalloc buffer) to ceph_direct_read_write(), the ceph
code calls iov_iter_get_pages2() via __iter_get_bvecs(). This explicitly
skips taking a reference on slab pages:

if (!folio_test_slab(folio))
        folio_get(folio);

When the IO completes, put_bvecs() cleans up by calling folio_put(folio)
on each page. Since folio_put() lacks the folio_test_slab() and
folio_test_large_kmalloc() protections that put_page() historically
provided, will this unconditionally drop a reference that was never
acquired?"

I think the proper fix here is to switch __iter_get_bvecs() to use
iov_iter_extract_pages() and clean up this path, but that's a separate
change. I'll drop this patch from this series (it wasn't really related
anyways).

>  	}
>  	kvfree(bvecs);
>  }
> 

