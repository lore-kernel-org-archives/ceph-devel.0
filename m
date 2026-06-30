Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB636D4F1
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782835311; cv=none; b=DVIEg23kFi1BeoKf3/49/pLQyub76ieJ33oFj70RdYD5vjN9N7pC6a9reknWfZMQtazk9yLsT2Z0nypyAK0mlBg1W8hmmeeQ6+PTHRS+zcruHhVtCKwMmlx6m5fZcQliXCi1FTiNf6vtn0jlD0m0vD2n/n33FsW2LN2bzgfm9dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782835311; c=relaxed/simple;
	bh=RHaNn3g4w14aDa53UTweRy7LDhA+u+PVBgz2wJvYFng=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gho1C1LsPYCm8LgvxrBIC3MaOV258wUDtrbP+q7Qv1N4JTrCu0aGBaePaVZkY8DNCF+I/XjAyQ5aEdIAeu7f4a7D3GJSGP24SVUNhCNB6e/T33DMCXD0Wkfj/E3JDe7SmoUxHN7vdK2K028x9uhxydLYaLb5T74ng9gP8SqQy4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=a5Vq7Ze0; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="a5Vq7Ze0"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84794e800f4so974522b3a.0
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 09:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782835306; x=1783440106; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIMOZD/PhyReFTACDz34bK2Y4dho8I+GhKGHZivlkuU=;
        b=a5Vq7Ze0wGe3/cP5OCoMkLYQg7iMmz99iEfULyGYywz9eG7ylULKY3DO7Fbe5mApry
         mZLeP2/pP4w+NGfIHYPVF52B35+cjxqtlhSRx8HqOty5Xb92XI+hhJH55Wwh55RnnJhw
         ulJXXh3Pu+M0WjeGkJl6AMMg87oJB+E2S7z05RqmZ3DD4boqeICvlmW9oak4GV4LbqMC
         rYPRz3i3B257mqceZJYJYKk43Xnr/7eQnG8a1goL5sUhRDu9J7sQf0tqLAxVu+ma09Vi
         1sttoMYQY/p71kZsgCmAYL6uuBrsUZsdNZl91MolEPHB8H+3Mr5Jgu7zUcwvVURrkRJ6
         JLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782835306; x=1783440106;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIMOZD/PhyReFTACDz34bK2Y4dho8I+GhKGHZivlkuU=;
        b=ddzzT0t+bv0PSxant5PpI0wP8BF8AODrNW2JP9RnMcB6eUnDO/Du5b8Az7CxviQfNz
         Ge4erpnTANYVXHnsuteL9EkCTmMBHviAD1c9E99HzS7Ffmipjghx2W6YNMEC6eInWomr
         hoTh8orA0w+XnfrN0qSUfyAUMKPLZcQTu2ENWgSMu276R1BFqi+ZpgBbqyG+eJCQZc34
         x5ZEo9SP4lgq1Ap3N0hvMrJ7ueLoCB3VFO2O1Ukvm/va1fRKw7LfYemc8do4O5ZyXbxc
         RIg1Hguh8vLu5see+ATQM7AVe6w4QY2FDiZm/WnMfTu5dPCaNRxaFv8aNP5Zd8EHIWGY
         GdYg==
X-Forwarded-Encrypted: i=1; AFNElJ/qQN48g84JWUzBs3+Ii5K51319ymmRJTAKAw4y7RXXoCrlaxmGhEM91SJKoScqg0amKvmW5FVG8y4B@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7obVtCXU0fm4qTM36znxe4T7MNtSM99/sK1L1pEXBS6NdPLb
	eyU1sqHceczAecABC4+WDIRwvsNDpXGC6/tGSlQwmKDXCffdywM/38Qcw/LTBIGfwg2m0JtpOyM
	yRdk/CqOGbA==
X-Gm-Gg: AfdE7cmxJrK56cONTlMFTcqJDu4mcdFKN8fnj9txj2BIKut+Kp7mNFrStFqIEAjgvCh
	GIoZEF8C+nEOoft0+eUq8fY9NH3eLhMKlWuUQZs2ZSG1I7HcggbuLCaDDGEgI5cI1ceu+VabckR
	bfbBtgndE6MfsJsml9wmdsXeRLF4WIDYHMGwct7duf1pWWaPq/yoo3JDGXWL70sExD4i6T7JZ5P
	80YfFrkYLWcSKdYvuy5BFuHZMjHRojalnIRCKSdU1NP2nwKd2m8GhKYGZwZVt8zAaLGyTM5BLIh
	Qn7LtkSkNiiMceshAMvuiQyBPu2zBe+r1vcVZTMIih5YIZuK+gFunwtTdTS0GnlZIuoonfsPzqp
	fc5YqCtYAHlEJlqwxpQ4oeqpTOOIkYH63j2d2Jdlk//92D1UG0BlEI3egoEpQx9o6HeXqE/amFn
	CoWA6cAkkBm8rMZR1aoMrfpe4uFjvEJuZKISVzBXx33gi3WjAfzNkjs7aTTA8WpK8Duip/eg+rM
	8R16OmI5zUbdvDMCjNhWOyFcueJqs14nUqe1wHIi77WGqc2d0+btn0x8aYk4btMkZJUoMxTvFKc
	4+LW9DE=
X-Received: by 2002:a05:6a00:4517:b0:845:3d82:10fc with SMTP id d2e1a72fcca58-8479ea7ccffmr3710039b3a.0.1782835305534;
        Tue, 30 Jun 2026 09:01:45 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479ff8c6f8sm2271108b3a.1.2026.06.30.09.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:01:44 -0700 (PDT)
