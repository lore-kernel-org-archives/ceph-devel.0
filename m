Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2D83AB289
	for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2026 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776695496; cv=pass; b=d5UfI0AZQBNs/wIVorVMeLYqhNn52pQjoqqfVe5aSJkLyrq8IChMotl4U2OHGAchJeahUds4cIAYEgzKuo59UFKRzDS2eoIdY758qHXIF2fDtkWmj7QZRjL2wxykM9vmI4ROIv7HAJdgVkI9ZuwgRqJAaQIxGnH4Badg10NUglA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776695496; c=relaxed/simple;
	bh=kqPRzU1r8Upp5TYgefpiWZ9RVnkrVKI+N7GY819VmUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFXcJhOm/+2N0UBabcvd7/sAfTBRd/k5qwdc0OqN4Alot6YxDuUFpAxPkXFIkSc0SBGXUz4/iUtIpxEdbJCeOQGua9FILbK/34kR7DFaFVDJZFQ3qCDQwV2j0pS8LyI55GsjqW7YnZtlTXWxsgwosxojGH3o+DDDl2IrKLyPJR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhQanICp; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhQanICp"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5675d609621so2390905e0c.2
        for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2026 07:31:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776695494; cv=none;
        d=google.com; s=arc-20240605;
        b=Aoacm9IcISHyF3iPY/qMESNBRCsygQF1qO16uLWdYyOk4hRP0hjBICQUOrbibzTUpJ
         P6Xus3d3k5XMEEGeuITHd9cji29mM9kr1sVJ1az2dakrbwT4rH6WjRevxDid7S1DfNpm
         lBvZYXhQdIO8HXHF/gNI+w/T5pauFqGe0zFea1E/NVUdSx10W7RBztc/RHB+CQGw/L6u
         cGyNI8HGVqSn5eaX56nHKWRwVzZqSYPXjoPExqyTv4/0IQ3UywI94x89tqgbYljYdRW+
         djkAKiQXtb2gvUFOF++HHeJlWFLlDn08x2q/O0ooGo/RCWp0ZbKtHxmOSZJIH27na6n4
         qVpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        fh=a0t7O4/8KEKvuFqF/6jRKvyjqpkOvlOircN9+wIt2ks=;
        b=FlOGCwXci+3uNYR2zamWolVmxzirfomeUoa0jQAwrrPFeWNZg2qU3jqxrEfk+6RII2
         lDfTpNot1tNnZ2m4JO7fWxRsKKq3qhyeJfF3w9ToJWeBoI+FSQqgOtg5+pNrzHoppTKZ
         BKZlHzx3Mo/Jhjmoqk5HEk2amXoA5Mm4Kn0jzjVCjJwd3ESpu/VXGgyFbnWVSWXcsVlP
         SWymy1hEND3FZ08URBprVsFciSydjcHUh6K7wEyLq4CVUKyQwAxzshdWUmHOFkBsXcfZ
         RW5VERB+Al3RiI0D0R87f9felyg5COqeTh4eoxn4qmR+5LClGVzuDUYSxb5uiHFrodCC
         2Lww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776695494; x=1777300294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        b=EhQanICpPv6wEMAT2QVDm8MgxITvcGEAYHe1m42iLSyMQj1Y0WareKAEFrCkR4fDyS
         SPGbqqTXwePHWW8p/f+2UlF/X2ihrUtbg8fbhtFxe6Qkqi2/QsyMkbJOzqro8eqXQAMl
         WcTOuWJXsUbOkZXsn0mFPAAJhM+mIGkIVvCxhoXQub2kbpvG2XE+6iWz+07ORoIJhtIs
         ClD0K9/EMLGHnjeD7QhTdYd1UAPBisbBisjidOI06FRByUtkXvWoSYx8MVyVgkzYR17D
         5S+1XoMelyZ02D7ZT3mCabthO4VIPjJuimT5uUTlee+2Q1h9TgB0nS+/3YwCJhdIarG8
         Pp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776695494; x=1777300294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4O8Xd8WCONGvKBMRsNl+HFLA/9jUjeJYvKk/a3SZv7Q=;
        b=d0YfWg0rscqM+bUa16jYdlos9qY1kcZeVdAVnCzi8wWj0ZFTbRfPVFyu0THnCHiJxi
         p/un1pgjPlChC7RCXTHuNe55QCF+W4nTvqLbrI/THscqVzogPmy9Z9pMpQF+k5F6Y/oI
         +GIisQBfN4t1CyNr8S4JTGgHk+SX1+MpAQqq9JuJuZI0AmgAozOQjPXN8aG296B0oTW4
         QMlusQw3MoUTt+ZFDhE0yfZZHWNVwgGokYQoesyxIBVVCsMYZ2GegHKnkIaMrFJT0HeS
         NO/LmmhHrAopQje4d7rvMmqdRrvV+PHjWXa845jT66xqvJ6+3lOkBMR+K4pI+EyPOIyf
         Id+g==
