Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26D331ED6B
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2026 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769675906; cv=pass; b=hMS6Z7cOoGjJIv0FyqlVep/0bSwQX1nhCaN+ZjbMUmJo+2L2dGttsxyqIBmpTxdyp8/ZYDt3Yh+zisWD5zLE/Y3/P5EzESqPZgjuY4RBHD51HxOA2T7MjzTn5oDmMpKPZLh9WWSyxAMAAG44JJcPQ88/5iZVFuWR2aXI5EHEKFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769675906; c=relaxed/simple;
	bh=UilJeaPmuHrsT8ExfKu2QOy+jHJl6jZYHbsJbV7RuCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRq8cwXF7X7AeysIgNUvbTLnHLidg/3siX6uPTwhqOaKmq3njNMXqgAmGRtkaYQ6l83OsXyKgydXRIg4sIYk2U23GWuYyVGBMSBPge/M/quyYc4XP1TAVOLuv6JGiF9FkB69+cDRZiyd7OyhHmkut/pzU5+lrK3BTbLGHGOZHMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJyS/g7u; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJyS/g7u"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-124a635476fso999004c88.0
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2026 00:38:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769675896; cv=none;
        d=google.com; s=arc-20240605;
        b=Vo2E/MKUveUiRZNIB6OalTa+5+rjnLavVQrzBYx4E3iqlGz6aEWf3hk/gys7mBD3OA
         Zh4EWx7QqDW2U5Zriod4C0fBq9SvEDNGYeoFtJGvEeAJKtqcABq70OlW7MeUKRhqTxAt
         q9IFvwz2ZOJBDANQZKrgVCm9wk6lXZIJxyo58ZRzYD86xsGYssQBYqYbyN4whTYgKESS
         ng8Olr/udMSsMpV6p+x//1b7bBtDKmPZm7R587E1ZvOiOzOd9k6khD5Ipbp8ZpvLHK7Y
         SYNpVkWnflBl7bVCN3d7VVf/2T7mTZybldQVUiS+mlj2lko//F/Sx8CTMULpcCXF5Rq6
         5sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6sLWJsumtAbpNs/UcpNRwfSFjhkkDH9zBfCZTpxJdwU=;
        fh=D1e4OHpRyrDipzsfYikirxIIWWvtZiwEJENyMeAbPDU=;
        b=B0pNUMe/dO7rycUGOls2psIB00KMl3w4xRspt/EDlAwCwPoV6dU1lHFxefQDF6aORK
         wi10FFobsHSyxJCZWKa4JXWWykl7Tj5Eg1zgFr8xLVCduWRMYB2Yh0c2rp/872Ke5P4I
         EWHPwDiZk1+SgN+Z8IAJ9IyvcjIYwv0NImJKPPUkTnU8fjdP2TxitEA3FKj2Ex8txX35
         uAxP+ejBtKob+GiSITr42eaCZtF0Wri2ch+EMTFpDT5Oif2UJ37xkow/SYoLc5eNhzza
         3J3WThjS+4d7CyFIXBSPSNMQVaGzxNvOpcaLqozhqDh0ES7G41MLIM822NZGlJZ/WmIy
         2aDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769675896; x=1770280696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sLWJsumtAbpNs/UcpNRwfSFjhkkDH9zBfCZTpxJdwU=;
        b=ZJyS/g7u39zOF1hRFd4aHxlFxKiIVKexRd+eCWz7HLANymmnYciga36waXGvVxGuTs
         3QWMWlRvES66T4IBaIHwR7/feMJkxeP0EN+Fp/DaEPFD/PPXh/ixLypS0edQ+zoXwRXa
         dd+AaNa+eqhBa9U7nl2Hq072dNpxLGRcKcisHFnOaN2hz2ujG30UFrWPyBzayS9KIQOU
         7bV2IgU+xLg2qIEUdhwUbIA/8mGOqC9lDpNQgjywZ5za7szPk2l6y8QlxPnmfdHHoyTX
         cgXD8hIzdgAaMX/7Rr5Yjjknm194P3tVgJIG3ZoA1VnCaoN/SB7kiGkUtwVhjxRuKiyP
         6NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769675896; x=1770280696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6sLWJsumtAbpNs/UcpNRwfSFjhkkDH9zBfCZTpxJdwU=;
        b=NKScGooo5tD1Od3NX1py9b/yYsOsrjlFCGpX9c+zYk5iyFMklSxCX6nwFteQnapzZU
         d7WzKRtUbs8+fRxu2Vu0ZIWMD+FVkBz/4ZQkIys4fppjm2qnJ6ARSD2zxWpnrSJjqmbH
         y9DxovqcCu2WqxQTnTiWI2xJdgQ9ThzYIiPZplJEVCWR8pzXJS6lNxrslLxgpdZsXu0+
         Pl0jNv501HWQ0d3IxpLlRdKQdKwK+sMz3EBJlN2wG0dV8PbUhTjchrTRFmdsgMdsNEO2
         +jVR38JQ/OZ/oVq3a53/yg0HL7vFJCSdOMXdsT6F/CKbuRxH5cqUJuthlDUW+dYZBZiz
         MODw==
