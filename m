Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E3432ED32
	for <ceph-devel@vger.kernel.org>; Sun,  1 Mar 2026 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772377332; cv=pass; b=nlw0PYj/OhjGT7o4mFAZY5NgG/N4mfpTto/CHLjH5i0cXaWExXf3k04cJgVE/QxZIzztnk3gDO7b8sa8k1vVxNpeXumTlt6MvjUF27VaySI8hS233Ea3mxpymXzxD/no+o5LjWsCMadhl3SO/XddVCU9o9Jfpg4ICyyvzfDyWW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772377332; c=relaxed/simple;
	bh=V37CR9us1N0esOdbbifQtaXVD0Ciudjbj+QVzwLv+pU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5qEEENBmtdvjCYvRKwpgrWN6bqc4f4j46u2E2PEedNGjPOUrJN3NU1N1CASrALb1IIwl7I/Ev+VHjwYXd4ir5jILWkiPRpYcmC9ZWBxSWaYC9RC68YBsvbcEqHGUQGe10gM3L3YA2fgUrknVawt95pDJJZJzSh2Eknv1yKrqRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMBPcvuu; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMBPcvuu"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5fdf6ad2517so2261399137.2
        for <ceph-devel@vger.kernel.org>; Sun, 01 Mar 2026 07:02:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772377330; cv=none;
        d=google.com; s=arc-20240605;
        b=R7x7S/vPYD7IUXAfNpn+06AEMd2T+qbuz4oWpMGwAcprP7lFDxW6pQH22Vx4e63hCN
         VQ7hjFogYjKOrAOQOO7U3De69KAor1oRta/5RJopri16jf/t01q3FuG3DTsCe25Ohhyk
         X+WDAsFfHI5b8GS8UCtbSNabASNP/qGaQvbT8dTI/ycKQlbedPqEzG78mjWeGMN+i42E
         7h9bc1NxYoUwDXE0ciA5g51LcIgKKOylnmYPH/mRRPELSuc4ogzAbRXnaYDCCN1DjsA8
         hCvG9L2wmsqJyJ+U+tTq6X2e+zLnODd0as+2kMEtYfgF5eewk8hlucDGMJGxiqlc9nyt
         HIrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2DEbj6UlaLHWTSmc9tFmxEh3Nd0lpNrPuON3F9X96hM=;
        fh=YjAOa40POKhWMF+ex4qjdu9dmw7iV1KjiUFu6SvtsHY=;
        b=DGcXfvRpmYGAManO8JMGOKeUqvD58qkMzT0+KWxwnuaEvvoau+kS0EPB97Z/OMaCM4
         i0lnnYh4YnJCrooMNoXPl+F8lrNRHNovDas01LzrzTPZz5R/dvbb7Bqy+SsUZw72QO2e
         Ce7rRerbq7xr10N1C/9ZTylmctfbsepuIC81wtK9JrduQexAHklQRiUSRA5A3HZD79UM
         I6rVJ7dcthScdihE/eNr1JUp9zjrXgSBSle8Lh/hHjnaGGV2+eSACn1OuS8sTeWWyXtC
         KoRlexemyRF7u53M0xZBtjaWcrO9nxBZIhUvP1q/mO2htAzQSP+t1rVkvxMoUCTsmzX5
         Qzcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772377330; x=1772982130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DEbj6UlaLHWTSmc9tFmxEh3Nd0lpNrPuON3F9X96hM=;
        b=mMBPcvuuF06lWTN+/TyD56IA4ZxnV47aeOImyEfUxIhwJ8ARyQhMXNydHupIySiwKo
         3B4GrMVPoNudjz+R81qvW4zSrF+Kw/fQXKoE7x4eI2QD8v78T0YAjvQyyOqBukk3G9m/
         5hsmJm4bWhUFIuBmfeCtGcxJr/dNshVdKduoNXeFOQGX+Riq6k7FhXmdMiBAuPnU0LbV
         TU5gBV+m17qa2RRhmXg3iI4QOAYwHd+GG5MUuYQVxFwJkAWUAmy+yJa3WnouUGwW7wyj
         Nl+T+4tLUifJ6fmu976xdHtvP4nQhkkjPAwckmLn6Z4J+C+JWryxLiZ49no7EqpMmu/+
         LTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772377330; x=1772982130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2DEbj6UlaLHWTSmc9tFmxEh3Nd0lpNrPuON3F9X96hM=;
        b=Ss4jKnTY3WKdJQSpgxgwunmYssnEFzGa4MEETrn7xz/8WpXcF0ue8J685d2B8F5PZ/
         4efesMz0+XEKIB6sF5/a7koq8KjNU7niJSIWnlYYxysW35GTyYAQWfqo/xyZ0rx1kiK6
         WCuPxieeRBtxrl6F7Y40HIRJ8Z7A00MKw4Kd8h2Jg/1i3T1k9DK1NW2SvRY4K9adVuTf
         5jJMeAlOsw1+QZWGrVzZhsqmnAgL0sUxoMYRinkYsLew13o/Pun6n7t/rwwp2ad/KQzv
         dwierjfkeW8PUHzBKMufiBt408239IC3yoC/MhIL6gNpfbMzSTy6Bz4m393wRI2TOpRR
         3ltg==
