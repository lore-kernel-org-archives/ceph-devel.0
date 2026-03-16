Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0753331A65
	for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773677572; cv=pass; b=jn6chEHfN4L06JNpOjSH+LIDlrP25wKCLRYPwHWK2+2a/W93G+t8aRTHDgoQxt5xIDx1OdcRJHnDsnANUyfMLdO9KKr1R6uQ1Xrw+CXARFFd4E7MVFxVdl/9JeHm5JHeEhwhkenPSjAnhj1/B9+T2538HBo83HQjihqJxzqjEqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773677572; c=relaxed/simple;
	bh=mngjUXyQIGRdPpzvMVY93piHPQBoPK11l7fLKRKjC7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtNZY2v+9ml9dGnt/J98yKRlEwqCFmC1soAaX35FBGlOzFCXpov85rWI1DQ2sFhm4qKmRbxn0m7xhY1c04OnzeTnFoMBy4rkarxUJW/tzzh8NTcJ1Al9MkVURX5elfjt3Ra/EMJe39Y465ZzgIEihBxSBR5DtOyDtYaMevtW2E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j44JMaNr; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j44JMaNr"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5ffbcfbcec4so1031510137.3
        for <ceph-devel@vger.kernel.org>; Mon, 16 Mar 2026 09:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773677570; cv=none;
        d=google.com; s=arc-20240605;
        b=F2PC0JqaaqaqxN0yH8U4CjAJw3NZU51h2E2rZA1N8Rq3kngsV0j8gwXA3wz8K6uQu9
         16xjhjK31opMKFcTkaKEgbvtgZ+uwgLh3nfqZib4yoB3CVTh2JzlfnEV0rFb/3mFDoTq
         vcr6PvtpGoln9obWn518GkG/N3xFXsvGmlSHgVNnKZRfBpNLc0ca6bBirrFmed76eQEl
         591FLPPiA2npnWTuCy+xflK8AU+2egD1j4383jfO+rQ4AuMBakQPnpY0d+d+/NYKpgbM
         kyP4nhTyGUiDzam4iGp2pydJl8HS5NWPfWJww4PK05DOpZ3OJuL7ds5cW+lSI2A+5qfJ
         j++Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J1pru+Gdj6fAyFCvZjE2fE08MsUs87siGvVmJJo9pqs=;
        fh=enatmGduLc0+HOkjaDJXcxSW1Ll3nFUR8J/L3QxSzL0=;
        b=P9DvuyY7kWCTAIQ72OW3c0Z9nVdreYJnkY9D20aq10mwCtHWk9xokC/DTTZHAGWaeR
         SiVsgmLuC607Y76QVIJI1uSiQbbbqr4U63gYTnywnMM2sES0OvKpi14G/KDj8yZXVMKO
         AEBR1Ac7ZkIW8MWQvE1uHdzY7pqR9Zw0otxFj1Nc/qSW/Pk1Yp3V0y0VkQ5Oo3nTCZT1
         2rCsy3T2JUdPve73Jxgjc29m/ujtCM6JISX8HlwHsvOHcjuLWr+S+GzZcgmskIkXDTj0
         4EPefy/aVcPc8PItOHLlwMLcagPFfA/kVnEk4gDIxL5qqsmtD1JxxS2ZQgd7OKijFV59
         6pKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773677570; x=1774282370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1pru+Gdj6fAyFCvZjE2fE08MsUs87siGvVmJJo9pqs=;
        b=j44JMaNrFBAXhZkUUvHY/tt1leg33h3rAo3Ugh3BKflwB6ZUzBgJTvqJM5+uLK+FZI
         7vHgnOIh005vRT1XNeK/P28EbrLwAY/wN+E+a1YpUsrgtcArcEtuNr0CPqNh5BysxXra
         a1BHvzFzgS8inLM8Q756Pdnf/ddDwQ2KtDCmWdoKhl9nzPbZ/02QEnbg2oOhAd+Y8f2+
         Gwir3ZTttiZa04Dp0+sfXei0I5H6h548/Nk8m3hrRxqGTwtVSaWVo98q9kies8dh9PG0
         VGYddRJgagKEk5WsBQZj7dJEx4hbG6Svn6nf3WPOYIFjG5q1dQWstWlCGXxL7pby2XZO
         8XeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773677570; x=1774282370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J1pru+Gdj6fAyFCvZjE2fE08MsUs87siGvVmJJo9pqs=;
        b=MXzHbhRz64HI03c4hhK44pfEOuJuzINYACzWyiR0ZnvGqkJddXiCD0LHhPCuRo4SXH
         8aYao6vbZZ1OlXARuZ4MyBw7j7HCzRmiFsKFSEcyEkLUunkAoW08E0p2ONueCG7ewjLU
         G/FKZhZvfi5v7cpB/tfewhfeaJ5KTeXvlIPMYwxMCn2gxWwFn3mH9eAk7xvteGEvxcIJ
         Y7zuqHy/yMwZStDT/VoIP1rwynov2mKm8mhOcApGxtFUzGIwNQRvfxzMdPd9cj6BbGb9
         VOc3AWSu00GHQOJQCoKSZKVR0pb+Aa6ZaX2icYm9ZBWK226MjRKEqF3QVVC5nHASMiPV
         r+ow==
