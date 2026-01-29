Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405D2A1BF
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2026 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769645668; cv=pass; b=OcoP1IX0q2oGHDQ36KD4TaIrPd4GND5uqjdsRkmGm6ir60cLhMmUd5Slx3cYKBc4LN67ak1Rt5nwVhVsQZ2af5V6BA+dKrkg5xforunzK0Xmb1JiLTxJTNjND21XQIOvrU2sRKbSQRm1sXnZUC6ypPaWlr60bV8ncfgOmzMc4VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769645668; c=relaxed/simple;
	bh=50QxciPK3r2oBy6SEWNPjjqnjBbCd5zh9qbAl45kkHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0RtXlKQsHkKgoA4U3JQ9m5D5ZJcCY+8PzsvgY4/BdSAUTHKN2HXInnIRUsuv15fNvFhpEqy3AIr0nDzh/rAH4KziNrLcOHZxz5czHjRyAoudncQQQjEJaVc1kWEJwKxwVJ4B3ExlY9AXFMGy1wHftEMRWrNE6z8F8V7wanQra8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVUQ2HKU; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVUQ2HKU"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fbc305882so294387f8f.0
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 16:14:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769645664; cv=none;
        d=google.com; s=arc-20240605;
        b=ak6DpZ1ajVt/oukpUBTcbVz27Mf0xhZ/2vyFguUWeEycCq9C0hyBprJWK8DjfaVKEm
         WwZETSIeM7cRZW4oy206iHMbiqIeJyrICzKwKZn4AGC63Jpw91xZ7UdB683NttxX3vu4
         wuXiPT3MRAJnTwJm+4JPBpePmKn2ksdy0qTHJJXqYM0sS+7QCnOSw1ig0rjqNtNoG/sZ
         8fj73x71zX+o3jC127vA/ZJr+2L3ITWFpIuMMn6udtu1OOjttkfLL92WyffhLeBOInAR
         yHhKLCJdIKZrAwcXwESjGjZk/8CcwLJ/sFl8k5Ot6cuZrAr6KcsaMMXTMnpsJMRRs+J7
         4DQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rGmOA/3JEll4123vLuKI4WXr6YKJzEVRGrrPlIEjgXE=;
        fh=RRXAt/g3pe0YZ81jBgoENVOVbFZb3lwaeW1BsLpKHCo=;
        b=FDleC/rbtX8jT7VEdaITV+d2LkV38Q8VM8r5iHEKVXptSHPmQ5jY6mt0kXRl8VmEgD
         mff1o0QUX6c1Q/puEesyq2iSELyH6Gf8XSgZtZLatOcvF8AkAp/bWsaiMTiv65tVs3qM
         UpXPBKC/RDdXXwD+HHifwZbvZOaVBSbazdw20/UIkUOjJ2AsydxbMspBzlnohJZ8nDy+
         vD7KSaaGEkOQ9YrCXE22JEVGJHf6Hb6RPnK2ec/wcF8POelaa8Rf/1S6ty400Mf6yi6n
         dqW3u99vi6c8Pba8GC4qWorrWfFh7iWkLMqAJliiL6NWVFipkZmoF6j5xs8B49iQjxH3
         h2tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769645664; x=1770250464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGmOA/3JEll4123vLuKI4WXr6YKJzEVRGrrPlIEjgXE=;
        b=MVUQ2HKUCY8ijGQkSgp7RIMJQZnz+t8lh0g2V/M1u1TRJdl3B2/TeC+TpfqlfzJL00
         rkm45EgH3wv/l20c5jkvstSSiGGRFhabXt9kVLJusAGgQf9B2C+YZ0W9XjwynDKTOFx/
         k9eHCerYsaEqXrWbdq7OKwEBFPW/OeWiL6QYaPdVuih+Spm9VSnKvm1efPXnIOvCEKkW
         EjxuAjyx/VruQw8oEz2ejUUd7CVMYmN33JspSi1s5Dh8ujqiRSmLW+ieh7RU6AvrQk2K
         jrWppufKZXziiryjjEah20MzWOMmUz+aVc8fXfLbQAEkxh+IhWVvJZZfKhpP5CxubHFO
         zpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769645664; x=1770250464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rGmOA/3JEll4123vLuKI4WXr6YKJzEVRGrrPlIEjgXE=;
        b=ev8fuRVJsHRSet2nYwB17/2kwxjfrbGyEGUEsy6bvdSD4PmZxXTZ06HQ/EBhysqNjy
         M08p+9zP45DiQiTVWiA7mipb4aWTVRtRS35ErflHlSjKgJzJ0aWRIXtadRJ3oGIAfFvX
         vzv1IJ8o9/UusKbwKoa13itXlpOqrtTjdPy0AvHYT6rETOJNloHGHTihdOodgERUayHa
         N723KQ/gGHfsErL+VBOSPMCp9HLBQSJATuuKod3VWWRhsgC2t3PSvSEEgn/eUjRXl6VM
         CHY70aIANch4gmHHQK9TK58+2WItjUroXebR2hQkR2AcqF1wctbKacYAKGQoijGtKo4P
         S14A==
