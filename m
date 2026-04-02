Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8664B3009F6
	for <ceph-devel@vger.kernel.org>; Thu,  2 Apr 2026 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775156110; cv=none; b=UW5uT5M/eJnh6SLLp5WkRzADjtMX8xzYWJltHTgDezPnDQUI20c+9z1/pRXRs2jtnf8xD5ZXhFcvFtHi5oZWF6+5nLjTtvplZL321+qGGsFIwHJi72X3lYCaafR6K7/OWnesD/2rJslfpM+ReQBQA9oQPCck3MLn8+wob3CIE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775156110; c=relaxed/simple;
	bh=1juJjqn3FZDQokTKCzGrnQrJZxs9V+Cm+GzRE/sjHlY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TxGBmiWDpDAXq4h49GwyztZ8unL7FbHmmGiEvLJCrd1Cf+4G8mIqV50yAdoVaWymKo69T3v7YKfzZQzgW57vKbmwBhIxvWSThIhQ62SrAjSK1lQJak8cxpW1GS//dtgCA6v95BR6HiL3LHMezsxW4DOy9dg4LCc844Ok1cFh1gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6QSyU7x; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiCQXxii; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6QSyU7x";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiCQXxii"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775156106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kAqgUQ3fPhJxhiGUcpjyYMy4ZHB+Q3w4TN9iGgHF/Is=;
	b=N6QSyU7xAJ0i9eqnUkHKTPL4yfeuvKXXM3jvw4Qpyf/l2NJXM7Xokf9S+N+dseExUzQBOn
	bRfdFgaPOfgVXwCCxg+KN9E/Ct9gRR67Smb7YPYlI/EyiqBRZmB5aH5WCNqijHgnSP5YaQ
	Vsta56dLYkAJWkBW796lkK+zrak9XNI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-zjtwvDxUOWaP7s6Tp6q9tg-1; Thu, 02 Apr 2026 14:55:05 -0400
X-MC-Unique: zjtwvDxUOWaP7s6Tp6q9tg-1
X-Mimecast-MFC-AGG-ID: zjtwvDxUOWaP7s6Tp6q9tg_1775156104
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-467dceb8e77so3146461b6e.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 Apr 2026 11:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775156104; x=1775760904; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAqgUQ3fPhJxhiGUcpjyYMy4ZHB+Q3w4TN9iGgHF/Is=;
        b=HiCQXxiiEz6wnyrZ6CyKIGfYRp6WY9vPZwdMDutPRLW6ouBYUDZ+pZjWm1bV1aITHf
         3kwsASYe5d/Jd4ejiEGABzMECEmMXtyPAopwewnQ6DQadgz6dxpNQ/vreZZyf8DjHBaj
         l6Rbp+BnpxZmA8i/4dbCAhAQa+EXOXhjX8siymwKflB3g8Eat9LwwVrcqzGViTt+Pjtk
         46nGgijQcso+kH/H8KHxHhJe1rM3gIPbpcTyihBuNc7mds32nw+romiPNTRUk4E86h5P
         vuRAlYlH5eYY33R5clG6uPfpzjfr4208UMkh3YJQdJSs5d5CYr4EYQkEGjhDx0IfX89i
         fh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775156104; x=1775760904;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kAqgUQ3fPhJxhiGUcpjyYMy4ZHB+Q3w4TN9iGgHF/Is=;
        b=Kw8PqVF32Tyg+ED8q8l5qHRgAo8nCbhsM7M0NK5SldfrLTmqWzxYH1Q5KyQCzRKctv
         yOccIasNruYYHcUqHayHBWmyGy/i7NplEXbWD4zjWvaB60aQQJrVcqPUqYdtI2NEo1C8
         xcKdZQpzowyVw2E8Juw5fWSQiWIxiO7bNLophDM8cHlULncwUYsSHTxGURYrennycGrx
         fI+IdxFQ4E2KDAY6suSTGTBoyN1firEDyjpN2AKGLv9FRi4h5SxWz37W0B3XAluB+2qF
         dA8aA74t78Dvuliwpen0Eot6nBGkuicjtvJuh2VSG3smBEYdQ1ak/Dna3Kq3/jFM2QuF
         1o3A==
