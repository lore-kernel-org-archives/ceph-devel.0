Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF447279E
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782836196; cv=none; b=RlfExqqz/7Zdjripy8Ul6sBQepgMw6y5eYmgmoyUd+MwUjGc9KNVZPSp+OTjAZ6rpKw0oNn2ZsHtnDLlQuGvcFB/X+qBSt4mR187GTeOoHzlllgCVMmscioKL9WUAhve8zI7b0Hhp17RahVfQDc8TCyxSlC4BjydAChLbJcbBQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782836196; c=relaxed/simple;
	bh=dft6UTbnBFX7b3N2P7AA7LU4Jj6czJV1paB3+as71kc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJdqpODBUJs72K1V3SiA0p88nWrk2a9Je6/pHibP6k+bg+nJaLf7cAb++MFwT+gYCiS4E++FtbDftN+V94OdZTHLEMT6Ec33JVCQvGHWmcuG8MpBOE7pVkD4imZ4gFT7Jcr/w+faW3yBedSPeZkB5g1GGOynYtONUDnQAMaCwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=HrcMFlY+; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="HrcMFlY+"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664d78637f8so2306857d50.3
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782836191; x=1783440991; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdQ69ClsSVzahSR2G4k3xJt1HLDb1bUUXm3gO6a8tzA=;
        b=HrcMFlY+4dnjNDLNMa67kRdPrd0MTaCnKETE8V1sShT3VSMP8a1o/tl8Sc+0VXlS6Q
         AqIBh5E7+9oDIB4uEgok6/6Fi8nsLfv9iUd+Y3ZkhxctR/QmbQpQbJ3MZeWpxqOX83of
         RjG/k6ZJbD24mxVyc1y5VOtnOTAU+CyPd13VNaHNwDBwZnA6vkYxMZVDus1UWL3/F3V6
         UL1LYdbwKmqDAFeL6YtmyydyQhJvlBe2f++IAmZzYJNreSCQoyEcP3vQYjFIUHFbQUq3
         VapKOs5MSqBg7VlmbqzX52noWl3Pjo0yumPmARmCw5MSqS9NujGeV1uMNGPdq60uT+tQ
         mQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782836191; x=1783440991;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdQ69ClsSVzahSR2G4k3xJt1HLDb1bUUXm3gO6a8tzA=;
        b=sjOYH/F5A8QGfozRE+aVFyX3v5YSmqLEQdVhAVjFF0C6X7z6hQeYjcRIFGCo4++jy/
         5LAl6eC+/5pW/08YTCx7931K6MTYXNS1LmeslWPcxbFiuB/DcHdpDf3fTNAOfnY2kiEU
         c6AY8aYD0KDjyZ3No8/HoE/EXGK6CBAbI5qewTtaEQiKyqezTsjzOs/OYRjnD4fuWqwK
         LAEh3dcl3VpIT9WS4ZZL5nP/oBN3Pyrd2qfGRlfAS6RmarSFbjnby7QJd0IdRNSJc484
         8HOp8p7zfIewOhjPvvq/bBHoMXy4LJS5dqICfZ5KsrAPCp+3OzoXQsUxR/TpyUjmMiMp
         i2YQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpq6I6w91gVgfrFa4ncK1UroCYz7jBHh4MgdAFHUDWYs8+9GXSpnQho/tiPkxoNC7uz5t9YYXAOCO1W@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4+StNqke57nTiHXyIkzXVninMkmxvl5R1yC9pN1ywsn6ABVU3
	DktRFKXCRq4UQR6lrV1fIvl3CT0lZAq7P0QQPbf5gOyQ60oYkjNyBBI9sOfgDJ81wTs=
X-Gm-Gg: AfdE7cnYMpd2dgLQ+sxHG8CBb3wpPfpQxeaDxNCdWOsnhXRReeiXqWwDZAv3kvwupvZ
	D+q+x5Yi8mOPKSG7+Fqo52bxX0ikzX2K7a4yI2ebYd/zjny8YZGZo7NFZ0UAIMIqRu8hvFsNgRy
	TGLTBRQSOLnbMjY6d1gQTQJ2glewnB7IpG12yEBq+Uer1lJo08/UiLTI7LnO3/k5Ul75tke3inJ
	A53W9fYkkZcBBn3VlRrPp/x1eKxn8daVZYkORqqC7QjyrTe8PRlPGtqhwg7sxFY8Nep6ZVJqSQv
	QVmpdphTNiOphntE246C1WQKuUgQQS65QZHZbCdY8dzjIVt+UxULRDCh1qeBatopH27DE8WUWA+
	0fgd/+Q9dNxeEkZ+ZzGJC/MjXVjKlR7loYGigkH4Eg9gi3zpUzJVjhbxk+bJo44A8GIXToFttra
	3aTpUAHQHcDE4Dx1lmS+UIPAgW/H23JKCimWHJsentFsfkb09ePX9E46fn/oJnq7EjSC1SM8ZTW
	LXXVFejPnXByU5tgp3jK77cOSh//R045faVcscXOptSRmMMB72WQAo1mWY0adV1M8t0sfQJrZ3v
	jcluCRA=
