Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E32D2417C2
	for <ceph-devel@vger.kernel.org>; Sat, 21 Feb 2026 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771688981; cv=pass; b=a7lWKRg4zeL+KgSoMpUd7IzKhKbGCz/GzKuSU3Rw+KAA/axsY7t1738TKtWR4H1Zkq8G9IHz1UVvQHbTv/UKbA+7Hle7KcU7I1nVL7xFVdZfe55xcEtURNnSz/WiY+OzqiZrrrv5VpJSiQ6Gzp+E9h021cQSFSgqZmtK9AL38vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771688981; c=relaxed/simple;
	bh=23P6V3/EZFsgY+c1DhMXwm+sT4gSINYfgO8QSA/c/N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+EX2TGw/Is/Q14l96xhlvgaBsaUw1MoYdq2jo423qz3Xa81JfibPDD5DM3wmHSyaE0COIEZUR4ZpnxKPYJ122EYZhhkrMXqDFP+svHw4XKOYVCo2YHruY+h8+HIpRhsTtrqtVw70FSmF2cYRi3eyZG5ur+PPOq4mKI/ngfKgxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gkb4fODz; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkb4fODz"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-948bfb6b6bcso926671241.2
        for <ceph-devel@vger.kernel.org>; Sat, 21 Feb 2026 07:49:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771688979; cv=none;
        d=google.com; s=arc-20240605;
        b=M17YLaxCh6BGkpx+y0SApUehBeUV2HE2894CYk0FoAJwvqQJXH73Xrlamf3g0fbanx
         Cfmrm4pieM6qFGn5S9Dq56/4HbxzhFnwsz11D57vbq6Kk/03wtFfpyhqLcXXkBr7E/ba
         INoBBzkLyPEDYefIWHBClC1h2GVJWplG3DV5WtZN2Qu253B2nkXfUhRY8CxcCJK08hmm
         HzX76RvPH8WkTi54KRVYJcZy20dMzauVaJwQKOirWPenzq/pcLwT9I38j4ntBUEJXnof
         IdWR6edNy1qag/yLsMk22japm3d1ePdj6i8UhhDlIRtnOmXI35Tw448NOPFJnnzMDpTb
         a5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+CV+mZKQ0tWQcWo2Qtxm/k6mbCGnay44Iva+S/9PlIo=;
        fh=ZoPk0ElUHABvhlRVYXABUoITgqYcnH7TJG9V4U3HJpc=;
        b=hfZtDq5Kj8oCJbG716rlAxLxc+6tpycgeLjAnuMv5E+sAhuCBWdySKCyk3OVy6Favx
         1NTT4xjVT/gYwEQDIzFeMMsH2/3HgTlwd1XM2xUWnvfrDsbfudvyDZ0OeqAedVFWIBpG
         ZijbD/qtk0MOaQktbOHkiDBNl8AGmkhNltD5VDwkWpIz+9qLaJFs7c5KlUEWblDlshk5
         GdZMRj2q9fiCJ7U4Xqs3aTOaG5me3NKLoXSa7HBvRccKudxcwpPT8SSwxwkl/4rGq8d6
         ByZK8YPmmu9Dkhq/gkxwIr6C9qY2kwds3T/KjC/xIHslY9e1N/jjTvgh0aUrdthF2G/m
         YcQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771688979; x=1772293779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CV+mZKQ0tWQcWo2Qtxm/k6mbCGnay44Iva+S/9PlIo=;
        b=Gkb4fODzMaw1FLWV7mj2nCgQ03v5D6/tPz5gHoVwIGz2lLtM06+6FOW6rnoYecBJL1
         Uikc2GaVK1cDHI42+uotLOIYJ/g3huSLJtoxuXUDOk7Fr2lCTZn/Rl3MZ9XPCO4HPhD/
         UtNuy4LArncf6UKt57ejd7jtyhd3w5eBdWMIk4LLIA/cJVAaVdQC/TiWyiW6dNqUSFMX
         NLeThlFQuWxY0TzxS0mNhI44QpBx+ybld6i7VIXlxb3yPUx73HYZhK/4WK9tRdCVwbAe
         NMWcuQj+hR4G7Xdg0TAlaJH2OFWMi3S6BboSVmZ4WKVbvgJDdpgdpTfoWJQYQ0VwpgHE
         HDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771688979; x=1772293779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+CV+mZKQ0tWQcWo2Qtxm/k6mbCGnay44Iva+S/9PlIo=;
        b=Ch8/OfqicqHYeej2pfTjHIBiPCW9Sz/MtiubCd6zma59oANFEBuINZ21h75Khl9+Vg
         fHb7vptXlaXYcUTGf2vqIkFffk6yzV3MgGCX0m8obeatNz9Wde83GdG2iiqy7DhJeYe9
         V/sEdQaP7JZhCwFPthMJEzUNBwXONtozcVMkgaQXgHPu4j1ymanzIaD0pt/wkn185Duv
         cXjJAd5S0RHNrIcq7+kOMfTqPxONGfp1v9NG54KoxlVB/huGH0/29WWBrBBoIa+bcsRH
         mdHvVI3l/0Niz03jfd2S5IO5saJgEL7s79IkGQp1T/o0dvL8V4gYonSgwKrAqbOjyxA/
         QbRw==
