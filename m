Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84137B41B
	for <ceph-devel@vger.kernel.org>; Thu,  2 Apr 2026 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159065; cv=none; b=WefTse5t7vzlHSm6vUIfIti6vXluxoMDYZjvYCiLs/exhZMLNRUaG9ytJ4wvIRXrRI0OwJfKOaXZmuNS8AvkMX0UpdwvyMW8imqBa4sy2VGEmZhRWakxr09vcBK50MG/6EVBTIjjIR07U1KJbj/XpQwLiURbC14R2vxyPxtjrIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159065; c=relaxed/simple;
	bh=dhkwOMkpSTXzAF4Md11a5xeyXEAjMCbXsGoUuO9ISMM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V1n4I9+/SOpamMhr4Z3neMJXH1BbHaIn52GqMfqK6P/gEpJrST5q1Vj/k+gEEL4hQdxGVOHIVZETCpI6DokKhJoKtLk6lFXbair6iJIA+STMhUX/X0xFqbia8Fgkm992PFnPZnGUK9ssyeFjDzJqB4GOHIMAwelwI62NY5PSyTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAWY6NO0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oTNrShel; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAWY6NO0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oTNrShel"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775159063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfB9s0LuiQf6iXmJ//bXhecPlnuCrZC+QJFbTGU8i38=;
	b=JAWY6NO0QwYXhaG3C2pTz27N/EgYeMmNtpRB7vIRr4C09kHW3oxYfizTb+3uJ5nNkG7T9f
	74jRnPbZJurGODja6mMmSktdTnvyec5mCo3R5ApPACQR6eRX1SNr48DtLuViEWlNrhqCmz
	18UntGSnzxZmXSPo//USHixzmJMUC5c=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-wdzl2tQmM8Csug7iqqbwtA-1; Thu, 02 Apr 2026 15:44:22 -0400
X-MC-Unique: wdzl2tQmM8Csug7iqqbwtA-1
X-Mimecast-MFC-AGG-ID: wdzl2tQmM8Csug7iqqbwtA_1775159061
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-46eeae14d8cso778786b6e.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Apr 2026 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775159061; x=1775763861; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfB9s0LuiQf6iXmJ//bXhecPlnuCrZC+QJFbTGU8i38=;
        b=oTNrShelriJEMQo9yVkd9vge8mLcItReBT2gL4SH9WIE6v2Ua1X8rf0bOhwL9o3e7l
         SoUj/xFfSZ0OMpf4M8zbOT45mhW5jCAb7ENermef/7HAEdRwxgyEk6vh0Kr94hwujf1o
         GovAOy2NwuqU4MkaOUVoz7TUmupCQ8DT3YmGOsiPyE1UikIFv6kI3cKHqMtZNULcUR3/
         1O0GyOJmq4zEykWxlwPZoHHBzyen/PbcI/C4NdP4yWSGsjoJyLKxPm70QYjbT1Mywjz1
         GU6h0abGU7kDw4Jsjp1Le95t8hWpUNa7La6HxjX90MCVdATzYMc6/2imRF6VgvJqcZMD
         TZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775159061; x=1775763861;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZfB9s0LuiQf6iXmJ//bXhecPlnuCrZC+QJFbTGU8i38=;
        b=Llnf4WhTb3SpM8iKaAuDruXrs5x7rNLCeQwoR53CNs5Q3kBQUJXk5gU63O6BTAqEj2
         HwLoP+UzvOClVx2HmTW+u1jVCNXkvaBundCePPuTc+V31gwzW+9gND80GS61oOa2lFmv
         AtUok+1sdcz3G391IxutmLf7NNEV1+tT3u8HeMuiTMVZ1Spm6JyEwJJGZv/z8BCU88BA
         ab1mPUoBpIqD/FyCBEvBtm4czWQAJaXrer7n3ENj796s8efDjDu5lBtpCqD+QJLQOhoC
         9fBg8eB06USNKWVoDtv4pv6s/gE3AvWRLlo6mkVwccjT4oym4XlO4xCzWfsXHk84xqRp
         6pCA==
X-Forwarded-Encrypted: i=1; AJvYcCVpTp4e1zdOsSnoCnSwbx/61zMq4sN+gJYuPmtJjwdXUGdujzWJaMCjm1wMUBqVVp8WsTuWidUhNd0g@vger.kernel.org
X-Gm-Message-State: AOJu0Yylmte/Xb/+cSIty0h2CtQljEerpUlnbwU7+VmlNTsgE+5hqn+w
	xhzSyVnhL9/ptAT35xGe02LnIkEtHnIzifMpukfvmO7ia+z9JUyZLrdX8akqZTSs+W0deHzoWyw
	jfvteif+h609x5s05zYOFcy223sXiWJA/1TFbuz87OU7ELrcpnUiFJUJ43XnlguY=
