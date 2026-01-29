Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21D238C0A
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2026 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769646608; cv=pass; b=JPPcpDtHOwf9O5iAudUMBIW7DEoVtl5J8EK8USzZZ8AMyUuEQ2+PaDfAvyZD9l+uHKczEolYg6/caD2+jtlE7yZvYrYpMHGiQ4KhxnXoNxoPz9I3EED1m/UsvLwdlmiSSDLYaeOUmBrvZg137KDXxikRQ88R3RP4WR5oheAubqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769646608; c=relaxed/simple;
	bh=1eMMISMtKdMZAxC48pNaHXm/nhvjqEEtGqWuDZGKc/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeAG/lpVJvvJ7OXW5kzF/hSIdMdGZ+7bvbLwN0ZHu9ymsy8hF32xy8qDIvjP6rwEbdr24kvm9chAa+VnjLT+DxiBwkJpX9QSOcmGJ/krTILpdHrR3NGlXzoU0uxB8go3h8tvgC9K4NwXnptha8D9+HQSfd/tikLkIvyNoMQljZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCh1chNg; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCh1chNg"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4801bc32725so2871835e9.0
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 16:30:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769646605; cv=none;
        d=google.com; s=arc-20240605;
        b=TudiUj0pN30Wal9NNwcKv/J9LZAa72vomShGQTjp0LZTbFnN06P5ehYvEYMlJKCHmV
         KC+PdEsD80nIFtpQfRlGWhTD4U+Res0WSNPqDmtsuHrr+YWXIeQBDJqPpcYKmw+Lzwma
         SDAfC/krEZ7Lz+yIFFQCDfFlRpEW1tAJtWNvJxhDZLgdw8h/XyPLfWyajsau/cDKw5nV
         mbvTO93+6BKf/7WIYV9/kMOkp8JSA28mo+PpnR/fFLT+VmZvACF4HIqOzZ11ixK0roPs
         vlP3nImvjk5o+sxy/3mvbaEFZHvEkT0s1jKQWqtBw4y+ifv/5WCxxurp5Vos0clc5Gtw
         XnmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n4WVV+4ephNgyhPHk8ZRQ/OrpzAMbrme6jhlWNbvFVE=;
        fh=u9DnAkFIpsHIWMo+B/CgaKHWYZN6oe85/rZ6U1kvV2o=;
        b=lCV6xIrd0xplBD2qysBoscOlvLqusBlecJOnErjJgdsX329nbPGKITlBSj6jEe6RAs
         B4jEmBGzWrO+U03Z//CNlr7BrfRsdZBdW8ac6mxG4uh9RMLq8FYjP9ppyPv/6TH4HRKk
         N2b2DNs+iQy7L6MglV5u8RCP6OgYg2PBUdj9Cwp5sFQjZ33G9SIsZ/zlCQlRF1AE4ibh
         CfV9mcSGjBG9txoI5OB1dcKwAwOWD3H8jrImQL+gv5sxH3vMsfiPManSOGKSQoYzyLRz
         aOySHXqTyKQ7XhQIBvQ0UcvBidyd0riDYV9Ccvu5gJnGwtVHiUwO00iKeNlgNHeH25Q2
         tZGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769646605; x=1770251405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4WVV+4ephNgyhPHk8ZRQ/OrpzAMbrme6jhlWNbvFVE=;
        b=JCh1chNgJna7XodwbrOcPMUO8U/ZCnmdXY3WSmUAEQuARHEbQfU8cEExbOARuYV6kN
         Ovmz9dofyUu4rcQX/wVD5KGOQg2yRMlPcWmtuuZMippVIJwm+pRqoyM/w8oqJJw8Hx/n
         eKmixxA0hCMN1+yTO8c4s3l8Mdd+wXRgVaQjSWc1gtgFnbZSzBbQmKBAfopnYW9l9c4O
         srpKxu5e1OICX5DQGfMVaHZkK0Xgpsbc/fd2Zlxfmk0k5185sEqtKZo+Ps9oxq16Uz1A
         wACWFqySmjGEm28zODMf0nIocHGST7SqBpU1TOQecgJgXTdH4xJ/5HWAhIVxyFibpnpw
         aFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769646605; x=1770251405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n4WVV+4ephNgyhPHk8ZRQ/OrpzAMbrme6jhlWNbvFVE=;
        b=Lyrkz1dkrVGNLHcEWRfye2hig4vh7PAoRUufAzDoZ1MORgEGcFxrZU4bX2Noys3pq+
         WxZFR2xec+6dMjevOpF5TtpgU3OMBxz+2nN5U4Cb9zPErobeTZrNnqppr+Lkvc8EYUC2
         s+OY5JbUimogrURTgEar+EwszcBixSxQlvOmgS7DFVfFUZISSqr21h1TsKRE0geva7V3
         XskQOg5ZHacRTTkwnmv/1eoEofvJVgC0zm4p1gjcyZtVO02LFi3gHsyhrem51v6PgR0X
         wsy4CrOeGc2JaZiekHpOFqu+DF09SB2W6NN51YoiM9e1Q91hsmyKQyPV6jVWAroxo7oX
         mKvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcW5Vq6qoHtiue+ObauGVoZqJOqzGqFPJ0H0KWg1GF+2CMAwoIQzlH4aQHgdh+7vi9NoAO+hZFHVzj@vger.kernel.org