X-Gm-Message-State: AOJu0Yzhbj1FkW2Xk0U30der8NUmxnuxWbdop8gw264woqKLKLRF8o5x
	Soxr8Kk9qDbO9R07CoH+fAmOm7y+aqhWxRibmcxPLeMadEkCVR9032E5Sf0LS4CC0v22KjhndMo
	Gmft7GYCSgrTtLjJ1FWMl01FxR9/BJr0=
X-Gm-Gg: AZuq6aLF2ut1XmsXHfdFpnjk7kjyvBIi8uFaKqlRW1bVi34SyKocgkPxH6IzDoJpzX0
	aYahMP8GcvIGH/w9qvn6KsxcvPPQqpThymRyYUI4Tu3v+AWoxK/I+0B3a63g9KrYBE/C5QJU/X7
	UtwKBk544dVHpZeh8stCGFgNc1jcHYi9OFkYmxgqXvtGWwOx7aSjBXTnRsOXDcmUteQwfV/Jzar
	V0cp/6at7y2ttBCyVbGnRH1sBQnftkBadrCA04KBkJz++l/7wniZnt1iWC8rpZFGvUjhUg=
X-Received: by 2002:a05:7022:218:b0:123:3488:899c with SMTP id
 a92af1059eb24-124a011d463mr3918942c88.40.1769675895986; Thu, 29 Jan 2026
 00:38:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128103329.964466-1-idryomov@gmail.com> <20260128103329.964466-3-idryomov@gmail.com>
 <d455ab78d10e36ca96f7188f7acaf1dbb007dffb.camel@ibm.com>
