Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7932E3E2767
	for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352939; cv=pass; b=PhnrwNhAo9ZE5KVp4CHMbo+KSyTxcv7UB92ro20I4LzhLzCYvMclfSbXINdSHh/SR2MglA76pwO2zoI0C75lTrYJaVm8nj9uTfbt1sjMOEq98MRi78mZemh8bfjBF/RtanWYmGUKuo6CqtSo09rDcG2EJKpABLjkG0avzazgkak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352939; c=relaxed/simple;
	bh=d8h0wpCxAz5qr8QgJAWyo5NPmRw20h5MEF24J15IyVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nppMNHPk41dyNGTamniaRxswWpT3KVxfcSmXFTSdUwotd7nlusiDB10NsgXwwVbsMvCD5lDVN9QaynCoZATJfPlIKxzBAPfHuSA6HI6mi0icejiW0y5YrSycTayXVdMTecllR6Heuba+ZPtmkSh4QDrEpocbtOohnaApVRVIQ10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4lVbpH3; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4lVbpH3"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-605def5b80cso2608220137.2
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 08:22:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776352935; cv=none;
        d=google.com; s=arc-20240605;
        b=RhG2o6xMPplOLrinUZAtLDafPDDAGGvZIhL/cYQ0JREwgKFldLBHKyX688LthXIDG8
         c6Q3SmIi43il+ehNQawjTzieLXShGlJCzaz5RlUpiDsV2a5GS0t9g2GQbXPBV7EQmBr4
         iEQJWaQwpG566KpyVcny5FT+s1OduXyFBjMATq7TTCPiq1goQXbsFUmgac7mglez++Dr
         VVb6JRJzh+qPO4FXgnrAobKiz9k5C4a5OrysmaD5LSqCauLolFFnwlLfQRyOVKvvw807
         jg2YvjHXCOg3azCJYLim3Cc/KhwivcqIXWesmpv7XSc7793gSSu6XUFlVUAuWBTHRbVh
         0iVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        fh=PUqiTPusgwShkd8jAS813wv3LvH71tNG/MQgJUX1LDY=;
        b=D0eFz/z+gH4wVRq6NshuLHxRAfvgmSJz4v/ilACqiKaB+F9s1USq8Ueqn6m3+8Jrz+
         pKRPAsXYnNO149lsj6BRhppeauE7o1jTBwu07s4rFpDRgNMPAthfWnkPLrc+1iFNGyJ2
         og6ULimale8tihffgSmVzq5/GIjKBxPBS4P/XGv5hJ6TCKe/6M5yxee5ovPL6GC65W6y
         3NcwF8AnU7N+BEkKl3Nbmid7T5c8OTePb/x8xOO/7DsWRcZA7zJQzbREkPI+0nZ9+kZU
         E2YYfPdyh5efNSRCusQ7RYRyVAJ8UlNCCSadvYV/VQDMgyaTo1XM8qy4lcNniIPt9dt4
         e72Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776352935; x=1776957735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        b=g4lVbpH3NYuTwHK4zof4cI1R5F3IIOc7rqMOk/MWHpRmevLzRVb+qRlTlkjItjBIHx
         c7M0jhqWfaQ2vMdmdCGZvAPwF+odTZ9kyd6p7sv+kuJPT06vFRz8sGzxEE+RDZyrNUPi
         T43wkAslMCjJ0svGA08kUb5Gbx/3985K1GhQDZgh/+pTKuxWXmHDa0LxQ7N8Y6D+AdMV
         pK9JcsBfafPuXYE4xQ1M0Bsj7zmPTRKj8Oqs1QY2itp7CaL3brWr7nECH3oyQEx2Fb50
         mvvGzjXFjjCeXabKEm078u3WnFCD8fkfLKek/kSJSKQGUKyNJa4mEQC63tdpwccNytZ5
         6URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776352935; x=1776957735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZrzbbPcScOB3YiJODipm6pYCq1GabErqB6lK+E1UuOI=;
        b=ikazddveX6JF8Dx6akJPF24PQWrKmvTcy8S6UACFBZe2Xv2jBFPdBhFFweohS3mXca
         df2sjughS99wScwbHlck85z8nHwL1ZUS2bXMAP37K/7U7cQsIwAcSR9gj8dwAeGZhptJ
         lPB6RhKjGKfD2h5CXFe/xamq49XbdZ791Q6YHIWgAh9E6sopd2D0jXXqrunv/GhNH/w6
         uy8rZbsUuZyimy2Rw3/CvkN52E6NqWL/JZh+/P9qviXifGikRk5AUfsq75RkwPKScajv
         GZfTwbRmqGBn4DdNZi9Z5hYszl22ZcczUckQWGjcgH2bOgKZVgYJVD7JewP8DIuoSz3P
         k7cg==
