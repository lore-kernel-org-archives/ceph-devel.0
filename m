Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5BC38759B
	for <ceph-devel@vger.kernel.org>; Mon,  9 Feb 2026 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665468; cv=pass; b=cPTdLHB2IjnxkL/GF2L9xZjXBoYtm3WRYiiBJzO7ZlebgqrlDn8H6OUxNWDfwlBg7pTpX6dNlwgUlDhCyVpgJmM746m+kTWUYKtVcQfg33p63mbZsXFB3oePkCkFFiTq2Vh7l0Dmkm6IhiMNR5i8iC2J4rsRL+sDrPTSF5+iMeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665468; c=relaxed/simple;
	bh=WffbCEqzcd3rwbdw8KW7tPkWtqd8imAfGA668jUKPAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gq3vDGmxlHcodbnKAuVJR2bo7pjP4kRSHAtHq/ikyYWSrBuin0/H1SOeqOYR0noNKVud7vCIt6MHHJJR2srYRfPDsnBYyMN84pYU+4zt6Ofb43Po96FHhZGGfC7zj+P0XIw7BKufBd1MJe6Yj3CKf3l0INsXYfvSd+mfYnc5w98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRYo9pSc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9JPSYDD; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRYo9pSc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9JPSYDD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770665467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WffbCEqzcd3rwbdw8KW7tPkWtqd8imAfGA668jUKPAs=;
	b=eRYo9pScm0JTqRGX4tUmHVsIkj2uYAUc7DPq3VoqKFSntBFHQ8u7iB9h80Rd4rcVptvOlL
	sC4CazPxhrBv7rpBXTIWISkJXoUkGlaIP31wINq0Hf/LXWMbagcvoNJvjz1I8LUN47WYvT
	uKZQ/6WkCK6Q+VAvfty4lAo/2Ajw12g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-Xm_erETQNJ2S2RsAaVRgAw-1; Mon, 09 Feb 2026 14:31:05 -0500
X-MC-Unique: Xm_erETQNJ2S2RsAaVRgAw-1
X-Mimecast-MFC-AGG-ID: Xm_erETQNJ2S2RsAaVRgAw_1770665465
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-352e214cce9so58645a91.1
        for <ceph-devel@vger.kernel.org>; Mon, 09 Feb 2026 11:31:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770665465; cv=none;
        d=google.com; s=arc-20240605;
        b=MHy51n3XdBForpAEckeUAUNJHrV40j6no+SfEgd5wX8I9Yl3UBje4VxhNEtwvv8EcN
         7uxCrNjxF4pmqlAKMAFVdJCH+FRMKXikrbYtN07BhVMAZ8YEMn3cRYAVYlVJ166gt/iB
         3O9at+dP1XI6p8Oo0bt3Df+2FM1LAu6GhNmZgEm85sOVLVqAUVMoD4EMsue0eSbDJBvK
         yalsaGqxdEUgKq5ksN57ulEUxsECOM6GLes+kMNyEcooNjbmG71KB4oQsBZ3GsFliiG1
         85myv1VoYNLqFJU8YSmPuFjIqyKmKGpoSFDznCJjln2f3omMKXxlAfOROwEpgfEpMHPv
         z9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WffbCEqzcd3rwbdw8KW7tPkWtqd8imAfGA668jUKPAs=;
        fh=4VGoo/ydrSYMM1xiJlrZnK5sbe8sCwqukMjzbh7F/68=;
        b=D8mgEU+U259MEEb+31Vu5ohzNQH3jhoDqF2yf3xGpYUvuTwgjY/ASCHs/VE65PnCrN
         JTGykAIQ/bo/SxSG5nLXdBMsyMvmy1pDtImt0h8PC08rcBllYn32EzK/TwfBDQ3WQfX7
         qg0zQOVHJeLpegvfu3bUb/VIpqq6TOHi/gdVE1iP9Mo75VRPB0QTVSErOmPADarBoFxb
         tYl+t81AKwNmWrKfDulScSEX8LEQaYxyKmY+WVulSOquwmxmIqlrQ0bUm8aCVsmrXnE3
         KCxC3Yyrh7KSOl22IcuZQ+i6ADkRCTXUfPgBZyKkJ8aC+kvzdQhbebpcAe0HeGG4spJ4
         7UUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770665465; x=1771270265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WffbCEqzcd3rwbdw8KW7tPkWtqd8imAfGA668jUKPAs=;
        b=V9JPSYDD/Yb4NsqjNjh5+U2hl8KZaw2HMRoe0IpnM4iGaSR2O/XDkyYRDF36/VVCKL
         IEVo0ZqnEN3wdQKt78CirqdKhdkmRtz8B4TttgQEymXx6AnvDBCaKO44FGHW37H97uqN
         25K/lNXg9E7aE4iXCQfJ5/cae3Fv+RqAwp5QCZzZcntqoLixu47ztyQHrhrukCvHgos5
         ayF7AE5UnAmo5jVh7sV8eG+OV3sO8tSBoT7vR2nVl5BNYEL2/46j3HmVyd6ALyyo0G2W
         qHj0Qyxzw07yNMWtMrRIGfuPREd56c+wma64nKOgSahEKtg1zGa67mqZrcC2ov1H6COJ
         1yJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770665465; x=1771270265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WffbCEqzcd3rwbdw8KW7tPkWtqd8imAfGA668jUKPAs=;
        b=elHkUxUTwbqc3tPRVT6/SCX6kQpb/oz/hFEipg1LmjE3rgvmLrdV1T7EoDO1ABaPUf
         4EA50Sv8KWeH/qIsZ1Mk4TzaN1K9KBCHpN8p9w2jwG4DSVbCt/hmpbt8JR38wypGrfWO
         /eNGFMYUF0tPznfEMlPNaw1yzRP9Keaeo7U5Ro5kbwtm1GJRZyI8HX1F3668/Rq+WWRp
         H7CX43JBVgR3JzAhnhSeE9k+40zvXLsRcjQd5Cg5xeHQmktkat96TFctPr/55no/GE7K
         pUDQXOWqTEWzFI3f484lvJ0Ncy25aW6Tn0YQEcRtyt4RN9283FoifwdlvxA44HVv/hvn
         crMg==