In-Reply-To: <d455ab78d10e36ca96f7188f7acaf1dbb007dffb.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 29 Jan 2026 09:38:04 +0100
X-Gm-Features: AZwV_QifiT8oujmqBVqPX9uwNrnaJBGeVebtJSB9_mGqQgYBJFlJ72LxaSqfwSE
Message-ID: <CAOi1vP9h1PWM0ZTOYBvW=76RBLJNSejHOqg_h0zWa4z2M0gq8Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] libceph: generalize ceph_x_encrypt_offset() and ceph_x_encrypt_buflen()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	Patrick Donnelly <pdonnell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 9:44=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2026-01-28 at 11:33 +0100, Ilya Dryomov wrote:
> > - introduce the notion of a data offset for ceph_x_encrypt_offset()
> >   to allow for e.g. confounder to be prepended before the encryption
> >   header in the future.  For CEPH_CRYPTO_AES, the data offset is 0
> >   (i.e. nothing is prepended).
> >
> > - adjust ceph_x_encrypt_buflen() accordingly and make it account for
> >   PKCS#7 padding that is used by CEPH_CRYPTO_AES precisely instead of
> >   just always adding 16.
> >
> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > ---
> >  net/ceph/auth_x.c | 44 +++++++++++++++++++++++++++++---------------
> >  net/ceph/crypto.c | 25 +++++++++++++++++++++++++
> >  net/ceph/crypto.h |  2 ++
> >  3 files changed, 56 insertions(+), 15 deletions(-)
> >
> > diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> > index a21c157daf7d..5d7245884f95 100644
> > --- a/net/ceph/auth_x.c
> > +++ b/net/ceph/auth_x.c
> > @@ -44,23 +44,35 @@ static int ceph_x_should_authenticate(struct ceph_a=
uth_client *ac)
> >       return !!need;
> >  }
> >
> > -static int ceph_x_encrypt_offset(void)
> > +static int __ceph_x_encrypt_offset(const struct ceph_crypto_key *key)
> >  {
> > -     return sizeof(u32) + sizeof(struct ceph_x_encrypt_header);
> > +     return ceph_crypt_data_offset(key) +
> > +            sizeof(struct ceph_x_encrypt_header);
> >  }
> >
> > -static int ceph_x_encrypt_buflen(int ilen)
> > +static int ceph_x_encrypt_offset(const struct ceph_crypto_key *key)
> >  {
> > -     return ceph_x_encrypt_offset() + ilen + 16;
> > +     return sizeof(u32) + __ceph_x_encrypt_offset(key);
>
> Frankly speaking, it's hard to follow why sizeof(u32) is used. Maybe, it =
makes
> sense to introduce a named constant? This could make the code more easy t=
o
> understand.

It's part of the on-wire format which dictates that ciphertext_len is
encoded as a 32-bit integer.  It's pre-existing code (I just moved it)
and a meaningful name for "length of ciphertext_len in the encoding"
would be significationly more verbose.

The comment that I have added just a couple of lines below attempts to
fill in the blanks:

  /*
   * AES: ciphertext_len | hdr | data... | padding
   */

>
> > +}
> > +
> > +/*
> > + * AES: ciphertext_len | hdr | data... | padding
> > + */
> > +static int ceph_x_encrypt_buflen(const struct ceph_crypto_key *key,
> > +                              int data_len)
> > +{
> > +     int encrypt_len =3D sizeof(struct ceph_x_encrypt_header) + data_l=
en;
> > +     return sizeof(u32) + ceph_crypt_buflen(key, encrypt_len);
>
> Ditto.
>
> >  }
> >
> >  static int ceph_x_encrypt(struct ceph_crypto_key *secret, void *buf,
> >                         int buf_len, int plaintext_len)
> >  {
> > -     struct ceph_x_encrypt_header *hdr =3D buf + sizeof(u32);
> > +     struct ceph_x_encrypt_header *hdr;
> >       int ciphertext_len;
> >       int ret;
> >
> > +     hdr =3D buf + sizeof(u32) + ceph_crypt_data_offset(secret);
>
> Ditto.
>
> >       hdr->struct_v =3D 1;
> >       hdr->magic =3D cpu_to_le64(CEPHX_ENC_MAGIC);
> >
> > @@ -77,7 +89,7 @@ static int ceph_x_encrypt(struct ceph_crypto_key *sec=
ret, void *buf,
> >  static int __ceph_x_decrypt(struct ceph_crypto_key *secret, void *p,
> >                           int ciphertext_len)
> >  {
> > -     struct ceph_x_encrypt_header *hdr =3D p;
> > +     struct ceph_x_encrypt_header *hdr;
> >       int plaintext_len;
> >       int ret;
> >
> > @@ -86,6 +98,7 @@ static int __ceph_x_decrypt(struct ceph_crypto_key *s=
ecret, void *p,
> >       if (ret)
> >               return ret;
> >
> > +     hdr =3D p + ceph_crypt_data_offset(secret);
> >       if (le64_to_cpu(hdr->magic) !=3D CEPHX_ENC_MAGIC) {
> >               pr_err("%s bad magic\n", __func__);
> >               return -EINVAL;
> > @@ -193,7 +206,7 @@ static int process_one_ticket(struct ceph_auth_clie=
nt *ac,
> >       }
> >
> >       /* blob for me */
> > -     dp =3D *p + ceph_x_encrypt_offset();
> > +     dp =3D *p + ceph_x_encrypt_offset(secret);
> >       ret =3D ceph_x_decrypt(secret, p, end);
> >       if (ret < 0)
> >               goto out;
> > @@ -220,7 +233,7 @@ static int process_one_ticket(struct ceph_auth_clie=
nt *ac,
> >       ceph_decode_8_safe(p, end, is_enc, bad);
> >       if (is_enc) {
> >               /* encrypted */
> > -             tp =3D *p + ceph_x_encrypt_offset();
> > +             tp =3D *p + ceph_x_encrypt_offset(&th->session_key);
> >               ret =3D ceph_x_decrypt(&th->session_key, p, end);
> >               if (ret < 0)
> >                       goto out;
> > @@ -312,7 +325,7 @@ static int encrypt_authorizer(struct ceph_x_authori=
zer *au,
> >       p =3D (void *)(msg_a + 1) + le32_to_cpu(msg_a->ticket_blob.blob_l=
en);
> >       end =3D au->buf->vec.iov_base + au->buf->vec.iov_len;
> >
> > -     msg_b =3D p + ceph_x_encrypt_offset();
> > +     msg_b =3D p + ceph_x_encrypt_offset(&au->session_key);
> >       msg_b->struct_v =3D 2;
> >       msg_b->nonce =3D cpu_to_le64(au->nonce);
> >       if (server_challenge) {
> > @@ -368,7 +381,7 @@ static int ceph_x_build_authorizer(struct ceph_auth=
_client *ac,
> >               goto out_au;
> >
> >       maxlen =3D sizeof(*msg_a) + ticket_blob_len +
> > -             ceph_x_encrypt_buflen(sizeof(*msg_b));
> > +             ceph_x_encrypt_buflen(&au->session_key, sizeof(*msg_b));
> >       dout("  need len %d\n", maxlen);
> >       if (au->buf && au->buf->alloc_len < maxlen) {
> >               ceph_buffer_put(au->buf);
> > @@ -507,7 +520,7 @@ static int ceph_x_build_request(struct ceph_auth_cl=
ient *ac,
> >               struct ceph_x_authenticate *auth =3D (void *)(head + 1);
> >               void *enc_buf =3D xi->auth_authorizer.enc_buf;
> >               struct ceph_x_challenge_blob *blob =3D enc_buf +
> > -                                                     ceph_x_encrypt_of=
fset();
> > +                                          ceph_x_encrypt_offset(&xi->s=
ecret);
> >               u64 *u;
> >
> >               p =3D auth + 1;
> > @@ -634,7 +647,7 @@ static int handle_auth_session_key(struct ceph_auth=
_client *ac, u64 global_id,
> >       ceph_decode_need(p, end, len, e_inval);
> >       dout("%s connection secret blob len %d\n", __func__, len);
> >       if (len > 0) {
> > -             dp =3D *p + ceph_x_encrypt_offset();
> > +             dp =3D *p + ceph_x_encrypt_offset(&th->session_key);
> >               ret =3D ceph_x_decrypt(&th->session_key, p, *p + len);
> >               if (ret < 0)
> >                       return ret;
> > @@ -804,7 +817,7 @@ static int decrypt_authorizer_challenge(struct ceph=
_crypto_key *secret,
> >               return ret;
> >
> >       dout("%s decrypted %d bytes\n", __func__, ret);
> > -     dp =3D challenge + sizeof(struct ceph_x_encrypt_header);
> > +     dp =3D challenge + __ceph_x_encrypt_offset(secret);
> >       dend =3D dp + ret;
> >
> >       ceph_decode_skip_8(&dp, dend, e_inval);  /* struct_v */
> > @@ -851,7 +864,7 @@ static int decrypt_authorizer_reply(struct ceph_cry=
pto_key *secret,
> >       u8 struct_v;
> >       int ret;
> >
> > -     dp =3D *p + ceph_x_encrypt_offset();
> > +     dp =3D *p + ceph_x_encrypt_offset(secret);
> >       ret =3D ceph_x_decrypt(secret, p, end);
> >       if (ret < 0)
> >               return ret;
> > @@ -974,7 +987,8 @@ static int calc_signature(struct ceph_x_authorizer =
*au, struct ceph_msg *msg,
> >                       __le32 front_crc;
> >                       __le32 middle_crc;
> >                       __le32 data_crc;
> > -             } __packed *sigblock =3D enc_buf + ceph_x_encrypt_offset(=
);
> > +             } __packed *sigblock =3D enc_buf +
> > +                                    ceph_x_encrypt_offset(&au->session=
_key);
> >
> >               sigblock->len =3D cpu_to_le32(4*sizeof(u32));
> >               sigblock->header_crc =3D msg->hdr.crc;
> > diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
> > index 5601732cf4fa..2b98daffe9af 100644
> > --- a/net/ceph/crypto.c
> > +++ b/net/ceph/crypto.c
> > @@ -285,6 +285,31 @@ int ceph_crypt(const struct ceph_crypto_key *key, =
bool encrypt,
> >       }
> >  }
> >
> > +int ceph_crypt_data_offset(const struct ceph_crypto_key *key)
> > +{
> > +     switch (key->type) {
> > +     case CEPH_CRYPTO_NONE:
> > +     case CEPH_CRYPTO_AES:
> > +             return 0;
> > +     default:
> > +             BUG();
>
> Maybe, return error code or INT_MAX instead of BUG()?

Random sentinel values like that often backfire in my experience.
A BUG is much more clear and acceptable here IMO because a key of an
unsupported type is expected be rejected at prepare time.

Thanks,

                Ilya
