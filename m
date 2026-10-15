Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA5D3B4E8C
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093533; cv=pass; b=JJro3TqK5H+OSWh3gj+bMrQzpy9/aqKSZyKvI9jHxKMXfKIdCSNeh600rgNV+B03EHVSLVrjURP0Pn6lmGLSZMEDqn1CaLOqcpJe8822qp3Qf1usKPAbf3s4lHVsVskLQEmwdP0VXmcHskkOoxfFt8wykLQAy+0P19ewJPXkk2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093533; c=relaxed/simple;
	bh=rUeS/xuQsA6DpulQ5gLZTPgWyt3PFheEdxPEtDmQpAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Azy+odd+uQ+2CG5fKfzrCO60KQZ6DQBhd1enzvZsxx+ejDpghcYDRCwPxESdbXij1A3Mjk5l8BFpIOShzFf9ImlMugIl21YNfv2noqZvi8mo7WTE9hUa/T2X3Y1WPntzBIiZUapJ1VgYX31ruZ1oOKoC+qTx+pkQq9iBmxMavlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CkeK1Meo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YStH/6zs; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkeK1Meo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YStH/6zs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792093531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/jCg/YDFTxo4rxhpppNdODIDqzYkL4lcpoJNVladB8=;
	b=CkeK1MeoZkoVWk+LxXD4mCT3yHaqcyKdBCdT1ffomQdBX4UfZhcZTVPoGhW+FMdnguM2Iy
	PCDD2NFy1dUMi1xARwIQYeCDsv/OLotbJafeYunB+DoYlVmiNjf3J90vwM3PV0AvID6mIe
	qyU8z5yeOc8YpnRPTzu/8cfbPa97WYY=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-lkUbBMPbMGqsJXULTmDUqA-1; Thu, 15 Oct 2026 19:45:29 +0000
X-MC-Unique: lkUbBMPbMGqsJXULTmDUqA-1
X-Mimecast-MFC-AGG-ID: lkUbBMPbMGqsJXULTmDUqA_1792093529
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5e95ef10aeaso2051892e0c.2
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 12:45:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792093529; cv=none;
        d=google.com; s=arc-20260327;
        b=UEmvvQbD7ScwC5tslDe1lGKjsm2x07KlvLsJduM3YeZ2tnaU2m3qezjyNPhh/KaWuN
         wAJh7pk6gRQXUUkZVCMbIRHawjsqM9G+Y17mBclaTLbU9HSzxsYjeq8DuDe5psCUC/nM
         xA3+TA7XzMfe5jgnZNjbDNRdXfsekYDqq5sZIZSFhP2/gZTYNUy/PAg0CgFFY0Wrl/Pj
         6MvvIPFoRjp+F1G1XiT123Lbs8HtFL+JUhI5XcXfwat6AQ+CZWQzF7nCbdIp4mAPsgJ3
         1lUUsUBtXKYO6/jsqD8w+Niiuh+PW8YG9Xr5IMfTmUBk6BeiBDIw3g5DNjUwV61fr7od
         7ffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e/jCg/YDFTxo4rxhpppNdODIDqzYkL4lcpoJNVladB8=;
        fh=c5c+/4XNYp9JDBRny9mOYiIKAhhdx2JrTzS09+L9qc8=;
        b=kaNYNo47osEP9FyABZeR9W7m0Hkk9+eKXo3p0QEdKGc2jMXGWA2gUuTJl/yX4h8c6y
         nJUkslmj9JVLwYku8nAXJO4XuDStQGf1b1H/9qzxzqpKntXhnS02CdwHbpkhh7nqzDkU
         yskc0G9H0G6/7IMCuyxdqvnmYHSv0VGICqNGJ1RuXJxT8Yakfrmxyl1Zu+THjiEhGGVg
         w/iLAkySio6BBZvUofaltkCFbJ+ot/96Y5vwBsavkWFdtkqXCuWepTD3kvT2iwwkUUZh
         VfiPy05YILukD5+GR1jDPw+9rOkAHlxMmAC67iKNywXjCNukMmxhkGOxwtdGZVq+zolw
         wX9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792093529; x=1792698329; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e/jCg/YDFTxo4rxhpppNdODIDqzYkL4lcpoJNVladB8=;
        b=YStH/6zsrUgqq738WWc3YwiFice/4xeIcv2E3LZpYhV3u8nRzceZ9RkXTR3OnHLQQW
         EIS+7Pi6mVZggvRQdvdDfovtmpiBH16/tjiZzWDLFWv30I6z6EwsBNrcXG3Ag5ZiCBtS
         Aj/Pn/bxEL1ok8uDMMRxH8pdJTIJJM44L/XMS3sg24yKdPiytGTngO4wDZaimU1ULBYc
         qgsXaHT1DV/eLLd6PoEHtwihMKS11eQvQYPesrIXr+K/lWy9wRKgolFLJBXLlTj7jnT5
         4KQlI/FJ9X7uTRPWWNAC/uBV53+8BL3EVxILBcxuBFhoOq5XlxBMJ64MEsPP/Jy0BI52
         dbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792093529; x=1792698329;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e/jCg/YDFTxo4rxhpppNdODIDqzYkL4lcpoJNVladB8=;
        b=pswPuWb3rpPe8R9DejIzPo+oiCAqO5HEmsILi2rNCHLhuTxfNInrcxJZ5puEagskAx
         ZS5CoSqAJxF6bfIi5f4ll5HjUPSMdKoVJE8Wbi62FbrnCvqyZvfN+d2QbAsBrqhAyB53
         U/uHV9fXZ1tpG0n8mDV94+Y0jxxhd/+x7oJyzEar9Lzh9tnH2oYitJzNDbEmcuKHCr0X
         2Z5BeVrDcFdZHQVieo2ld4Z/GhOwyeGRvc0hDHgG+OsGEyHPzSDjrl/48jaiEbgNpk+f
         0I19F1GOACnuh4cPaHBs+LinSomPfn22aaLFqxlLpMWS8gFuEyjcTH1z5knaE83iuukD
         IN+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzi4AOZHM/8RrSGJyclpVc1M7MXOP1ss0n1VNio0017r3ET9MzvCqPVHBYeq7YaaDZ8XIqxxRWVfor0@vger.kernel.org
