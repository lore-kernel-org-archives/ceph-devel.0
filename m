Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123DA419FCB
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238264; cv=pass; b=b2SaWF3lt4x8UO3USeA9oVj9/Zoro7C+3kUagBWrAv+04FtPHRtgLz2TSObR8kfT3EQ3sTEM5F2JVkMF3d0u55Ay9u7Dc3xi2d1EM+OoRDHhWKgsLijUlInH8SkkRWj9b2RIBVoaNZ605m/uOBTSDUAaYPyIhEpwyRfJBaqGSGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238264; c=relaxed/simple;
	bh=l3Tm1AV8dcK86Un0HFAsfoCUZAjWuevQd8t/b+qY8Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6UvP+IHz9bOAgtMQRHhZaZwOdPsjW2KBG4atzdZr95HVvYsJx3mhyKkBJmzsFfJrNGYB230HPxIYpsapCdLQl5er/UuvumZIHgo6qsdfGu0TiImTQ3/B2mNCv9236xFNH1THF9/Z24I8daY+rox9PbVNFklU9nzcjgE6CLjDwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUbjnXu+; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUbjnXu+"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-96935063700so2198159241.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 04:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785238262; cv=none;
        d=google.com; s=arc-20260327;
        b=XC5ajuW2QSeIk4o3wOAgQqua8gAYy0h/K8Y6xQINyyfA7oOXPlaW6Z3jlNGUjENAge
         c6NdDxUsg/War35i4Np1klPapdJHRretGFXfBlf9bvVQ6ATH/zpEBKhA6ZAVY2MHosiU
         kc6gR0gOuWr4Jgy6U8iy1Xa+ocohfKY3nmZ8/jCb+SowKUc7Jb+1uoaUqNu0PXiaCLah
         TReHdlQMvqP3EXGVUAnezCacgBas/CRC9ecnBdovwWqZAWz9ozeTcT20PLpGRUz/JZQa
         iau/j537qLcNP6uGK9dRIZ7nFcKC8BKweEB6Cmxfqp46mofEeHZIx/GzN6bMJZsWIiFV
         qFsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VEUA2hNG8LcDuIh44rfCasVHu4mLqVaGDQhYorW3toM=;
        fh=32olfSH/r2XNnaMdwHsF7B9KgfiS+3HWKFV3rXHJGxI=;
        b=CjmknuySQOHkL/6BfyyTW9RxTueHi4MtZ8YQpOrVaP7mfBPL5lFvST3N7qHYhHtJJa
         3apqx2yGkY+GGrN6qF/H0bVsUz4/xGWWSPG24ESswVoFFiPIyxy1EEc3G/AvCH0H14ti
         riD/OCGXJ+qeRafarFUt08lZkwIVLBhrgLqJWS15ouAWLy44lJ0lR95LzRZaEyGSBgSo
         mt89CR/cyXgVd35HMt3lo8HPynPY8uolSjZU6bEvfAFuqL7QAiAcOnAVsnpYiZxgAEcK
         JtBss4SyY+z3qD7E1qSIO5jj/oWbYHfYEfFxq0TbznkNDLmUzGDsEQ33Hd2IfZflbp54
         mR+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785238262; x=1785843062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VEUA2hNG8LcDuIh44rfCasVHu4mLqVaGDQhYorW3toM=;
        b=aUbjnXu+9GXjNVOAK3QJo1rSytAEBjQMu0qLft6KnnF/xE8U0VM6KikLC7my2KTCNO
         J2LuKr61ph5QqPQIzMEtzpfOQ4xvi9k2qFGKNrUZeqbWTMHt3NLmd6dRb9X46x4vN+0r
         ICu4fx12Z5oHoYBxvVcYh4MJ/hlq5+Lhl39ldIA1C05ulPMJDIWUyEoqhoAWCwjAYDX6
         LdDPzDoxpCI4oRnYsPaSAiN62PInsHcryBmMT9XUnIV/LhsCuuLSd5e5vo3buOBUwD0V
         /9Yh6/Ef7BuBEic6QKJy79balQ1lKI+d1hLN8P3Swh9UHe5FAxIlcIEg/vkAxqwsodA3
         KqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785238262; x=1785843062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VEUA2hNG8LcDuIh44rfCasVHu4mLqVaGDQhYorW3toM=;
        b=AIfGIGMoXCgBI2IG/OhpMhd1DD+z+dyYkLEz2MiSFvTYhrrm9T6HJ8bIQMGz/Y/ZEb
         ZLfvKqPnSpZGAZZMWCZrG2UymHAARkB9mTQpMIGDgb74FKb7xZ65klUqm6raaF/JCsd0
         pV1jwluXYginFVNUoHQ7Nvc4tgO4+Wu5no5bHgAow4jRLLRgiAHpDugEzbL6X3e+Kh3b
         ICEV9tWkLqDFpHnUVWdTznW0lBwPjw4T9XgD4gjpMgRPfD4GMvMki0d9nKL7vOnJGHlS
         swEPlw+AZi+FJGpUepGG/5qcrCxLxioFq4uqalKAbirLX2WB+4J7yT8Z2M184i5mn5Es
         ShdQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGozJIG/EAqC9rMD+WnLTEhaQEhQ4I1qVxuq0YsxJC5qctVtOdqWghtWgY5d05sDyzdJsAJBUX3LzF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4DmRJKh7pBSnCakbzGBjHpCI8LuJxBkaRKsL9rSgNZcAk0oyB
	TWkOqevy2AwgTNpQLLyDPtzjBDsqUypTbM+C1z57Pw9X00E5F9EZdva+/1B8hj5tH69zn80vupm
	HORBVXjUsmN41Y6zS3NbUbVpJ5Iu0qA4=
