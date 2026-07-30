Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12795175A6D
	for <ceph-devel@vger.kernel.org>; Thu, 30 Jul 2026 00:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372277; cv=none; b=e8dfTDhKPpvHGcwHD6cqDQ9kat6Aii2naZhTrwYagx4qPjHkHtuWSauf+HNHdac4lkF7CxkZwzixV00JtDylbPSY3w2FRo2ZRKfPQ7Rpx4G8KywZ5Xirq9GKX4ToLAOOB9rYPmAXqM2rvkaMjiihCWxkFedYuFWUJCJRgN5YIic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372277; c=relaxed/simple;
	bh=sQVhWgiKLvHWn1VDZSED4tPynksvzPhmiVmZDKyMj7A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HTEnyv/h6QRRkqcC9ulbCYIwty5BwSSnInVlfN1IiKlB9hl+QvT1nOXQoX1EVLBWji+1q+ywTcFSZGre1AeHIeEILps8urzQcjTXTKs7TDfIlrz1lb2qDDjjMi9dQQ3cYZyZSiLclYTGpjs6gTdKZPvy7Zn+REq3t3tPmxnethY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=a+ltGFbG; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="a+ltGFbG"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-38e8adc1d70so712763a91.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 17:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1785372273; x=1785977073; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=O06ciFiXT7VMPkc5g9cxbogmMW21hmrna1aD4Ka4MlU=;
        b=a+ltGFbGw6EIjfTqXZVt3zSun+R/tYQew4j/mri5Fdh0mXcpAdWKpeHT/jGhbKJZVi
         WBmwNDj1DwHsNeY1OkCjwhxxLM90/BPSTXPRp4hV6gk1F/BipBfrn6d9wjvUIUa2cn8a
         y5v5EOVtxnJT/UW4zTSlMN7CEszprFoEGohnVuKsyoJ4YH00WMENZVoF1+oMt7mK2j4A
         1msxWRIWVniMhhHvCZEGj9FMzDalsYp+v3GwVPAckKgWfbEk3ToFZLt6+n2zh7ic7ABQ
         14YVz5LbXkDU9AWfNGuvtHjOTxqL8MKiRYlQKalqEmuyHZqwX8mYzFt0G4D5uw2ANeX1
         ooEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785372273; x=1785977073;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=O06ciFiXT7VMPkc5g9cxbogmMW21hmrna1aD4Ka4MlU=;
        b=OEJxw7ooXMfULRIgb1zl/WkxDcv7/BrEwde8m4lpLN2MnDjBpcqP60TbBkLhydWJQq
         MPym3zElRnicUgeynQ3//+WAjO6QosB7u4jZnnBQ+qkgapyTLj9Sobl+OyvDy2T3XLLN
         V6BbrQUmax1t50P4USOzQX3FVjPtJb1ci+aKCjtx50M1TOVvk6Pu8B73fcLRU3Kq6FOz
         vff6mg3lOjrFJ0Onh37kP0TRmyP5I50YisehQ/hVYDCcXB45rMiIHpzaRSn3kkowYFbZ
         ZwTkDTRRsIpYTml8coQSp7mQylV/AfwweNMAJWV1kKxfZBfH6XYmFCzJ0QT5N8Y1cZyy
         koeQ==
X-Gm-Message-State: AOJu0YyeMahWQHKKbo50kK1gTlRdsXyDRfjbHel2OonuRyBtlaiJOKdU
	H9E2zSrsiEpDFPjxFsDTIEz9Hi4+l5Pws4rEug/UzVIuvdm5RSjTamw7uCtPbzOIj/s=
X-Gm-Gg: AR+sD12W3xA56ZS2yROOStZVefPwq/FtrQ+IBbKAcfN+qbkv5tr/2nQLJ0Wc0DkxIhg
	xNl9kLwhSjry2Wg/rEdaHv0hAQZa/xLJm1wywcLwivcTIsAEeI0d6JzSiuDoLNLemu5OugWQ2Uw
	HLKjCa4i3CkCJ+77Ro8EHip/nCyCzpHC574VoKwr506eQdmRKjCUSqONkrUTYy0+rHtyFSZ2Hr0
	Vh+PIEhmwEhO/zGywEj0/QvsM0tq/nWWNCaFttKlCTMOHEOckCi9bFCEOTFpmkztsexcFhjQ+U/
	aarxOSh0EeHrNUk8P3aoJVk8J/gQ3y0Ed+o0D1W4KJ+DbwCFBPchRe/j/TKuBCWTAFRzr5VP22q
	FfDzccWzYmaJj4nGWCCEfksxugm5c2Yz8KhpnOAC9b75smAz1H8Vi+wdAeZcR6gha9Asxfuru80
	6DLxmR07nr2M/bPuNW5roKi7M2Ja7dC/a3RrRdqQwqZTtUr0el9YGOaksTjz3cVeYaCt5VuLxaf
	ZroQ0JQ6x9wwQ9UjHgVrpW8h6Zv2B52oJTxpevMeiieoRen2CxZ2b4phNvUM60kcGQbh2U+WViP
	nS+iRa67iN+/SvSUw1402gbT2CsM9ouFIT9ymVWUN5fG2eyIztI48QM=