X-Forwarded-Encrypted: i=1; AJvYcCXGRmQxRwMJkh3GJdd+oZHYViIazlKe8NBnFmtK+MkccrkFySUzOKJA2X77breC1+ug04eS4FDghDX9@vger.kernel.org
X-Gm-Message-State: AOJu0YxcQPWp4ZBoMz9DOuMZluAkQqN1xmK174PB3nGC8p4ZDC/F6Euf
	zZzcZXqW4m2mryxQBDfDyxBKndefRYbzeqsJUradgONXDoT8GDUCk0XwKltLnfQ7MLwi/kEYWSn
	J467bbfZplgaFmN8AFxfS+OMGhd+v223F7O8HGzrlbtlutnRbSVMS0YWUE/QyPUYLqzLcPgTUtL
	opTQkTu+I/t5nsLFammnICeZmsJ1Vhu+qPlM1d/g==
X-Gm-Gg: AZuq6aKGGgCA8jVJCZv7bV5PvbDed6flJjB8Zc2tWYj6KyLc7HwtXftLUhZSjSngRCg
	1jqZ0ItRyGPxJSoYT3ZlvBeKYJsBHkb2sKji99S3gN5C7+2v4w/JiEitIUyd8nMTwgTGXP6rUGL
	ZsrDHNVVbCJ7Z6Acu/aZ+jDld4T/XWjjVetDxe4q+0RXMvl82KvHk8MIh2UxP/7JYdCjN3BtRw3
	1JzT3aRjmQR9fmTs+i1t6BAhQ==
X-Received: by 2002:a17:90b:314c:b0:34c:9cec:dd83 with SMTP id 98e67ed59e1d1-354b3e4b663mr11325013a91.27.1770665464674;
        Mon, 09 Feb 2026 11:31:04 -0800 (PST)
X-Received: by 2002:a17:90b:314c:b0:34c:9cec:dd83 with SMTP id
 98e67ed59e1d1-354b3e4b663mr11324989a91.27.1770665464260; Mon, 09 Feb 2026
 11:31:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aYN-TBrwARmBBuHM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <d0325ea755f153558ac2c8e8501a3cd9980b4ea8.camel@ibm.com>
