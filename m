Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0696F19AD5C
	for <ceph-devel@vger.kernel.org>; Sat, 18 Jul 2026 02:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341062; cv=pass; b=FZJ+SQSTojGE2zaLXjP96puJXUV6b4IBooMS0SWd30YUjZC6CROGj4RN0IB68nldliYt3i4mSJSmRTyn2H0ZDqqzG9HN6iobz3rYPWkyWD7lh/APGT+cfBUEUdKhU3Fj5wpUOQ0U29u6BeV0C6VxREZTekC71ypJAddCa17MYWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341062; c=relaxed/simple;
	bh=ER829aVlJEN7uAPRCihDfe5yQUBijkRwZ1oEYdfRD0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neDWliq6GL7Jj1ZKud6GDUrxgW+/Zb2Ptck/9EMGKFbflxVVyboWMYWocNgUnUAQV608BusRWNxCfW9UphObAVemcgRrk6DibwjJqnXOnECJ1rwhVZw0kc8ti/jpDzK+73eHNpgApwlgaG0Zo79IxZkgDD9rHJFcWKTJoVrPm8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=L7LGueeY; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="L7LGueeY"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1677c91969so443473166b.1
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jul 2026 19:17:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784341057; cv=none;
        d=google.com; s=arc-20260327;
        b=QCE17j59EiPpZmCTVd7OALU/MX0XJGgfQDwhMqcdmYrngF53LlnEsuKdgFRbeIaIEB
         CN/97bbYgeAiFvW5rDrrxX0bOEJn027/VRJk/s2t3B1mQor2FSl2fDRQWWMWG3W1KR23
         ILRdXyREogEOM9a3yTKUNcAB5yjQss77FVMWY2SpUFFd+2uyLvpa3fkf+CYa32WvYnyB
         mLrYU31NNvXiXpcuHoMbBQoC9Aw4LKTtVHm7EVfM7lWYFFG2rgqxxGBD9Kf2wmccjO3t
         ggp741zbpMj2gHd+uocsAEHLNrFF00xabNQHufpjjXzTkNgr//GRZgbmpPeELpVAbeS1
         oz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=etbPd5gszAC7C4ewjZ+ZWZllDbwqEbTypTzhuWJRkDA=;
        fh=EjqezAPaSlW/BKbATfL8mRNBpVL/bFFr0hkeePrGIR4=;
        b=lnoBtk4CdIx7u1UsrYSt8SG7eCjq2bi4owaYeFpX6PbYU8ysP+8mdg9ZSSlbFv/vos
         hdaV6S/t711+tNI6oA5e/Sev6oYg/FTcVm976HF99b8LpMqjEyLffr1USc4I70lZwAHY
         x8Ftwih8l4J9WHSvvkm9kqIekjUasuRbjkI5bXdNOj1X1Ca0qhGJd9NRARrjGUMo7eHj
         +qQIPcm+eh6iRlyHYU8TdUoGn7MAxHB8CFZvYO6YPMwRSXAKsX+Ts6XDyFiL55nV6Shh
         oLYo+cqyTBU1AIb8odjfDB/rFE+NsEWqlojXE7q0HnyTR/4yC79apJ/2DE43k0e7aq9q
         j5Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784341057; x=1784945857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=etbPd5gszAC7C4ewjZ+ZWZllDbwqEbTypTzhuWJRkDA=;
        b=L7LGueeYT1THhOCPOi2yhwD6vYQ5mP7Dv59hPEOxQIlbPvdGOEH0SgUGqHcNaaNXTU
         5v+yx2A1b3XuAqcdw3Qb2dF39HSvfYCtLHv01CD5JLOw0lbB2VRIIhAdbYcI0aY/QXkB
         WvGjPRwqUSejGklsrKKCLOTEBpxqAbCsEHxab3V/f419wsQrgBkfSiJmj1C1KRzP9Slo
         jBP5gvDNv4CzrMOdyo2N91bn4VTab0WhEhnEQO04Kul0W9nM6k+BkVRLcsHmPPoy5LPR
         svx/ZEoR+5Yugpqes00CapepGUslR8hTPsj9oHQnfapC7AkIuhC7GjCL/NOeGN6QbrfO
         1OQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784341057; x=1784945857;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=etbPd5gszAC7C4ewjZ+ZWZllDbwqEbTypTzhuWJRkDA=;
        b=mRQ8tEc2ITdR4UhPZiz1yjU/Q3c+ZfwGTZBmb8mLpElGGiFsQnSl2vWeAW80axUCw/
         RBmkbkDBF87wStqpTg7MGRRD7XNziEZB6Cbx07lopSawhsxIQ7cLQrfTB5j2YCNPdvMZ
         yAfBudNXeaJd0MtnP4Cjnf9NBbvjGT/SaRdCfBWJ5coch4qGuK++ONIl/jqoMAD/sZ0M
         DllLHZ0CVgURQMo1feyCxW2VMt6Cm7IieHkqsPRYOJ1Dx3sU+0gm1wYsvqOjIImPYiy5
         Gl5Ocd9x5NXnYu4TRFm53SepLVBSTtRCVMU9aca4P/NRFrVjEpxBwn4VB9eTsdLaMsp0
         yplA==
