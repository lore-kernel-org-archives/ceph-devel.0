Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8921ADA7
	for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2026 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770832562; cv=pass; b=XOqynbz4Mv33bdqMyvAtgMRjqbgJHgc3y70K8gTsPRHABEQZUe0BtBWknoPoHZgquHrYIzG0BBNhsDKgHV1DtmDd091cPgpkFBxRXoMBhHKNNfEuQFMTmNH570Qys2oV7/gtNr5R0n9XO17CjjkfSQQEs2KseL0aTl8PjW7lMLc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770832562; c=relaxed/simple;
	bh=WqDmcBu1wGzmvMG5WdTsGmnjyWyUuprH2CPK/kku+og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pq17H/GLOuxHHi9yY9Ps8q7oF2qyzcAGepGcptKmTbOKRRTxg6srioXjU2dKab5oq9e0Xz5FCP/lvy46nFn8+RLRL30fYiV2jhI43e8z3MeCv4SCre3rrcM9hXiSdZcaIetVA3YIuh5+RHbSZVWwo2/lH1Brg4f4g/wuuG1qyOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfDvo+y2; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfDvo+y2"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124afd03fd1so8458021c88.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Feb 2026 09:56:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770832561; cv=none;
        d=google.com; s=arc-20240605;
        b=b0cSCN6IfCyS2ToEXq/ntIlXx6OvV0PC8H1wibXFP5QFUJUkaYiW2GnSuYuDGhc58w
         a39AjIPH3A1TKw64ivhKgoDA7/SjowF6w5Yb0VoG+SmcmW0tX4BTxyX8MF26rZmticd9
         bjieRUHKoG2nSayLjofdy/behAhj6duIyinL/RBps67INO5gi+7JvGcbvYJcRJRRcwAi
         /NgOV6PSMhUvtNMyTSdvDogKdPfev4QIzL2qktPxbCj6booMs7ei3fO64QYq9MLxig+j
         WAXQC/JgL2mH5AIyzh9t+lzHt/G+oP3u8bq3Zw09LfcjY0YUGMoEqMPZ7WU0KBc0KkkA
         4oww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JS8N4przpHfYV/wHgVy5O9woBaEoigomokrqEauriIc=;
        fh=+95Xz0tFDhpQbQlERxAAxBXr4YGENkA1NOjYsR94h0E=;
        b=TnHLPFwa6jQBlACIbSochFR975dzUbUt1rcn2rMHZ+RW/ISUPhDCAaIeD1Ghivcl7z
         0wOEL5P1X8fvH0+tJn6Sx8k6JXtx7bAYz/ChtobwVa7tDO0I7rGm85keksy2br+XjfBZ
         1b+6Ho/6OOVvhuD2m5FRzI/6AG/NSBsw3Vm0iqHmSqvhARdk6kVpkVtFm3CjZdETSpft
         PLRYbPP8iEH6Kz7NbeQKc8fmlzmCL9utR8A8dwhrIGJ2z6MHN/p24vSCRYVzOLSh6Tth
         n2tju2cNWL6bsf/eM9Wt5kmaelEk3SYdMgRXfzrNsgEFExMbh2UJ9mptBhFIHp4Qfqge
         wYgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770832561; x=1771437361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JS8N4przpHfYV/wHgVy5O9woBaEoigomokrqEauriIc=;
        b=UfDvo+y2QPpnQbtxzBDrvoWWl46Sc1k7UDqyig2wt1V6oqX/Nf1dXLMnTyi7Fj+oQ5
         nGTpvxGJUJ5+Rsjs3ig6Hk0jNIA9ToZDz2s9QfSAB+CpdHn8+2pYQmrLQ9A1wZeuRQnN
         RD5xq6Ym/6u3xJdgpmuyXFe7bcpYwDh1fso5qE2MaCbef7VjJdLFXRxLBNRdBl7hxzsY
         Hh2HnSB8CN+9KzsNmwQV2PMKZnYM6pYpjo7CHIJsh7Y78GOpCngbhwNyh22oZ7IlFnOM
         oBBhb2ehYZKzgDr7/l/THeP/ieEdAXjfQexv4SJRETER4tfpImmE2Rt3Y1OXT87WRqtk
         Hu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770832561; x=1771437361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JS8N4przpHfYV/wHgVy5O9woBaEoigomokrqEauriIc=;
        b=UfUfuVu7ZILQ8jPK9M+UFCOKNfYLt1uESKK9bGEmBc2T8xu1BrhjKAwGi9GmfV6B1G
         zcdtZOTT5MXPmtp8wF0dCa+vfEZd6Cyrv1fo0SrxfTC/7z88CVFNXdgT3nVh7XEB/Jxa
         wIbml8OGV/bg/IoqGMUS+7ldKK5Yy4JGnt3VrALgNH/Ge54O3YhalIYps6wMwbeeaCVe
         8JgrYyfJn/funxrnMivD6fHUa2C4l2JIPeOB9DyoLfOJQxvbYC1+uHKVw4o7vR0p1xs5
         0Q3+fy857sceiHEPNhBcsdS5GXgC9oIZ0UOtRIvfLhdrMmunRCmfO2XJpVGqMYvbNmz1
         XcKw==
