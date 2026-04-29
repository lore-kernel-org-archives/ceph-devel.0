Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A3A3A75BC
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 08:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452090; cv=pass; b=osgzKumTMMHzLbS4E1dTjaeDR/mteKqdas6gkSd5DVyBI/TAL7pw32r8x7YP6H24faCt+8D1cyIK+xFCoogP8zqozuqEcLDqb2LPDoLBX03PY0UqAmaekhWWWDFhHWSSrigx1BMfKUnKAI+fIPx2fhSJZUlHxQBPwT3YAkvtRgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452090; c=relaxed/simple;
	bh=u1mGCCf7xdfYI0duurRpf9XWRZSzgzx0GXgyDgBbACs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTka7cINynj16fyuIJwyzz+ZA54GvznL0XST1iKjQBwCod/BITOaspO7RCWr6W2lGQX5V2SBO529zZErvnfQ4vXJSIsNL4xhqsHhdRQ6tEMvWbcd+c9ZL9tXHkgwEqGOUv7esj70qqGfI0WO/Gp0Lozf0ojYhhYQqVDTfiB8X4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvKan7JG; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvKan7JG"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-6120528b8b4so3595233137.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 01:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777452084; cv=none;
        d=google.com; s=arc-20240605;
        b=Dp/nxB0re61lqdmYwKAnI4517gOMPgapZg5m3FreWP5VwqOMtJorvpw2u4lwFN5zbj
         vTtjvRrw7sEmU/GKKdRdk+oHIz7VTe3SQv+az7kBnPHm+NDWH3XaM3RcQNilLXTBU3l/
         yPhvG2tHxnxYGPaYJZJ9YK++qA0rbmsxigHjKnVv5wto874fakNfIpg9Ec0Uk7iYpwvm
         4cQxZ842RNtVvqga/YE2NWn/zCI0qISV3J8xUhu/XEKalDE4BqlfpYU9oaXU+1jeCgie
         u8xDyLl33Clw8NnK6ijyl+NHHvukRDn1UY2sL0oRwPah88vlEs+F2TKW5ZtafFAxDj2n
         e5KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2+g09mudIUJSVi1tFS9LqYUYtA4FyLkk1aKQQ0V4a28=;
        fh=4F+B2mTjvDbSvMoiiH+SLxlYqvBxNL1YKg8M/8jMSCA=;
        b=HVUY2c830eakNuO70eyAS+A8aF7etWNdPWWza/6N93QzdAPi7jsp0vose+lnn2rmeQ
         pHW8ilR7ZoN7q1+QmuEhImX7WMYJMYd6WZuyCY3XBSCZduOrCxVrevpWHehuVTVV8td0
         HRO+dqdDLMKzuUSIKN2vY2uvLA4r49S568ZPDIZwiYl7W6RbasCFay48awve0WFP7NFD
         ViehEpNxYmU4ZtI5tOjSRtlXAWfRLpbrZe6II4YZ+fwEULfGXRQca1yfmXbbMeSzJMEz
         nmY9qnFTx34ks0g66XSvX08XDeXUFJXtI4xagC3lk/1NfPEAxyGkWKt/BaCjGT1VtOD9
         03kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777452084; x=1778056884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+g09mudIUJSVi1tFS9LqYUYtA4FyLkk1aKQQ0V4a28=;
        b=JvKan7JGB97G9diFMysxD9CVjmtG7csj1SHxcrZ6V8ljfmTqKJ3tGU6+ij87aOa42m
         i5TcPdp5Er/PgOhnl75WRYqtS04cOmBho3n9z4vRUDWFA5MUAW+CNjXaa5MhnA7WZyrs
         964Y+sJjoJMqCbGAgFmAfghKHxqsXxjSPY82IiP0AG7XzlSgsag5gu7fSFAEgArMXN4U
         Ht+aGgo5axyXrWh2+YHaXZ1Q4JI7m0BDDBbc1Plow1q/dvFjmtZmJHv+S2BtxUx1Kp74
         cEUanQ5PapWLqWnEvKWE30BManqLMoNpn5wPBS0drsV2mDU/yA0gn5ds3R4BRUU5nOMf
         GGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777452084; x=1778056884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2+g09mudIUJSVi1tFS9LqYUYtA4FyLkk1aKQQ0V4a28=;
        b=c+ZV5G7W6HUeDgnfiw7WjNsZu5e9ok5s6qoWFTkifjZrPhprNxlewQ/m0q1IThoD2C
         lUjs9zWvzoYvIJV4ebLNfjritTELFeJKV/UmN0SHNGTchqSnvZ/jp+MK7jDhyAc6Y2kv
         dk9XrXR7/golRbkhxCI9OctTnxyv4T34DyBZ0wqwcooqObdqLBgrZMDLcdALKAlL1aDS
         plBGDNeXjtPcRzDoAccmucX6IJX0CsV7fSw/zrDdzNJbJ7W9/HIvNxT60cexZi+a1Mzt
         asrCCzwbFbrAkEpOCSMJDvz02igJIQY4akXkq+MANBl2FZWRF1HPLS5Ve0oHUGGDa2C9
         LYbg==
X-Forwarded-Encrypted: i=1; AFNElJ9DMIxhg/3MmMM8YYefaZncnAzqiaO0lgDR0O8U+HXzr8N1pkxkr6q15/rkLxHJag2kCKtV/LIFQdh8@vger.kernel.org
X-Gm-Message-State: AOJu0YyYAo4hVgGcA6MYyYw8qzMGm9dQfZlZzwyXBvhblj9ih51MwkTY
	E0coWpfek16BtI47+a/NykUNnUnxqYS2r11xG1FXuaIj2sftHNCWFsXIFsvW+G2eMFO5Dfr1suP
	c2IR02FFnGyZLPVEs2f+p7YPGOwg3hlbrTGXu