In-Reply-To: <d0325ea755f153558ac2c8e8501a3cd9980b4ea8.camel@ibm.com>
From: Gregory Farnum <gfarnum@redhat.com>
Date: Mon, 9 Feb 2026 11:30:53 -0800
X-Gm-Features: AZwV_QjgNoNiK9LFT9-Pc0-EzGf-Y_6IhE5XQ-GoDVCI8fbWEN-uYkVfyvD0XnA
Message-ID: <CAJ4mKGb1KZ75-j3ZZcqiUD+r_dwQ-zhxOi43Ub6qqHruOat0=g@mail.gmail.com>
Subject: Re: Exploring supporting fallocate() in ceph
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ojaswin@linux.ibm.com" <ojaswin@linux.ibm.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Patrick Donnelly <pdonnell@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 3:06=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> cc Patrick Donnelly and Greg Greg Farnum
>
> On Wed, 2026-02-04 at 22:43 +0530, Ojaswin Mujoo wrote:
> > Hi team,
> >
> > So I've been trying to understand ceph and cephFS and as a part
> > of that I tried running xfstests on ceph. One thing that stood out imme=
diately
> > is the amount of tests (~150) that we skip just because we don't suppor=
t
> > fallocate() and fallocate(FALLOC_FL_ZERO_RANGE).
> >
> > Thinking in the direction of what would it take to enable this in ceph,
> > I came across [1] which suggests that we disabled fallocate because
> > it was not trivial to make the space reservations known to ceph.

Right. It's hard to even sensibly define what the various fallocate
options should mean or do on Ceph, and then making them do those
things is another challenge.
But to be clear, we *do* support the FALLOC_FL_PUNCH_HOLE and
FALLOC_FL_KEEP_SIZE flags.

> > Seeing how fallocate is an operation commonly used by applications for =
various
> > tasks, I'm just wondering that would it make sense to explore the possi=
blity of
> > enabling fallocate() and FALLOC_FL_ZERO_RANGE again in ceph. A few appr=
oaches
> > that I can think of are:
> >
> > 1. Explicitly write zeroes to reserve space. This is not ideal or perfo=
rmant
> > but maybe with more and more hardware supporting optimized zeroing like
> > nvme WRITE_ZERO or scsi WRITE_SAME commands, this might not be that bad=
.
> > Also, it can be argued that this might be better than not having anythi=
ng at
> > all?
> >
>
> I think it is not good idea. :) Because, storing zeros and keeping zeros =
in
> storage device is not very good approach. Especially, it is not good for =
SSDs.

Everything in Ceph works hard to be sparsely-allocated on-demand. And
unlike a local filesystem, which can handle fallocate by updating the
allocation table but otherwise not touching the disk, Ceph doesn't
have a central allocation state =E2=80=94 every OSD handles its own data. S=
o
even though the RADOS wire protocol supports a "zero" op, all it
actually does is truncate an existing object down. To actually
zero-fill in response to fallocate, we'd need to transmit all those
zeros out over the wire. For a small fallocate of 1MB or something,
this is fine =E2=80=94 but a common pattern we've observed is that if using=
 eg
a disk-on-file image, the software would fallocate the entire size of
the disk image before writing. If we get an fallocate call for 4GB,
that's (by default) 1000 objects we need to zero-fill, by transmitting
4GB of data, for an operation that most programs will assume is
handled in constant time with bit-twiddling.

> > 2. Since the issue tracker is 7 years old, I'm just wondering if it is =
worth
> > looking at the ceph infra to see if we can support fallocate in an alte=
rnate
> > way.

Fallocate does occasionally grow new flags, and we definitely want to
support the ones that make sense. I'm just worried that ZERO doesn't,
and mapping the semantics to Ceph is difficult and sometimes
undesirable. So it's not a question of "do we support fallocate()",
but "which fallocate() flags do we support". And we need to talk about
them all individually.
Also, support for fallocate flags are widely fragmented, so most
programs which make use of them are prepared to get NOTSUPP on any
given call. That reduces the pressure for us to lie or do something
terribly suboptimal. :)

(Note that I'm picking on the zero op here as it's one we've
previously discarded, but that's not set in stone. Maybe there's an
implementation or an argument we didn't look at last time around.)
-Greg

> >
>
> Patrick, Greg,
>
> What is our position related to FALLOCATE? Why have we disable it?
>
> Thanks,
> Slava.
>
> > I would be interested in exploring this however since I'm new to ceph I=
 just
> > want to reach for any insights or pointers from the community.
> >
> > cc @Slava since he has been helping me out with ceph
> >
> > [1] https://tracker.ceph.com/issues/36317
> >
> > Regards,
> > ojaswin