X-Received: by 2002:a53:c041:0:20b0:664:ae6b:b49c with SMTP id 956f58d0204a3-6651233cb43mr797458d50.81.1782836190471;
        Tue, 30 Jun 2026 09:16:30 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6650053f901sm1132804d50.1.2026.06.30.09.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:16:29 -0700 (PDT)
Message-ID: <3f7204ad1911795899e20a84ae8b86da537d8672.camel@dubeyko.com>
Subject: Re: [PATCH 06/12] fs/ceph: consistently use `u32` for
 `time_warp_seq`
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 30 Jun 2026 09:16:28 -0700
In-Reply-To: <20260612165204.86137-7-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
	 <20260612165204.86137-7-max.kellermann@ionos.com>
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
> Previously, both `u32` and `u64` was used with implicit casts.=C2=A0 All
> this does is add useless overhead.
>=20
> This will allow better struct packing in `struct ceph_cap_snap`.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> =C2=A0fs/ceph/inode.c | 6 +++---
> =C2=A0fs/ceph/super.h | 4 ++--
> =C2=A02 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index c26217ed2034..17df694fe978 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -915,7 +915,7 @@ void ceph_inode_set_subvolume(struct inode
> *inode, u64 subvolume_id)
> =C2=A0}
> =C2=A0
> =C2=A0void ceph_fill_file_time(struct inode *inode, int issued,
> -			 u64 time_warp_seq, struct timespec64
> *ctime,
> +			 u32 time_warp_seq, struct timespec64
> *ctime,
> =C2=A0			 struct timespec64 *mtime, struct timespec64
> *atime)
> =C2=A0{
> =C2=A0	struct ceph_client *cl =3D ceph_inode_to_client(inode);
> @@ -939,7 +939,7 @@ void ceph_fill_file_time(struct inode *inode, int
> issued,
> =C2=A0		=C2=A0=C2=A0=C2=A0 ceph_seq_cmp(time_warp_seq, ci->i_time_warp_se=
q)
> > 0) {
> =C2=A0			/* the MDS did a utimes() */
> =C2=A0			doutc(cl, "mtime %ptSp -> %ptSp tw %d ->
> %d\n", &imtime, mtime,
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ci->i_time_warp_seq,
> (int)time_warp_seq);
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ci->i_time_warp_seq, time_warp_seq);
> =C2=A0
> =C2=A0			inode_set_mtime_to_ts(inode, *mtime);
> =C2=A0			inode_set_atime_to_ts(inode, *atime);
> @@ -971,7 +971,7 @@ void ceph_fill_file_time(struct inode *inode, int
> issued,
> =C2=A0		}
> =C2=A0	}
> =C2=A0	if (warn) /* time_warp_seq shouldn't go backwards */
> -		doutc(cl, "%p mds time_warp_seq %llu < %u\n", inode,
> +		doutc(cl, "%p mds time_warp_seq %u < %u\n", inode,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time_warp_seq, ci->i_time_warp_seq=
);
> =C2=A0}
> =C2=A0
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 505a1552f355..9b5119b1d0a9 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -266,7 +266,7 @@ struct ceph_cap_snap {
> =C2=A0	u64 size;
> =C2=A0	u64 change_attr;
> =C2=A0	struct timespec64 mtime, atime, ctime, btime;
> -	u64 time_warp_seq;
> +	u32 time_warp_seq;
> =C2=A0	u64 truncate_size;
> =C2=A0	u32 truncate_seq;
> =C2=A0	bool writing;=C2=A0=C2=A0 /* a sync write is still in progress */
> @@ -1091,7 +1091,7 @@ extern int ceph_fill_file_size(struct inode
> *inode, int issued,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 truncate_seq, u64 trunc=
ate_size,
> u64 size);
> =C2=A0extern void ceph_inode_set_subvolume(struct inode *inode, u64
> subvolume_id);
> =C2=A0extern void ceph_fill_file_time(struct inode *inode, int issued,
> -				u64 time_warp_seq, struct timespec64
> *ctime,
> +				u32 time_warp_seq, struct timespec64
> *ctime,
> =C2=A0				struct timespec64 *mtime,
> =C2=A0				struct timespec64 *atime);
> =C2=A0extern int ceph_fill_inode(struct inode *inode, struct page
> *locked_page,

Makes sense.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
