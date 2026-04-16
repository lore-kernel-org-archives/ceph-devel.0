Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB9D3B38A1
	for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776340751; cv=pass; b=bIzkHbakX7Za94uobxpPM+11Od/N+Fp0CgsvGjMmSIKeu0//CwYGj27TzD4S/jj357YwVeiMnx29JbqBpwApaOIkao3kq29NcGu2Kt3dnyFlJdLwhXKqQEqx71nyOYRLd5E/aFF1C9nnQcsckW5tqgEM/MkCby4Jo/8SCDucyR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776340751; c=relaxed/simple;
	bh=Bw7/eU46XNMmEAY5yaZoewjP327xtGOJwYlC+oEFeMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWe3e+VDVJDTfm01QPUqXAs7RVyzqW+lKVaRY/Hf/eV6PNWMTWHvBIhm4oxhKnhvr7C8aP/c2ztSlCqltxtmu7bBvPxmsMaMhkcZncDB8MS58aR+eU39bajdJGyFuLaIo1oUp2BenMYwt80lce675DzYbudD9o+SoZ8NbQyDYto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yv/iJipA; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv/iJipA"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-605def5b800so5074586137.0
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 04:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776340749; cv=none;
        d=google.com; s=arc-20240605;
        b=P5Fb1Udm6PTC6makqnpiGkJQWZ6cXpamo6Xq1Mo0ZILdMshorYr23pPyaxvLvy6bFn
         5y45+MON/WGAbAkYi23PPYMUdCLiZfB+WJRzHi3fwa/8wIgUmA3I191ov/Q2Hb7EoP8b
         FNmsQBbFAM8HAXG/Lp35iXdjSi5XCbcHBX41P5YedbH5XUhlf40AEflVewPIHMK1mNu8
         P6RhpaG0cYLGhX7docxO/okyJvD//6AN60s4tUH7BHC6//xj3C24g7f4V2ictdQFy1US
         4p0sLAxTu3CRDwZjYWwcM3qtQRcHZMyhMpYKDssa+A6yZmioKaboyrqm/Leyc5QPz4oS
         FPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        fh=q53YOE/isXpCJPuLwaJEj7NOaYpo4LhnnQFknZkVlQE=;
        b=bnsQjZz1nqG6QT+eDkCX6QitgbJApmVFT1Y+NnP/KEF4fQxhZOBsdkDdVZYNEpwdaJ
         vP/Xr7kQ51IHnYMIWROJ3LeFCjpXhb1OqR5cibWR8l79p+76+evf0TQWjj/d3ApxtTFQ
         0Of74o27Eglihdm+WFxe1E+17JpQtA8YOvqrleoZbKvgyqzEwPdn3pwp8g1uIX9AbyLF
         jYEbI+DYJ5yplM0UvQvFu3eOkLAttHPsQiCrHoLAzR9jgANqJYyzct1dYbnvv+J+c/tw
         XSKVA7XTVcstCLKXEyCyZP9mmdnnv/zJIkf5bFdqpeJkDzGlkOzt4Dl+06LHzCMSt1Pa
         gRWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776340749; x=1776945549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        b=Yv/iJipAA+nhsL4hM00ueWwDagedY8BECDRzHx12spLwNgoS8ZakY4zrK2dkiR6l2J
         mQ3pEXXlrCi9kMRBkZi2YHE6qORxLcsWe+D8l+wjDn8HWOrCtWjKCgf5gVQmenh2NByp
         MCPNQ/tGjC/7AKKVlE3P3sIa6vn80p3d3lTSYo8ONK1oz6WoMzmPVNtYluTYxoNlq/gl
         23amyKa5o+u6+Qji1591D7SZNcgKyeEHjHsrOnz+jlamox/cVrUC1NkqUB4QzAKYFrCI
         XYiMktKmpNaISctvSp/Zchtq++MLrF/hVgPWAelzahh5Lq/eJ/sH7+6gxH0vD3vgUtNt
         7D/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776340749; x=1776945549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JqYJ8R4iGWahwud4pP2JmsmCHvSHhoaPalUrCsDrudA=;
        b=q7hoo05hu7Y/ICbhUo5ZOCvZ+s3Z8UrtDpR5YJgFx24R/24pJ0Jh7MgYpeEY/Y9zIr
         n4GAbWO1hzHgxtisDKtL6Dy9+nOw3BhT+Wz4ALj37Azp9aQiFYafyxUQYr+Bq77aITlN
         y0mcHQ9DdiLSpp7TBXQZGn7iN1AfT6UILZM9XSx9yc7lQH8wnUJoBDCordcdlToBIIRt
         39BtpOjpbCFG6+k9QWbk5EuYOHYxWR93mzul8HWd8ESD1+XO1PlWMid+go/as9WqP0Z0
         2m2YQTFTXmbNTTdHk3SU2+zv/cBo0WE+MSUopYe5wtNMFf2t37GUk+2WiHyvREiOHA6u
         nwrQ==
