Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A1B665
	for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2026 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770711328; cv=pass; b=KCwdKg12nrYSec0NFneTncf3tzoX7xfJWgtFfSaxVaYWpiErJXbC4NDgChMU+p/Agkf2DlCt2Q8zbGP+mzXX8nAPGKZwJ1PX8DkpdzQYXJO78kc157WSGG5//S8RnVGkNZlVIgg1XgAsU0PfExP2bYGzo1ghKYOy+gkOr9YUa60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770711328; c=relaxed/simple;
	bh=7zUUa260y7Lreyi4GWgMkRztf3n7bjNj/UDE7A6snAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fo4mgc4pQuPkTTv9j5g/YwCr/xRqbaFwJ5xUAEeQK5xB0hUzTinBCpJHAoB8lx86tkgfPFgpkPhrTJGCKhbEYswClgwRr4E7U+IredEDhFVoouBt7hCxvz+1cqhTvgpKsElwgHte4u81CSWnoc06qMfxEVysBrW3vs77Tn6uiIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1/rR+42; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1/rR+42"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12721cd256bso1694371c88.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Feb 2026 00:15:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770711327; cv=none;
        d=google.com; s=arc-20240605;
        b=i+ABoI+j+6kR27jgW7BKLwQ3Pc4TzUgjRHOObZBIoIai+mKo9ti+LK/KuARPPxD5Vd
         AhxltzMuP6Rtb55Pn83glOUEns0jrTSLN1BqTTpiozzUaPPqMfCTGu9V83+J6HYJtej3
         xXnsYR+9dJPdcl9y8kPsLx9i/yYUqc2kex5aFRt+LipHgsRU3VvY2bC8gIzGM8cjnOYH
         NiYrnwFN7Q9N6veu4d2d3O4RLTPs+0fZeSlNGnay99Hrh4Ygis4Gi+P1FPevCuLCH5mg
         H4WbWV0tdJqCKyhXxvHQCaH/CiJ2/bWEuHWzK3Mi+6Ga9g0n5bwTqjsI8hhUbfiHAOxg
         UV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=inVHyqBzWFkNK/NR/mqYzuWdR2fxBPksyqke2wUosQY=;
        fh=POBX4LJhNwdVIOtw/5M6KxM9feCdg7OqXaLY00Fi7CE=;
        b=IbgeiQONC3ngGX608s7/O6GOyH0LVbIMVgyWKcmAtGl+/Y+P4GXJo9xY81nqwp1Mqe
         Jj2MW4+GWbU968ZJoKbB5MU8Xo1jtzF9EqhKUaOBHDVriWyMKWvVBTxUZA40NyJ1uGr2
         0PJYEhOIVR0TmrVSYTwiCaTm52+yZ52bhxokeQihuLj64oT/Z/tPxHMHwxH3PeHrN4Zl
         VOFcqqIbKzkFLdff1Ix6KM6eqxWjl80HG0s5D8cZDJ4LGJsqR2oaiWASe+Q3nVtGOIzs
         Pje0a6bYKUUwFMqtkzjiTlZFmkJ8RtwP9ILltXeVdPP5+ln0UHgjKoXrZ66n6e4FsrJW
         HH8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770711327; x=1771316127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inVHyqBzWFkNK/NR/mqYzuWdR2fxBPksyqke2wUosQY=;
        b=A1/rR+42zaUh8XdzZHKOc1S2mw15fenU4CQ12L5M/VOXWpaVbnDGwTRcLQ2gaOWu79
         BOSoCngvZIW18KSSGOesiTJ75I0ACXkcaOeOQRt50VAFuZPk71+To47TtVQfgjwxF9dV
         SyGYlcG8NI63zIFYNwiqGMzBPtd+N6+QWTQ7Whl8JB68UWqKNwd+ihtVfI0icsc5hkJl
         7KuvsC/T+mHA0WlHZFPUWT5LOUs1STrKpxYnCLimDNIvvyso8cOvLJnIIHOjpanigIG7
         VPTkVRq3pVZica0+jg29xbhy0eDI7uR3gPUNXvgZP7aHK3G2HeieGb3YEIL8jFndXod/
         aoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770711327; x=1771316127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=inVHyqBzWFkNK/NR/mqYzuWdR2fxBPksyqke2wUosQY=;
        b=bKt+PBQcQKjSYCiGtwFKfoWOuSW+2/jRAkNjU/tarPPjHno1k1RYKvdB+IvUDocObH
         yFgO65D6OmXhYe3CJZBiYozEN5WAs7NlfvdByoyELYuB8XMIVCdxQS7hUpfmKQVvPvSZ
         iF7lGL+CBZCuZwFbRiVuhovJzmw/0fXuEGaxw16zGaG/5HGjS9vihxI9j0ZlPYj8CGsW
         rkOyhtHvE1E9eMGWx8yRrARtpd0FteWqTujeHCeEu1BIgeHyOo15Wg2YTiVMLBpEZuUQ
         k0ka8DEdSgz59qLwk9LIQe45c86GjWG+wBnEEDV4BGlFQnG+UeUwmmwIrEbwj+cEVC2s
         8Vcg==
X-Forwarded-Encrypted: i=1; AJvYcCV5tcXo/hQ1fcpFT7Y6S8JISdjkXvWrWVEDFS8lUJWhL0MoJcvAKn89CTyrPoCpz7GWHo5EyiLfq2Sw@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk8xd4dHsuS1PeVVnn8OlXLBKedMs0jEfn+UznL7Yh9q+pVXCd
	WXlRT2UWvzqbJKyVXHuMjVKs0sffEAaZ2i/3neGEhloqUoVomw1g5RbBRvV4JRIdUdmk6HT3y1X
	/g+yAmvbRtIUaJoVtHHX15mY9pZwpSlk=
