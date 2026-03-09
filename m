Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39286346781
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089217; cv=pass; b=pPrJIcL2E7Tlur3qaHlmks3tBav/bSb/lrcp+aU6FXno0z6DHKU4lPHRS0mNk4BiGRNCtmL8yiOk4EK5zyXbvpKTwOW/LYEHO9+TLUqo9Uuk2qABPZOE3R9mO53CXnKI7wh+s98zMrccWBCiCEmkcqzzafAmSFcSdGhI067yyNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089217; c=relaxed/simple;
	bh=NUzvQC1dCAluteXD7Izu4zRn0RxLuIhPikB72twWGCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oIBUr7ZgaPv7ms7LhWE2Gg3fZm6frdDi8qNlw+i+MlI/oQGgUxmyg1iAwI6vu1tLwBuhuKQfpM1EitrZe8ajtJ8KPsMkNTsYyxBinF80dgzS+3vYzFwRe5Yqvl8a/2aKW69gkqYQ1F0cYi1VpQ8SSi6/pP9JRmVqvVfK8dhaYG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjYamErY; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjYamErY"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-128d2e3074fso2491666c88.0
        for <ceph-devel@vger.kernel.org>; Mon, 09 Mar 2026 13:46:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773089215; cv=none;
        d=google.com; s=arc-20240605;
        b=TYq5adTFiVF51blmdVXFAmCN6Kq/f4AQKRrvUCHpnqNM0K73ReePxq3S7nG+um36GA
         MFua0h2e0oY/pdY85OeISWK5oKu+Z+1F3wlGG/fMdiYM6SdZAVSYJydCXvlZPcnXmfTq
         8Z0/PPwgjUn8O47Rjl8c9U3SlN1LBP2qwCfrfZ+lvlMZITrYFoF82pnh70Dcan8vvGZd
         U+igzE5LV5V3t6wdRjGLNkreQgLwKJg4ib0vhX7Ds8EZKcyW7Aasx0Ekd4g9HW2nQOnY
         sAfMOELlyi042e5DmP4DEekcLO4fGXIfGYPSkUojOn2lAdUucDJvNucZ2fsduQegadnV
         rpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nXku1iWqKQvSVlRtd3X1m4yNEmstVqrmaMgjRsNQRBE=;
        fh=FBgesWuv5taG5LgP/mAgmU5o+8GnVB+EqMDMRyA8WLA=;
        b=iwVYD0YA9D0S7QAk6FrRkg5r/cDYLZNx4QzHavfCEzFPWdv/jJmvUlgpAf7IR1Kq+K
         loEMKY9ckgTXGK3SZJfyQ/Pudfxi9pCmCrNq4dpwC80g0TnBXcgyOkrRhaDT5HILOHzg
         yAUjOHQIVb3Pu2oWi0liOLqZ42H4jHzmPqx4Y2Beqd2+ZPJTzfUNnMBBAiTBp78VurrY
         PX7IPBxkh40kuToDuwRgNPZlJvPLpkkSt2cVbzXLQIYK2oUKnp2CpQw464weppkhAcOf
         37qfvVR3+hrmMd8HzEX1Vxf5Ks9WCI4nbry+boJ4PgkdjUn7w91oH0rqk8HIQW5UNlyg
         yAjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773089215; x=1773694015; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXku1iWqKQvSVlRtd3X1m4yNEmstVqrmaMgjRsNQRBE=;
        b=IjYamErYt1zUeFuPKXQC2TccwYldaqJBeJHiQ/dHIMJDKv4jLvrmcfqx3AeEcxSlOM
         9WQy+BCeRt4o026Wl52sG98nAOpLX8WkOO+KoGsFWVoaR4tiYAltwhQlarIaqTZFP+pe
         UX5B0+ydPiIwylwU6ZtDPGlkHVy57aXeePGSV5tQfp1kjLFXlO6FRecs4IMcFqonjBeI
         mAcIYU/DYtQia2DdJHjyzgjnSpjoq1dbAeyvwce3KJzWEX79rKS+1b10TTIbZNvPMnJd
         geWgw6BwoCVe5KHEhxlM9q8gNVPytkp7gDSFxMdsUhUCGyPzwOcRQIKvkduH/We1NAEg
         gnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773089215; x=1773694015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXku1iWqKQvSVlRtd3X1m4yNEmstVqrmaMgjRsNQRBE=;
        b=F+ABWYRhDKyH5jraiYw5Sjig4Eg6oKk3HBliecpzWL8MhlxqZlW0xFOPKCEs2AFQ+C
         loiHxm9aQdFHg+ViSnJrTh2YVOi8iPk7rppCZpaD5P8O6JUGainlcE41JiVORErbh0jp
         tDHIdvkpi5XaieHpxU4eJERgvb1YgOpjNoaK97TtKra/FMYTMJQziKW8T3JSkq/xayCN
         bRDdOdcL0wHYHxNJZgtdgc2F6aCInCkzTQMDmn7x7qsBAS7sFQ5gGOnR3lNRKAaNUVUK
         /+RrQojMW+IH8zv8xgegHMup/kqIkgjWTffCz/2cnTWX1n7hacRwyPcw3h1NjXpf33fg
         Kr8Q==
X-Gm-Message-State: AOJu0Yz3j/wdBB0GOJf/BZA1tEU/O2v0inMpDt81B7DG37B3AMPDk4dS
	ECgtGFp6dJ8/lHUW4U+ztehvTohIz7yNFhGGBOUxSztdcQtDAXi0YswBbRwhySIHEuRNfT5EYNU
	JpMWPGGPVDMfq39QATkCrnGXx5znxyXg=