X-Forwarded-Encrypted: i=1; AJvYcCUfW1ytUGQS5E8TTpzK0kjE/thzbbfVrO17fQAW6Uh+Mqx5ivFsi3bm66PqbMJ/nihxGfTQSkeT4rU/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7JPGHH6IdGUikn+kus6dmxsXllrQH6nfVMsIuP8ioAmgdKyd9
	Ujrkzi0/xgHWC10bdHOmUAYBsLC9ct5gzTWWragdYDO+SuvyvdgXkKUSEXldwuGZuLXT+4wfrEo
	Rm9YM8i5RkngHEwBfzmRzLOlpJZIX7Dk=
X-Gm-Gg: AZuq6aL8SiUtIcS8qNVWurJL/foSTqlz7tqZAJnYdMbsweWe9WU/4QQlVCMvQhyc4zq
	E3xSkjK/3ObrxTnxqsOnYwCX16yje7edFPOekFcete9fmUtmJgffeqbUsvtFqJFEV/9wuMH17N+
	WIBufR4iAvWlzI6jqUDoco0y+bQ12rmGBKmSBApP6LrJMCAHN67Jm+5+MsAOc1sOQreyVJ8dU88
	dgYFni19I02qKrzxT53IKwT1PbK/yPhRdJq9QK/kfjNC0GYu+IztLNrSGg4GKaX2MVchuRCKpfd
	tq6RJTZzLsN2z2ZSWPQvf8dXgTM80hdWUmHOPgrtcEw=
X-Received: by 2002:a05:6102:6cd:b0:5db:f031:84ce with SMTP id
 ada2fe7eead31-5feb30aa44cmr1230671137.29.1771688978916; Sat, 21 Feb 2026
 07:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sat, 21 Feb 2026 21:49:27 +0600
X-Gm-Features: AaiRm52uxICzwXE4h2cG-NB71vMvoLaBUhNK0X1besn-bhoE2jLckvjHX39jcu4
Message-ID: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	v9fs@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
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

On Sat, Feb 21, 2026 at 8:59=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> Hi,
>
> I came upon this "Ability to only open regular files" uapi feature sugges=
tion
> from https://uapi-group.org/kernel-features/#ability-to-only-open-regular=
-files
> and thought it would be something I could do as a first patch and get to
> know the kernel code a bit better.
>
> I only tested this new flag on my local system (fedora btrfs).
>
> Note that I had submitted a v4 previously (that had -EINVAL for the atomi=
c_open
> code paths) but did not do a get_maintainers.pl. It didn't get any review=
 and
> please ignore that one anyway. In this version, I have tried to properly =
update
> the filesystems that provide atomic_open (fs/ceph, fs/nfs, fs/smb, fs/gfs=
2,
> fs/fuse, fs/vboxsf, fs/9p) for the new OPENAT2_REGULAR flag. Some of them
> (fs/fuse, fs/vboxsf, fs/9p) didn't need any changing. As far as I see, mo=
st of
> the filesystems do finish_no_open for ~O_CREAT and have file->f_mode |=3D=
 FMODE_CREATED