X-Received: by 2002:a17:90b:584d:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-38f9bd12961mr455843a91.4.1785372273108;
        Wed, 29 Jul 2026 17:44:33 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504db2c4csm14191227eec.28.2026.07.29.17.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 17:44:32 -0700 (PDT)
Message-ID: <20d914756be4793b799de192fc0cc0b208c17655.camel@dubeyko.com>
Subject: Re: [PATCH v2] ceph: remove the inline data support
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 29 Jul 2026 17:44:29 -0700
In-Reply-To: <20260729-b4-ceph-remove-inline-data-v2-1-db0c92dab8ee@clyso.com>
References: 
	<20260729-b4-ceph-remove-inline-data-v2-1-db0c92dab8ee@clyso.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-29 at 09:28 +0800, Xiubo Li via B4 Relay wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>=20
> Inline data support has been deprecated in the CephFS MDS and is
> being formally removed.=C2=A0 Existing inline data can be migrated to
> data pool objects via MDS scrub (see PR #44359).
>=20
> Add CONFIG_CEPH_FS_INLINE_DATA (default n) to gate all inline data
> code in the kclient.=C2=A0 When disabled, CEPH_FEATURE_MDS_INLINE_DATA
> is defined as 0 so that the kclient no longer advertises the
> feature to the MDS.=C2=A0 The MDS will then refuse to open files that
> still have inline data, returning -EPERM, preventing silent data
> corruption that would occur if the kclient tried to read inline
> data from OSD objects that do not contain it.
>=20
> This config option will be kept for a transitional period to
> allow existing CephFS deployments to migrate inline data via
> MDS scrub.=C2=A0 Once the migration period ends, the option and all
> inline data code will be permanently removed.
>=20
> Users upgrading from an older Ceph release should ensure all inline
> data has been migrated before deploying a kclient with this option
> disabled:
> =C2=A0 1. Enable and run MDS scrub to uninline existing data
> =C2=A0 2. Disable inline_data on the filesystem:
> =C2=A0=C2=A0=C2=A0=C2=A0 ceph fs set <fs> inline_data false --yes-i-reall=
y-really-mean-it
>=20
> Link: https://tracker-origin.ceph.com/issues/67769
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> Changes in v2:
> - keep CEPH_FEATURE_MDS_INLINE_DATA always defined as (1ULL << 40)
> =C2=A0 so decode logic can still check MDS feature bits; gate the
> =C2=A0 supported features set via CEPH_FEATURE_MDS_INLINE_DATA_DEFAULT
> - Link to v1:
> https://patch.msgid.link/20260728-b4-ceph-remove-inline-data-v1-1-8ffa7e0=
8459a@clyso.com
> ---
> =C2=A0fs/ceph/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++++++=
++++++
> =C2=A0fs/ceph/addr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 16 =
+++++++++++++++
> =C2=A0fs/ceph/caps.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 40
> +++++++++++++++++++++++++++++++++++++-
> =C2=A0fs/ceph/file.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 20 =
+++++++++++++++++++
> =C2=A0fs/ceph/inode.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++=
++++
> =C2=A0fs/ceph/mds_client.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 30 ++++++++++++++++++++++++++++
> =C2=A0fs/ceph/mds_client.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A0fs/ceph/snap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 ++
> =C2=A0fs/ceph/super.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 ++++++=
+++++++
> =C2=A0include/linux/ceph/ceph_features.h |=C2=A0 7 ++++++-
> =C2=A010 files changed, 150 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ceph/Kconfig b/fs/ceph/Kconfig
> index 3d64a316ca31..be1c8ada5665 100644
> --- a/fs/ceph/Kconfig
> +++ b/fs/ceph/Kconfig
> @@ -17,6 +17,18 @@ config CEPH_FS
> =C2=A0	=C2=A0 If unsure, say N.
> =C2=A0
> =C2=A0if CEPH_FS
> +config CEPH_FS_INLINE_DATA
> +	bool "Enable CephFS inline data support (deprecated)"
> +	depends on CEPH_FS
> +	default n
> +	help
> +	=C2=A0 Inline data support has been deprecated in the CephFS MDS
> +	=C2=A0 and is being formally removed.=C2=A0 Existing inline data can
> be
> +	=C2=A0 migrated to data pool objects via MDS scrub.=C2=A0 Choose N
> +	=C2=A0 unless you have a legacy filesystem that requires it,
> +	=C2=A0 and ensure all inline data has been migrated (see
> +	=C2=A0 ceph fs set <fs> inline_data false) before enabling.
> +
> =C2=A0config CEPH_FSCACHE
> =C2=A0	bool "Enable Ceph client caching support"
> =C2=A0	depends on CEPH_FS=3Dm && FSCACHE || CEPH_FS=3Dy && FSCACHE=3Dy
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index e2da3ab9f808..5211320a50ac 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -274,6 +274,7 @@ static void finish_netfs_read(struct
> ceph_osd_request *req)
> =C2=A0	ceph_dec_osd_stopping_blocker(fsc->mdsc);
> =C2=A0}
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0static bool ceph_netfs_issue_op_inline(struct netfs_io_subrequest
> *subreq)
> =C2=A0{
> =C2=A0	struct netfs_io_request *rreq =3D subreq->rreq;
> @@ -335,6 +336,7 @@ static bool ceph_netfs_issue_op_inline(struct
> netfs_io_subrequest *subreq)
> =C2=A0	netfs_read_subreq_terminated(subreq);
> =C2=A0	return true;
> =C2=A0}
> +#endif /* CONFIG_CEPH_FS_INLINE_DATA */
> =C2=A0
> =C2=A0static int ceph_netfs_prepare_read(struct netfs_io_subrequest
> *subreq)
> =C2=A0{
> @@ -372,8 +374,10 @@ static void ceph_netfs_issue_read(struct
> netfs_io_subrequest *subreq)
> =C2=A0		goto out;
> =C2=A0	}
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	if (ceph_has_inline_data(ci) &&
> ceph_netfs_issue_op_inline(subreq))
> =C2=A0		return;
> +#endif
> =C2=A0
> =C2=A0	// TODO: This rounding here is slightly dodgy.=C2=A0 It *should*
> work, for
> =C2=A0	// now, as the cache only deals in blocks that are a
> multiple of
> @@ -2006,7 +2010,11 @@ static vm_fault_t ceph_filemap_fault(struct
> vm_fault *vmf)
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 off, ceph_cap_string(got));
> =C2=A0
> =C2=A0	if ((got & (CEPH_CAP_FILE_CACHE | CEPH_CAP_FILE_LAZYIO)) ||
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	=C2=A0=C2=A0=C2=A0 !ceph_has_inline_data(ci)) {
> +#else
> +	=C2=A0=C2=A0=C2=A0 true) {
> +#endif

Maybe, some static inline function here?

> =C2=A0		CEPH_DEFINE_RW_CONTEXT(rw_ctx, got);
> =C2=A0		ceph_add_rw_context(fi, &rw_ctx);
> =C2=A0		ret =3D filemap_fault(vmf);
> @@ -2037,7 +2045,11 @@ static vm_fault_t ceph_filemap_fault(struct
> vm_fault *vmf)
> =C2=A0			goto out_inline;
> =C2=A0		}
> =C2=A0		err =3D __ceph_do_getattr(inode, page,
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0					 CEPH_STAT_CAP_INLINE_DATA,
> true);
> +#else
> +					 0, true);
> +#endif

