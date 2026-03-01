Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B0430BAA
	for <ceph-devel@vger.kernel.org>; Sun,  1 Mar 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360187; cv=pass; b=She8NBV9qbKSbgs5Y5GhClc5f8soKb3p/nIDapAih1etEaiELzt9opIrgOSrqDM5ORN7fuhzV+RRhKs+ekzIuaQL8Bcubr39PzG+zoFzo4sIAv18dz5kkRiTOg4VdM89sdgdnGzmh4mM4J9JY28H1iiQ7cQYeU25RFPVrMaz26Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360187; c=relaxed/simple;
	bh=s7rfjnPtFd6SU6xoPH3SYe9hNrVk5+6PWUoUYgGCnIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9oO4Atv+wBXA6epZZ88Rbiw5Mk/RPls8S/9mACEMSIdmH9VyvK47edaTKACessYD8pcf4FS9CinflNBpkpB3lufPR17tkVlLCPk39GXQoIYJ9onfaVmRdc44ggDb4UNWTykn6+yR9HiJIBlX/GMOVw4BeKCnns7Cn35OT8L/ZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N04lOntM; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N04lOntM"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so1043462241.0
        for <ceph-devel@vger.kernel.org>; Sun, 01 Mar 2026 02:16:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772360184; cv=none;
        d=google.com; s=arc-20240605;
        b=QGlZLOa7+ur1HPocdFGldvA1IZLpghpmY0Q0/wOg/q6UMphZ9jDMTrSchsk6S6AYXU
         64LCGRQnSd0BrWvDSK+SsJe/aSiAzT2n6g1Shb16n1hLUcuVTsv/F9rP/4gynnmYf2oT
         b0Lwz5zVTPwPhUvfe8dgxZ6vG3FxQCcbcaoSRFVnz6u37Kq/FTazDRTrvbly3ANsEcG8
         PKatAEACJQSHR6O2nLVo7pBWUu5gEbCjIudgOXzERPifAFemo92PbBccob0Co1dUOMmu
         seY6dCOPxsfUgw4twqcIGQOWCH9EZSQ/SkAC9jW7xK95wLsiH+LsKed+La9fz2TxN2IU
         K2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZrlN72XdG30IkaSiOSU/cpdfc/g67VmbA5qDRZerWc4=;
        fh=0JyJ6B+jwUiH0l7tzkF7eyJ1O+uVP0P/GBSq4taRwh0=;
        b=DkaJ8vK/YXMtmAXdN6d6yxuMeby6dFplrMPRfx9hPmF9V7WSXWw+bu5+MiQD8MDaGZ
         LHG1YUtNd5qIOtZJdO4ztjZZpfN2c1iD4mW6P0zO9rbBgYHq8Z9J21p8RuTpn3C0Hjvb
         BSjueDGFwM3w2kDFldHyNoWySnC0DUKmtuy4VSFdt3r87IB6LsFqAyMcMCJZgvx/X+BL
         D6TI6gPHutmJXwY6Jo/W5aas1tBownVhXoIFbh+X8Kd0UjUsBVTgivtMtdKC1l/4Ynwr
         1gTfIT9FekThtfJ2nEe0paqUVwfiKekpggiINn3pxvRWlyyUA4TqUURL8NCzxAGLgEEc
         p4nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772360184; x=1772964984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrlN72XdG30IkaSiOSU/cpdfc/g67VmbA5qDRZerWc4=;
        b=N04lOntMi64Tm+WqmzZhhWbQVrZnkQBqb/MlNznFDsXrPLPhUMz2dw+9bZmRLd62x6
         gIZip+2v7bDGN3YmJtyk4HJAS4UVN1WG1U0Aqu+faG+/IK+3n9PscrvR3J8Hc2r3L5vD
         A5uXJoMIZWCHG9gWgha3KPr9hJU5Pwao6gkNx9B+qbzu5kCnHRCJ5NXOFZVE81rWZMuy
         oNEWxKfvREP7ll/7g5gPcPb1e+5IBkH+hqPqacUdRkaFalxafjYraKIm9CEePams18fe
         kE2Ybd6TdGJv+3qXBbPDTeW23hLy3ZGb08T1SoziBB2S3B18vq2kSbBKkP1SUMhuR+Hw
         L1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772360184; x=1772964984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrlN72XdG30IkaSiOSU/cpdfc/g67VmbA5qDRZerWc4=;
        b=MwoozmSW8dAUqz7pH0X8SWXpNlED5zdWt50Ybj8h0vmm4tj0XWO2mHqY6m3D/+1GSv
         5LhF+0bPhFvbogHKq/ppDMnB9bR1Zxx45bLuJSz/4AtYUIOMMA+8Y5jAsnl2ADLwGx/9
         73ouLeBIUeNa9dkkFiWw8Wv5fzxFeOPk53MPHLEZj/A5hfvKCcdrsTPDIE2QAWJVPQON
         No3zIKmYJmWAfGq7GA3uaVzRE22ZBZ7tWobxQoQGa/yy5wgJLxHwdPRsm8ghrMbSBapp
         FOeb3B8dhN/g2wV1YVRKIAjCMzNbI/FA83m96aVXuBroz140m/OTrG4hi+nDeHgqEQsF
         /jqA==
X-Forwarded-Encrypted: i=1; AJvYcCUQmhin3u2dT06gPUgt1M5a0O/fU3ooQrCYQb5K4eROsLqeKiGLVo3sIHg1p3BmVZz4iyWBVqDStWrj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuk5vsfsivGctxfhuzO2Yatg5m6LsMNUFVxP/+P1sdvzh/NiC8
	yqsGqXHC6VHnJUom9Rsya1pd7VRqTBKFk0NzlSmm+yCaZfFoiDYnwIgaESbPGOtV5r7dD8acImL
	NGejkxeiy6bCrp4jr7PmHLz3/0NVEdZU=
X-Gm-Gg: ATEYQzxA26CBKdU5ppk8ybJuIKXXREAws1sEBHDkABBt7hZiPbAE0gxjLke/chTekm7
	jCCLyQBhsCsotAhkmeyMw1p79E5vP/NC0XjR9FS0XTSGqJ0pqh7GrLYZjLIDZ38d1RZWWXVIYyJ
	oMj0/OeCycY1GyDZ9AUzvPCwi7qk6hd0puDiBLf40eP7AUzNsk0rLAYu4BDmYVrwmSYx0Levwhc
	Q+nK+421pdAwKLlk0oXPnnwBJpH/kuvcoHZ43JYs7/ECnj7zCV1BFr5/h+yZ+XXCXdBxEvZZQhE
	Wk9I38EBv72811pCmoQQsjTTHiAJGDCpEE8wZN6Cdw==
X-Received: by 2002:a05:6102:5091:b0:5f7:24dc:3ac3 with SMTP id
 ada2fe7eead31-5ff322bf4bdmr2863289137.7.1772360184080; Sun, 01 Mar 2026
 02:16:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
In-Reply-To: <20260221145915.81749-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 16:16:13 +0600
X-Gm-Features: AaiRm52S_i7uxGvz2GvDZgmu6T0jp37pcUwvZrAaDhnW-l9lgBlZerFtvlbrSME
Message-ID: <CAFfO_h6Y1QcW7mNGdCuY-_J6zrF_F8aW+Q8O9SvoBbXTxteFjQ@mail.gmail.com>
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

Ping...
Requesting for review on this patch series please.

Regards,
Dorjoy

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
