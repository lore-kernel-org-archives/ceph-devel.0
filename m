Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747B3CF032
	for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2026 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681764; cv=pass; b=aLGKPZtR3xIgSDSOstnBoV9YxH/X5rfErbaV5KJdZKqX4R0hqOWFvoZ9d4Gjreg7iCeRjXpumIBSwvTl6baai8b1Jk3TB6VThgq9dIe0G3Q2xB7HzpzR29PUl/vqb3g+ZD7KxA6WGJZ73h9ulNhsLiHgluL3it24eufTUqPgfiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681764; c=relaxed/simple;
	bh=38YIF2h9LQRciTDudLh6dbVHlCWQ+CVfx4lmwVgz+TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4emgaLSmLv2vraSTJnFMb8WQ4+EtDT3jLWM/O3IUNzYo5fyaSfX1S9/pXm+6NDrMB0fiEcvfvUgMNBYCSOnkb67O+U0/yiohD1PyIOpWd2VcKNOJNMBXrpHq2wBO8qDhd0wRnbxZsVzpAvo1OOY3CVif6XxYBJyfUKEHPQl4ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcYmuPi0; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcYmuPi0"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5fff774800cso2874659137.0
        for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2026 10:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773681761; cv=none;
        d=google.com; s=arc-20240605;
        b=EKfCRGD9CYHUrYKNUMgIa2Sj3WdSWaM+pHjwDL6qP8cnOL5w+Yvl/EAexiHmpUZd+B
         zB0SaWkB3FrNEEw8hyxFKyNEWWWmEw4t+hxZd7Dw0MuQOW1459GXut1MkTwavpgco1GR
         Glfe5eFW9CzxAlGxB24S6MImPtcUeT5f46A9oXTH1CtF7QJ6K++riw0utQyMreeOxGnB
         z8ppsb+APPdXFi9Xfhs2HPIizhth8GZsNdGViBOSWuPP6i3BCnTy6s4j+s1D2MpmKn4a
         pGx4R3BKgf9ZE5qwDQsza3HcFbk/NOKTEd/pI9tATKRpK7Y7SOpn0Aa/001BQ7zlb5mD
         gFSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y3DZPi773JGtMdvcTYXrz3SkUkUANIodCa33A4wwy7k=;
        fh=4vOOtOxq2sfEqi+dXZKfYFknEm22+P5cQh2G8ZYDfvs=;
        b=iMOepbT771gyF0yIXweahdWfElxLKnc9AjzmluKPLTl6bhzjlzlFs1rkbpuzLsZKai
         IIcPqSti1BFvN8uWom2KZwbtJQjXeYSSmKPbzAbT59Om2VngcDxHkEWnohyTZbqk6RqO
         /LyCnDjwj8ueum62Ew2t9tU2AnCzaUb9Ln9M7afEp4jHe8mb8AZW0K/BBsBAS3Zh9PpB
         ciJZV3mAUu3d8SuKGhcDYZA7K1Nz3WrnBtRpT3m+fXKAEDgNiPrYeVxMYedsRVINuRvP
         Lw//+kjzCIIXnyRJ07/ggGC75+Uc9C2oRr+mzdE9swfKRjjxeDFNR0ULzT8XMLjkyt7A
         jtAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681761; x=1774286561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3DZPi773JGtMdvcTYXrz3SkUkUANIodCa33A4wwy7k=;
        b=HcYmuPi0X/TZNmyRIOXExfvEHRzD0UyzV54M82kVNgBzzjKlBf7yjuyMETcJ7LusHX
         pr4wvj5PTOWmQLvZr0/nXx+Tqv/O77n+pWvH7woRd/u8jnCj3F1WihYuOO50zXEfUlpo
         P7srtkllUt2jcefTNJ+39OAhm63tB8Y/e4qItfYY80voDNkTai5h05geghQmFWiqCtW0
         lVyCyVhRPKH0p+C+PHpz9DqJJzT9jJr1wPNN1sOcV1X3tMTRY7A+UE4Hvqm+O1+2s7m+
         dinmKniZOJu9i7oMW+aLBtXr11vx6l/tDr23e4AjmBuEk2vF8T8I0ICnInpqLgKzBWYR
         m2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681761; x=1774286561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y3DZPi773JGtMdvcTYXrz3SkUkUANIodCa33A4wwy7k=;
        b=qKWsQhWnfg09TETn8M/zcB1n134ytrVpOzB5ubmuwhnNIelvTKVdZQ6N5fyC0t/lFi
         f0+9zow8/k7MpTZhoiVS2Gm1NhpEgpJYCz/jGUbw0fS/UH5xjEAJ3RzdM8BkFnr/ZUjH
         yfH+kXA4jc3B1SeMJ9YdXulWjDfBfl21oDjnJj7XEagesT6Ne2zq/0qnQk+KQ8t696y/
         yTsbQCYW3y7c9jy8qgX6nAaX4vpkrYsABQQNpLEQds0QzUw6BkINYTf45BTJxmCczNZD
         W00444uMqFktz79OUmSOM+2TNjOfXPIVoBe7cSLeZIhQ28laVkDbDlsGWplWrO0MYHcd
         wOaA==