X-Forwarded-Encrypted: i=1; AJvYcCUODNYDSjXgh7WanH7NKVLsoO860T6WcFC7LCROZHF57QPa/ZRKgkJRI8x4A7sYTeoG11gf1PYmJWTP@vger.kernel.org
X-Gm-Message-State: AOJu0YyYU9xokIRh1UmrGtyjItEtd8uknIHd0vEiw9UwfjS0cHxv1iJk
	7eQX+tnRCRoLWa3DUpsr8XQD0nSi8pFs7CVkGwxky8ptJoU69y0G9KUBdgM24Yd4tjX7u5JemNQ
	L23L8Ro07GwouzbYk64mZmuAxLRga+jE=
X-Gm-Gg: AZuq6aKR4TdA3jDJeipESxvc5rdF4dxeW7MS4I+YZe5f+vtS61cTx3jkHxiIXnW91bT
	2WvF7R9Tq6mIRyHBk7J59WYrwf2+BU3G7wAJgTLg8UeY/wZ5TuiyJQGaqfxVyEW15aVtLg4H9l5
	fv/ujIrzApLj9VCwL2YDSaLLvtS6dNG27Oq/5ZhhTcxUhpnAjIZQ0CKZxjJP7qsl5UN38l3LtPk
	RKYWHLYNYnqyEqwMUnofh7RofKJvCGlpBPhK2U+bI12uLK37wjZaOyElZ9FoXvTNuHoBU+ip/sF
	FULVnpw=
X-Received: by 2002:a05:7022:6189:b0:11b:9386:8257 with SMTP id
 a92af1059eb24-1272f7af26emr4852c88.44.1770832560611; Wed, 11 Feb 2026
 09:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126023055.405401-1-CFSworks@gmail.com> <20260126023055.405401-4-CFSworks@gmail.com>
 <65d1b29527a7ea8b06fd18854a25e0d1f60a24c0.camel@ibm.com> <CAH5Ym4gTE_ueXXuDngBHWdUd=LU0SFQEB20vs0rSYL_BB4O-Tw@mail.gmail.com>
In-Reply-To: <CAH5Ym4gTE_ueXXuDngBHWdUd=LU0SFQEB20vs0rSYL_BB4O-Tw@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 11 Feb 2026 18:55:49 +0100
X-Gm-Features: AZwV_QgS4tn4DjAYiNyfg_ZSi-fNhKBbxRAO3X244l8eXXNoA3QMuHF12-p0ZVY
Message-ID: <CAOi1vP_bEV-qWhCW8KSDDDyKJ2nZmXN0M3d+U7JpARE1=zS=uw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] ceph: remove error return from ceph_process_folio_batch()
To: Sam Edwards <cfsworks@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Xiubo Li <xiubli@redhat.com>, 
	Milind Changire <mchangir@redhat.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 29, 2026 at 1:30=E2=80=AFAM Sam Edwards <cfsworks@gmail.com> wr=
ote:
>
> On Mon, Jan 26, 2026 at 2:55=E2=80=AFPM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
> >
> > On Sun, 2026-01-25 at 18:30 -0800, Sam Edwards wrote:
> > > Following an earlier commit, ceph_process_folio_batch() no longer
> > > returns errors because the writeback loop cannot handle them.
> > >
> > > Since this function already indicates failure to lock any pages by
> > > leaving `ceph_wbc.locked_pages =3D=3D 0`, and the writeback loop has =
no way
> > > to handle abandonment of a locked batch, change the return type of
> > > ceph_process_folio_batch() to `void` and remove the pathological goto=
 in
> > > the writeback loop. The lack of a return code emphasizes that
> > > ceph_process_folio_batch() is designed to be abort-free: that is, onc=
e
> > > it commits a folio for writeback, it will not later abandon it or
> > > propagate an error for that folio. Any future changes requiring "abor=
t"
> > > logic should follow this invariant by cleaning up its array and
> > > resetting ceph_wbc.locked_pages appropriately.
> > >
> > > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > > ---
> > >  fs/ceph/addr.c | 17 +++++------------
> > >  1 file changed, 5 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > > index 39064893f35b..cdf11288d6b7 100644
> > > --- a/fs/ceph/addr.c
> > > +++ b/fs/ceph/addr.c
> > > @@ -1284,16 +1284,16 @@ static inline int move_dirty_folio_in_page_ar=
ray(struct address_space *mapping,
> > >  }
> > >
> > >  static
> > > -int ceph_process_folio_batch(struct address_space *mapping,
> > > -                          struct writeback_control *wbc,
> > > -                          struct ceph_writeback_ctl *ceph_wbc)
> >
> > I still prefer to return the error code from the function.
>
> Hi Slava,
>
> Since the objection to this patch is mere preference at this point, we
> need to seek broader consensus before either of us unilaterally
> decides whether this style is appropriate for the CephFS subsystem.
> I'm willing to follow the preferences of the group, we just need a
> "group" first. :)

Hi Sam,

The rationale that you provided on v2 [1] and in other responses makes
sense to me.  If the need for signaling an error that would be handled
by the (currently only) caller in a meaningful way arises, the signature
can be rolled back but until then I don't see any point in continuing
to always returning 0.  Having this rc variable that one needs to
remember to reset on every error path only brings confusion; the bug
that is getting fixed in the first patch of the series is a clear proof
of that.

[1] https://lore.kernel.org/ceph-devel/CAH5Ym4jn8wg+mYGqKGb17OZGBkyDeX-Vx3w=
gfVT0cqPtn36QFQ@mail.gmail.com/

Thanks,

                Ilya