X-Forwarded-Encrypted: i=1; AJvYcCXrlI8nN4rRugL0prjLVhmj8cd1mrEwBkozlj870oq/BJ48nTRCt2kE2Tq+bTjshh1aI0nc5XUJsPfo@vger.kernel.org
X-Gm-Message-State: AOJu0YzKn1yFwkseMXACTXOdtcERogHkmX/NxlZPjTEfHxJt/RAHJrAI
	Z5qp2qtYREUNuUHS4JT5UlC8s0nEEkFuTnzfr9S/P7BH3EvbLmyJyoDSlFs43Mnu4EgRy8uSSzp
	U7VwAroIDpfoP3Kj3BajYs4fFw0X1EdU=
X-Gm-Gg: ATEYQzyj6WdbSI00P5hATWN2N5Jons63hqNWpD9OwDGhY+uqyhpXSzaJk05xR16uEpx
	a5eZ8kxTTOfR8+Q3df8rF6nc49eLEC6gWkn62/BQLjspG8dLuSZdJsWdv3VmUZ1cS96ba9NjDEX
	2ZzPcCkApvWzdry45wZLVJ8fJvRN+4wv6UBMdthI9sKwu4ng9uFLjeq9KMREDYyVMV52u/jaOXu
	jjaVsmAxPJBDS+eAb1Ot0BMoopTRoFX/BtwicnEy1LPQdaZlA5sYFjhUt6JAHCdkLSVc7Q8VRuQ
	SD+I9jGRxH+9yvWF6Dw6EA8Tb8rYd5hwYqjrdAuBzQ==
X-Received: by 2002:a05:6102:cc6:b0:5ff:1445:88ff with SMTP id
 ada2fe7eead31-5ff322714abmr4377922137.7.1772377329579; Sun, 01 Mar 2026
 07:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221145915.81749-1-dorjoychy111@gmail.com>
 <20260221145915.81749-2-dorjoychy111@gmail.com> <2f430eb613d4f6f6564f83d06f802ff47adea230.camel@kernel.org>
 <CAFfO_h7i86qdKZObdFpWd8Mh+8VXVMFYoGgYBgzomzhGJJFnEQ@mail.gmail.com> <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
In-Reply-To: <ed5aeaa81ad9b87926fa7ebee0308aeb8df9f0ac.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 1 Mar 2026 21:01:58 +0600
X-Gm-Features: AaiRm50b25Ilp0U_HqmXYGEDuiLaRPqAldbyxEp-tlfkTSKlimm7-yBVSXDXKJs
Message-ID: <CAFfO_h5za6gV99TQS3pwHnf7zyCeVySn3CdRyV+_jFqjovGBqA@mail.gmail.com>
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

On Sun, Mar 1, 2026 at 8:47=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Sun, 2026-03-01 at 20:16 +0600, Dorjoy Chowdhury wrote:
> > On Sun, Mar 1, 2026 at 6:44=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> > >
> > > On Sat, 2026-02-21 at 20:45 +0600, Dorjoy Chowdhury wrote:
> > > > This flag indicates the path should be opened if it's a regular fil=
e.
> > > > This is useful to write secure programs that want to avoid being
> > > > tricked into opening device nodes with special semantics while thin=
king
> > > > they operate on regular files. This is a requested feature from the
> > > > uapi-group[1].
> > > >
> > > > A corresponding error code EFTYPE has been introduced. For example,=
 if