X-Forwarded-Encrypted: i=1; AFNElJ8lYpyTTIpaxknM6n2SUjjECLdtAz5r6eTh3jPFQvtMMBXjtyRxSj/tV/9BcBR7dupI1UYAIo4lssN+@vger.kernel.org
X-Gm-Message-State: AOJu0YzjiyMC9f51YBXgeDDtJ3+DyeBsWCoOHwykn8iD1aQLSCDbQ8aR
	1hd+aMEGIBJaUqIJHsFRqYPGjNzox0oM4Bc/47Ty1fcOCCetF0S6QbDs0JTmN8Nx34JRUlWezu8
	U+fXoqrdqlsUpuVwDfnZvGn7JTH6BeRw=
X-Gm-Gg: AeBDiest7vkSpxXXJM+tBhx9+E8y480kAELdaHdgVcZSPdlhO4k5NZJVTdmdQWDifX+
	ttWJB2F73p9Mrna5ZVkvoflJ3FHtpi8q1Yr4+ZGyn28xvjTKyuxDTTaO3AdUAHyUZ3V5NdqUmwT
	Sy9H8HPRLSvrz3viPkBUn4ExslHb6umBinrzli4gE0aK92YWQe10DVhdzw0x4FAAeSmGMR3jC/M
	69v72YGHdge1wtjSe3UxAI+QAkETJFDLejBCDK0/QJI3oIIvcXmsvEOTdISsRz8QiSPK6QFEww1
	/Eb+khIHQeuLfvhTCeYMswzcuybURDC09WabXqHtFA==
X-Received: by 2002:a05:6102:6a94:b0:607:a3cb:4573 with SMTP id
 ada2fe7eead31-60a00c36c76mr12126981137.26.1776340748680; Thu, 16 Apr 2026
 04:59:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <2026-04-16-selfless-milky-wasps-shin-p6liRL@cyphar.com>
In-Reply-To: <2026-04-16-selfless-milky-wasps-shin-p6liRL@cyphar.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 17:58:57 +0600
X-Gm-Features: AQROBzAEjiDzwaGAEKhFLRhObmxO2qMMzryZZhbLCURVPls0DvUuWHW8g_k7mMU
Message-ID: <CAFfO_h5kWCYszymaY=tPAbpU=PjLFxsND+CWSYtypN4iuW+qPw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Aleksa Sarai <cyphar@cyphar.com>, jlayton@kernel.org
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

On Thu, Apr 16, 2026 at 5:41=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2026-03-28, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
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
>
> Aside from the nit below, feel free to take a
>
> Reviewed-by: Aleksa Sarai <aleksa@amutable.com>
>

Thanks for reviewing!

> > diff --git a/fs/open.c b/fs/open.c
> > index 681d405bc61e..a6f445f72181 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -960,7 +960,7 @@ static int do_dentry_open(struct file *f,
> >       if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
> >               f->f_mode |=3D FMODE_CAN_ODIRECT;
> >
> > -     f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
> > +     f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | OPENAT2=
_REGULAR);
>
> It's not clear to me why you dropped this, I didn't see a review
> mentioning it either. (General note: Ideally the cover letter changelog
> would mention who suggested a change in brackets after the changelog
> line so it's easier to track where a change might've come from.)
>

Thanks for the general note. I will keep that in mind.

The review was from Jeff Layton in v5
https://lore.kernel.org/linux-fsdevel/5fcc2a6e6d92dae0601c6b3b8faa8b2f83981=
afb.camel@kernel.org/
" 1. OPENAT2_REGULAR leaks into f_flags - do_dentry_open() strips
open-time-only flags (O_CREAT|O_EXCL|O_NOCTTY|O_TRUNC)
  but does not strip OPENAT2_REGULAR. When a regular file is
successfully opened via openat2() with this flag, the bit
  persists in file->f_flags and will be returned by fcntl(fd, F_GETFL)."

I think it makes sense to strip off as OPENAT2_REGULAR is an open time
only flag (like O_CREAT and the others already), right?

Regards,
Dorjoy
