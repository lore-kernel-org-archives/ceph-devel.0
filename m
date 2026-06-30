Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F35747277C
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835894; cv=none; b=nlQqwQ/DGZUqvlCzYSu/b2w7oZo8+rWl9CPcqXGyv1UkeKBri/mquj3dc1Nva99rJA/8hcZb6VG7MHH5endMO1OkU0bjM3FMF/VL7kuTA4/KtbxcKusN1I56UCzf2oWrBHQ34D4xxU7Mvcuo7pm12Jl0DAWXQWjc4Cw90+Bsq8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835894; c=relaxed/simple;
	bh=Bfitx2bCHS+UCYEHhxSaSWt7rGfZINe3xvB12xf4OuM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mEV/FiBErK8yEiubL8EYfrnm+bD5u2tuWfI/HFZZP4rcl6KNTi7Tuqc1j6xtAR0zHCxe92DqiL+zqrkgDmRvIMGkfbIFOSfyf16hvjzINyQvef708VdbexP/9P+njouKQsGO6Lrfr6rrm7Uor6yqjklHcwgdQW58M9/Bf6H86ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=cSNLY9p9; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="cSNLY9p9"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1384ebe7a10so8432299c88.1
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 09:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782835891; x=1783440691; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eyu51LZd/iRigB7+GzdAeuR3cs8VnVhLcPMYxd5Cu5k=;
        b=cSNLY9p9UcifNV9/HePNTNO04ohY2IAiROxq4LoXD680TQLYwOtm+QGkMdTsxHBabW
         LqZS2M74/Fj//ZigDXVA9/Y46xzc99x7Th8G9F8QdlIGrk81Yx5OZXYSL/p+Bxhy5f9B
         TwfD/rOX3nz3LaESgR580B8APOOsj/y0TtmgeP+2iVAO3e8ixKF4Zjwqkzqsp80sMmjj
         f/WPKGSkeug8shU0/X3gxUGLcnHHprgs9MI3exOksgqx5ZYA8C89c61JFqegYoVGiHRn
         noJSxohYiqsJHUuUX1HqVjfQlGQG+EBG+FN4Y+XZsHe5HvHHX9UezjcFdD6sAq3fsFY3
         +ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835891; x=1783440691;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eyu51LZd/iRigB7+GzdAeuR3cs8VnVhLcPMYxd5Cu5k=;
        b=Fq0TrcFX25K8cGMC3Zs5B56b9O00rlwZMMkbK8nNYdj0PIEYrB9g8zzQSUTf2b6Vqr
         Nqj8edwVyR1LMqLRVruoHBgDqJguzakEJHvESzDPgcGy2o+wJ58KAI+scPxZJuRgXAxz
         CbXKj3FNDkgqfK13c+fb0Fw0uJP/LG1la6vy+zYAJMIqSIdyTgEWFzzUZsCf4iNrj8aO
         tYSiKzLolAI3HP+y5P8+T3s+Jq6h1OTmQ9HmyR+iXIbg1SWff+0UfjKIvUOUYT8OOdhA
         JiFdhX2BIVZMllQMEc+viDSJd47l0sp1DGnZR+00Dzcs5ZQfrr0sNoWsmuWvoKhIWVVA
         FOcg==
X-Forwarded-Encrypted: i=1; AHgh+RoqQ9RIG657BtFvQc+GkfFkTEEYn/SxInV3GkLegnpdWRN1RIkwBqM0UeBtGiB9rOQHILTnM4WBJ3yu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5F7c7Ygp9qcyvDK1kIffSbAlw1lGYYBTGSKBkIMvmwVz2HGI
	NBr1nWSIHFLTvfdN6ZsUkTD1MXLKIf0N60mBUknOoD0hiQQ8P4N9/FOf2Wm8DPCBLCF/uv93t2d
	4zSX9vrh0zQ==
X-Gm-Gg: AfdE7ck+eC797EmACDr8w9JA0LUdHr/OhhL0oTsRLlOm2MIPrVK563ZWpruU2zdGbEx
	jIYDmeLqn20fYSHcE4x+rYBKNkxz3r/fZVTK4AVugRrqU3jZmdCwnUov3Shv9sFC1rfcY0HTl/8
	KQdmoHdy6PLAbfbc9JFnMbDxhRXarRIyP87+f0P5sK0/jC7mnpkaCF3UQ3m/ZTwWFWNmUj/LIg+
	7tT9HN0XlDtwSkWMUfmsP3GXs2ydYoCsgrY+fYexjDF9PAvzl0li2bbnsCdolVM+s7dn88WdW8a
	DasXnF9e6sYod0Gfi9OwxtKHr/W2RAeGRrJ3q0YVBfHuTWfn93P9b1xrIxPufWyO6u7v+Nj0ajM
	08wv/U2/YMzZHHJHRVMWn+UQlq8yZv2lolWDWNoqHOpWcoHxeq2+dB763hJgWTHC7Z6SDI54n9W
	cDTJKXI2Np4vtrYQeipf1sB8iu0211tOEA3kOJfk6HjH2mlJ2ciwHOJCH+qkyaS/7SceB4HFWJV
	qsOxELpvDUxPDN4L/dM9ToQQRei7okUvrSfAvpemMlREhk+CXD5dYQceEzaq+UT0Cgth4bgtXeE
	tzSf8W3omOgy3dY/jQ==