X-Gm-Gg: ATEYQzx9JsVO24QoXVdTPJ8/944muaDHILWOauPVl59mRFNKc4m2g7T7jh9F1Bb7dIu
	XSYSdL7MMVdYA3YgcFVMC5jv94zyvXnUgrx6UzY4fZiKGd8Oc8AsgQV9WV2+v7CpShttF+nYEzC
	xUVDq0d2h/Xh09HufOc3rrerprSUNU07WfJiWzDwLfkZnO3G+fWhuGCeIGWpRGWYqof6z9Xb/Cr
	Up6pamNqTFH6QTsc2eLG4Q9mz6u6kXYqdhbN9eaNf7kQDXiF325jVjPtIMX9qoTjUVjregTm6RE
	w7OgV4k=
X-Received: by 2002:a05:7022:250a:b0:121:9f05:c4c2 with SMTP id
 a92af1059eb24-128c2e7257emr4836737c88.23.1773089215253; Mon, 09 Mar 2026
 13:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308221142.695096-1-idryomov@gmail.com> <a02c4542718e9647072bcb7661f4d7834c64fcaa.camel@ibm.com>
In-Reply-To: <a02c4542718e9647072bcb7661f4d7834c64fcaa.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 9 Mar 2026 21:46:42 +0100
X-Gm-Features: AaiRm51jK6IYZlqOy4wZbvRAdbe7bMo6rMp5eAGD0j-pW4sAz5i0SUQegjcNdVk
Message-ID: <CAOi1vP8nUc_H_WAc=iGxcQAwsJBD1AtXp0gyMekm9W8U3boa8w@mail.gmail.com>
Subject: Re: [PATCH] libceph: reject preamble if control segment is empty
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"raphael.zimmer@tu-ilmenau.de" <raphael.zimmer@tu-ilmenau.de>, Alex Markuze <amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:18=E2=80=AFPM Viacheslav Dubeyko <Slava.Dubeyko@ib=
m.com> wrote:
>
> On Sun, 2026-03-08 at 23:11 +0100, Ilya Dryomov wrote:
> > While head_onwire_len() has a branch to handle ctrl_len =3D=3D 0 case,
> > prepare_read_control() always sets up a kvec for the CRC meaning that
> > a non-empty control segment is effectively assumed.  All frames that
> > clients deal with meet that assumption, so let's make it official and
> > treat the preamble with an empty control segment as malformed.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > ---
> >  net/ceph/messenger_v2.c | 17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
> > index c4ddf7911f7d..50f65820f623 100644
> > --- a/net/ceph/messenger_v2.c
> > +++ b/net/ceph/messenger_v2.c
> > @@ -392,7 +392,7 @@ static int head_onwire_len(int ctrl_len, bool secur=
e)
> >       int head_len;
> >       int rem_len;
> >
> > -     BUG_ON(ctrl_len < 0 || ctrl_len > CEPH_MSG_MAX_CONTROL_LEN);
> > +     BUG_ON(ctrl_len < 1 || ctrl_len > CEPH_MSG_MAX_CONTROL_LEN);
>
> Frankly speaking, I cannot follow from the commit message why 0 has been =
changed
> on 1. So, why? :) It will be great to have more clear explanation of this

Both branches of prepare_read_control() set up a kvec for the CRC even
if ctrl_len =3D=3D 0:

    add_in_kvec(con, CTRL_BODY(buf) + ctrl_len, CEPH_CRC_LEN);

    add_in_kvec(con, con->v2.in_buf, CEPH_CRC_LEN);

This instructs the main loop to read CEPH_CRC_LEN bytes off the wire
and essentially translates to an implicit assumption that the control
segment isn't empty (i.e. ctrl_len > 0).  This assumption holds in real
life (i.e. when the client is talking to actual Ceph servers) but not
when incoming frames are tampered with.  The patch made that assumption
explicit -- we won't even admit frames whose control segment is empty
anymore.

> change. And I believe that named constant is always better than hardcoded=
 value
> if this 1 has a special meaning.

It's just a check for emptiness, no special meaning at all.  It could
be written as <=3D 0.

>
> >
> >       if (secure) {
> >               head_len =3D CEPH_PREAMBLE_SECURE_LEN;
> > @@ -401,9 +401,7 @@ static int head_onwire_len(int ctrl_len, bool secur=
e)
> >                       head_len +=3D padded_len(rem_len) + CEPH_GCM_TAG_=
LEN;
> >               }
> >       } else {
> > -             head_len =3D CEPH_PREAMBLE_PLAIN_LEN;
> > -             if (ctrl_len)
> > -                     head_len +=3D ctrl_len + CEPH_CRC_LEN;
> > +             head_len =3D CEPH_PREAMBLE_PLAIN_LEN + ctrl_len + CEPH_CR=
C_LEN;
> >       }
> >       return head_len;
> >  }
> > @@ -528,11 +526,16 @@ static int decode_preamble(void *p, struct ceph_f=
rame_desc *desc)
> >               desc->fd_aligns[i] =3D ceph_decode_16(&p);
> >       }
> >
> > -     if (desc->fd_lens[0] < 0 ||
> > +     /*
> > +      * This would fire for FRAME_TAG_WAIT (it has one empty
> > +      * segment), but we should never get it as client.
> > +      */
> > +     if (desc->fd_lens[0] < 1 ||
>
> Ditto. Why do we compare with 1 now?

This is where such a frame (or its preamble to be precise) actually
gets rejected.

Thanks,

                Ilya