> > > > openat2 is called on path /dev/null with OPENAT2_REGULAR in the fla=
g
> > > > param, it will return -EFTYPE.
> > > >
> > > > When used in combination with O_CREAT, either the regular file is
> > > > created, or if the path already exists, it is opened if it's a regu=
lar
> > > > file. Otherwise, -EFTYPE is returned.
> > > >
> > >
> > > It would be good to mention that EFTYPE has precedent in BSD/Darwin.
> > > When an error code is already supported in another UNIX-y OS, then it
> > > bolsters the case for adding it here.
> > >
> >
> > Good suggestion. Yes, I can include this information in the commit
> > message during the next posting.
> >
> > > Your cover letter mentions that you only tested this on btrfs. At the
> > > very least, you should test NFS and SMB. It should be fairly easy to
> > > set up mounts over loopback for those cases.
> > >
> >
> > I used virtme-ng (which I think reuses the host's filesystem) to run
> > the compiled bzImage and ran the openat2 kselftests there to verify
> > it's working. Is there a similar way I can test NFS/SMB by adding
> > kselftests? Or would I need to setup NFS/SMB inside a full VM distro
> > with a modified kernel to test this? I would appreciate any suggestion
> > on this.
> >
>
> I imagine virtme would need some configuration to set up for nfs or
> cifs, but maybe it's possible. I mostly use kdevops for this sort of
> testing.
>

Got it. I will try to figure this out and do some testing for NFS/SMB. Than=
ks.

> > > There are some places where it doesn't seem like -EFTYPE will be
> > > returned. It looks like it can send back -EISDIR and -ENOTDIR in some
> > > cases as well. With a new API like this, I think we ought to strive f=
or
> > > consistency.
> > >
> >
> > Good point. There was a comment in a previous posting of this patch
> > series "The most useful behavior would indicate what was found (e.g.,
> > a pipe)."
> > (ref: https://lore.kernel.org/linux-fsdevel/vhq3osjqs3nn764wrp2lxp66b4d=
xpb3n5x3dijhe2yr53qfgy3@tfswbjskc3y6/
> > )
> > So I thought maybe it would be useful to return -EISDIR where it was
> > already doing that. But it is a good point about consistency that we
> > won't be doing this for other different types so I guess it's better
> > to return -EFTYPE for all the cases anyway as you mention. Any
> > thoughts?
> >
>
> There is a case to be made for either. The big question is whether you
> can consistently return the same error codes in the same situations.
>
> For instance, you can return -EISDIR on NFS when the target is a
> directory, but can you do the same on btrfs or ceph? If not, then we
> have a situation where we have to deal with the possibility of two
> different error codes.
>
> In general, I think returning EFTYPE for everything is simplest and
> therefore best. Sure, EISDIR tells you a bit more about the target, but
> that info is probably not that helpful if you were expecting it to be a
> regular file.
>

Good point. I agree. I will fix this and return -EFTYPE for everything
in the next posting.

> >
> > > Should this API return -EFTYPE for all cases where it's not S_IFREG? =
If
> > > not, then what other errors are allowed? Bear in mind that you'll nee=
d
> > > to document this in the manpages too.
> > >
> >
> > Are the manpages in the kernel git repository or in a separate
> > repository? Do I make separate patch series for that? Sorry I don't
> > know about this in detail.
> >
>
> Separate repo and mailing list: https://www.kernel.org/doc/man-pages/
>
> ...come to think of it, you should also cc the linux-api mailing list
> when you send the next version:
>
>     https://www.kernel.org/doc/man-pages/linux-api-ml.html
>
> This one is fairly straightforward, but once a new API is in a released
> kernel, it's hard to change things, so we'll want to make sure we get
> this right.
>

I did not know about this. I will cc linux-api mailing list from the
next posting.

> I should also ask you about testcases here. You should add some tests
> to fstests for O_REGULAR if you haven't already:
>
>     https://www.kernel.org/doc/man-pages/linux-api-ml.html
>

I only added a kselftest for the new flag in
tools/testing/selftests/openat2/openat2_test.c in my second commit in
this patch series. Where are the fstests that I should add tests? I
think you added the wrong URL above, probably a typo.

Regards,
Dorjoy