Maybe some macro that can hide this?

> =C2=A0		if (err < 0 || off >=3D i_size_read(inode)) {
> =C2=A0			unlock_page(page);
> =C2=A0			put_page(page);
> @@ -2168,6 +2180,7 @@ static vm_fault_t ceph_page_mkwrite(struct
> vm_fault *vmf)
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0void ceph_fill_inline_data(struct inode *inode, struct page
> *locked_page,
> =C2=A0			=C2=A0=C2=A0 char	*data, size_t len)
> =C2=A0{
> @@ -2214,7 +2227,9 @@ void ceph_fill_inline_data(struct inode *inode,
> struct page *locked_page,
> =C2=A0		put_page(page);
> =C2=A0	}
> =C2=A0}
> +#endif /* CONFIG_CEPH_FS_INLINE_DATA */
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0int ceph_uninline_data(struct file *file)
> =C2=A0{
> =C2=A0	struct inode *inode =3D file_inode(file);
> @@ -2370,6 +2385,7 @@ int ceph_uninline_data(struct file *file)
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_vinop(inode), inline_version, =
err);
> =C2=A0	return err;
> =C2=A0}
> +#endif /* CONFIG_CEPH_FS_INLINE_DATA */
> =C2=A0
> =C2=A0static const struct vm_operations_struct ceph_vmops =3D {
> =C2=A0	.fault		=3D ceph_filemap_fault,
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index f8d898ad091e..2fd2116a3308 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1266,7 +1266,9 @@ struct cap_msg_args {
> =C2=A0	kuid_t			uid;
> =C2=A0	kgid_t			gid;
> =C2=A0	umode_t			mode;
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	bool			inline_data;
> +#endif
> =C2=A0	bool			wake;
> =C2=A0	bool			encrypted;
> =C2=A0	u32			fscrypt_auth_len;
> @@ -1336,8 +1338,16 @@ static void encode_cap_msg(struct ceph_msg
> *msg, struct cap_msg_args *arg)
> =C2=A0	p =3D fc + 1;
> =C2=A0	/* flock buffer size (version 2) */
> =C2=A0	ceph_encode_32(&p, 0);
> -	/* inline version (version 4) */
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	ceph_encode_64(&p, arg->inline_data ? 0 : CEPH_INLINE_NONE);
> +#else
> +	/*
> +	 * Inline data support has been removed.=C2=A0 The field is still
> +	 * encoded for protocol compatibility; always advertise
> +	 * CEPH_INLINE_NONE to indicate no inline data is present.
> +	 */
> +	ceph_encode_64(&p, CEPH_INLINE_NONE);
> +#endif
> =C2=A0	/* inline data size */
> =C2=A0	ceph_encode_32(&p, 0);
> =C2=A0	/*
> @@ -1499,7 +1509,9 @@ static void __prep_cap(struct cap_msg_args
> *arg, struct ceph_cap *cap,
> =C2=A0	arg->gid =3D inode->i_gid;
> =C2=A0	arg->mode =3D inode->i_mode;
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	arg->inline_data =3D ci->i_inline_version !=3D CEPH_INLINE_NONE;
> +#endif
> =C2=A0	if (!(flags & CEPH_CLIENT_CAPS_PENDING_CAPSNAP) &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 !list_empty(&ci->i_cap_snaps)) {
> =C2=A0		struct ceph_cap_snap *capsnap;
> @@ -1620,7 +1632,9 @@ static inline int __send_flush_snap(struct
> inode *inode,
> =C2=A0	arg.gid =3D capsnap->gid;
> =C2=A0	arg.mode =3D capsnap->mode;
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	arg.inline_data =3D capsnap->inline_data;
> +#endif
> =C2=A0	arg.flags =3D 0;
> =C2=A0	arg.wake =3D false;
> =C2=A0	arg.encrypted =3D IS_ENCRYPTED(inode);
> @@ -3192,6 +3206,7 @@ int __ceph_get_caps(struct inode *inode, struct
> ceph_file_info *fi, int need,
> =C2=A0			return ret;
> =C2=A0		}
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0		if (S_ISREG(ci->netfs.inode.i_mode) &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 ceph_has_inline_data(ci) &&
> =C2=A0		=C2=A0=C2=A0=C2=A0 (_got &
> (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) &&
> @@ -3223,6 +3238,7 @@ int __ceph_get_caps(struct inode *inode, struct
> ceph_file_info *fi, int need,
> =C2=A0				return ret;
> =C2=A0			continue;
> =C2=A0		}
> +#endif

Ditto. Maybe, some static inline function?

> =C2=A0		break;
> =C2=A0	}
> =C2=A0	*got =3D _got;
> @@ -3518,10 +3534,12 @@ static void invalidate_aliases(struct inode
> *inode)
> =C2=A0
> =C2=A0struct cap_extra_info {
> =C2=A0	struct ceph_string *pool_ns;
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	/* inline data */
> =C2=A0	u64 inline_version;
> =C2=A0	void *inline_data;
> =C2=A0	u32 inline_len;
> +#endif
> =C2=A0	/* dirstat */
> =C2=A0	bool dirstat_valid;
> =C2=A0	u64 nfiles;
> @@ -3564,7 +3582,9 @@ static void handle_cap_grant(struct inode
> *inode,
> =C2=A0	bool queue_trunc =3D false;
> =C2=A0	bool queue_invalidate =3D false;
> =C2=A0	bool deleted_inode =3D false;
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	bool fill_inline =3D false;
> +#endif
> =C2=A0	bool revoke_wait =3D false;
> =C2=A0	int flags =3D 0;
> =C2=A0
> @@ -3830,6 +3850,7 @@ static void handle_cap_grant(struct inode
> *inode,
> =C2=A0			check_caps =3D 2; /* check all caps */
> =C2=A0	}
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	if (extra_info->inline_version > 0 &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 extra_info->inline_version >=3D ci->i_inline_ve=
rsion) {
> =C2=A0		ci->i_inline_version =3D extra_info->inline_version;
> @@ -3837,6 +3858,7 @@ static void handle_cap_grant(struct inode
> *inode,
> =C2=A0		=C2=A0=C2=A0=C2=A0 (newcaps &
> (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)))
> =C2=A0			fill_inline =3D true;
> =C2=A0	}
> +#endif

Ditto.

> =C2=A0
> =C2=A0	if (le32_to_cpu(grant->op) =3D=3D CEPH_CAP_OP_IMPORT) {
> =C2=A0		if (ci->i_auth_cap =3D=3D cap) {
> @@ -3856,9 +3878,11 @@ static void handle_cap_grant(struct inode
> *inode,
> =C2=A0	}
> =C2=A0	spin_unlock(&ci->i_ceph_lock);
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	if (fill_inline)
> =C2=A0		ceph_fill_inline_data(inode, NULL, extra_info-
> >inline_data,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extra_info->inline_len);
> +#endif
> =C2=A0
> =C2=A0	if (queue_trunc)
> =C2=A0		ceph_queue_vmtruncate(inode);
> @@ -4476,12 +4500,26 @@ void ceph_handle_caps(struct ceph_mds_session
> *session,
> =C2=A0	}
> =C2=A0
> =C2=A0	if (msg_version >=3D 4) {
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0		ceph_decode_64_safe(&p, end,
> extra_info.inline_version, bad);
> =C2=A0		ceph_decode_32_safe(&p, end, extra_info.inline_len,
> bad);
> =C2=A0		if (p + extra_info.inline_len > end)
> =C2=A0			goto bad;
> =C2=A0		extra_info.inline_data =3D p;
> =C2=A0		p +=3D extra_info.inline_len;
> +#else
> +		/*
> +		 * Inline data support has been removed, but cap
> grant
> +		 * messages (msg_version >=3D 4) always carry
> inline_version
> +		 * + inline_data.=C2=A0 We must consume the fields to
> keep the
> +		 * decode pointer in sync.
> +		 */
> +		u32 __len;

The leading double-underscore is reserved namespace in C. Maybe, simply
len?

> +
> +		ceph_decode_skip_64(&p, end, bad);
> +		ceph_decode_32_safe(&p, end, __len, bad);
> +		ceph_decode_skip_n(&p, end, __len, bad);
> +#endif
> =C2=A0	}
> =C2=A0
> =C2=A0	if (msg_version >=3D 5) {
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 3823671ab95a..901ed97b1963 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -224,7 +224,9 @@ static int ceph_init_file_info(struct inode
> *inode, struct file *file,
> =C2=A0		ceph_inode_to_fs_client(&ci->netfs.inode)-
> >mount_options;
> =C2=A0	struct ceph_client *cl =3D ceph_inode_to_client(inode);
> =C2=A0	struct ceph_file_info *fi;
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	int ret;
> +#endif
> =C2=A0
> =C2=A0	doutc(cl, "%p %llx.%llx %p 0%o (%s)\n", inode,
> ceph_vinop(inode),
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file, inode->i_mode, isdir ? "dir" =
: "regular");
> @@ -258,14 +260,17 @@ static int ceph_init_file_info(struct inode
> *inode, struct file *file,
> =C2=A0	INIT_LIST_HEAD(&fi->rw_contexts);
> =C2=A0	fi->filp_gen =3D READ_ONCE(ceph_inode_to_fs_client(inode)-
> >filp_gen);
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	if ((file->f_mode & FMODE_WRITE) &&
> ceph_has_inline_data(ci)) {
> =C2=A0		ret =3D ceph_uninline_data(file);
> =C2=A0		if (ret < 0)
> =C2=A0			goto error;
> =C2=A0	}
> +#endif

Maybe, static inline function?

> =C2=A0
> =C2=A0	return 0;
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0error:
> =C2=A0	ceph_fscache_unuse_cookie(inode, file->f_mode &
> FMODE_WRITE);
> =C2=A0	ceph_put_fmode(ci, fi->fmode, 1);
> @@ -273,6 +278,7 @@ static int ceph_init_file_info(struct inode
> *inode, struct file *file,
> =C2=A0	/* wake up anyone waiting for caps on this inode */
> =C2=A0	wake_up_all(&ci->i_cap_wq);
> =C2=A0	return ret;
> +#endif
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -702,7 +708,9 @@ static int ceph_finish_async_create(struct inode
> *dir, struct inode *inode,
> =C2=A0
> =C2=A0	ktime_get_real_ts64(&now);
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	iinfo.inline_version =3D CEPH_INLINE_NONE;
> +#endif
> =C2=A0	iinfo.change_attr =3D 1;
> =C2=A0	ceph_encode_timespec64(&iinfo.btime, &now);
> =C2=A0
> @@ -2224,7 +2232,11 @@ static ssize_t ceph_read_iter(struct kiocb
> *iocb, struct iov_iter *to)
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inode, ceph_vinop(inode), iocb->ki=
_pos,
> (unsigned)len,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_cap_string(got));
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0		if (!ceph_has_inline_data(ci)) {
> +#else
> +		if (true) {
> +#endif

Ditto.

> =C2=A0			if (!retry_op &&
> =C2=A0			=C2=A0=C2=A0=C2=A0 (iocb->ki_flags & IOCB_DIRECT) &&
> =C2=A0			=C2=A0=C2=A0=C2=A0 !IS_ENCRYPTED(inode)) {
> @@ -2267,7 +2279,11 @@ static ssize_t ceph_read_iter(struct kiocb
> *iocb, struct iov_iter *to)
> =C2=A0			if (!page)
> =C2=A0				return -ENOMEM;
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0			mask =3D CEPH_STAT_CAP_INLINE_DATA;
> +#else
> +			mask =3D 0;
> +#endif

Ditto.

> =C2=A0		}
> =C2=A0
> =C2=A0		statret =3D __ceph_do_getattr(inode, page, mask,
> !!page);
> @@ -2349,8 +2365,12 @@ static ssize_t ceph_splice_read(struct file
> *in, loff_t *ppos,
> =C2=A0	if (ceph_inode_is_shutdown(inode))
> =C2=A0		return -ESTALE;
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	if (ceph_has_inline_data(ci) ||
> =C2=A0	=C2=A0=C2=A0=C2=A0 (fi->flags & CEPH_F_SYNC))
> +#else
> +	if (fi->flags & CEPH_F_SYNC)
> +#endif
> =C2=A0		return copy_splice_read(in, ppos, pipe, len, flags);
> =C2=A0
> =C2=A0	ret =3D ceph_start_io_read(inode);
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 61d7c0b8161f..20abf7dc9c64 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -627,7 +627,9 @@ struct inode *ceph_alloc_inode(struct super_block
> *sb)
> =C2=A0	spin_lock_init(&ci->i_ceph_lock);
> =C2=A0
> =C2=A0	ci->i_version =3D 0;
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	ci->i_inline_version =3D 0;
> +#endif
> =C2=A0	ci->i_time_warp_seq =3D 0;
> =C2=A0	ci->i_ceph_flags =3D 0;
> =C2=A0	atomic64_set(&ci->i_ordered_count, 1);
> @@ -1030,7 +1032,9 @@ int ceph_fill_inode(struct inode *inode, struct
> page *locked_page,
> =C2=A0	bool wake =3D false;
> =C2=A0	bool queue_trunc =3D false;
> =C2=A0	bool new_version =3D false;
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	bool fill_inline =3D false;
> +#endif
> =C2=A0	umode_t mode =3D le32_to_cpu(info->mode);
> =C2=A0	dev_t rdev =3D le32_to_cpu(info->rdev);
> =C2=A0
> @@ -1362,6 +1366,7 @@ int ceph_fill_inode(struct inode *inode, struct
> page *locked_page,
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	if (iinfo->inline_version > 0 &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 iinfo->inline_version >=3D ci->i_inline_version=
) {
> =C2=A0		int cache_caps =3D CEPH_CAP_FILE_CACHE |
> CEPH_CAP_FILE_LAZYIO;
> @@ -1370,6 +1375,7 @@ int ceph_fill_inode(struct inode *inode, struct
> page *locked_page,
> =C2=A0		=C2=A0=C2=A0=C2=A0 (locked_page || (info_caps & cache_caps)))
> =C2=A0			fill_inline =3D true;
> =C2=A0	}
> +#endif
> =C2=A0
> =C2=A0	if (cap_fmode >=3D 0) {
> =C2=A0		if (!info_caps)
> @@ -1382,9 +1388,11 @@ int ceph_fill_inode(struct inode *inode,
> struct page *locked_page,
> =C2=A0
> =C2=A0	ceph_fscache_register_inode_cookie(inode);
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	if (fill_inline)
> =C2=A0		ceph_fill_inline_data(inode, locked_page,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iinfo->inline_data, iinfo-
> >inline_len);
> +#endif
> =C2=A0
> =C2=A0	if (wake)
> =C2=A0		wake_up_all(&ci->i_cap_wq);
> @@ -3022,6 +3030,7 @@ int __ceph_do_getattr(struct inode *inode,
> struct page *locked_page,
> =C2=A0	req->r_args.getattr.mask =3D cpu_to_le32(mask);
> =C2=A0	req->r_locked_page =3D locked_page;
> =C2=A0	err =3D ceph_mdsc_do_request(mdsc, NULL, req);
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	if (locked_page && err =3D=3D 0) {
> =C2=A0		u64 inline_version =3D req-
> >r_reply_info.targeti.inline_version;
> =C2=A0		if (inline_version =3D=3D 0) {
> @@ -3034,6 +3043,7 @@ int __ceph_do_getattr(struct inode *inode,
> struct page *locked_page,
> =C2=A0			err =3D req->r_reply_info.targeti.inline_len;
> =C2=A0		}
> =C2=A0	}
> +#endif

Ditto.

> =C2=A0	ceph_mdsc_put_request(req);
> =C2=A0	doutc(cl, "result=3D%d\n", err);
> =C2=A0	return err;
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 18be36c2e9e8..6a439da76616 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -156,12 +156,26 @@ static int parse_reply_info_in(void **p, void
> *end,
> =C2=A0	*p +=3D info->xattr_len;
> =C2=A0
> =C2=A0	if (features =3D=3D (u64)-1) {
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0		/* inline data */
> =C2=A0		ceph_decode_64_safe(p, end, info->inline_version,
> bad);
> =C2=A0		ceph_decode_32_safe(p, end, info->inline_len, bad);
> =C2=A0		ceph_decode_need(p, end, info->inline_len, bad);
> =C2=A0		info->inline_data =3D *p;
> =C2=A0		*p +=3D info->inline_len;
> +#else
> +		/*
> +		 * Inline data support has been removed, but the MDS
> always
> +		 * encodes inline_version + inline_data in versioned
> replies.
> +		 * We must consume these fields from the message to
> keep the
> +		 * decode pointer in sync, even though we discard
> them.
> +		 */
> +		u32 __len;

Ditto, Maybe, simply len?

> +
> +		ceph_decode_skip_64(p, end, bad);
> +		ceph_decode_32_safe(p, end, __len, bad);
> +		ceph_decode_skip_n(p, end, __len, bad);
> +#endif
> =C2=A0		/* quota */
> =C2=A0		err =3D parse_reply_info_quota(p, end, info);
> =C2=A0		if (err < 0)
> @@ -276,6 +290,7 @@ static int parse_reply_info_in(void **p, void
> *end,
> =C2=A0		*p =3D end;
> =C2=A0	} else {
> =C2=A0		/* legacy (unversioned) struct */
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0		if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
> =C2=A0			ceph_decode_64_safe(p, end, info-
> >inline_version, bad);
> =C2=A0			ceph_decode_32_safe(p, end, info-
> >inline_len, bad);
> @@ -284,6 +299,21 @@ static int parse_reply_info_in(void **p, void
> *end,
> =C2=A0			*p +=3D info->inline_len;
> =C2=A0		} else
> =C2=A0			info->inline_version =3D CEPH_INLINE_NONE;
> +#else
> +		/*
> +		 * Inline data support has been removed.=C2=A0 When the
> MDS
> +		 * advertises CEPH_FEATURE_MDS_INLINE_DATA it
> includes
> +		 * inline_version + inline_data in legacy replies.=C2=A0
> We
> +		 * must consume them to keep the decode pointer in
> sync.
> +		 */
> +		if (features & CEPH_FEATURE_MDS_INLINE_DATA) {
> +			u32 __len;

Ditto. Maybe, len?

> +
> +			ceph_decode_skip_64(p, end, bad);
> +			ceph_decode_32_safe(p, end, __len, bad);
> +			ceph_decode_skip_n(p, end, __len, bad);
> +		}
> +#endif

Ditto. Maybe, static inline function?
> =C2=A0
> =C2=A0		if (features & CEPH_FEATURE_MDS_QUOTA) {
> =C2=A0			err =3D parse_reply_info_quota(p, end, info);
> diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> index 731d6ad04956..9bcf1a9d5ba8 100644
> --- a/fs/ceph/mds_client.h
> +++ b/fs/ceph/mds_client.h
> @@ -149,9 +149,11 @@ struct ceph_mds_reply_info_in {
> =C2=A0	char *symlink;
> =C2=A0	u32 xattr_len;
> =C2=A0	char *xattr_data;
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	u64 inline_version;
> =C2=A0	u32 inline_len;
> =C2=A0	char *inline_data;
> +#endif
> =C2=A0	u32 pool_ns_len;
> =C2=A0	char *pool_ns_data;
> =C2=A0	u64 max_bytes;
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index e5d8d59ffc17..3bc3a2ce72a2 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -613,7 +613,9 @@ static void ceph_queue_cap_snap(struct
> ceph_inode_info *ci,
> =C2=A0		capsnap->xattr_version =3D 0;
> =C2=A0	}
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	capsnap->inline_data =3D ci->i_inline_version !=3D
> CEPH_INLINE_NONE;
> +#endif
> =C2=A0
> =C2=A0	/* dirty page count moved from _head to this cap_snap;
> =C2=A0	=C2=A0=C2=A0 all subsequent writes page dirties occur _after_ this
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 3737ea7ed88b..eced08f52b79 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -274,7 +274,9 @@ struct ceph_cap_snap {
> =C2=A0	u32 truncate_seq;
> =C2=A0	int writing;=C2=A0=C2=A0 /* a sync write is still in progress */
> =C2=A0	int dirty_pages;=C2=A0=C2=A0=C2=A0=C2=A0 /* dirty pages awaiting w=
riteback */
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	bool inline_data;
> +#endif
> =C2=A0	bool need_flush;
> =C2=A0};
> =C2=A0
> @@ -381,7 +383,9 @@ struct ceph_inode_info {
> =C2=A0	spinlock_t i_ceph_lock;
> =C2=A0
> =C2=A0	u64 i_version;
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0	u64 i_inline_version;
> +#endif
> =C2=A0	u32 i_time_warp_seq;
> =C2=A0
> =C2=A0	unsigned long i_ceph_flags;
> @@ -1335,11 +1339,14 @@ extern void __ceph_touch_fmode(struct
> ceph_inode_info *ci,
> =C2=A0extern const struct address_space_operations ceph_aops;
> =C2=A0extern const struct netfs_request_ops ceph_netfs_ops;
> =C2=A0int ceph_mmap_prepare(struct vm_area_desc *desc);
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0extern int ceph_uninline_data(struct file *file);
> +#endif
> =C2=A0extern int ceph_pool_perm_check(struct inode *inode, int need);
> =C2=A0extern void ceph_pool_perm_destroy(struct ceph_mds_client* mdsc);
> =C2=A0int ceph_purge_inode_cap(struct inode *inode, struct ceph_cap *cap,
> bool *invalidate);
> =C2=A0
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> =C2=A0static inline bool ceph_has_inline_data(struct ceph_inode_info *ci)
> =C2=A0{
> =C2=A0	if (ci->i_inline_version =3D=3D CEPH_INLINE_NONE ||
> @@ -1347,6 +1354,12 @@ static inline bool ceph_has_inline_data(struct
> ceph_inode_info *ci)
> =C2=A0		return false;
> =C2=A0	return true;
> =C2=A0}
> +#else
> +static inline bool ceph_has_inline_data(struct ceph_inode_info *ci)
> +{
> +	return false;
> +}
> +#endif
> =C2=A0
> =C2=A0/* file.c */
> =C2=A0extern const struct file_operations ceph_file_fops;
> diff --git a/include/linux/ceph/ceph_features.h
> b/include/linux/ceph/ceph_features.h
> index 3a47acd9cc14..207b93787a4f 100644
> --- a/include/linux/ceph/ceph_features.h
> +++ b/include/linux/ceph/ceph_features.h
> @@ -132,6 +132,11 @@ DEFINE_CEPH_FEATURE(38, 1, OSD_ERASURE_CODES)
> =C2=A0DEFINE_CEPH_FEATURE(38, 1, OSD_OSD_TMAP2OMAP) // overlap
> =C2=A0DEFINE_CEPH_FEATURE(39, 1, OSDMAP_ENC)
> =C2=A0DEFINE_CEPH_FEATURE(40, 1, MDS_INLINE_DATA)
> +#ifdef CONFIG_CEPH_FS_INLINE_DATA
> +#define
> CEPH_FEATURE_MDS_INLINE_DATA_DEFAULT	CEPH_FEATURE_MDS_INLINE_DATA
> +#else
> +#define CEPH_FEATURE_MDS_INLINE_DATA_DEFAULT	0
> +#endif
> =C2=A0DEFINE_CEPH_FEATURE(41, 1, CRUSH_TUNABLES3)
> =C2=A0DEFINE_CEPH_FEATURE(41, 1, OSD_PRIMARY_AFFINITY) // overlap
> =C2=A0DEFINE_CEPH_FEATURE(42, 1, MSGR_KEEPALIVE2)
> @@ -204,7 +209,7 @@ DEFINE_CEPH_FEATURE_DEPRECATED(63, 1,
> RESERVED_BROKEN, LUMINOUS) // client-facin
> =C2=A0	 CEPH_FEATURE_CRUSH_V2 |		\
> =C2=A0	 CEPH_FEATURE_EXPORT_PEER |		\
> =C2=A0	 CEPH_FEATURE_OSDMAP_ENC |		\
> -	 CEPH_FEATURE_MDS_INLINE_DATA |		\
> +	 CEPH_FEATURE_MDS_INLINE_DATA_DEFAULT |	\
> =C2=A0	 CEPH_FEATURE_CRUSH_TUNABLES3 |		\
> =C2=A0	 CEPH_FEATURE_OSD_PRIMARY_AFFINITY |	\
> =C2=A0	 CEPH_FEATURE_MSGR_KEEPALIVE2 |		\
>=20
> ---
> base-commit: 602bb4525c8146865b7f6e44c81d54bf97861aed
> change-id: 20260728-b4-ceph-remove-inline-data-d55c6466dd7e
>=20
>=20

git apply --check ./\[PATCH\ v2\]\ ceph\:\ remove\ the\ inline\ data\
support.mbox
error: patch failed: fs/ceph/Kconfig:17
error: fs/ceph/Kconfig: patch does not apply
error: patch failed: fs/ceph/addr.c:274
error: fs/ceph/addr.c: patch does not apply
error: patch failed: fs/ceph/caps.c:1266
error: fs/ceph/caps.c: patch does not apply
error: patch failed: fs/ceph/file.c:224
error: fs/ceph/file.c: patch does not apply
error: patch failed: fs/ceph/inode.c:627
error: fs/ceph/inode.c: patch does not apply
error: patch failed: fs/ceph/mds_client.c:156
error: fs/ceph/mds_client.c: patch does not apply
error: patch failed: fs/ceph/mds_client.h:149
error: fs/ceph/mds_client.h: patch does not apply
error: patch failed: fs/ceph/snap.c:613
error: fs/ceph/snap.c: patch does not apply
error: patch failed: fs/ceph/super.h:274
error: fs/ceph/super.h: patch does not apply
error: patch failed: include/linux/ceph/ceph_features.h:132
error: include/linux/ceph/ceph_features.h: patch does not apply
>=20

./scripts/checkpatch.pl --strict ./\[PATCH\ v2\]\ ceph\:\ remove\ the\
inline\ data\ support.mbox=20
ERROR: DOS line endings
#145: FILE: fs/ceph/Kconfig:20:
+config CEPH_FS_INLINE_DATA^M$

ERROR: DOS line endings
#146: FILE: fs/ceph/Kconfig:21:
+^Ibool "Enable CephFS inline data support (deprecated)"^M$

Every new line in this patch is indented with spaces, not tabs.

Thanks,
Slava.