X-Forwarded-Encrypted: i=1; AJvYcCVUvF4OB8TImKGmGEVwZN2YNV7PWwm+bPmNmROuDkLK86eF2n8nrv6t3NKy7gf4bfbBTsi5iebWz2VD@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8tPFMN5Xh+0khkWwdPGLXfJ/YJbYVmHvlz9l/Y094x29swQKJ
	NztgXoDEoc1Au1MWyRzOBSCVQbA6LklUlhklT0hWyxRS/IxCrLVayWemWPC/N6zFIUmHwW/RRlT
	JMHy9QFXJql21R+JbHQuoWRgSvVSL+6w=
X-Gm-Gg: AZuq6aI7OOwuuQiDduHM4qUWrMeWZPA2pez1gNprzQWxPe4yNXR7AQQ/W0WLNgWDuQ8
	wdlLZcZfErgzHl3LenWvoboT1fVj5dJXAMeADZpmmEyNFrQFmtebbr/7HQKpNdsn+iX4h3v0XSr
	fmCK8QDtHGONLbSxIIfXilzt+zLZZFMgAtrtkaWdJtHMe85bsRTEzDz8UZlf9UGyzgbM8lkiwXT
	yUyLcjO8RgpXpvfXjgMbn3WIOJ3fGgPTVzEeVwveByb77XOUyodEXTNbckVHTt614tmKDnZI/Zu
	qdIfT1m+t2nqOamtwVUYcxMfLZFUKKnsUk6fJg==
X-Received: by 2002:a05:6000:26c7:b0:435:b068:d3da with SMTP id
 ffacd0b85a97d-435dd02d68emr9696633f8f.4.1769645664179; Wed, 28 Jan 2026
 16:14:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126023055.405401-1-CFSworks@gmail.com> <20260126023055.405401-5-CFSworks@gmail.com>
 <345540f12f8825ebbe067564fbd94bc1966e126b.camel@ibm.com>
In-Reply-To: <345540f12f8825ebbe067564fbd94bc1966e126b.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 28 Jan 2026 16:14:13 -0800
X-Gm-Features: AZwV_QjL7WSxd9V34GitdnckWu7SWbs9OPRvqVYyYiulbOgwVKmk2EglradscsU
Message-ID: <CAH5Ym4jsBiEHoyPnJh+dffGzuKuvaF9JOV2WX9_sU6V2NLqXxA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ceph: assert writeback loop invariants
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Xiubo Li <xiubli@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	Milind Changire <mchangir@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 2:54=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Sun, 2026-01-25 at 18:30 -0800, Sam Edwards wrote:
> > If `locked_pages` is zero, the page array must not be allocated:
> > ceph_process_folio_batch() uses `locked_pages` to decide when to
> > allocate `pages`, and redundant allocations trigger
> > ceph_allocate_page_array()'s BUG_ON(), resulting in a worker oops (and
> > writeback stall) or even a kernel panic. Consequently, the main loop in
> > ceph_writepages_start() assumes that the lifetime of `pages` is confine=
d
> > to a single iteration.
> >
> > This expectation is currently not clear enough, as evidenced by two
> > recent patches which fix oopses caused by `pages` persisting into
> > the next loop iteration:
> > - "ceph: do not propagate page array emplacement errors as batch errors=
"
> > - "ceph: free page array when ceph_submit_write() fails"
> >
> > Use an explicit BUG_ON() at the top of the loop to assert the loop's
> > preexisting expectation that `pages` is cleaned up by the previous
> > iteration. Because this is closely tied to `locked_pages`, also make it
> > the previous iteration's responsibility to guarantee its reset, and
> > verify with a second new BUG_ON() instead of handling (and masking)
> > failures to do so.
> >
> > This patch does not change invariants, behavior, or failure modes.
> > The added BUG_ON() lines catch conditions that would already trigger oo=
ps,
> > but do so earlier for easier debugging and programmer clarity.
> >
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  fs/ceph/addr.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index cdf11288d6b7..4e392fc70d33 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1663,7 +1663,9 @@ static int ceph_writepages_start(struct address_s=
pace *mapping,
> >               tag_pages_for_writeback(mapping, ceph_wbc.index, ceph_wbc=
.end);
> >
> >       while (!has_writeback_done(&ceph_wbc)) {
> > -             ceph_wbc.locked_pages =3D 0;
> > +             BUG_ON(ceph_wbc.locked_pages);
> > +             BUG_ON(ceph_wbc.pages);
>
> My complains are still the same. I would like not have BUG_ON() here.

Hey Slava,

I understand your preference, but as discussed before, the BUG_ON() is
defensive programming to catch an invariant violation earlier than the
existing BUG_ON() in ceph_allocate_page_array(). If the invariant is
broken, we'll oops anyway; this just makes the oops happen sooner and
easier to debug, and reduces cognitive load for future programmers
trying to understand the loop invariants.

Regards,
Sam

>
> Thanks,
> Slava.
>
> > +
> >               ceph_wbc.max_pages =3D ceph_wbc.wsize >> PAGE_SHIFT;
> >
> >  get_more_pages:
