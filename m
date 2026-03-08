Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5DE21D599
	for <ceph-devel@vger.kernel.org>; Sun,  8 Mar 2026 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772951479; cv=pass; b=UJtBD6TtjIgMrfNweKx1Ce9ZiSj7w+Y+4f8ST0F8qQod+JLJY67py2nNxT+PeKkd4O05xtFithklsBwMPl5BUF9fZpNZyp2R7mVEt9i1xWb/w4KTCW9LRh+WS74gLVnYgVRMNscA8zcxJCoU4jFruSqfQoG/zqvXFSCTKitlfI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772951479; c=relaxed/simple;
	bh=bqMEOQ0Ckcrgyric5QOWebyRcZKyiXhkKZw3Ukws05o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BI5YrYedZbb9qHOHWrFdXixqlYXV8vb//1Xnbe8J2jL0CSHTNQbr6nce+dLJrx974acEWqH1Ayti0l9MWESnoAQ64VTgygw7TPmqdnstxKmgWqTnOF8uoRwuYFXrAcZJXE+JO5EL1xwZfIrgLXVMmKYQVNqKZWFsa0XuTL6mmuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoBC7Wij; arc=pass smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoBC7Wij"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-94dda16ff9aso3087011241.2
        for <ceph-devel@vger.kernel.org>; Sat, 07 Mar 2026 22:31:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772951477; cv=none;
        d=google.com; s=arc-20240605;
        b=Wb9Zxba8f0nm72CtmaEs+e5y/yw/IntdCHZFrT2+iQoyf5I7fkivOX7XdaWWVTTe6d
         9tZe3OKTdO+hMWnPx20SIzmSGfuloBPTIbaZeMFqLgjS+oyKovWYOdyevod8DhJNtvHq
         jeni9CZw8mPkZ9IfAETQlZTi2heCMbareUAWyR0sXyxk1ls8Z51C/M5mhn0Qrre+lMJ3
         +fMwm7pmGEOSZc80vOBuGQl/vDpEo9kwTJiYWeq/nA7mSLPwrZsaqgbplf3viATG4iF2
         kYM+WelYTNPaXUyRdR5Y/BtpArgfIF3OyOzzcqf2XJO99uCyxRkyXX6WmSH41SZ0Y+be
         io9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        fh=lX9B0QLnugJtU8sARTfz9Iad2TuQGRV+QqfvpSuUzOk=;
        b=McJxwUbIw3/yeCqkEyezRWMGdpnUHUE5wAcA9apXCy+HheDI+/3IH04u+0EpBjJ/Bi
         GSNJsAbx8bELLJARxr3Kl4JwMBcCT7AtTCcBZ+yWsoTmTR6EU0mIjoYB4ZHEUnYKyI4a
         fHs5V3u9mzu/N8sAUGHry9kSoO7Yg11YWHJisNlXrPZbK2YAmelnE8ENBNApsyVF/JXu
         OVtuT3dV8pUCmgNZbbbwgPW6hsWPem8x9++naYDUdpuPRsvseQ+KNSwvJuTzJOMUFSkx
         4SRajqH74oHnrJjpUl8R23bhoL5IqrVypjduMJojThI7/sxrV2zxkHfLYUef9gOmkS0b
         8QiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772951477; x=1773556277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        b=UoBC7WijfmQjVlLHxpWqT3DlTCrRD4bQJHimo+Ve0AMx+0bxsR3bN/1HscBrJM5qp4
         hAoHmEH3IXVxPHPjHP72bQjLwytOTAT5lJd6vLsKUfcx09gi0FJHs8GAtUs2Zp97KKRS
         FEk475ub7vx4XQABNB53DotIZxjsKUBLPuPd0GzyFt/3v07yHqf9qXCPxfHICyaytCF/
         wULC1pF4Xso5tHqPjvY31TUJdWMLPO7UZMC4SdrzuK11/bdvaGVzvdmvJy12Y+tEql+T
         EYn1klj2Rf4ROnNVpKQExB+BChYuTiyYbqJmdmRYKShyl6hiOYBewDd9lUoEbhAHN1Ij
         57aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772951477; x=1773556277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wmFGvCnSNVovQCGgt6RuGUFVOm9BbgW1X0Xq7Fd9owU=;
        b=UhnIoMnZdbSnUM25Y1TRpQdVbFrGhg0zhot4caIqpFNHgNeaQcDVLZCIqSdonLS4Bx
         SYDRPp/oykqLinsM1NXvOhEVA9NbmOAemvUCZn87xEtAjszdZgTmb7Z27gQnngNR9PV1
         p8dnUw+mCCKHk+1hLMKwfdLdtMAcP2iLO0zzKf0bAPXmajztMjUhFEO/NKLYY10cQ5oc
         yPTHeXKCBd+N5KmxdIX9FEPeE5B0T4FDB+QGb8AfI2t8PgMfL1Mr9PJh1nc1DctyoRMy
         XwJb8AZYSnSRzXBp0Bkyb2L395HsB16mRlXMh5Azfz+iFlKFiCjLOQ0mvQBoDn997HuZ
         nDjg==
