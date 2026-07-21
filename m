Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E163E3A0B3F
	for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2026 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616040; cv=pass; b=FST5QA7OEVuLPIVP2lOmPUNsvzX7J7yVI0tUZE1+dlGj4dJTUTJ7/LGVhqKMha/VWvM8fEEyBgVs7Krnc+QCVZku7YYK+Zd59T+QeJHdtkampLGCfKeE6892wr2aRVdTzk+qKmiznpvO1Umez/njnFcoNXbUno/M0bGDLpt9YxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616040; c=relaxed/simple;
	bh=Pbafnf/X6DbHkWi5jDEhPznwkeKW+23iGKw/iY+a/Ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdH9Lq9XpQ9irgEU1W+hOr9lQBoIxXKq5cq8z2JbFX6iqR4hdAI5CcDbstbWOP7Re9DEzl5PHcMAxfpLkueJ9yAZWqAGbt+GHy6EX0Ora+BziIlsPBBqpd0MIShqIgpGVwCRXMZjdZsBxhcfUxVoy+RS8rRntUdB00rsmFDpP2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=n+BBCUfo; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="n+BBCUfo"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1691e4ec40so731530266b.3
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2026 23:40:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784616036; cv=none;
        d=google.com; s=arc-20260327;
        b=StTJ5J2R9TB+6sj30U+seeCpQPFz7ZKd8ld8IfZGEqLN6/rtVuo1GExaJG4d2/lm0Z
         5reyEW4OW/gP9s5Qwk1sfhGBEFodHGqBRqPFr9WiOJtQQcKeWCCiYyNJRXSS34rGgyP7
         /pg7NfjkL3w6b5vu9v8PEKaaScNFTOQSRMxivou57+SGYagPKaYRo9wIFwlpvolW3BxJ
         +ZK8U1BFM72PGNVA00rxe5Mnu3KA39WpRGXDQpyXvGMFPx6JRT6UIazJ5ooZWUvFX117
         wAe+VMPdyAhaqSDSxYDPMznUe9O63waAzWtCAJrrSpbnfF8OZS7gnr/XZNqh60OEQtKW
         e1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I4Vy7UzJe1rm6qhu4XolxjYWSref9jsXggUvf2dCt1M=;
        fh=D28pvOtlJVS8vLxEPBeWuLStO2R0MsfYzxnaCgPIbYA=;
        b=YRc2z3uAeIZJSPmEszSB3ydUjI636Pfflc49ZOJbGD3otqbFcxMDXcjdjfW2ItYQWQ
         a+rvOJowjheeyXFPMv1ERQtuueiXGL+DQy8qUP2/ql+Mcb8gCxMTQEMwZVQg9X/Zhsfj
         IRzsQxap7eV3/MhaFr9s6Znb5apXCulzMURnXA+Sq87nINqr+5yrSH5xocZNk1Lu9xDF
         vXeIGstRwAa2pyA7S7EzEx9DBFPz8+svv2DVGdcGOinFAgEMJThrZLK8EUuRU2fumPGG
         2bCmN+LGA+8XAGljjWbeB2neqR1G9XhEQTIngZymEFbPX1OJxYGLVd82iT7ZNcwmBJ5b
         RW/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784616036; x=1785220836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I4Vy7UzJe1rm6qhu4XolxjYWSref9jsXggUvf2dCt1M=;
        b=n+BBCUfoNkJ5WUr8hpYf8uAP8mIAPB78qbf52W5Xx1ufkAwFaAtHKj1mAaD016fs/G
         EeesebktGEP05nIT93ltumm7659E/0xBnSheW9XhKTSM7BAsYhC+r4SJdQbc4f7BWaj3
         s+qZ1FDQGZ66ZhGB84+WlCM8kkXVbVg7gqRcpKeKR0jOmC6j6JyRCc4PllpZAFCy4lWe
         c2IlFLjPmCDrCuI/G53UUaO3nMpdQkWhSaf0sC1y2aJhykaohdcPyMHl58mkDs9MwXlq
         T4X9wsBjbFmnIt76nygfhZEsz+4qqW/aczAgNOMoTMjrna1ldH5nr+ae85s5zQgr5QjE
         csZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616036; x=1785220836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I4Vy7UzJe1rm6qhu4XolxjYWSref9jsXggUvf2dCt1M=;
        b=bS5/wW4Mr8phyZ5s0K7iNRJb73sIL0QiClTRHmePadLy5LrxbgFAOquACATouUnp++
         6eK1Bfa20K9Ajp1bq8pmUNM0I7eIFPdTjLQIji6fV6rXiZ2ZPlYTBjTyedT6+u//cstX
         x2YZ2MHI8fmwgQGQefliY0iLFW4Y+FuNF7zK2I5Y8KW7MD1G0VoGAOzI8aBvH/wc8s9S
         XFcLr5/72uDzXnAYwTaK+Qk778kAPq8JR6uhNANiY1VQSU1OZD/6r4dBqWa4v0dA6okG
         RyLd1ikyTcgTW4yt4/EgpDJ3kl87T5MeI13SG9qxxRJizBZJ2oCmzac7w2aJgc2P0HaL
         dzjw==