X-Forwarded-Encrypted: i=1; AJvYcCUYu+nEUlu1o16hzmzDQDgFYoRfu31sZfYTxZVYPzgvqXbQKuzn2lmidlTOMDi5suZff1k6tyJI2Zb7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13YbyXCDXCNWYwB8GJUQJLB5hY1ZiGS/yk7bqQVcMAZ1JPjAe
	DA5w+tD1qobsk5cmQYkvSg3hMu+Ip8Lx9HF1/FOr4iISdxUIPtmtvAd6NPJ6cvUh3ZdgdfBFsJq
	wO+hMaSCJ7olo0vJNkQaee/jNUfEKr58WVjn2yv/6qaId5j2wHsngxZvZWaCXYV4=
X-Gm-Gg: ATEYQzyOboYbvM4ygXC1X4nHoBk/op33Kz2lMg2KQviy3MEAwEK3OoEzYhnHqK7C441
	1/6cPnQJQXzWFrPUkMgc9F/ox+v9jmiU5CpsRon0FW0xGlLvll2ke/Mbt0u2Gw2PDkjbS3fOtm2
	7SUSAdoSIwF7zLJ6jUbZzk43Qoy4nl9VKl5HbiMjShr+qm9sLXzwMgi/8hWoKD/pUhqkGoH0osS
	WDU5Oy6Tgng8z9uNXs5OcAilV86b47u36p8cE2WC8wUgw6wU4+lcNSEsYoXeGFFklE4Dn1O9Ozv
	EQBQGGyVFhO/5KAfwTTrdolTL+O7CUJ5qLzZNV61/Z+n+LjrYt5ULfweGpKajgi8MsxZktsdFD/
	lLT2SD8MNls7f6nmUMjXQnd/rwEYAZMsCxlzD+RMUdSNtm9eLu8Tw
X-Received: by 2002:a05:6808:159b:b0:460:f435:2a71 with SMTP id 5614622812f47-46ef8218f3dmr283085b6e.46.1775156104453;
        Thu, 02 Apr 2026 11:55:04 -0700 (PDT)
X-Received: by 2002:a05:6808:159b:b0:460:f435:2a71 with SMTP id 5614622812f47-46ef8218f3dmr283065b6e.46.1775156103974;
        Thu, 02 Apr 2026 11:55:03 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba72fd409sm2594664a34.16.2026.04.02.11.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 11:55:03 -0700 (PDT)
Message-ID: <74ebe2eb03ce3b1ae3038badffc8397d82d3eff2.camel@redhat.com>
Subject: Re: [PATCH] ceph: support RWF_DONTCACHE
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, dhowells@redhat.com, 
	pc@manguebit.org, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 02 Apr 2026 11:55:02 -0700