Message-ID: <59c115f6df6f3ec1c9660363958f173f722834f6.camel@dubeyko.com>
Subject: Re: [PATCH 02/12] fs/ceph/super: make field
 `i_truncate_pagecache_size` optional
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 30 Jun 2026 09:01:42 -0700
In-Reply-To: <20260612165204.86137-3-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
	 <20260612165204.86137-3-max.kellermann@ionos.com>
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
> This field is only used with CONFIG_FS_ENCRYPTION; without it, it
> always equals `i_truncate_size`.
>=20
> This reduces the size of `struct ceph_inode_info` by 8 bytes on
> kernels that have filesystem encryption disabled.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> =C2=A0fs/ceph/inode.c |=C2=A0 8 ++++++--
> =C2=A0fs/ceph/super.h | 11 +++++++++++
> =C2=A02 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 22c7da1ea61c..1504b889622c 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -680,7 +680,9 @@ struct inode *ceph_alloc_inode(struct super_block
> *sb)
> =C2=A0	ci->i_truncate_seq =3D 0;
> =C2=A0	ci->i_truncate_size =3D 0;
> =C2=A0	ci->i_truncate_pending =3D 0;
> +#ifdef CONFIG_FS_ENCRYPTION
> =C2=A0	ci->i_truncate_pagecache_size =3D 0;
> +#endif
> =C2=A0
> =C2=A0	ci->i_max_size =3D 0;
> =C2=A0	ci->i_reported_size =3D 0;
> @@ -865,6 +867,7 @@ int ceph_fill_file_size(struct inode *inode, int
> issued,
> =C2=A0
> =C2=A0		ci->i_truncate_size =3D truncate_size;
> =C2=A0
> +#ifdef CONFIG_FS_ENCRYPTION
> =C2=A0		if (IS_ENCRYPTED(inode)) {
> =C2=A0			doutc(cl, "truncate_pagecache_size %lld ->
> %llu\n",
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ci->i_truncate_pagecache_size, si=
ze);
> @@ -872,6 +875,7 @@ int ceph_fill_file_size(struct inode *inode, int
> issued,
> =C2=A0		} else {
> =C2=A0			ci->i_truncate_pagecache_size =3D
> truncate_size;
> =C2=A0		}
> +#endif
> =C2=A0	}
> =C2=A0	return queue_trunc;
> =C2=A0}
> @@ -2331,7 +2335,7 @@ void __ceph_do_pending_vmtruncate(struct inode
> *inode)
> =C2=A0	/* there should be no reader or writer */
> =C2=A0	WARN_ON_ONCE(ci->i_rd_ref || ci->i_wr_ref);
> =C2=A0
> -	to =3D ci->i_truncate_pagecache_size;
> +	to =3D ceph_get_truncate_pagecache_size(ci);
> =C2=A0	wrbuffer_refs =3D ci->i_wrbuffer_ref;
> =C2=A0	doutc(cl, "%p %llx.%llx (%d) to %lld\n", inode,
> ceph_vinop(inode),
> =C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ci->i_truncate_pending, to);
> @@ -2341,7 +2345,7 @@ void __ceph_do_pending_vmtruncate(struct inode
> *inode)
> =C2=A0	truncate_pagecache(inode, to);
> =C2=A0
> =C2=A0	spin_lock(&ci->i_ceph_lock);
> -	if (to =3D=3D ci->i_truncate_pagecache_size) {
> +	if (to =3D=3D ceph_get_truncate_pagecache_size(ci)) {
> =C2=A0		ci->i_truncate_pending =3D 0;
> =C2=A0		finish =3D 1;
> =C2=A0	}
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 6aec40955387..f0f03aeb5b19 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -461,11 +461,14 @@ struct ceph_inode_info {
> =C2=A0	u32 i_truncate_seq;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* l=
ast truncate to smaller size
> */
> =C2=A0	u64 i_truncate_size;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=C2=A0 =
and the size we last
> truncated down to */
> =C2=A0	int i_truncate_pending;=C2=A0=C2=A0=C2=A0 /*=C2=A0 still need to c=
all vmtruncate
> */
> +
> +#ifdef CONFIG_FS_ENCRYPTION
> =C2=A0	/*
> =C2=A0	 * For none fscrypt case it equals to i_truncate_size or it
> will
> =C2=A0	 * equals to fscrypt_file_size
> =C2=A0	 */
> =C2=A0	u64 i_truncate_pagecache_size;
> +#endif
> =C2=A0
> =C2=A0	u64 i_max_size;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* max file size authorized by
> mds */
> =C2=A0	u64 i_reported_size; /* (max_)size reported to or requested
> of mds */
> @@ -660,6 +663,14 @@ static inline struct inode
> *ceph_find_inode(struct super_block *sb,
> =C2=A0	return ilookup5(sb, (unsigned long)vino.ino,
> ceph_ino_compare, &vino);
> =C2=A0}
> =C2=A0
> +static inline u64 ceph_get_truncate_pagecache_size(const struct
> ceph_inode_info *ci)
> +{
> +#ifdef CONFIG_CEPH_FS_SNAPSHOTS

Maybe, I am missing something. But where CONFIG_CEPH_FS_SNAPSHOTS is
defined? Currently, we don't have it in the fs/ceph/Kconfig and the
patch has no declaration of this compilation option.

Thanks,
Slava.

> +	return ci->i_truncate_pagecache_size;
> +#else
> +	return ci->i_truncate_size;
> +#endif
> +}
> =C2=A0
> =C2=A0/*
> =C2=A0 * Ceph inode.