X-Gm-Gg: AeBDieuULjEzExrASlnjaRVZ5z94VYGCVOhRSOuPbEJiwFZLOJGDPnYoR6u2Fe4pmu/
	bGJWfE5GYyDmJxeCoEE03hZQ4goi+lMLCS61CkdPhVldGsnQqE6aIkFeIhfxNpkSVv5CuHPIwyI
	5bUWKh9487zQ3QdK7TuzSMdq5eI7kwo1P6f+VXaMCBhIglQu7gYj9jyzGKduKLAKjuPAABJ3W56
	3DxqYBFHdestSmC2Vy3CD2vwp0CCmUfVhoUVL2/0hOo1EqBS3qm+2ea1/aNf/4O0Jiy2saDdEmD
	j+tjhfol2obLhGqvBw==
X-Received: by 2002:a67:e705:0:b0:611:a5b6:f4d6 with SMTP id
 ada2fe7eead31-6280a3a7e53mr3178758137.18.1777452083755; Wed, 29 Apr 2026
 01:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428121546.148369-1-raphael.zimmer@tu-ilmenau.de> <58f52c8a-54ae-4982-ba68-a9a9d138f484@redhat.com>
In-Reply-To: <58f52c8a-54ae-4982-ba68-a9a9d138f484@redhat.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 29 Apr 2026 10:41:11 +0200
X-Gm-Features: AVHnY4KrZIivTMTIL6bqwdf3BCnXWPxxsL8hDOJuHcEmGOzbkkkT7wsvcUCXe1M
Message-ID: <CAOi1vP8NgWN3LseLR9ynP+gEWQ8E_0_e=CZAOCpwBpPQr_Y+wQ@mail.gmail.com>
Subject: Re: [PATCH v2] libceph: Fix potential out-of-bounds access in __ceph_x_decrypt()
To: Xiubo Li <xiubli@redhat.com>
Cc: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 2:51=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
> Hi Raphael,
>
> On 4/28/26 20:15, Raphael Zimmer wrote:
> > In __ceph_x_decrypt(), a part of the buffer p is interpreted as a
> > ceph_x_encrypt_header, and the magic field of this struct is accessed.
> > This happens without any guarantee that the buffer is large enough to
> > hold this struct. The function parameter ciphertext_len represents the
> > length of the ciphertext to decrypt and is guaranteed to be at most the
> > remaining size of the allocated buffer p. However, this value is not
> > necessarily greater than sizeof(ceph_x_encrypt_header). E.g., a message
> > frame of type FRAME_TAG_AUTH_REPLY_MORE, that is just as long to hold
> > the ciphertext at its end with a ciphertext_len of 8 or less, can
> > trigger an out-of-bounds memory access when accessing hdr->magic.
> >
> > This patch fixes the issue by adding a check to ensure that the
> > decrypted plaintext in the buffer is large enough to represent at least
> > the ceph_x_encrypt_header.
> >
> > Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> > ---
> >   net/ceph/auth_x.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> > index 692e0b868822..9e64e82d0b63 100644
> > --- a/net/ceph/auth_x.c
> > +++ b/net/ceph/auth_x.c
> > @@ -115,6 +115,11 @@ static int __ceph_x_decrypt(const struct ceph_cryp=
to_key *key, int usage_slot,
> >       if (ret)
> >               return ret;
> >
> > +     if (plaintext_len < sizeof(*hdr)) {
> > +             pr_err("%s plaintext too small %d\n", __func__, plaintext=
_len);
> > +             return -EINVAL;
> > +     }
> > +
>
> You just check the AES/NONE case, which the plaintext_len >=3D 0 +
> sizeof(struct ceph_x_encrypt_header). While for AES256KRB5 the
> plaintext_len >=3D 16 + sizeof(struct ceph_x_encrypt_header).

Hi Xiubo,

I don't think that is the case.  plaintext_len is the length of the
payload that was encrypted, it doesn't vary depending on the encryption
scheme (only AES vs AES256KRB5 -- __ceph_x_decrypt() wouldn't ever get
called for NONE).  For both AES and AES256KRB5 that payload is whatever
the original caller actually wanted to encrypt prepended by hdr (struct
ceph_x_encrypt_header).  See the comment on ceph_x_encrypt_buflen():

  AES: ciphertext_len | hdr | data... | padding
  AES256KRB5: ciphertext_len | confounder | hdr | data... | hmac

plaintext_len covers hdr | data... and nothing else.  Anything extra
like padding in AES case or confounder and hmac in AES256KRB5 case gets
added during encryption and subtracted during decryption and is never
surfaced by ceph_crypt().

Thanks,

                Ilya

>
> I think we should also check the AES256KRB5 case ?
>
> Possible it should be :
>
>    if (plaintext_len < ceph_crypt_data_offset(key) + sizeof(*hdr)) {
>        pr_err("%s plaintext too small %d, need at least %d\n",
>               __func__, plaintext_len,
>               (int)(ceph_crypt_data_offset(key) + sizeof(*hdr)));
>        return -EINVAL;
>    }
>
>
> Thanks
>
> - Xiubo
>
>
> >       hdr =3D p + ceph_crypt_data_offset(key);
> >       if (le64_to_cpu(hdr->magic) !=3D CEPHX_ENC_MAGIC) {
> >               pr_err("%s bad magic\n", __func__);
>
