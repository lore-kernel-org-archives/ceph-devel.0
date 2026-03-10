Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58633E1CF9
	for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2026 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172806; cv=pass; b=WAch5V3u3YCTA8fSaRWSu5F6axiM2oe3b91WXs15BOcGsfVcLsl53M+gbTho3rpljStHm25HeyB+ZWexVfbdCkjXnNWR4VwwScMg5bqQ1eDy619A9plFKGZmyglMcnLdqb0Kcgv+09Lk/BrDTtk+pd9XZhSpz8EX0ec5CfecDkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172806; c=relaxed/simple;
	bh=idb6D+oz1sMkRSsKyBwIuhLzPJ1DB8eh0aCUtCAgr/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qkji7Y41OnNr7rh+r5+HaiTVOl3psuWhU4ub01piXNiCqrlB96cHS3O/GW/ERbWF46auehw1ruRaCwaGQatu0JS6aNRQZT5/zXykwVjji7O5I0JUA9504k47G+YaFsxJ2UlM2Mw1IOKeQG6T61Rn87QsBD1p+swR7OXVJ8sVbA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ui+Jd1F7; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ui+Jd1F7"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso13524623eec.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2026 13:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773172804; cv=none;
        d=google.com; s=arc-20240605;
        b=SK96sqEDuSUiK0Dt/WcE1dKTuvK8cZCp38+W0PAy0yEF07d8OpgW0/5kSLCeg/F9x4
         qd7jcSn1LmMDUqsWjBh+8YrPZvXIeP4kyqhOWMOz29jlz4u17ely0d9mqh47SbFNrmaQ
         L6CtwtlYNtSWh9/Xk77wEwk9CTkS+bG8TQ37knplOasYRWeXVTtpUZOJTadOhlkG66r6
         3cNOuIdOjCiqHnaHhdcW3B7hlh/Rk/Tk5ZXQRvS/085ecyubLtAkIIfV6XVwPIxuS1xj
         sq7IVC05v3h9hzF42UfSgBZjiibFwcZToaL852GdIGNSB2M2lmYczirIq+XcrIWpw7Ri
         0XYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OduxUVJhEHxBq3d0ED4CaS6I7KLyBwki3XSRlcfEc4I=;
        fh=xuUd3x3Q7uGH5J7UDthtUDdMfKD0btWIXx/siNysgzk=;
        b=cpJ+IjORMIrr64OCSpqR9bRk7vU0RMcmPWpOc+UGDPAF0YY4auJSrtejBPzOkiX0L9
         n+0s2jKz1q0D2dHeUZVZk2S/rji9KGtQTnQAo8vk1estjiCv4ARxoeKH9cbwtt3s+FwL
         ih2oJg5MGsG1oXhgEhuMKiDAoFccYrjq7CurfSiPbGMzCXfkdvsSJHI6RLFoTOIUzvA0
         CAD5nz2uN4vz0H2Rkodt4oIhoduAX5pNjLJ8vDMe9NJLuMkFcI+f9vlpKDPXrUTl6Rol
         Mt1DLXurkV1yCRq0SdpLDgqBmiTmd26BNXTjw+37CybxeqiaMz4HqbrIIgFJYHfjwL/5
         Jxvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773172804; x=1773777604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OduxUVJhEHxBq3d0ED4CaS6I7KLyBwki3XSRlcfEc4I=;
        b=Ui+Jd1F7E5eeYfZ+AaKy9GYjGSmlo4n9f8RXeAZ7tAyUnqkiKHG/iK3btgI/kHcvm8
         QjkdLQ1gP2aTJYRCTkEGYxHyJcVYW8WwgBQuH9MITo5sSRSxwwy4maSVyzDsKb2mZxI8
         kDXnBiu22/nNqA8ejbDqoaYSkukm1wTu0VMCejsxcs+1e199A0dE0FG6M+7m+jC7jveW
         hJCZ037o2xjF5zSk0LHDcp6rkU1NOTzPgdL2DPVNvLNp7WAojq0H09N7OJ/cmTCFMu2h
         c1rzSeMSz2oIHGthRjfIZei1NHbW68VF1rrH5h3bsqywdw7gOKYmWqh2NcUj3Z2T5f6C
         9TQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773172804; x=1773777604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OduxUVJhEHxBq3d0ED4CaS6I7KLyBwki3XSRlcfEc4I=;
        b=LqfM0v7mu5+x7Qu/4ctZ/oHm8PSvgzyIrgHI4XrNRA+hhJBWkhfhI0O3sxwoJ6Cioh
         md0VETs7BroXLQAJKVRJ22vtBVBha1gmUKb9635CacUxSh6Jj1BePKn0N+IM+sN3uGv8
         t3Tp6nAq3xmVWl5WMvhZfXY45o0KvmiDh9O3xqLaZ+8srO7iek7mecLYfSeFAjFaVIJB
         l6lNAGxMFMlcCXOaNlbZMubNPv6JZ8sg5gUY5/iWkFmHljTVfaQD/zh0U9+9tB5WEh99
         51iFsEVG40tGfHSk0hAyN/4fEWvGySFN8eYQfKgdhXiSX4Ln/6PTzTp36BTGjgRX5ghX
         1Msw==
