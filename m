Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755C5319617
	for <ceph-devel@vger.kernel.org>; Sun,  1 Mar 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772378402; cv=pass; b=MJq8XgzfDohpMYqoC7TxAJowhwFQy8I+Q38fzFoMXy/GyOND4UZDkry7tyd+r4mDlNOsBLCZo3Hk5M0OAyIpqTkGWCx79cBnBQ3GwlK0RcU2K+JoCm+5WeXom0Xyl9UPxQ9dN2rs/sI28E/8YY76QOXCkG4q8HmH2wmFVEugNMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772378402; c=relaxed/simple;
	bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBSiB7M8JPYf7rX7RieXqaWJaMl/XwvC4J0bbTOMBbzMTB3FIpD/C0Ye/YUsNJDxIMCVVPXjfy3QNhXczN/4ZEzlGOnyyfKteEKN5/sfxgTDKdt9KucoB2CjTicJ6zi98ybO+kK5Aq5GrKtrDPJQhuLjaqg9gnvl6+t/uDG7fMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4sAIl9E; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4sAIl9E"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5ff07cb35f2so1923005137.3
        for <ceph-devel@vger.kernel.org>; Sun, 01 Mar 2026 07:20:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772378400; cv=none;
        d=google.com; s=arc-20240605;
        b=SYaZz+if84RoaSfn4Mc01yJcVyFvg7nsZA4ZOFvNa8N6ObE1Gdd3uxKVZPQHEnYPvD
         hYN4+36rnfitBHgCL+bTTR2u/PXBHPP0bAyiEa102MBDucJrx91OvWYgsEHbOaSfRcoz
         A/U2NOPDQc/bY8E9Za7TIdby6FFm3bkW8lJheafhV+bOtwU4dvluN29kWy29gjzvjGim
         p7ZWJSKacikANEjPugsK5n1IiUFtcZI2OnIpkiEzQT7Q0uIEzALsFkIF0yldDRyVbrRm
         uprFR5yhQd49qepKQVVbnURaYWWkN6LVVEJ3cPdN2RYoObMEKFubNx4c3Kl50cg89V1Z
         Qxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        fh=HxWrw8r1BtzrWrrl5gGrYsFD/wOi3wtG5mbqnA8rEX8=;
        b=HuMNQDZC786i1CHe/DYC7YtNrQN8U9zINu5yrU9OKsscxJcoTZRtow8ItB2liFdHJ9
         qRSzavB8QdZMBKxS+apFfSzE+xE8TVlL6cfsHaU/LaIPAL1ybNlvBoF/kBPirfyHbahN
         3jXGdXjR274nB9I2mg/+2QMiNcc37t6vnFMVnc7Ru+XSUYOajGKrP/YOpHYn+LRQw39j
         DIvKZFO//jcxbPVwz5R9NpGGxJ9klRdadnmzC0rxeUbpbaN1e799XJTHAhhG7/RvWdJZ
         70r7yNTRUAJX4HPDE0XIUmwmS7ZWbjKiIN+oGt0KkxslM0tpuwUcWhqGjpLA7tdgOgVb
         yVGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772378400; x=1772983200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        b=H4sAIl9El3DNOjSs6WpoPmMrg64nxdhM2ZU5p6QYdJgq0rtcVMiLtOknYAp3Sg1HnR
         zuEPbTmKD1ahGkEt3CE7W/3H5T9dhJifaqxhoa4FnJIn1ZHEkCrP0KrT0cHSvWzxETnb
         MbQOhGyR7CPg5xgLKg7YKeEJVtdUNLNdy+utBZZbL/Jp+UK/UYfxbYJC/r09iyrQkrq8
         mxKbP0RTNPaULQk5XcC0nqNjCJTCy9r4hOpSX+4eaoRxRsX2lGltWHfOVKOZiO6+5udc
         ZHmxplPmgnjfFEzR/g0/DYxbZ9xUIHWOxlu9NKNyarI58YO2J4A566bqfoxSDFengttt
         GXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772378400; x=1772983200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fiwwjp3q58poFbwEi1UnSoyKncjAv5ZQQsyqXdz0VPE=;
        b=JQYNG+M90Ftsudysk4D2QM5ImSfw5fDq4JTpGRJJFfTmmyX/6R6kgZZK5ekRA1PAIj
         6FsacyK1RVuJOUaeUghhVsebDSNFGu4ja34GDLbziqk4xmjLPnJ0hyRaj+LpY+xCldhw
         bX7gkulJY+QK08ET57G3MAGyAdZo2rbFhO2aMa9MKIo9C/FBmuQf8V7mEAdw+HSxuOIf
         cEpiDL/K+WHW/TJAdCnFhk8Tz7YjGs/601ObKWhcUYrCrhC9UdpEFMrkjMRUwI74xTLR
         QPZFGWMN6V0P3qmQuVAYNrKX0YIE9sQ0tUa7XI4iXeGL52Ks47ESIqVXWYqqfGig2svK
         Cpwg==