X-Gm-Gg: ATEYQzw4ZQIK+BxsInZmJO7Q2AERootqvCNCqOub8NNHCvFv6K4lPZoomTnZoT1MbP9
	K9rfp7Qr2itP7zC3LI1NKURnBbs8D/yTZOjVsFdZXfl1LlF8acinNaNscZPiSXd0C+bWZtxCJ7i
	oJiu/gXIwGgH5RUcDH5IdWCKS95qLRKk6UFB6X6QgDEsmmObcNpqdFP3gXcORrbZWmcpGnFbWSM
	MdFnvAPD7F9rXxbt3JZNcmyFExCHaQW6Zb8vNHtWj+SEOskyDj3LMHSKkKsNLcGCWwg8au04WHi
	H/RSOzuBhNyTxbYw1l7tfei/ia1BViMzKoplyBrv3mHJ/OKWPpD3XCoQmIvZXb5m5wu2ulAD2Yd
	fwonQEDLyXDCWDv/aM/zOslODR5WnnhXsgk/YEoHDpPVtAHrM2CHi
X-Received: by 2002:a05:6808:1310:b0:467:cda:f189 with SMTP id 5614622812f47-46ef790e783mr355630b6e.32.1775159061032;
        Thu, 02 Apr 2026 12:44:21 -0700 (PDT)
X-Received: by 2002:a05:6808:1310:b0:467:cda:f189 with SMTP id 5614622812f47-46ef790e783mr355609b6e.32.1775159060457;
        Thu, 02 Apr 2026 12:44:20 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46d8f9603fdsm2199923b6e.2.2026.04.02.12.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 12:44:19 -0700 (PDT)
Message-ID: <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
Subject: Re: [PATCH] ceph: do not fill fscache for RWF_DONTCACHE writeback
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	pc@manguebit.org, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 02 Apr 2026 12:44:18 -0700
In-Reply-To: <20260401205613.2095623-1-max.kellermann@ionos.com>
References: <20260401205613.2095623-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-01 at 22:56 +0200, Max Kellermann wrote:
> Avoid populating the local fscache with writeback from dropbehind
> folios.
>=20

The idea sounds reasonable enough. However, this patch cannot be standalone
because it depends on another one.

I assume that a filesystem must declare DONTCACHE feature support by settin=
g
FOP_DONTCACHE in its file_operations.fop_flags. Am I right here?

And what's about the IOCB_DONTCACHE. As far as I can see,
write_begin_get_folio() translates IOCB_DONTCACHE into FGP_DONTCACHE:

static inline struct folio *write_begin_get_folio(const struct kiocb *iocb,
		  struct address_space *mapping, pgoff_t index, size_t len)
{
        fgf_t fgp_flags =3D FGP_WRITEBEGIN;

        fgp_flags |=3D fgf_set_order(len);

        if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
                fgp_flags |=3D FGP_DONTCACHE;

        return __filemap_get_folio(mapping, index, fgp_flags,
                                   mapping_gfp_mask(mapping));
}

The Ceph write_begin path calls netfs_write_begin() but does not pass
IOCB_DONTCACHE through to trigger __folio_set_dropbehind. So,
folio_test_dropbehind() would never be true on the Ceph write path right no=
w.
Does it make sense?

> At the moment, buffered RWF_DONTCACHE writes still go through the
> usual Ceph writeback path, which mirrors the written data into
> fscache.  The data is dropped from the page cache, but we still spend
> local I/O and local cache space to retain a copy in fscache.
>=20
> The DONTCACHE documentation is only about the page cache and the
> intent is to avoid caching data that will not be needed again soon.
> I believe skipping fscache writes during Ceph writeback on such pages
> would follow the same spirit: commit the write to permanent storage,
> but otherwise get it out of the way quickly.
>=20
> Use folio_test_dropbehind() to treat such folios as non-cacheable for
> the purposes of Ceph's write-side fscache population.  This skips both
> ceph_set_page_fscache() and the corresponding write-to-cache operation
> for dropbehind folios.
>=20
> The writepages path can batch together folios with different cacheability=
,
> so track cacheable subranges separately and only submit fscache writes
> for contiguous non-dropbehind spans.
>=20
> This keeps normal buffered writeback unchanged, while making
> RWF_DONTCACHE a better match for its intended "don't retain this
> locally" behavior and avoiding unnecessary local cache traffic.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> Note: this is an additional feature on top of my Ceph-DONTCACHE patch,
> see https://lore.kernel.org/ceph-devel/20260401053109.1861724-1-max.kelle=
rmann@ionos.com/
> ---
>  fs/ceph/addr.c | 34 ++++++++++++++++++++++++++++++----
>  1 file changed, 30 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 2090fc78529c..9612a1d8ccb2 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -576,6 +576,21 @@ static inline void ceph_fscache_write_to_cache(struc=
t inode *inode, u64 off, u64
>  }
>  #endif /* CONFIG_CEPH_FSCACHE */
> =20
> +static inline bool ceph_folio_is_cacheable(const struct folio *folio, bo=
ol caching)
> +{
> +	/* Dropbehind writeback should not populate the local fscache. */
> +	return caching && !folio_test_dropbehind(folio);
> +}
> +
> +static inline void ceph_flush_fscache_write(struct inode *inode, u64 off=
, u64 *len)
> +{
> +	if (!*len)
> +		return;
> +
> +	ceph_fscache_write_to_cache(inode, off, *len, true);

Are you sure that caching should be always true? All other calls checks tha=
t
ceph_is_cache_enabled():

bool caching =3D ceph_is_cache_enabled(inode);

> +	*len =3D 0;
> +}