X-Forwarded-Encrypted: i=1; AJvYcCX7FXbRnWsG71Hlmurftv9Krp5+RcPQqngL8WPq7W6goosKO6C3zVuzuBieFi6t/usEg3je6bnmz0/h@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtsRCDhZCmEU+ifxLDhuHYKfV8YbWocnGfJ6QESVv7WhCcjXW
	41A4l92E/iPwvNWsfGoInX3LcZg3YNE9GmWFnuS8vB8OZWE8iI1SQA8De+Yq66Zha455Zp5uAsy
	Qbx9F1pagv6ozTPZTJZpgJu0LF5pxreQ=
X-Gm-Gg: ATEYQzyqYv/NKcHT9Oi2gThGewN2cyVDMZfEhjs+iLBT54gBXYn+CmssOer4wyKTGIb
	T8AO9ySbTJdx0B2FZ8XH+o7GZj4hn8IQsuaxpg9y6tv3JD4t89xawBrs74A7pBA2sLajL1I4OF2
	VSH7+oJm98e+cmTrWBUwETpfVSDAp/f+Yxc7MtJPTHD8ZOibWgAidpfZnNcu6Syw9QiT1ImUddP
	8YX6lMarzbPHExxyGkdtd3DOXVhMeIYrChu7tTiRlYYBfp9yChG1aYxSvL4jkU5VVb8MCSmpRMk
	LO4AoW8=
X-Received: by 2002:a05:693c:3001:b0:2b7:1d38:3596 with SMTP id
 5a478bee46e88-2be4dfd0933mr7144905eec.4.1773172803921; Tue, 10 Mar 2026
 13:00:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308221142.695096-1-idryomov@gmail.com> <a02c4542718e9647072bcb7661f4d7834c64fcaa.camel@ibm.com>
 <CAOi1vP8nUc_H_WAc=iGxcQAwsJBD1AtXp0gyMekm9W8U3boa8w@mail.gmail.com> <72ec1d6227ebf4a07e3fa4c487ec274bc3e20e1a.camel@ibm.com>