X-Forwarded-Encrypted: i=1; AHgh+RoKuwpellJoBOq2c1TK3XjQUkSJD1O8TcplFOhZTWDKofR1KqgiSQpG1xLd3xuGGhOtklDw6OY1/eE4@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHBE/Lm58g1WaE1OnZqtm2sukqLaKx7NKdQ6Ml6KNQK8bfpTn
	TUKS6pv8XFujcE8FlhFwv4J2dJNYjsfw96wigiXLoLK81SZl8Va6tbPpnGStWZYQSw3lknfGXu2
	AgnNzWLQJ8isVSpdCos7wZN3+bJsTHqcbwA157D/yaw==
X-Gm-Gg: AfdE7clG1/cTz3LmMVkDhjjzz7UjcMxtn0oGX6EDTfv5gbxukIaTb6G2d80eUezmFv+
	EGGP0OliESl+gxEGGWAIGlvbsB/EV7xtfH34hX43ndu7ZnIpBDr3zVCsD+krSAbUd/rljcOPv+S
	7AHjufzT9dw/G7WFhO+jSdi9RB/I7fviulshA0VIivO16wM+KofZ6DIglSOQ4F9dUmlW6vM1ZmF
	Ct7nu+kXffwWTrdNRjnYXAXJ8KW6yb9Vl0s+nHGb/5D0i/cbUIJD52G56o=
X-Received: by 2002:a17:906:c146:b0:c16:5855:65a6 with SMTP id
 a640c23a62f3a-c16b46aa3famr202348966b.11.1784341057138; Fri, 17 Jul 2026
 19:17:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717-ceph-append-fix-v1-1-c51907ac8e36@clyso.com> <b5e05cbd0b7aa6ecd8a66dedb71a58e37dafdc8e.camel@dubeyko.com>
In-Reply-To: <b5e05cbd0b7aa6ecd8a66dedb71a58e37dafdc8e.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Sat, 18 Jul 2026 10:17:25 +0800
X-Gm-Features: AUfX_my7mKfUnA2o_nugbPq5_KE1620P3NOo-69YBZFPbjZr-LNeUPDmgxcbon4
Message-ID: <CAOJNxR+F3_iXWOm053zRVQyLCd=sRWVBd2XeUXoqYAA0BR34Pg@mail.gmail.com>
Subject: Re: [PATCH] ceph: revalidate ki_pos for O_APPEND writes after cap acquisition
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On Sat, 18 Jul 2026 at 01:35, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Fri, 2026-07-17 at 17:33 +0800, Xiubo Li via B4 Relay wrote:
> > From: Xiubo Li <xiubo.li@clyso.com>
> >
> > For O_APPEND writes, ki_pos is set to the current EOF via
> > generic_write_checks() after fetching i_size from the MDS.  However,
> > ceph_get_caps() may need to wait for Fwx exclusive caps if the write
> > extends the file (endoff > i_max_size).  While waiting for Fwx, the
> > previous Fwx holder (another client) may have already extended the
> > file.  When the MDS grants us Fwx, the cap grant message updates the
> > local i_size, but ki_pos remains at the old EOF, causing the append
> > write to land at a stale offset and overwrite data from the other
> > client.
> >
> > Fix by re-reading i_size_read(inode) after ceph_get_caps() returns.
> > At this point we hold Fwx exclusive caps, no other client can modify
> > the file, and i_size reflects the true EOF from the MDS cap grant.
> > No extra MDS round-trip is needed.  Only adjust ki_pos when the EOF
> > has actually changed.
> >
> > Link: https://tracker.ceph.com/issues/7333
> > Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> > ---
> > For O_APPEND writes, ki_pos is set to EOF via generic_write_checks()
> > after fetching i_size from the MDS via ceph_do_getattr().  However,
> > ceph_get_caps() may wait for Fwx exclusive caps (because endoff >
> > i_max_size).  During that wait, the previous Fwx holder may have
> > already extended the file.  When the MDS grants us Fwx, the local
> > i_size is updated via the cap grant message, but ki_pos is still
> > the old EOF, resulting in the append write overwriting data.
> >
> > Fix by revalidating ki_pos against i_size_read(inode) after
> > ceph_get_caps() returns.  We now hold Fwx =E2=80=94 no other client can
> > change the file, so i_size is stable and correct.
> >
> > Fixes: 8e4473bb50a1 ("ceph: do not execute direct write in parallel
> > if O_APPEND is specified")
> > Link: https://tracker.ceph.com/issues/7333
>
> The patch has two --- separators. The Fixes and Link will be finally
> dropped.
>

I used the B4 and just added this to the cover letter. Let me fix it.

> > ---
> >  fs/ceph/file.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 9d89d7fc1095..b35c9aee48dd 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -2491,6 +2491,32 @@ static ssize_t ceph_write_iter(struct kiocb
> > *iocb, struct iov_iter *from)
> >       if (err < 0)
> >               goto out;
>
> ceph_get_caps() validated caps against the old endoff =3D pos + count.
> After adjusting pos forward, the real write range is [cur_eof, cur_eof
> + count), which isn't re-validated against i_max_size. Could it be a
> potential issue?
>

Yeah, Good catch. We should fix this anyway. Let me fix it.

Thanks
Xiubo

> Thanks,
> Slava.
[......]