X-Forwarded-Encrypted: i=1; AJvYcCU/Hu24q103yY75Hsxh1mDevz/WyQEKMHn5tpU3LLjPtP01RPnanTodliKews4mzOc/6QQfL+rU96XJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6dent35S/NIGTgh9jIiJxUCW9QvdQl5x0hPEI74QlivIJ4ms4
	mewW0oSbyo0I/wx8mHlE6IzcJtu0joiI6KuKtlL4XFVTRRxBxXfnHCwQpm9/8FY7BNLlapnVYNx
	XMMWfmCbvmMJ+KcDffYIgauvXEZLzz6g=
X-Gm-Gg: ATEYQzzRyT8D0CblmXqqJfbxKxgy+XYXslpSBBlWJSGq1G9EZBDjU7gGuHauahqPd4Y
	7A7yt0kmtILH3LaLikRlW1yK6nDM0lqzXfZEGnrAlNO17FXzGv56RmlBeeYMj8aPcESlx790isT
	fdhn8FnfPoYjtSgngnHZyJL/dcgSST89+OTyjscKjQTbz/pHVWZIk9bp3IysUEGGMbGblMwsn7p
	t8VSSn9xKD9W7A883akSF7lTytouHqqx3fobQxHCxaw1CuqoaHGC5IXPG3QuWQiS/f2yvCiLgfH
	OL+TiymIl9Nu/HZ6DNGNtdm0KW1DCTpOL1lPvbYHjD5OIP4iF3aSCQM=
X-Received: by 2002:a05:6102:32c4:b0:5e1:866c:4f8a with SMTP id
 ada2fe7eead31-6020e52dbbamr5788771137.20.1773681761421; Mon, 16 Mar 2026
 10:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <5fcc2a6e6d92dae0601c6b3b8faa8b2f83981afb.camel@kernel.org>
In-Reply-To: <5fcc2a6e6d92dae0601c6b3b8faa8b2f83981afb.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 16 Mar 2026 23:22:29 +0600
X-Gm-Features: AaiRm519sCKeQSwcsAIj83-gCCcOtyLCMrhp4On2ZfkD8pFyjWgcliN3tJw964Y
Message-ID: <CAFfO_h5pyrTTwJ3swHNLT=ZyeTJG=eHw626bTqQqAh+GeN3PhA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 10:53=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Sat, 2026-03-07 at 20:06 +0600, Dorjoy Chowdhury wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > like FreeBSD, macOS.
> >
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -EFTYPE is returned.
> >
> > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> > as it doesn't make sense to open a path that is both a directory and a
> > regular file.
> >
> > [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >  arch/alpha/include/uapi/asm/errno.h        |  2 ++
> >  arch/alpha/include/uapi/asm/fcntl.h        |  1 +
> >  arch/mips/include/uapi/asm/errno.h         |  2 ++
> >  arch/parisc/include/uapi/asm/errno.h       |  2 ++
> >  arch/parisc/include/uapi/asm/fcntl.h       |  1 +
> >  arch/sparc/include/uapi/asm/errno.h        |  2 ++
> >  arch/sparc/include/uapi/asm/fcntl.h        |  1 +
> >  fs/ceph/file.c                             |  4 ++++
> >  fs/gfs2/inode.c                            |  6 ++++++
> >  fs/namei.c                                 |  4 ++++
> >  fs/nfs/dir.c                               |  4 ++++
> >  fs/open.c                                  |  4 +++-
> >  fs/smb/client/dir.c                        | 14 +++++++++++++-
> >  include/linux/fcntl.h                      |  2 ++
> >  include/uapi/asm-generic/errno.h           |  2 ++
> >  include/uapi/asm-generic/fcntl.h           |  4 ++++
> >  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
> >  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
> >  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
> >  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
> >  tools/include/uapi/asm-generic/errno.h     |  2 ++
> >  21 files changed, 63 insertions(+), 2 deletions(-)
> >
> >
>
> I pointed Claude at this patch and got this back. Both issues that it
> found will need to be fixed:
>
>   Analysis Summary
>
>   Commit: 7e7fa2653ca57 - openat2: new OPENAT2_REGULAR flag support
>
>   This patch adds a new OPENAT2_REGULAR flag for openat2() that restricts=
 opens to regular files only, returning a new
>   EFTYPE errno for non-regular files. It adds filesystem-specific checks =
in ceph, gfs2, nfs, and cifs atomic_open paths,
>   plus a VFS-level fallback in do_open().
>
>   Issues found:
>
>   1. OPENAT2_REGULAR leaks into f_flags - do_dentry_open() strips open-ti=
me-only flags (O_CREAT|O_EXCL|O_NOCTTY|O_TRUNC)
>   but does not strip OPENAT2_REGULAR. When a regular file is successfully=
 opened via openat2() with this flag, the bit
>   persists in file->f_flags and will be returned by fcntl(fd, F_GETFL).
>   2. BUILD_BUG_ON not updated - The compile-time guard checks upper_32_bi=
ts(VALID_OPEN_FLAGS) but the code now accepts
>   VALID_OPENAT2_FLAGS. The guard should cover the expanded flag set.
>

Good catches! I guess for issue 1 I need to modify the line in
do_dentry_open implementation to
f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | OPENAT2_REGULAR);
right?
And for issue 2, I should change the VALID_OPEN_FLAGS to
VALID_OPENAT2_FLAGS in both build_open_flags in fs/open.c and in
fcntl_init in fs/fcntl.c, correct?

Regards,
Dorjoy