In-Reply-To: <72ec1d6227ebf4a07e3fa4c487ec274bc3e20e1a.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 10 Mar 2026 20:59:52 +0100
X-Gm-Features: AaiRm507YXRHgNELUYNTh6VMwzKmiIidC28ix5NbNuUjpxuSdR9V5YXDRSuRWXs
Message-ID: <CAOi1vP81eV8tMOQ3UEjA47napt9AsHyOXSWii4Qk_4feVcOCgQ@mail.gmail.com>
Subject: Re: [PATCH] libceph: reject preamble if control segment is empty
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 8:08=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Mon, 2026-03-09 at 21:46 +0100, Ilya Dryomov wrote:
> > On Mon, Mar 9, 2026 at 8:18=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyk=
o@ibm.com> wrote:
> > >
> > > On Sun, 2026-03-08 at 23:11 +0100, Ilya Dryomov wrote:
> > > > While head_onwire_len() has a branch to handle ctrl_len =3D=3D 0 ca=
se,
> > > > prepare_read_control() always sets up a kvec for the CRC meaning th=
at
> > > > a non-empty control segment is effectively assumed.  All frames tha=
t
> > > > clients deal with meet that assumption, so let's make it official a=
nd
> > > > treat the preamble with an empty control segment as malformed.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > > > ---
> > > >  net/ceph/messenger_v2.c | 17 ++++++++---------
> > > >  1 file changed, 8 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> > > > index c4ddf7911f7d..50f65820f623 100644
> > > > --- a/net/ceph/messenger_v2.c
> > > > +++ b/net/ceph/messenger_v2.c
> > > > @@ -392,7 +392,7 @@ static int head_onwire_len(int ctrl_len, bool s=
ecure)
> > > >       int head_len;
> > > >       int rem_len;
> > > >
> > > > -     BUG_ON(ctrl_len < 0 || ctrl_len > CEPH_MSG_MAX_CONTROL_LEN);
> > > > +     BUG_ON(ctrl_len < 1 || ctrl_len > CEPH_MSG_MAX_CONTROL_LEN);
> > >
> > > Frankly speaking, I cannot follow from the commit message why 0 has b=
een changed
> > > on 1. So, why? :) It will be great to have more clear explanation of =
this
> >
> > Both branches of prepare_read_control() set up a kvec for the CRC even
> > if ctrl_len =3D=3D 0:
> >
> >     add_in_kvec(con, CTRL_BODY(buf) + ctrl_len, CEPH_CRC_LEN);
> >
> >     add_in_kvec(con, con->v2.in_buf, CEPH_CRC_LEN);
> >
> > This instructs the main loop to read CEPH_CRC_LEN bytes off the wire
> > and essentially translates to an implicit assumption that the control
> > segment isn't empty (i.e. ctrl_len > 0).  This assumption holds in real
> > life (i.e. when the client is talking to actual Ceph servers) but not
> > when incoming frames are tampered with.  The patch made that assumption
> > explicit -- we won't even admit frames whose control segment is empty
> > anymore.
> >
>
> As far as I can see, we have several calls of head_onwire_len:
>
>     net/ceph/messenger_v2.c
> [1]        line 1348
> [2]        line 1372
> [3]        line 1409
> [4]        line 1436
> [5]        line 1480
> [6]        line 1517
> [7]        line 1787
>
> The [1-6] cases have ctrl_len always bigger than 1. And only case [7] loo=
ks
> differently:
>
> static int prepare_read_control(struct ceph_connection *con)
> {
>         int ctrl_len =3D con->v2.in_desc.fd_lens[0];
>         int head_len;
>         void *buf;
>
>         reset_in_kvecs(con);
>         if (con->state =3D=3D CEPH_CON_S_V2_HELLO ||
>             con->state =3D=3D CEPH_CON_S_V2_AUTH) {
>                 head_len =3D head_onwire_len(ctrl_len, false);
>                 buf =3D alloc_conn_buf(con, head_len);
>                 if (!buf)
>                         return -ENOMEM;
>
>                 /* preserve preamble */
>                 memcpy(buf, con->v2.in_buf, CEPH_PREAMBLE_LEN);
>
>                 add_in_kvec(con, CTRL_BODY(buf), ctrl_len);
>                 add_in_kvec(con, CTRL_BODY(buf) + ctrl_len, CEPH_CRC_LEN)=
;
>                 add_in_sign_kvec(con, buf, head_len);
>         } else {
>                 if (ctrl_len > CEPH_PREAMBLE_INLINE_LEN) {
>                         buf =3D alloc_conn_buf(con, ctrl_len);
>                         if (!buf)
>                                 return -ENOMEM;
>
>                         add_in_kvec(con, buf, ctrl_len);
>                 } else {
>                         add_in_kvec(con, CTRL_BODY(con->v2.in_buf), ctrl_=
len);
>                 }
>                 add_in_kvec(con, con->v2.in_buf, CEPH_CRC_LEN);
>         }
>         con->v2.in_state =3D IN_S_HANDLE_CONTROL;
>         return 0;
> }
>
> So, we do reset_in_kvecs(), call head_onwire_len(), and we do add_in_kvec=
() only
> after that. And ctrl_len value is defined by con->v2.in_desc.fd_lens[0]. =
What is
> the guarantee here that ctrl_len should be bigger than 0? Do we have prot=
ection

Hi Slava,

decode_preamble() is where con->v2.in_desc.fd_lens array is populated:

    for (i =3D 0; i < desc->fd_seg_cnt; i++) {
            desc->fd_lens[i] =3D ceph_decode_32(&p);
            ...
    }
    ...
    if (desc->fd_lens[0] < 1 ||
        desc->fd_lens[0] > CEPH_MSG_MAX_CONTROL_LEN) {
            pr_err("bad control segment length %d\n", desc->fd_lens[0]);
            return -EINVAL;
    }

prepare_read_control() won't be called if decode_preamble() fails.
This is what is meant by "reject" in the title of the patch.

Thanks,

                Ilya
