Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E708A3542CA
	for <ceph-devel@vger.kernel.org>; Sun,  8 Mar 2026 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772989826; cv=pass; b=cqTH/6HbRRKHnPRLN4zkJM46jt0hvpoLTWDNKU8TCeRARXS6/rIeqqw34lxFnorqc20ugv2yDD1aCLnlLvuo+z7b5rGndfBGeXKmE/PR9Z3I2FKOh3vjB0+tBZIMFQw3qodYE/ZLkj0HZC415xAriy8oYMBiwYxNhAP40W45N3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772989826; c=relaxed/simple;
	bh=mPpVNiloCu6uzQI1WxZPytR2t4HpF2nlFZDXYS8kVTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1SmQK8j4xxUpFHEXSvp5xk1wzsGKeF/x7x95J0NA3Ke3gC9wNIJVToaYo95SyFYY+9vICsBkmyLwTNFqx5XzXzW14xmDjN1+Sg6nAmaZ+FsW1sJGZvgjURj6hynw26McmVmNZQHr/YD0+9wEYwu0GcjOuMmp7TWjnWMZZccHHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=V5oii2AP; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="V5oii2AP"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dcdf60427so5617546e87.3
        for <ceph-devel@vger.kernel.org>; Sun, 08 Mar 2026 10:10:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1772989821; cv=none;
        d=google.com; s=arc-20240605;
        b=Nh0Ci8JrBzcsx4QraAPnIOcAFCMLn8bN17YQIIF+BHK94Lfqszd6AhyUTVsQOyO8TH
         wIqLuj9IStjZXlf/c7GGJKDWyLbOUTkeG0Vtyofhnji6AAk5OFY+LgKug7fIPq7xCsV1
         be0s/K11/YVtEJz6Z6FPW4L1a1Vnw5B8XjmELUw2o7JFFO0EUjpYJpYeaI/obhk03XvK
         K4GhdnoVcl92Atcvdx3xnjDky8w/qUUNH3xIC2lwZO66rh8Ta4v1i2vB9GS7C1s7d4Ft
         RsvD/DvDgJvaCfwYog+oyxmIgb/FoBqbdiVuwvglGslivI8tWJuay1dGV5XEdEf1RZv6
         fMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        fh=1LS7DKP6+NZ3m6b69wBTHZ/nVQVmKcI/rGD3sep3oKw=;
        b=INXPp83Bh9jtLJgdFu4KP4UVRGYtoSNHlWW6jdeRneH+gM//FezhmP80p2LpPfTkYW
         a19LQoIer4iF2hHh3NB+LtHm95SKBr2oiYar04fhj+pboflQHM48M1UoU27thOv1/6mv
         SZ18k2coE+eJH9ja13XFVl69ELAimrAjRFHRWkQg7ymihdEm8dQCAQkZaF6sqX+pIy70
         nIX0pMKfp+bf1eIxJEy95kaNfC49T76nQH0UIHjmY/IM6MZyJHHc/ykbotEYEfiXVZOZ
         bT5BhKsWW1VYhRw5gBOhMI3+VtCVEYGRbP2prRAS1NuVAE2E61YT/IJjMS0SyfSJoBLh
         ss3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1772989821; x=1773594621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        b=V5oii2AP7iK/gHbMNDsSVEdYvHWzBqwPyeiCJaSxH80cBJ0weDfC5z5Jac3vnz4xBd
         Tn2ClWoMdMt+leExQaUPFXVNn1yHQ669Vg1RrqJYPh/2X3l9jSvgtmZZiIj1bUZ2IzMa
         dB3alhLex5Auo3ljWEQXqzrJbKBAnpaXzkW8R3j7dH57EQCqLyyRRuNOPBvBnxDwabY1
         PCB7f6Teh/1ED3+YhCaqbNuWa+/ytjyR+MjlDNbb0urQBJvJj9Tgkb8oCphjnt8HYU5m
         JKo9lxiVLkjF2Ntl0hmSDMics51tH/PApK2OBsOlL42naroddrbbIARbX0CgiVbmpphc
         lFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772989821; x=1773594621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gg9ZdLv2ki48mUNl69QeK9y3vC32V/8zR5xNICHMQ28=;
        b=FHKR6TKbOpEwkGDXlnxQYDh97FymKBBlNXtQ9nwcD4cTlUlCNL9zA5Mp1L6fMUyhuq
         h2vJqjof2ohMdocSbPinvUpH2kCi/2IMl8+m4xlQbp05+8S59eFWy3adEZWre8Le18aU
         kwCir7iD0pxhSw+zg/hXSb+ixsV5KshlRlc4KI6KsoDDeZ6Dtqn4m80p5IlSnsF12GA0
         PRHzqEqeT/DCJKLaaYWhmabxowpQU6QNPIjClFRSLHN0acE6fYhx8TkjgEaUbqkIZM+N
         3hOQJBKdAI6CMpz+i3i/aeyNY37WDHKBiY1AxbVGVXAp9wcX9Sce3VqFtzCn6iARLIc2
         o2CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFKuktRxSfv2yzhFQJGgEXa8y0V7wO21W2WhlzgPre47Uomrl626R4M00yD3xnSsBvVo+sDSBlduYu@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8LgiLYNuYG42ItIcs43YD3eeLfv7aoU6Fd9g8kEKkZTwIM69
	8x67OdxZvAqtdbgmrzdYC9RjR2IYRemmefZ8YTIn9HVi++OfDMbybFVBhPVyzP9J66EX2sPzfe7
	MfqcZJYMrNce3skYzJ1EV8p/fHuH8kWnxGr6hS1CS