X-Forwarded-Encrypted: i=1; AFNElJ+ADWQ+OS8Iow3MF96hYPeg1yDECc/hO/5siR8rqxykkETSJHJrqjdRJzXszr0VLFsd/RtTE/bQ/iVg@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJZjwPyNmmZcA2QcHL98Q6m5nRIYITb1LcjhLGhRC/Laca9tO
	JmjnLjPD2aMBfGWicIP5gUtaDbTPZtdgwQOutAI4pXxlgWIcRxMdKx78NugDOR7MGAe8FFNQ8/S
	d4YdaYiz9M/A039EkN5fm4GU0+eFkwBM=
X-Gm-Gg: AeBDiet+zY8C2nBM5pDkiwVwQ5Mqt3UQpfYg/J4sRUCJuhLSKmcRUdULu9dGAF/Q9Hu
	V1fDui9SUDVmIAPEXJjVD9GbNhrfn5vgzjC3N6aUjNW9Akb/m5Ko7pQR6WHeCIwWU9uOBPGrfkO
	TBs5ZwZBXIY8wIYTECG6PaR4cPkBWTn0ZqEw2vvObIVr6NJLCRVujn3sJeY5UCzn0LWT+eUIoKy
	+HtQuMJevr7eA7zDkbR1GBUsu7LofXE+6iToCo8mm9DXEBVWoP+6QXxw3w/r4GxlQlz5Eeb/Jty
	auKMZzu4H99dHdQ2F6N3sdx9oo00abEQYJ4MobAvIw==
X-Received: by 2002:a05:6102:4194:b0:610:48e8:8c4a with SMTP id
 ada2fe7eead31-61048e896d0mr7561251137.24.1776352934841; Thu, 16 Apr 2026
 08:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com> <20260416-abgraben-seeweg-a44ce660957f@brauner>
In-Reply-To: <20260416-abgraben-seeweg-a44ce660957f@brauner>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 21:22:03 +0600
X-Gm-Features: AQROBzDwlhonUu0OdB2GZDkt71Qp2GPutRABZHn8dYTEqH0ntcAPsZO_it5641c
Message-ID: <CAFfO_h5mORm0OuK-d4thzBWWySmyvLSVeVa7phZc4Df-8D=1Cg@mail.gmail.com>
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

On Thu, Apr 16, 2026 at 7:07=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sat, 28 Mar 2026 23:22:21 +0600, Dorjoy Chowdhury wrote:
> > I came upon this "Ability to only open regular files" uapi feature sugg=
estion
> > from https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> > and thought it would be something I could do as a first patch and get t=
o
> > know the kernel code a bit better.
> >
> > The following filesystems have been tested by building and booting the =
kernel
> > x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGUL=
AR that
> > regular files can be successfully opened and non-regular files (directo=
ry, fifo etc)
> > return -EFTYPE.
> > - btrfs
> > - NFS (loopback)
> > - SMB (loopback)
> >
> > [...]
>
> - I've added an explanation why OPENAT2_REGULAR is only needed for some
>   ->atomic_open() implementers but not others. What I don't like is that
>   we need all that custom handling in there but it's managable.
>
> - I dropped the topmost style conversions. They really don't belong
>   there and if we switch to something better we should use (1 << <nr>).
>
> - I split the EFTYPE errno introduction into a separate patch.
>
> ---

Thanks for fixing up and picking this one up!

>
> Applied to the vfs-7.2.openat.regular branch of the vfs/vfs.git tree.
> Patches in the vfs-7.2.openat.regular branch should appear in linux-next =
soon.
>

I don't see a vfs-7.2.openat.regular branch in vfs/vfs.git tree in
git.kernel.org.  Maybe this hasn't been pushed yet?

> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: master
>

I guess you wanted to mean vfs-7.2.openat.regular here?

Regards,
Dorjoy