X-Gm-Gg: AR+sD12/y3SZ9t4mMqOP0ClsxYYi1xgjzMRKosJtWYucrZssU0NTa8rnna/R78cFC7b
	XkyzNwvah9lYTdB+b39jsuaLUL/WSVk54v9SHawJdnUHNV5Zf5KdytYj/nBM1TZVCT5W5P+nMd+
	u3itmzL9a+V5g+eDLNRPLfhzy+nMWr2zD6Q0P9UXG7Brc7V+m+r6vjQ0v7B6z0Bhe4b4yjDZ9eQ
	1t3e1UB3PRlni97tIy+o9iCqUpMJhYV2AGKh3hN21TQ2+0+p6xCqu8lfBl4cs5rFpZ5BwOiBWrd
	9w7GfyVINRrgwf3R4gE=
X-Received: by 2002:a05:6102:c47:b0:71e:39e9:ce5a with SMTP id
 ada2fe7eead31-754a24bc971mr769236137.26.1785238261819; Tue, 28 Jul 2026
 04:31:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
In-Reply-To: <20260727014745.1304657-1-zhanxusheng1024@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 28 Jul 2026 13:30:49 +0200
X-Gm-Features: AUfX_mytE6ppl0cG8sc6kC0q1t-euIDfIyWvsizyrI0wGinuaHfau49fEDCdf78
Message-ID: <CAOi1vP-Ba2=Gd3_wtH0g9yfqB6xJVstjarsmUhXj7WGXedqGBQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: use the mount idmap for the owner checks in the
 SET_LAYOUT ioctls
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 3:47=E2=80=AFAM Zhan Xusheng <zhanxusheng1024@gmail=
.com> wrote:
>
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
>
> ceph_ioctl_set_layout() and ceph_ioctl_set_layout_policy() call
> inode_owner_or_capable() with &nop_mnt_idmap instead of the idmap of the
> mount the ioctl was issued on.
>
> CephFS supports idmapped mounts (FS_ALLOW_IDMAP), so on such a mount this
> compares the caller's fsuid against the unmapped on-disk owner rather tha=
n
> the mapped owner: the actual owner can be wrongly denied with -EACCES and
> an unrelated caller wrongly allowed.  Both functions already have the
> struct file, so use file_mnt_idmap(file) instead.
>
> Fixes: cee38bbf5556 ("ceph: add owner/capability checks for CEPH_IOC_SET_=
LAYOUT*")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>  fs/ceph/ioctl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index de07f19b0caa..12cb50e0a166 100644
> --- a/fs/ceph/ioctl.c
> +++ b/fs/ceph/ioctl.c
> @@ -72,7 +72,7 @@ static long ceph_ioctl_set_layout(struct file *file, vo=
id __user *arg)
>         struct ceph_ioctl_layout nl;
>         int err;
>
> -       if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
> +       if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
>                 return -EACCES;
>
>         if (copy_from_user(&l, arg, sizeof(l)))
> @@ -145,7 +145,7 @@ static long ceph_ioctl_set_layout_policy (struct file=
 *file, void __user *arg)
>         int err;
>         struct ceph_mds_client *mdsc =3D ceph_sb_to_fs_client(inode->i_sb=
)->mdsc;
>
> -       if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
> +       if (!inode_owner_or_capable(file_mnt_idmap(file), inode))

Hi Max,

Was there any specific reason you used nop_mnt_idmap for these checks?

Thanks,

                Ilya