X-Gm-Message-State: AOJu0YwS987yLnVS96wnwjzjBc1K9w5q1nZ7DBBl9gj5F2d1LU0cJo1a
	v7y8BfYYkIJvx2F3qrHUERjqTBwuj7wyNmZ6+1eokKnj6/Lu5bb+TIiaZUZ0cpCIvWp1CFkAZ6O
	ecvTbLDui6wnRXaeJqcXSc3pSHKh0iBYjat966RE=
X-Gm-Gg: AZuq6aJ1ckn95JdToONWBYHEyd7dSbTvkpA6S+Eu2LgjWXy4pdruBJUcjyNQkUvOWdO
	Lj7+swsk31Gfj8tsn71IgNphwN8UzDAKyr0lm9WmS2Mrm5k/X+7paBf1fNedcmaU+jU9ffSNnH2
	YnkJsTvlyIHI/x5K8NxyK25uuGWn+FSlSDfwDyNk85DRKehThazyyNrhhEE9NNIcBho0EwLRGIC
	mZ9R1jkTJeXrxbOgDEIXB6JLb0UqwuksTwvRLBfd29OeNj74CvNRI0azQ4BhEpzDWFv80TnEADi
	zlBsXLbneqVF0PDihWMs4O6sfUbyNDNj5UKZlQ==
X-Received: by 2002:a5d:5f54:0:b0:435:a647:a3b8 with SMTP id
 ffacd0b85a97d-435dd1bd807mr9067401f8f.36.1769646605054; Wed, 28 Jan 2026
 16:30:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126023055.405401-1-CFSworks@gmail.com> <20260126023055.405401-4-CFSworks@gmail.com>
 <65d1b29527a7ea8b06fd18854a25e0d1f60a24c0.camel@ibm.com>
In-Reply-To: <65d1b29527a7ea8b06fd18854a25e0d1f60a24c0.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 28 Jan 2026 16:29:53 -0800
X-Gm-Features: AZwV_Qi8JXNGuDRSBsWJ6m148wG9oid0uSjuqlP3a0RRZZ_8I1yroXpwkz14Qdg
Message-ID: <CAH5Ym4gTE_ueXXuDngBHWdUd=LU0SFQEB20vs0rSYL_BB4O-Tw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ceph: remove error return from ceph_process_folio_batch()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Xiubo Li <xiubli@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	Milind Changire <mchangir@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 2:55=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Sun, 2026-01-25 at 18:30 -0800, Sam Edwards wrote:
> > Following an earlier commit, ceph_process_folio_batch() no longer
> > returns errors because the writeback loop cannot handle them.
> >
> > Since this function already indicates failure to lock any pages by
> > leaving `ceph_wbc.locked_pages =3D=3D 0`, and the writeback loop has no=
 way