X-Forwarded-Encrypted: i=1; AHgh+RrhdsHaNDkzNtA3hv/+tvfaSGJIdyJ1KoQeL0R2Ar3lBN90kMhHmG6JyXtsLt0CMY3J+mEYJCtUXRwI@vger.kernel.org
X-Gm-Message-State: AOJu0YwF+nNtrvg4ELTndcRdB/NinPAGz0ClkZH2wpWrf8jy7Gxvv+SC
	H77V6Gay9C1qqrbyScODJXfc2jtxLXK2P/+2M2xqmfjvHBMQMk+V7AP2mmPMVuEHMgdoNjOTV5o
	N6NMVHLXCx4hMKXpvSTqgVQq97DJYzywNuC7C+xUwKA==
X-Gm-Gg: AfdE7clYDmD9FV3YQL8mZV+vDZYPNzsIzMMS7gh1LgK3K9b+KRgI3p5WRwx2mjOo28x
	GqXG+CgbieNKG0PrSfKWsMd/KIitoLLGlaLsai7TDkfuQJHDyBAjoiWwlWLfRgl+nei6i/kSFY1
	sIZ+DKxySUyxpLQ5vqJwas7JW1athRNhhbXgL8qlRBRyKkLRkL9D/5zCnprVw/jX6CtOMa1PzH3
	Xo/zKI3bgvRResbwSkeWNuEiUcNSbehEoC1PZHnbuBKVa/+I8TlKLh/PLgiXNWG
X-Received: by 2002:a17:907:3d0c:b0:c16:16b9:9907 with SMTP id
 a640c23a62f3a-c16b46d1d7emr698996066b.15.1784616035993; Mon, 20 Jul 2026
 23:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260721062047.3162957-1-max.kellermann@ionos.com>
In-Reply-To: <20260721062047.3162957-1-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 21 Jul 2026 14:40:24 +0800
X-Gm-Features: AUfX_mzT5JzCi2EuSXz-cDLd73m9QkFrJnB-xqWTeJmDL0O8Zo-HR_JgYgbuzzw
Message-ID: <CAOJNxRJeZWgQ2p6P9wa+KAGwBojGbwbT1hfXDw+U87RsUMin1g@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph/ioctl: add owner/capability checks for CEPH_IOC_SET_LAYOUT*
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Max,

On Tue, 21 Jul 2026 at 14:20, Max Kellermann <max.kellermann@ionos.com> wro=
te:
>
> These permission checks were already missing in the initial
> impementation of these ioctls.  This Ceph allows any user who owns a
> file descriptor to manipulate the layout of any file, even if they
> don't have write permissions.
>
> It might be a good idea to guard other ioctls with permission checks
> as well or even disallow regular users (even if they own the file) to
> manipulate layout settings completely, as this may be abused to DoS
> the Ceph servers, but right now, I find it most urgent to have setter
> checks at all.
>

Thanks for bringing this up again. LGTM :-)

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>


> Fixes: 8f4e91dee2a2 ("ceph: ioctls")
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> Note: this is a resend.  I had already sent this to security@ceph.io
> and security@kernel.org on 2024-11-25, but the Ceph maintainers
> thought it was "not a big problem".  It was never merged.

It should have just been missed.

The MDSAuthCaps::is_capable() in the MDS does validate the client's
cephx caps. However, with the default cephx cap configuration
("allow rw" / "allow rwp"), grant.match.uid defaults to MDS_AUTH_UID_ANY,
and is_capable() returns true immediately =E2=80=94 all Unix user-level
permission checks (caller_uid vs inode_uid, mode bits) are skipped
entirely.  The MDS only enforces client-level caps; it delegates
user-level enforcement to the kernel client.

On a multi-user host with cephx 'rwp' credentials, any local user with
a file descriptor can manipulate another user's file layout, redirect data
to arbitrary RADOS pools, set directory quotas, or pin directories to
specific MDS ranks.  The kernel is the only place where per-user isolation
can happen for these operations =E2=80=94 defense in depth cannot be outsou=
rced
to the MDS here.

Thanks
Xiubo

> ---
>  fs/ceph/ioctl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
> index 15cde055f3da..de07f19b0caa 100644
> --- a/fs/ceph/ioctl.c
> +++ b/fs/ceph/ioctl.c
> @@ -72,6 +72,9 @@ static long ceph_ioctl_set_layout(struct file *file, vo=
id __user *arg)
>         struct ceph_ioctl_layout nl;
>         int err;
>
> +       if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
> +               return -EACCES;
> +
>         if (copy_from_user(&l, arg, sizeof(l)))
>                 return -EFAULT;
>
> @@ -142,6 +145,9 @@ static long ceph_ioctl_set_layout_policy (struct file=
 *file, void __user *arg)
>         int err;
>         struct ceph_mds_client *mdsc =3D ceph_sb_to_fs_client(inode->i_sb=
)->mdsc;
>
> +       if (!inode_owner_or_capable(&nop_mnt_idmap, inode))
> +               return -EACCES;
> +
>         /* copy and validate */
>         if (copy_from_user(&l, arg, sizeof(l)))
>                 return -EFAULT;
> --
> 2.47.3
>