> for the O_CREAT code path which I assume means they always create new fil=
e which
> is a regular file. OPENAT2_REGULAR | O_DIRECTORY returns -EINVAL (instead=
 of working
> if path is either a directory or regular file) as it was easier to reason=
 about when
> making changes in all the filesystems.
>
> Changes in v4:
> - changed O_REGULAR to OPENAT2_REGULAR
> - OPENAT2_REGULAR does not affect O_PATH
> - atomic_open codepaths updated to work properly for OPENAT2_REGULAR
> - commit message includes the uapi-group URL
> - v3 is at: https://lore.kernel.org/linux-fsdevel/20260127180109.66691-1-=
dorjoychy111@gmail.com/T/
>
> Changes in v3:
> - included motivation about O_REGULAR flag in commit message e.g., progra=
ms not wanting to be tricked into opening device nodes
> - fixed commit message wrongly referencing ENOTREGULAR instead of ENOTREG
> - fixed the O_REGULAR flag in arch/parisc/include/uapi/asm/fcntl.h from 0=
60000000 to 0100000000
> - added 2 commits converting arch/{mips,sparc}/include/uapi/asm/fcntl.h O=
_* macros from hex to octal
> - v2 is at: https://lore.kernel.org/linux-fsdevel/20260126154156.55723-1-=
dorjoychy111@gmail.com/T/
>
> Changes in v2:
> - rename ENOTREGULAR to ENOTREG
> - define ENOTREG in uapi/asm-generic/errno.h (instead of errno-base.h) an=
d in arch/*/include/uapi/asm/errno.h files
> - override O_REGULAR in arch/{alpha,sparc,parisc}/include/uapi/asm/fcntl.=
h due to clash with include/uapi/asm-generic/fcntl.h
> - I have kept the kselftest but now that O_REGULAR and ENOTREG can have d=
ifferent value on different architectures I am not sure if it's right
> - v1 is at: https://lore.kernel.org/linux-fsdevel/20260125141518.59493-1-=
dorjoychy111@gmail.com/T/
>
> Thanks.
>
> Regards,
> Dorjoy
>
> Dorjoy Chowdhury (4):
>   openat2: new OPENAT2_REGULAR flag support
>   kselftest/openat2: test for OPENAT2_REGULAR flag
>   sparc/fcntl.h: convert O_* flag macros from hex to octal
>   mips/fcntl.h: convert O_* flag macros from hex to octal
>
>  arch/alpha/include/uapi/asm/errno.h           |  2 +
>  arch/alpha/include/uapi/asm/fcntl.h           |  1 +
>  arch/mips/include/uapi/asm/errno.h            |  2 +
>  arch/mips/include/uapi/asm/fcntl.h            | 22 +++++------
>  arch/parisc/include/uapi/asm/errno.h          |  2 +
>  arch/parisc/include/uapi/asm/fcntl.h          |  1 +
>  arch/sparc/include/uapi/asm/errno.h           |  2 +
>  arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++++---------
>  fs/ceph/file.c                                |  4 ++
>  fs/gfs2/inode.c                               |  2 +
>  fs/namei.c                                    |  4 ++
>  fs/nfs/dir.c                                  |  4 +-
>  fs/open.c                                     |  4 +-
>  fs/smb/client/dir.c                           | 11 +++++-
>  include/linux/fcntl.h                         |  2 +
>  include/uapi/asm-generic/errno.h              |  2 +
>  include/uapi/asm-generic/fcntl.h              |  4 ++
>  tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
>  tools/arch/mips/include/uapi/asm/errno.h      |  2 +
>  tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
>  tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
>  tools/include/uapi/asm-generic/errno.h        |  2 +
>  .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
>  23 files changed, 119 insertions(+), 32 deletions(-)
>
> --
> 2.53.0
>

I am not sure if my patch series made it properly to the mailing
lists. https://lore.kernel.org/linux-fsdevel/  is showing a broken
series, only the 2/4, 3/4, 4/4 and I don't see cover-letter or 1/4.
The patch series does have a big cc list (what I got from
get_maintainers.pl excluding commit-signers) and I used git send-email
to send to everyone. It's also showing properly in my gmail inbox. Is
it just the website that's not showing it properly? Should I prune the
cc list and resend? is there any limitations to sending patches to
mailing lists with many cc-s via gmail?