In-Reply-To: <20260401053109.1861724-1-max.kellermann@ionos.com>
References: <20260401053109.1861724-1-max.kellermann@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-01 at 07:31 +0200, Max Kellermann wrote:
> Similar to commit 902893e39076 ("NFS: Enable use of the RWF_DONTCACHE
> flag on the NFS client").
>=20
> The Ceph client now supports RWF_DONTCACHE for buffered file IO, but
> it needs preserve the IOCB_DONTCACHE state through
> netfs_write_begin().
>=20
> Unlike NFS, Ceph does not need to defer drop-behind until after a
> separate COMMIT step.  Ceph's buffered writeback completes when the
> OSD write completes, so the existing folio_end_writeback() handling is
> sufficient.
>=20
> This patch changes netfs because Ceph does not get its write_begin
> folio directly.  ceph_write_begin() is a wrapper around
> netfs_write_begin(), and that helper was calling
> __filemap_get_folio(FGP_WRITEBEGIN, ...) without access to the kiocb.
> As a result, the per-IO IOCB_DONTCACHE flag was lost before folio
> allocation.
>=20
> Fix this by passing the kiocb into netfs_write_begin() and switching
> it to write_begin_get_folio(iocb, ...), so IOCB_DONTCACHE is
> translated into FGP_DONTCACHE when appropriate.  Then set
> FOP_DONTCACHE on ceph_file_fops so the VFS will accept RWF_DONTCACHE
> for files on Ceph.
>=20
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/addr.c           | 3 ++-
>  fs/ceph/file.c           | 1 +
>  fs/netfs/buffered_read.c | 6 +++---
>  include/linux/netfs.h    | 3 ++-
>  4 files changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 2090fc78529c..b4ea3ba8211e 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1865,7 +1865,8 @@ static int ceph_write_begin(const struct kiocb *ioc=
b,
>  	struct ceph_inode_info *ci =3D ceph_inode(inode);
>  	int r;
> =20
> -	r =3D netfs_write_begin(&ci->netfs, file, inode->i_mapping, pos, len, f=
oliop, NULL);
> +	r =3D netfs_write_begin(iocb, &ci->netfs, file, inode->i_mapping, pos,
> +			      len, foliop, NULL);
>  	if (r < 0)
>  		return r;
> =20
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 5e7c73a29aa3..341589ef32cd 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -3191,4 +3191,5 @@ const struct file_operations ceph_file_fops =3D {
>  	.compat_ioctl =3D compat_ptr_ioctl,
>  	.fallocate	=3D ceph_fallocate,
>  	.copy_file_range =3D ceph_copy_file_range,
> +	.fop_flags =3D FOP_DONTCACHE,
>  };
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index a8c0d86118c5..6ec7c2459d8a 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -589,6 +589,7 @@ static bool netfs_skip_folio_read(struct folio *folio=
, loff_t pos, size_t len,
> =20
>  /**
>   * netfs_write_begin - Helper to prepare for writing [DEPRECATED]

The netfs_write_begin() is deprecated function. Maybe, it's time to switch
CephFS on netfs_perform_write() finally?

Thanks,
Slava.

> + * @iocb: The kiocb describing the write request
>   * @ctx: The netfs context
>   * @file: The file to read from
>   * @mapping: The mapping to read from
> @@ -620,7 +621,7 @@ static bool netfs_skip_folio_read(struct folio *folio=
, loff_t pos, size_t len,
>   * Note that this should be considered deprecated and netfs_perform_writ=
e()
>   * used instead.
>   */
> -int netfs_write_begin(struct netfs_inode *ctx,
> +int netfs_write_begin(const struct kiocb *iocb, struct netfs_inode *ctx,
>  		      struct file *file, struct address_space *mapping,
>  		      loff_t pos, unsigned int len, struct folio **_folio,
>  		      void **_fsdata)
> @@ -631,8 +632,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
>  	int ret;
> =20
>  retry:
> -	folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> -				    mapping_gfp_mask(mapping));
> +	folio =3D write_begin_get_folio(iocb, mapping, index, len);
>  	if (IS_ERR(folio))
>  		return PTR_ERR(folio);
> =20
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index ba17ac5bf356..d58c614e32fd 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -414,7 +414,8 @@ int netfs_writeback_single(struct address_space *mapp=
ing,
>  struct readahead_control;
>  void netfs_readahead(struct readahead_control *);
>  int netfs_read_folio(struct file *, struct folio *);
> -int netfs_write_begin(struct netfs_inode *, struct file *,
> +int netfs_write_begin(const struct kiocb *iocb,
> +		      struct netfs_inode *ctx, struct file *file,
>  		      struct address_space *, loff_t pos, unsigned int len,
>  		      struct folio **, void **fsdata);
>  int netfs_writepages(struct address_space *mapping,