X-Forwarded-Encrypted: i=1; AFNElJ+8rzMrMxE+kxFdUEPOPDhVHsGycPVBg1U4RELx2Cg8+oa7B5wF5FskM5FC5LZdevJANIDXakHTO3oR@vger.kernel.org
X-Gm-Message-State: AOJu0YwRg286vofBfgEIihXxQCmJbcfnlB9TvCBDdPlSlEovmUn8RWQb
	wGWCQ+wetCB4eAu/3bNeWwkq56jZzzYtBWn9101ZWG0RVuNhys69Aqiqi4P65htDS4z8xVSfjPB
	95ERuGICtGuk/HRSO8tHHbdkE91+ka9Y=
X-Gm-Gg: AeBDieuHfLGei6CQegFJZeAkeo/Pou4DX8V+wwV6PaWrBYA7EFFQ6A57XqxhlsPuZ6S
	HqXroOwITxqPqGofnpIlhhHfzEC3p0kjA6Sdordp+IFCm6NGO2XXx9ftXrhGr+p5EbXeKV31z4y
	v1c6E6fJFjaMfCnJXMna5RmZ9IlsOz4voIk9houjlDqm5yFMxnxVOmKdvApbOiY0ufhTCnBNN2B
	FJaJeFHu5EOvZM7yfozGoL4xfuJpqzY114f4h9z3MVnGwHCeggBHpoz074fNCgzxGmtFUgcSBGT
	W2iGUYfZUzEjTsMXisCKCOt5ZT7fkaT8r+/gYZ1oPq2Z+AJrq7AW
X-Received: by 2002:a05:6122:4d12:b0:56f:9512:145 with SMTP id
 71dfb90a1353d-56fa5a39aa7mr6593038e0c.13.1776695494119; Mon, 20 Apr 2026
 07:31:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260416-abgraben-seeweg-a44ce660957f@brauner> <CAFfO_h5mORm0OuK-d4thzBWWySmyvLSVeVa7phZc4Df-8D=1Cg@mail.gmail.com>
 <20260420-laufen-einzeln-4cf4bb364a5d@brauner>
In-Reply-To: <20260420-laufen-einzeln-4cf4bb364a5d@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 20 Apr 2026 20:31:23 +0600
X-Gm-Features: AQROBzDP8Lx2bqkiL-O80tZkD0rFOUG8sjvNKKIkhcPgFqdc6FHkIJDo6D1Xn7k
Message-ID: <CAFfO_h5FH36eqYuuoYy2eVRXGytmQHLfz5p7fLi+3wHmQN9MnA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com, 
	arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
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

On Mon, Apr 20, 2026 at 7:20=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Apr 16, 2026 at 09:22:03PM +0600, Dorjoy Chowdhury wrote:
> > On Thu, Apr 16, 2026 at 7:07=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > > > I came upon this "Ability to only open regular files" uapi feature =
suggestion
> > > > from https://uapi-group.org/kernel-features/#ability-to-only-open-r=
egular-files
> > > > and thought it would be something I could do as a first patch and g=
et to
> > > > know the kernel code a bit better.
> > > >
> > > > The following filesystems have been tested by building and booting =
the kernel
> > > > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_R=
EGULAR that
> > > > regular files can be successfully opened and non-regular files (dir=
ectory, fifo etc)
> > > > return -EFTYPE.
> > > > - btrfs
> > > > - NFS (loopback)
> > > > - SMB (loopback)
> > > >
> > > > [...]
> > >
> > > - I've added an explanation why OPENAT2_REGULAR is only needed for so=
me
> > >   ->atomic_open() implementers but not others. What I don't like is t=
hat
> > >   we need all that custom handling in there but it's managable.
> > >
> > > - I dropped the topmost style conversions. They really don't belong
> > >   there and if we switch to something better we should use (1 << <nr>=
).
> > >
> > > - I split the EFTYPE errno introduction into a separate patch.
> > >
> > > ---
> >
> > Thanks for fixing up and picking this one up!
> >
> > >
> > > Applied to the vfs-7.2.openat.regular branch of the vfs/vfs.git tree.
> > > Patches in the vfs-7.2.openat.regular branch should appear in linux-n=
ext soon.
> > >
> >
> > I don't see a vfs-7.2.openat.regular branch in vfs/vfs.git tree in
> > git.kernel.org.  Maybe this hasn't been pushed yet?
>
> Nothing will get pushed prior to -rc1 which is due this Sunday.

Understood. Thanks!

Regards,
Dorjoy