X-Received: by 2002:a05:7301:7c12:b0:30b:c6f0:1cd9 with SMTP id 5a478bee46e88-30ee1385716mr3181898eec.26.1782835891306;
        Tue, 30 Jun 2026 09:11:31 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2cd21bcsm18702116eec.0.2026.06.30.09.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:11:30 -0700 (PDT)
Message-ID: <20ac85bf97c98688671cb64e609b6e142d85136a.camel@dubeyko.com>
Subject: Re: [PATCH 05/12] fs/ceph/super.h: convert ceph_cap_snap.writing
 fields to `bool`
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 30 Jun 2026 09:11:27 -0700
In-Reply-To: <20260612165204.86137-6-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
	 <20260612165204.86137-6-max.kellermann@ionos.com>
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

On Fri, 2026-06-12 at 18:51 +0200, Max Kellermann wrote:
> This will allow better struct packing.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> =C2=A0fs/ceph/caps.c=C2=A0 | 2 +-
> =C2=A0fs/ceph/snap.c=C2=A0 | 4 ++--
> =C2=A0fs/ceph/super.h | 2 +-
> =C2=A03 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index cf9916608dc2..e50bcb393c8f 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -3288,7 +3288,7 @@ static void __ceph_put_cap_refs(struct
> ceph_inode_info *ci, int had,
> =C2=A0					struct ceph_cap_snap,
> =C2=A0					ci_item);
> =C2=A0
> -		capsnap->writing =3D 0;
> +		capsnap->writing =3D false;
> =C2=A0		if (ceph_try_drop_cap_snap(ci, capsnap))
> =C2=A0			/* put the ref held by ceph_queue_cap_snap()
> */
> =C2=A0			put++;
> diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> index 52b4c2684f92..6dbc7859ff49 100644
> --- a/fs/ceph/snap.c
> +++ b/fs/ceph/snap.c
> @@ -521,7 +521,7 @@ static bool has_new_snaps(struct
> ceph_snap_context *o,
> =C2=A0 * However, if a (sync) write is currently in-progress when we appl=
y
> =C2=A0 * the snapshot, we have to wait until the write succeeds or fails
> =C2=A0 * (and a final size/mtime is known).=C2=A0 In this case the
> - * cap_snap->writing =3D 1, and is said to be "pending."=C2=A0 When the
> write
> + * cap_snap->writing =3D true, and is said to be "pending."=C2=A0 When t=
he
> write
> =C2=A0 * finishes, we __ceph_finish_cap_snap().
> =C2=A0 *
> =C2=A0 * Caller must hold snap_rwsem for read (i.e., the realm topology
> won't
> @@ -627,7 +627,7 @@ static void ceph_queue_cap_snap(struct
> ceph_inode_info *ci,
> =C2=A0		doutc(cl, "%p %llx.%llx cap_snap %p snapc %p seq
> %llu used WR,"
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " now pending\n", inode, ceph_vino=
p(inode),
> capsnap,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_snapc, old_snapc->seq);
> -		capsnap->writing =3D 1;
> +		capsnap->writing =3D true;
> =C2=A0	} else {
> =C2=A0		/* note mtime, size NOW. */
> =C2=A0		__ceph_finish_cap_snap(ci, capsnap);
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 18960a9e735a..505a1552f355 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -269,7 +269,7 @@ struct ceph_cap_snap {
> =C2=A0	u64 time_warp_seq;
> =C2=A0	u64 truncate_size;
> =C2=A0	u32 truncate_seq;
> -	int writing;=C2=A0=C2=A0 /* a sync write is still in progress */
> +	bool writing;=C2=A0=C2=A0 /* a sync write is still in progress */
> =C2=A0	int dirty_pages;=C2=A0=C2=A0=C2=A0=C2=A0 /* dirty pages awaiting w=
riteback */
> =C2=A0	bool inline_data;
> =C2=A0	bool need_flush;

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