X-Forwarded-Encrypted: i=1; AJvYcCWZcO9oWI9cK/Hkr/zocop22hxxAXxiw28E+irn8qhW2t1MG5kXVb0Xh/zpRXMLNatogTkYi/QqOREt@vger.kernel.org
X-Gm-Message-State: AOJu0YxJcqhftmEKyQIpSXjRg8qnRBx86dl3+HRKhAztAVqBaaVTmY2k
	Ig3bLE+8yC38YBd8wnl/qzOsW2hj2ruio/uyCDZcF/A5aerw3PxBXEJ15xmcYOOpQcIQO3pVNWf
	VRpZjvRdJfgEcKaxkGsfm3qUpa/q+Uuo=
X-Gm-Gg: ATEYQzwNGf/es/leQ6icFZQrR7MVUWdnOOpFlJdpGclFLgKHT70V04r90kzQB9K2Cgr
	DCeRpEgLLIE/Mp5Xfd8YxQE1TJtc+mpjdjhAziBHtSFqRjDmuNxLIanbydEOfUs4JCPdsvdt+W/
	+u1jHI+C5Pj9//9zA7+HqGnw6fBHQjCDs8kV5JihSA7cVOHdqi4u68v3xQHuumaB45fLdrzGi7S
	pZQ/grolm1WtWRsZfPonrA3/rCw97Qxs+KGfCdIJwt8SpPoHQvtyZhXWohVRDVNIRRq1vT6Tapp
	gVqe0gvlleICA2LKIrhTBV7akWOTWGfxmhfrGd2Q8g==
X-Received: by 2002:a05:6102:41a6:b0:600:11e1:2a4b with SMTP id
 ada2fe7eead31-60011e12bf3mr732622137.34.1772951477120; Sat, 07 Mar 2026
 22:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
In-Reply-To: <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 8 Mar 2026 12:31:06 +0600
X-Gm-Features: AaiRm51WCqo6sYLOpIV6hZ1XNIYME3jM_VRhuXhqPcz8hjUnJuRMBp96SANcO1M
Message-ID: <CAFfO_h4g-QtE1gsp3nw7+BUYnRj29au=pYs1goEnppbdU-8DbA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Andy Lutomirski <luto@amacapital.net>, brauner@kernel.org
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

On Sun, Mar 8, 2026 at 12:56=E2=80=AFAM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy111@gma=
il.com> wrote:
> >
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
>
> I think this needs a lot more clarification as to what "regular"
> means.  If it's literally
>
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > like FreeBSD, macOS.
>
> I think this needs more clarification as to what "regular" means,
> since S_IFREG may not be sufficient.  The UAPI group page says:
>
> Use-Case: this would be very useful to write secure programs that want
> to avoid being tricked into opening device nodes with special
> semantics while thinking they operate on regular files. This is
> particularly relevant as many device nodes (or even FIFOs) come with
> blocking I/O (or even blocking open()!) by default, which is not
> expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I/O. Co=
nsider
> implementation of a naive web browser which is pointed to
> file://dev/zero, not expecting an endless amount of data to read.
>
> What about procfs?  What about sysfs?  What about /proc/self/fd/17
> where that fd is a memfd?  What about files backed by non-"fast" disk
> I/O like something on a flaky USB stick or a network mount or FUSE?
>
> Are we concerned about blocking open?  (open blocks as a matter of
> course.)  Are we concerned about open having strange side effects?
> Are we concerned about write having strange side effects?  Are we
> concerned about cases where opening the file as root results in
> elevated privilege beyond merely gaining the ability to write to that
> specific path on an ordinary filesystem?
>

Good questions. I had assumed regular file means S_IFREG when
implementing this as mentioned in the UAPI page:
"O_REGULAR (inspired by the existing O_DIRECTORY flag for open()),
which opens a file only if it is of type S_IFREG"
I think Christian Brauner (cc-d) can better answer your above questions.

Regards,
Dorjoy
