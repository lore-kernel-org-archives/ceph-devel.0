Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811CF3CB2EC
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 16:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075034; cv=pass; b=QeBfHtt0INH+W7PtfMNTOl+LXU2fFifkdAUKxw5w4NceKzLJT2xyL6vZuOYKpH2EyliNZ/Wi+Wb28hS/LSwwQa2ZY39yjZ/dqr3/KA3EZFe4AkpLIGhwdsOkzBz63SdJ28vlTc5t1WlzAjDR8k1z6PiYBYi2wngUGUGpz49ZkWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075034; c=relaxed/simple;
	bh=dElGlCWfTDUCaV3zjXVrwEshlrdMTwzM4Mn069fiLm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Peu//1p6xu3KctojSddy9Iu7xTmegeglWqHR/aF6PYWD1ndUhLSBnYvvcx7cGSizgG5X6o0VXL4/UXX8xK65vtyxmG4AcbaGNCWzCazZP+LpnD82baIR332Be2s+hEsPkgcvJItslGHAgUYnof10VmxewvlgvWpI/zJDWidQ8Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=J+Xuet5h; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="J+Xuet5h"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a140efd2d5so3014824e87.2
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2026 09:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773075031; cv=none;
        d=google.com; s=arc-20240605;
        b=aGb2gmn0gzM+4hPp6tqXD5GUV87bB+Sgelrtr35oumVVS9bmRZlX0Kj+TnZmIz/QzQ
         GxHtTYExVfxejOiNk9wBKc5n8cuB3H5kDpsH4FRkiyY/t71dxfNvZ+0ndeXyuHfDlFMA
         QPnaXhwiXBS1ZXmQWrXSWpMJ77OrqIKoCNzw9mNQmrvkrR9riFn8b4QDv3DPl6zdmuCb
         oCHAfnCoNsxNaQLISPU3ROGH1jafVx03ML2b3xE5EbA7z9aYJngGoKP76+aMpTrcVLy4
         esD+9lE9fmV8FuKD+iHcUk3lSv/71uVlzeR4qPYfbEbSmHbRRO22Vx2P0roL0HJHRXef
         DlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qXi97N/dEOi9sir8d8Z87lcT7PElOkZiITQbx2fwCc=;
        fh=rhJ1ZZgffkDSA7X+LsZthMp0UseqgxyVn8PzmfSRd1M=;
        b=gkknr936SJD9cR9IRFH0NcHaV0IMnAVc3MZ40M/nkL4ZK1sPQk05UKDL3y02RUTNRG
         GhG/Vqs2BSSvBZO9yWFPbCuw6QnXXbPAxhA0MXOoaCG00vAU2OYC/p5Sx7303K8NEuu3
         MTjKPbCsiK+vQwl4gC2bGyLX7KQlcAA7zDZs1M5DDSr3rkVkWAI1Rjvp0blhB327dTvB
         cakkXbx4NSf/g9I6VaTvd5E1OGAfK0NWGLbYoI4gxI2JKacdo+uhCZR/sU4ca6xYdf23
         hW26yCxq8R92AKmpCKeRqZYKYE4/pMpmam3ZMhljeOa7jjQawcoBxEsxj1Cu7IzP6oxC
         A5uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1773075031; x=1773679831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qXi97N/dEOi9sir8d8Z87lcT7PElOkZiITQbx2fwCc=;
        b=J+Xuet5hbFlie89tCjUFjzDwucKsd4NfrnrH1IlxidGOt/z+KgeLuYLA/G1tJg9YeP
         C1CoxioVNedpRpnH3i2g1e9rvaDLyL/wWFxrMS/dadrG87skwpJ9ll0VXP5/mb7t/tVB
         3nTver45s6YBmiBWLR4SANFDP+bIXXTcsmJ6clYmeEH7meYralZNdoAd1IxF7O6aIkco
         lCWgnoV4P4ikTR0XyXY+GmybQCrbR7LB3OkC8+7VNevH+4CSTtWk0BvwVojn5VB4UwmR
         IhgPtrXLc4SezqZQwBlfIP/+nK2z8AMiJCr0cknaXTC3MvGuBMz8TIpTguJCHWhMt/xS
         SObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075031; x=1773679831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qXi97N/dEOi9sir8d8Z87lcT7PElOkZiITQbx2fwCc=;
        b=SVfiztz7XvK978tY7e8wnUH6ZbA74t2KRtxN6Hq6lODDM1XwSbe/2NEu7AWcBxiw/b
         y/aJo0/ovFzyWZxXMJ5z9y5lNI3xZHt+B2nVw1dYIWt3SuMiiNjEH2dLYU484CQfDeql
         zC7fqJvLAtYnOKKtZr3EFGhMchUxxsRHqABtRmuZprweIhJY2f5+gKauZsCtaLaegwGI
         ek2z02JafOpFpnqJ5KOaMeaQoVXb+VXwnuduFEQwhvBB7I4mK+pNQTMMPj5Px9mpZpV7
         5+Jqab4/4bhLgHH4+k/qcqIvJMGoMxOQyYxwVqthIKbAv2hMnncDvr8Kv4V9Qgw8reEq
         S+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1QDIPsL/mACIPJ12T2g3gJX6twdtrZ8OTr3xGYxpDaBAytfHrm1X3hkTF2PKCDMOm/Hn35EV2l9g6@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xO/hos4jGrEmgm1JJwtM9Q1dvtUcT4n6wQTqczFhwQQmCyBV
	EMSp9X6pg6meBzXsEWRlsCNaJZxgWSnFWb0SEiUg8cnBN4vpDXSJLCCe+QUHNGrZmEdZBFa8Yj7
	p7s8oliEPuKj2UGbU+vPZ5fZc8+Qdw+D741rKMA0/