X-Forwarded-Encrypted: i=1; AJvYcCXZmrCaf8jaWgT9cTSh4GKd+E2gj9xOEQBAgJKIU3FS+WPDUBME9ZN0v8KrfQYTO57ia3xyjCU0aEr1@vger.kernel.org
X-Gm-Message-State: AOJu0YxxUIE3arGg5eO7qWpHIwSXhLYfDFIIhhnobO2MlTJSpbd0YbWu
	VaZjjiVJOniSqRlSKowMIKfuHlYRwh+c2DbnK7vwG1W3691sjNgl4ozdGTy2kv9z9lGHHiShMrH
	3vOzR6Bi2iqTapSTFOidnhQDu/Nlq0eo=
X-Gm-Gg: ATEYQzy/E8HUe6+5LAK2me3WtOqaJUdLrkKIhPxrOay5Rfoj5acxct7eKZxKoubsa1f
	SxNZij6bpXO6BndAyMz21B3yVoo47tV4mE4h7rbyiSajGTd4nCc31e+6NPIHFZxcJPpAQEirsra
	o5/Grbt/gfMFnacdhyBkYJLqN1J9fEDZP6zwHfTLh2wvJ/BuFbYXRsCX00uIlayi0dKUuBlDUE+
	bl2qqTQSuwJqTy5SDldh0gf1li+1sl3ZzovNqx3ktEsHPrTzXvresKnDA0HO1dGrOPg1TzRyHUW
	r0On2r6bJfsNcr7oRKdGeKzdJ8fMVyM/kpe7TfmV7Q==
X-Received: by 2002:a05:6102:160c:b0:5ff:1981:aba6 with SMTP id
 ada2fe7eead31-5ff31fab9ffmr5005001137.0.1772378400433; Sun, 01 Mar 2026
 07:20:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
 <20260221145915.81749-2-dorjoychy111@gmail.com> <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
 <CAFfO_h7i86qdKZObdFpWd8Mh+8VXVMFYoGgYBgzomzhGJJFnEQ@mail.gmail.com>
 <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
 <CAFfO_h5za6gV99TQS3pwHnf7zyCeVySn3CdRyV+_jFqjovGBqA@mail.gmail.com>
 <beead8bbff344ddfc279e0fc86db0dd5dd98562b.camel@kernel.org>
 <CAFfO_h4brg90tMNp6VAzs5Lo8Lbu=DK2csjDqr2zspOygKEFCg@mail.gmail.com> <73c8ea54bcda0b64093d84fe047914c0632c2d0c.camel@kernel.org>
In-Reply-To: <73c8ea54bcda0b64093d84fe047914c0632c2d0c.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 21:19:49 +0600
X-Gm-Features: AaiRm51DyMEBRNPI1HVDhCyC4qT7r77uNpEMtKgft97OSaudIMk11BvPwkDJ_3M
Message-ID: <CAFfO_h59LQSjncu_4YE5YB+mt-FL2c1GN-jF_WtoKj1u43DcuA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
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

On Sun, Mar 1, 2026 at 9:17=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sun, 2026-03-01 at 21:15 +0600, Dorjoy Chowdhury wrote:
> > > >
> > > > I only added a kselftest for the new flag in
> > > > tools/testing/selftests/openat2/openat2_test.c in my second commit =
in
> > > > this patch series. Where are the fstests that I should add tests? I
> > > > think you added the wrong URL above, probably a typo.
> > > >
> > > >
> > >
> > > I did indeed, sorry. They're here:
> > >
> > > https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> > >
> >
> > Thanks! This is a separate git repository, so I guess for both
> > manpages and fstests I need to submit separate patch series for
> > O_REGULAR. Do I need to wait first for this patch series to be merged?
> > How does it work?
> >
> >
>
> No, you can submit them in parallel, but they probably won't get merged
> until the kernel patches go in.
>

Alright. I can look into submitting patches in parallel. Thanks for
all the info!

Regards,
Dorjoy