X-Gm-Gg: ATEYQzzKP4VhuCqxOxAnzPiO6mw6/RmUD5TQMA0PveNnTx4/G1QmlR0wTzTudSUe35h
	a6DBaeFeW1ZO57nGSzvAaCIulgip/+v3s7DVQ8/E+RSuRuoptHZS1zIvTJb88ddxI2RBj7jxpG1
	fdb6XeHQhieKkXO8ebTjhXaEJVw1VSlngOX6C4us+yNGp4e5CFgdQpHOEo3HqwJHL7mqlbULjOH
	1Ef4aikKgRpClehkTxMY4lwl22lK0azqkn8pdsYDXzG9FD/NZHjPNdU9RgkUa387nh23U7Df+WP
	dEiIUOagTg62oE4=
X-Received: by 2002:a05:6512:10c1:b0:5a1:3539:1181 with SMTP id
 2adb3069b0e04-5a13ccc6854mr2584241e87.20.1772989820622; Sun, 08 Mar 2026
 10:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
In-Reply-To: <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 8 Mar 2026 10:10:05 -0700
X-Gm-Features: AaiRm53NE6RSEVl9G8ylA7uki0xCjhtuxwfA8HvbEL_OVbVZXAi0saXeclsKpvo
Message-ID: <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
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

On Sun, Mar 8, 2026 at 4:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@g=
mail.com> wrote:
> > >
> > > This flag indicates the path should be opened if it's a regular file.
> > > This is useful to write secure programs that want to avoid being
> > > tricked into opening device nodes with special semantics while thinki=
ng
> > > they operate on regular files. This is a requested feature from the
> > > uapi-group[1].
> > >
> >
> > I think this needs a lot more clarification as to what "regular"
> > means.  If it's literally
> >
> > > A corresponding error code EFTYPE has been introduced. For example, i=
f
> > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > > like FreeBSD, macOS.
> >
> > I think this needs more clarification as to what "regular" means,
> > since S_IFREG may not be sufficient.  The UAPI group page says:
> >
> > Use-Case: this would be very useful to write secure programs that want
> > to avoid being tricked into opening device nodes with special
> > semantics while thinking they operate on regular files. This is
> > particularly relevant as many device nodes (or even FIFOs) come with
> > blocking I/O (or even blocking open()!) by default, which is not
> > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. =
Consider
> > implementation of a naive web browser which is pointed to
> > file://dev/zero, not expecting an endless amount of data to read.
> >
> > What about procfs?  What about sysfs?  What about /proc/self/fd/17
> > where that fd is a memfd?  What about files backed by non-"fast" disk
> > I/O like something on a flaky USB stick or a network mount or FUSE?
> >
> > Are we concerned about blocking open?  (open blocks as a matter of
> > course.)  Are we concerned about open having strange side effects?
> > Are we concerned about write having strange side effects?  Are we
> > concerned about cases where opening the file as root results in
> > elevated privilege beyond merely gaining the ability to write to that
> > specific path on an ordinary filesystem?
> >
>
> Above the use-case, it also says:
>
> "O_REGULAR (inspired by the existing O_DIRECTORY flag for open()),
> which opens a file only if it is of type S_IFREG."
>
> Since we allow programs to open a directory under /proc or /sys using
> O_DIRECTORY, I don't think we should do anything different here. To the
> VFS, all of the examples you gave above are S_IFREG "regular files",
> even if they are backed by something quite irregular.

That's certainly a valid and consistent way to define this, but is it usefu=
l?

--Andy