X-Gm-Message-State: AFq9FYKmbX0c1R6zy0X8gdSOxtROreQDodAvwUHlr7av+uBhCO0gF1dN
	MCFGxJ9dLAeo4FI2Z1PXeVvAM9HPGsVfOKR1yP1FfBCEItm2ZkXyRDGI9rBL1/gbRgznp+5GGmF
	zb1URbtmZ+SxPwTnNR3wwE4hAiJShGajBofHC45KOdWgQSgt+ogKxdhzDeWZ+Bp7dwzh8duQGBK
	ZEUIThuEK+/3DYJ2z8NTThKo06App1vLLOrIcpsA==
X-Gm-Gg: AYBFou04yRZSONYgz8HZk9S7E7UVfsbG3E+4jxJjcfRTUM2TRDIcf19GZOmDKbPCD4S
	XNbokH10mr6xcoxuThbnVHJIdac5fsbKexnv0Iyh0NjAcLZNTmrAU7r+qst2QSbN0JfojgRyvdJ
	K1H/S2KZUG3mjDvK+WK3H4FVKJljkMb1FAQLX6Cb+eWvLhxH4CUPnifux8SPlKut8CueRRgz/Vd
	xU0um8CRAtNaej6GwnkYIBDBHmDTxhYUBpuKqNYb+ACy8fA+ia+ya58udq6Yd3YaVGibFUp9Y4a
	vY9HyPo8fHGvfghvLNarQTDCyQ==
X-Received: by 2002:a05:6122:3d0b:b0:5e6:82ca:c551 with SMTP id 71dfb90a1353d-5e91f591b44mr7262724e0c.22.1792093529006;
        Thu, 15 Oct 2026 12:45:29 -0700 (PDT)
X-Received: by 2002:a05:6122:3d0b:b0:5e6:82ca:c551 with SMTP id
 71dfb90a1353d-5e91f591b44mr7262713e0c.22.1792093528527; Thu, 15 Oct 2026
 12:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a01d0a297a3e174d21741a3ad586ce546327603e.1792081664.git.amarkuze@redhat.com>
 <20261015183548.GE2170687@google.com> <CAO8a2Sjr6XSizdgobZK1ZAO8PUd5tCDFKjdD-=3TXHwqOU6qfg@mail.gmail.com>
 <20261015193800.GH2170687@google.com>
In-Reply-To: <20261015193800.GH2170687@google.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 15 Oct 2026 22:45:16 +0300
X-Gm-Features: AclHuK-i9Hsh1nRovFHiSF3i8Hp7Cu5cMuuh8GOgLNjfxQfG6bb774db-F-FpUQ
Message-ID: <CAO8a2SgiFTarbcg-qgTLgjk1RsOMLwHsjj9ko8HgT99F1DAYrg@mail.gmail.com>
Subject: Re: [PATCH] fscrypt: allow filesystems to disable symlink target caching
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubo.li@clyso.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I didn't want to conflate fscrypt patches with Ceph features; arguably
two distinct patchsets.

I will CC you folks when this is acked then.

On Thu, Oct 15, 2026 at 10:38=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> On Thu, Oct 15, 2026 at 09:52:11PM +0300, Alex Markuze wrote:
> > Hi Eric,
> >
> > This supports the concurrent CephFS subvolume quarantine series.
> > There=E2=80=99s no Fixes: tag since this isn't addressing an existing u=
pstream
> > regression.
> >
> > The quarantine series adds checks to Ceph's ->get_link(). However, if
> > an encrypted symlink target was cached prior to quarantine, the VFS
> > bypasses that callback entirely when following or reading it. While
> > the target data is still valid, access now needs to be denied.
> >
> > This patch adds an opt-out for symlink caching and enables it for
> > Ceph, handling the encrypted-symlink case for the concurrent series
> > without affecting other filesystems.
> >
>
> That series wasn't sent to me.  Is it
> https://lore.kernel.org/r/cover.1792074165.git.amarkuze@redhat.com/ ?
> It would make more sense to add this patch to that series so that they
> can be reviewed together.  I can potentially apply a prerequisite patch
> by itself, but we'd first need to know that the rest has been reviewed
> and will be accepted too, otherwise it will be unused code.
>
> - Eric
>