The ceph_folio_is_cacheable() and ceph_flush_fscache_write() are out of
CONFIG_CEPH_FSCACHE. It doesn't look right.

> +
>  struct ceph_writeback_ctl
>  {
>  	loff_t i_size;
> @@ -730,7 +745,7 @@ static int write_folio_nounlock(struct folio *folio,
>  	struct ceph_writeback_ctl ceph_wbc;
>  	struct ceph_osd_client *osdc =3D &fsc->client->osdc;
>  	struct ceph_osd_request *req;
> -	bool caching =3D ceph_is_cache_enabled(inode);
> +	bool caching =3D ceph_folio_is_cacheable(folio, ceph_is_cache_enabled(i=
node));
>  	struct page *bounce_page =3D NULL;
> =20
>  	doutc(cl, "%llx.%llx folio %p idx %lu\n", ceph_vinop(inode), folio,
> @@ -1412,11 +1427,14 @@ int ceph_submit_write(struct address_space *mappi=
ng,
>  	bool caching =3D ceph_is_cache_enabled(inode);
>  	u64 offset;
>  	u64 len;
> +	u64 cache_offset, cache_len;

Why do you need to introduce the cache_offset and cache_len? We already hav=
e
offset and len.

>  	unsigned i;
> =20
>  new_request:
>  	offset =3D ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
>  	len =3D ceph_wbc->wsize;
> +	cache_offset =3D 0;

Is it correct initialization? Frankly speaking, I don't quite follow why we=
 need
such initialization.

Thanks,
Slava.

> +	cache_len =3D 0;
> =20
>  	req =3D ceph_osdc_new_request(&fsc->client->osdc,
>  				    &ci->i_layout, vino,
> @@ -1477,9 +1495,11 @@ int ceph_submit_write(struct address_space *mappin=
g,
>  	ceph_wbc->op_idx =3D 0;
>  	for (i =3D 0; i < ceph_wbc->locked_pages; i++) {
>  		u64 cur_offset;
> +		bool cache_page;
> =20
>  		page =3D ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
>  		cur_offset =3D page_offset(page);
> +		cache_page =3D ceph_folio_is_cacheable(page_folio(page), caching);
> =20
>  		/*
>  		 * Discontinuity in page range? Ceph can handle that by just passing
> @@ -1491,7 +1511,7 @@ int ceph_submit_write(struct address_space *mapping=
,
>  				break;
> =20
>  			/* Kick off an fscache write with what we have so far. */
> -			ceph_fscache_write_to_cache(inode, offset, len, caching);
> +			ceph_flush_fscache_write(inode, cache_offset, &cache_len);
> =20
>  			/* Start a new extent */
>  			osd_req_op_extent_dup_last(req, ceph_wbc->op_idx,
> @@ -1514,13 +1534,19 @@ int ceph_submit_write(struct address_space *mappi=
ng,
> =20
>  		set_page_writeback(page);
> =20
> -		if (caching)
> +		if (cache_page) {
> +			if (!cache_len)
> +				cache_offset =3D cur_offset;
>  			ceph_set_page_fscache(page);
> +			cache_len +=3D thp_size(page);
> +		} else {
> +			ceph_flush_fscache_write(inode, cache_offset, &cache_len);
> +		}
> =20
>  		len +=3D thp_size(page);
>  	}
> =20
> -	ceph_fscache_write_to_cache(inode, offset, len, caching);
> +	ceph_flush_fscache_write(inode, cache_offset, &cache_len);
> =20
>  	if (ceph_wbc->size_stable) {
>  		len =3D min(len, ceph_wbc->i_size - offset);