X-Gm-Gg: ATEYQzxhx4b/h2up5G40s0Gq1BqjaXMRW7W/a5hpjLhqIrY/SlCzvHGqMsQ5b4sNV51
	c0WNBA/ZiQyfRYrUKNi9ZsTajIt6wNEJ03D0kbMBaYLH8yKsIZ4tQ8ec/WZTG29KgR6fE42bswd
	Yw5NO37JPSTb8sG9CegWP6m9VJnHocP2+dRDqw+DAWnMAk28BJjmsa40Q/hqBKcAoWiqRxkwPKj
	SAtQeq6n8p+lcH8L03YuLfN8jul8Ia72R6zjInUuSYNp3uKglT7tVd5klqolTPi4vOjm+YIBuc9
	FM+F0y5Vk3/mjG4=
X-Received: by 2002:a05:6512:33c9:b0:5a1:3d7f:8fbb with SMTP id
 2adb3069b0e04-5a13d7f930amr3518616e87.2.1773075030208; Mon, 09 Mar 2026
 09:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
 <801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
 <CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com> <20260309-umsturz-herfallen-067eb2df7ec2@brauner>
In-Reply-To: <20260309-umsturz-herfallen-067eb2df7ec2@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 9 Mar 2026 09:50:18 -0700
X-Gm-Features: AaiRm50Rb5608a_d1ziKt7e3a5xZPZu4oB7F4zw8iu_Gm1KsPQukeeL-PdrpHz4
Message-ID: <CALCETrWjb+V-zrMT412MtmgDCx9y8simJBQ7+45C9MtdiSMnuw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
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

On Mon, Mar 9, 2026 at 1:58=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Sun, Mar 08, 2026 at 10:10:05AM -0700, Andy Lutomirski wrote:
> > On Sun, Mar 8, 2026 at 4:40=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Sat, 2026-03-07 at 10:56 -0800, Andy Lutomirski wrote:
> > > > On Sat, Mar 7, 2026 at 6:09=E2=80=AFAM Dorjoy Chowdhury <dorjoychy1=
11@gmail.com> wrote:
> > > > >
> > > > > This flag indicates the path should be opened if it's a regular f=
ile.
> > > > > This is useful to write secure programs that want to avoid being
> > > > > tricked into opening device nodes with special semantics while th=
inking
> > > > > they operate on regular files. This is a requested feature from t=
he
> > > > > uapi-group[1].
> > > > >
> > > >
> > > > I think this needs a lot more clarification as to what "regular"
> > > > means.  If it's literally
> > > >
> > > > > A corresponding error code EFTYPE has been introduced. For exampl=
e, if
> > > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the f=
lag
> > > > > param, it will return -EFTYPE. EFTYPE is already used in BSD syst=
ems
> > > > > like FreeBSD, macOS.
> > > >
> > > > I think this needs more clarification as to what "regular" means,
> > > > since S_IFREG may not be sufficient.  The UAPI group page says:
> > > >
> > > > Use-Case: this would be very useful to write secure programs that w=
ant
> > > > to avoid being tricked into opening device nodes with special
> > > > semantics while thinking they operate on regular files. This is
> > > > particularly relevant as many device nodes (or even FIFOs) come wit=
h
> > > > blocking I/O (or even blocking open()!) by default, which is not
> > > > expected from regular files backed by =E2=80=9Cfast=E2=80=9D disk I=
/O. Consider
> > > > implementation of a naive web browser which is pointed to
> > > > file://dev/zero, not expecting an endless amount of data to read.
> > > >
> > > > What about procfs?  What about sysfs?  What about /proc/self/fd/17
> > > > where that fd is a memfd?  What about files backed by non-"fast" di=
sk
> > > > I/O like something on a flaky USB stick or a network mount or FUSE?
> > > >
> > > > Are we concerned about blocking open?  (open blocks as a matter of
> > > > course.)  Are we concerned about open having strange side effects?
> > > > Are we concerned about write having strange side effects?  Are we
> > > > concerned about cases where opening the file as root results in
> > > > elevated privilege beyond merely gaining the ability to write to th=
at
> > > > specific path on an ordinary filesystem?
>
> I think this is opening up a barrage of question that I'm not sure are
> all that useful. The ability to only open regular file isn't intended to
> defend against hung FUSE or NFS servers or other random Linux
> special-sauce murder-suicide file descriptor traps. For a lot of those
> we have O_PATH which can easily function with the new extension. A lot
> of the other special-sauce files (most anonymous inode fds) cannot even
> be reopened via e.g., /proc.

On the flip side, /proc itself can certainly be opened.  Should
O_REGULAR be able to open the more magical /proc and /sys files?  Are
there any that are problematic?

--Andy