X-Gm-Gg: AZuq6aJZtRaMmcyqQvdiTPzE0dyM87p/YmJERWKYCyyY94crZFuoXhHRUsDh/JxRivL
	o3/PQJ+XYatr1LQceIDHsR3dyWE8eyYC3F0U2AWmH+EK28ROo9LRttain9RaLu8/vUnyrJf23Ed
	lLeZ+q5BbvvxfRRXH9RjN3xsFl2p70oouRQVRhFWzVkyO1TuB67yh36wDcqYbaHdVHkbZ1xv2D2
	mN2hgdk4Pl6VXkG7egFD3ucS19buS5WA18qrsXxD5imHmsCxcGnbFnSCAvizo+s4SQFSTHrqCgF
	hFdLrn0=
X-Received: by 2002:a05:7022:a86:b0:123:330b:398 with SMTP id
 a92af1059eb24-12703f51b55mr5824225c88.19.1770711326559; Tue, 10 Feb 2026
 00:15:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aYN-TBrwARmBBuHM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <d0325ea755f153558ac2c8e8501a3cd9980b4ea8.camel@ibm.com> <CAJ4mKGb1KZ75-j3ZZcqiUD+r_dwQ-zhxOi43Ub6qqHruOat0=g@mail.gmail.com>
In-Reply-To: <CAJ4mKGb1KZ75-j3ZZcqiUD+r_dwQ-zhxOi43Ub6qqHruOat0=g@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 10 Feb 2026 09:15:14 +0100
X-Gm-Features: AZwV_QhXLV2Z2GetrLLCScB5gNCS6eh2iGKRdJrcWHcO53mw6C5WYKoG0HA9ObY
Message-ID: <CAOi1vP9dgO-CFUpUdJ_w2OcAYq+YDKwJFk+R2uQXw_jyy3DTxw@mail.gmail.com>
Subject: Re: Exploring supporting fallocate() in ceph
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "ojaswin@linux.ibm.com" <ojaswin@linux.ibm.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Patrick Donnelly <pdonnell@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 9, 2026 at 8:31=E2=80=AFPM Gregory Farnum <gfarnum@redhat.com> =
wrote:
>
> On Thu, Feb 5, 2026 at 3:06=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@=
ibm.com> wrote:
> >
> > cc Patrick Donnelly and Greg Greg Farnum
> >
> > On Wed, 2026-02-04 at 22:43 +0530, Ojaswin Mujoo wrote:
> > > Hi team,
> > >
> > > So I've been trying to understand ceph and cephFS and as a part
> > > of that I tried running xfstests on ceph. One thing that stood out im=
mediately
> > > is the amount of tests (~150) that we skip just because we don't supp=
ort
> > > fallocate() and fallocate(FALLOC_FL_ZERO_RANGE).
> > >
> > > Thinking in the direction of what would it take to enable this in cep=
h,
> > > I came across [1] which suggests that we disabled fallocate because
> > > it was not trivial to make the space reservations known to ceph.
>
> Right. It's hard to even sensibly define what the various fallocate
> options should mean or do on Ceph, and then making them do those
> things is another challenge.
> But to be clear, we *do* support the FALLOC_FL_PUNCH_HOLE and
> FALLOC_FL_KEEP_SIZE flags.
>
> > > Seeing how fallocate is an operation commonly used by applications fo=
r various
> > > tasks, I'm just wondering that would it make sense to explore the pos=
siblity of
> > > enabling fallocate() and FALLOC_FL_ZERO_RANGE again in ceph. A few ap=
proaches
> > > that I can think of are:
> > >
> > > 1. Explicitly write zeroes to reserve space. This is not ideal or per=
formant
> > > but maybe with more and more hardware supporting optimized zeroing li=
ke
> > > nvme WRITE_ZERO or scsi WRITE_SAME commands, this might not be that b=
ad.
> > > Also, it can be argued that this might be better than not having anyt=
hing at
> > > all?
> > >
> >
> > I think it is not good idea. :) Because, storing zeros and keeping zero=
s in
> > storage device is not very good approach. Especially, it is not good fo=
r SSDs.
>
> Everything in Ceph works hard to be sparsely-allocated on-demand. And
> unlike a local filesystem, which can handle fallocate by updating the
> allocation table but otherwise not touching the disk, Ceph doesn't
> have a central allocation state =E2=80=94 every OSD handles its own data.=
 So
> even though the RADOS wire protocol supports a "zero" op, all it
> actually does is truncate an existing object down. To actually
> zero-fill in response to fallocate, we'd need to transmit all those
> zeros out over the wire. For a small fallocate of 1MB or something,
> this is fine =E2=80=94 but a common pattern we've observed is that if usi=
ng eg
> a disk-on-file image, the software would fallocate the entire size of
> the disk image before writing. If we get an fallocate call for 4GB,
> that's (by default) 1000 objects we need to zero-fill, by transmitting
> 4GB of data, for an operation that most programs will assume is
> handled in constant time with bit-twiddling.

RADOS also has a "writesame" op -- if used, zeros wouldn't need to be
transmitted over the wire.  The operation would still be linear in the
number of objects that need to be zero-filled instead of being constant
time, but the constant factor would be a bit lower.

Perhaps RADOS could grow an "allocate" op to also spare the actual
zero-filling and a counterpart "deallocate" op?  Currently the "zero"
op has implicit deallocate semantics which e.g. RBD relies on and it
would be great to make that explicit.  (The "zero" op doesn't
necessarily truncate the object -- that happens only if the specified
range happens to overlap the end of the object.)

Thanks,

                Ilya