> > to handle abandonment of a locked batch, change the return type of
> > ceph_process_folio_batch() to `void` and remove the pathological goto i=
n
> > the writeback loop. The lack of a return code emphasizes that
> > ceph_process_folio_batch() is designed to be abort-free: that is, once
> > it commits a folio for writeback, it will not later abandon it or
> > propagate an error for that folio. Any future changes requiring "abort"
> > logic should follow this invariant by cleaning up its array and
> > resetting ceph_wbc.locked_pages appropriately.
> >
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  fs/ceph/addr.c | 17 +++++------------
> >  1 file changed, 5 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 39064893f35b..cdf11288d6b7 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1284,16 +1284,16 @@ static inline int move_dirty_folio_in_page_arra=
y(struct address_space *mapping,
> >  }
> >
> >  static
> > -int ceph_process_folio_batch(struct address_space *mapping,
> > -                          struct writeback_control *wbc,
> > -                          struct ceph_writeback_ctl *ceph_wbc)
>
> I still prefer to return the error code from the function.

Hi Slava,

Since the objection to this patch is mere preference at this point, we
need to seek broader consensus before either of us unilaterally
decides whether this style is appropriate for the CephFS subsystem.
I'm willing to follow the preferences of the group, we just need a
"group" first. :)

Christian: Since you committed the patch introducing the
ceph_process_folio_batch() function, would you like to weigh in?

Thanks,
Sam

>
> Thanks,
> Slava.
>
> > +void ceph_process_folio_batch(struct address_space *mapping,
> > +                           struct writeback_control *wbc,
> > +                           struct ceph_writeback_ctl *ceph_wbc)
> >  {
> >       struct inode *inode =3D mapping->host;
> >       struct ceph_fs_client *fsc =3D ceph_inode_to_fs_client(inode);
> >       struct ceph_client *cl =3D fsc->client;
> >       struct folio *folio =3D NULL;
> >       unsigned i;
> > -     int rc =3D 0;
> > +     int rc;
> >
> >       for (i =3D 0; can_next_page_be_processed(ceph_wbc, i); i++) {
> >               folio =3D ceph_wbc->fbatch.folios[i];
> > @@ -1323,12 +1323,10 @@ int ceph_process_folio_batch(struct address_spa=
ce *mapping,
> >               rc =3D ceph_check_page_before_write(mapping, wbc,
> >                                                 ceph_wbc, folio);
> >               if (rc =3D=3D -ENODATA) {
> > -                     rc =3D 0;
> >                       folio_unlock(folio);
> >                       ceph_wbc->fbatch.folios[i] =3D NULL;
> >                       continue;
> >               } else if (rc =3D=3D -E2BIG) {
> > -                     rc =3D 0;
> >                       folio_unlock(folio);
> >                       ceph_wbc->fbatch.folios[i] =3D NULL;
> >                       break;
> > @@ -1370,7 +1368,6 @@ int ceph_process_folio_batch(struct address_space=
 *mapping,
> >               rc =3D move_dirty_folio_in_page_array(mapping, wbc, ceph_=
wbc,
> >                               folio);
> >               if (rc) {
> > -                     rc =3D 0;
> >                       folio_redirty_for_writepage(wbc, folio);
> >                       folio_unlock(folio);
> >                       break;
> > @@ -1381,8 +1378,6 @@ int ceph_process_folio_batch(struct address_space=
 *mapping,
> >       }
> >
> >       ceph_wbc->processed_in_fbatch =3D i;
> > -
> > -     return rc;
> >  }
> >
> >  static inline
> > @@ -1686,10 +1681,8 @@ static int ceph_writepages_start(struct address_=
space *mapping,
> >                       break;
> >
> >  process_folio_batch:
> > -             rc =3D ceph_process_folio_batch(mapping, wbc, &ceph_wbc);
> > +             ceph_process_folio_batch(mapping, wbc, &ceph_wbc);
> >               ceph_shift_unused_folios_left(&ceph_wbc.fbatch);
> > -             if (rc)
> > -                     goto release_folios;
> >
> >               /* did we get anything? */
> >               if (!ceph_wbc.locked_pages)