X-Forwarded-Encrypted: i=1; AJvYcCV7sYvhvZMuO47QqlaQLmfS6PeIPKpbqyTWTOkodCkLogBOH1X17NsnV1iwbsVM9JroosdIg25jTV1C@vger.kernel.org
X-Gm-Message-State: AOJu0YyLNFLsZhi65NZDlAqSf/Rl2ZRLmOukH5WFR0P14QdGZm6cd7L4
	3E1DI/bhWGGTULWL9q7KVWfzs41a0Q6szcLLswuL6v2796RAvSUJpvqcV3j+uEsT7SWwOThktzR
	kiZBvVO5MSVUQF5i6pJZjYfmKFzsTHpw=
X-Gm-Gg: ATEYQzw1KOR26EQvmkBCXA5EqRZaTl0+SW3EKAMcVvfD8ZLSs5d59PMf89hFjsGYUUG
	yeeNQGkJKJQntC5jo6kci+k0gkMV898nCmw7L8H86XrINicwlvzYsfVqyLf8Ah5xtP/BpYnXvyM
	Of4BRQJbOh++QDOj1hm4WWKDO7DfGFNS+6cLJ5Pz6uqfJhW6KR+wevUqkAdGLlUaYv0GsSoYnJ7
	1DJFCpcDDVe+Dadbr38UINmDq5wzyJq+r4ODD5CGk+k7OegnKd37chtPSvFaGCUSAd68uA1X1Yt
	10gxt4+ER16TbW/XpLpq7EffezUQqc5mtpOMChoDpf7j
X-Received: by 2002:a05:6102:b0f:b0:5ff:fbe4:8a7 with SMTP id
 ada2fe7eead31-6020e52bc2cmr4525326137.24.1773677569597; Mon, 16 Mar 2026
 09:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
In-Reply-To: <20260307140726.70219-1-dorjoychy111@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 16 Mar 2026 22:12:38 +0600
X-Gm-Features: AaiRm53PnIFKVZg8YyfIZR4HMQW1Q6cca8fQLreG4GsNHelMK8lmfHxNIAUkk-o
Message-ID: <CAFfO_h6iNKbcKUi+Em2emRvXdZCfxcm7HnCenpTg9pSsHMb6YA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] OPENAT2_REGULAR flag support for openat2
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, 
	andreas@gaisler.com, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping...
Requesting for review on this patch series please.

Regards,
Dorjoy


On Sat, Mar 7, 2026 at 8:07=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmail=
.com> wrote:
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
> The following filesystems have been tested by building and booting the ke=
rnel
> x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGULAR=
 that
> regular files can be successfully opened and non-regular files (directory=
, fifo etc)
> return -EFTYPE.
> - btrfs
> - NFS (loopback)
> - SMB (loopback)
>
> Changes in v5:
> - EFTYPE is already used in BSDs mentioned in commit message
> - consistently return -EFTYPE in all filesystems
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
>  fs/gfs2/inode.c                               |  6 +++
>  fs/namei.c                                    |  4 ++
>  fs/nfs/dir.c                                  |  4 ++
>  fs/open.c                                     |  4 +-
>  fs/smb/client/dir.c                           | 14 ++++++-
>  include/linux/fcntl.h                         |  2 +
>  include/uapi/asm-generic/errno.h              |  2 +
>  include/uapi/asm-generic/fcntl.h              |  4 ++
>  tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
>  tools/arch/mips/include/uapi/asm/errno.h      |  2 +
>  tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
>  tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
>  tools/include/uapi/asm-generic/errno.h        |  2 +
>  .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
>  23 files changed, 127 insertions(+), 31 deletions(-)
>
> --
> 2.53.0
>
