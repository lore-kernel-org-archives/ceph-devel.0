Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05EF37475B
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2026 09:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769677642; cv=pass; b=Gk6SY5U0FOYAbkiqpGNRex+UCYKyHU15uVTKDXuH6e4sq/8lXsO7jL3UbU/vn2+04mqdXSpCAR2UMIL3w1aXN/+F1u77vy5rRA4+5G3pGaGBYz64qhvBlI+xb3UBbnB7aIP7/WeDglqmW2wa9Pmo/mmhzt1EEWbkDZ2LalzASdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769677642; c=relaxed/simple;
	bh=gnVz61Gq1pClEKHwZTm9X049Dg9A0ACn5v5tm2NEAA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miqUd2d0ELqNJC+jp64acZ48JUWofRGbxCjzV592+u8l4L1l/8LirKpaMrF67WbLl6ybqa6of8nM4MzOLlhB7oMPiMqxzXjXgAzaPYTDs9pnK/HqYmwJ1SEBLvQNIcQ8rnCKivooS7F5pOyTbtX3kjCOGZ6kSHYO2yQb9KhSYdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjU3gCxA; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjU3gCxA"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1248d27f293so470301c88.0
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2026 01:07:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769677637; cv=none;
        d=google.com; s=arc-20240605;
        b=E93dc+yFlSokOOeBij6LrSNosDRc/A4No/YaxzglPx8keN4QqAR4j7o2X26opKgnvD
         wFcyj30BbjQRWB+Y4Z8DGhXoTLVE1kqglOLjKbJu3s5FrxZGI5r/hhZ0AHA/rVvCERJW
         U8C4oEatJpDl+k95ErlaSp1X0GPf7etY+jctLSuClWiR58ivx1L2Dal76uf7kfXhnvO8
         NhPToVUV0N+ZTKNffzeD4gVKWdy3O1yRbBRABLG0KgAZHJRZHCtoWbA7RxxWRCn56Ar2
         xKMWwtgCEuWa5od/Oe40Hl/MIoU3CBELhzT5TLLPricEIeUwt0UrkwJCRHsX0kSiyeil
         fxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zWfqXctpoirDeqR4tXcDHJ3xxhCdBktnZ8r4WE0+3Hw=;
        fh=D1e4OHpRyrDipzsfYikirxIIWWvtZiwEJENyMeAbPDU=;
        b=AL4imwli26z+C5KdPHLtMYNNZdnx47gBw5h1Sjc8R03lprd30/z659PooVTri+Ca0f
         N7SpkZBX2A2XvOtGnca9r4tsEDcGCRg45BlG3zgumVBSMzTwI3IF3CKRuit77OW6RFOQ
         7fu1bilLJAfQNlkHfS7RBMjQ8+cIyKZuSUS0WyR4RbfL1bLDBKvOXqK723bg6Zpw0TrF
         GKTHlcMemvP75Ve4mBAFTnr9QAWzpb9KlxCXvyofRTETNVZUhVpSHiuSwxPZ/E0EJh57
         X3ITJfowc0ZxFU+X5r+DGoKv/i73Yi2Hv1PK3wk91EaJO92XGH/+AGkoOjf0ehQyV/n0
         kCiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769677637; x=1770282437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWfqXctpoirDeqR4tXcDHJ3xxhCdBktnZ8r4WE0+3Hw=;
        b=VjU3gCxA1KpGaBG4rjKgh+KHDUwoVF8k5bswYDBsQZIruAPE7XSdL3poSqC2ohTG7Z
         NxfV/bhvb6o1uVOOxw4WWm+T8lxQuiVtzeDlp5kkrZ1QjU5mXijwvCqZsXAlM3KennlD
         1uR/SZoidsUra/cVnPwJIB1OeWxeWyiF+dm32OUpzFPLnjqlyeSLRoSC22ixShsR7LBD
         69PWzv2Zfde16yVfn2G7E8EXsfGES0VLF9Rj+4SBgV5Ar27DnvjOL7GJxLphrNau/J2I
         cpW6N17FuEvSORLq+LIuYdUvPYZIeQN0I1Q2Mx4a6gZec60xBK875emxO1aObaPv1Uoq
         8m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769677637; x=1770282437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWfqXctpoirDeqR4tXcDHJ3xxhCdBktnZ8r4WE0+3Hw=;
        b=rmVAaWBuFCODXtd6AgN2FGOr0+y3pB2oJ8JIGnuGBBtD51tApcwOP7x4fvOXjY6NOD
         tU27tJlnRsqrXrEAhzkQDtWRVJU7LsStCSrzkBurWu6TVLlRpshfCoY5NGqugLshz/Bm
         EKSrY8kJWSxY+wjBXgkLF+aJL2wlrl+yi62X6XorzgfyI/EQHiVRKE7OdkXH/9ciVw68
         WMGhhTcz1VHKq6YG8VEbffN+/FPQlvJ2Fmbo0NZSP5y9C8A1wgF+c94tgwx+oloINxef
         w4j4Grd3P8b2xpLR/k3/XLmKWSugNQbQZufSVViOv+RKqHdonumJS+Mwv40xDsRjpI59
         GyqA==
X-Gm-Message-State: AOJu0YzAtkIG63zEV7Lrl+z/n1I/id3Nc5MKGP9BX3IO7YQluKUop78q
	Soht3F8R1w4HRXNk53zIRIVpnQ7jKZwiT13k1Hh7emmZ+iGtanSmRG34JFNRQ05MDIwrx4EoFVW
	Bw7V4QnpSxzbwiU/+EA+Bc/hPUurFGIU=
X-Gm-Gg: AZuq6aL4gPi+4QThOliI5V797h/P82e/u1nB/UmGgGpWPtUDEAOgafxgRVOO8X9lvkh
	urs5NR9YoIc4qTVf2md7vLIBSf9QqTI6uXj82m6wgdjLiNI0M+tMeQtz5Qx/NjV15z5VctrhHpE
	nonH3MwaR7pv5XJD5qhbSeGv2zOOBugfmptDcboC+UwvHSWM1IVoivdGkLMb83AG6iGEsMKhoTD
	ttTU/itUGne8D1F8Rpf+SxQF1dOdXMuI0sC3nq2lE8Ccugp0U660U4A0/aMgWaBhiqMJEQ=
X-Received: by 2002:a05:7022:6b9e:b0:11b:9386:7ed3 with SMTP id
 a92af1059eb24-124a00f3168mr4346656c88.48.1769677636549; Thu, 29 Jan 2026
 01:07:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128103329.964466-1-idryomov@gmail.com> <20260128103329.964466-5-idryomov@gmail.com>
 <2fdd7564846c1a6e0ada0f90581884b9db3a57db.camel@ibm.com>
In-Reply-To: <2fdd7564846c1a6e0ada0f90581884b9db3a57db.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 29 Jan 2026 10:07:03 +0100
X-Gm-Features: AZwV_QgImVBJtL3SSozcbopTi5EPQg45KGlQe-RLXZ-ffIvsDh_8WoAS4rmmlzU
Message-ID: <CAOi1vP8tqYW6cUpbY_WqOQKbfz81Ge9rMWfq-vFDzvkoDPitOQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] libceph: add support for CEPH_CRYPTO_AES256KRB5
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	Patrick Donnelly <pdonnell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 10:04=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2026-01-28 at 11:33 +0100, Ilya Dryomov wrote:
> > This is based on AES256-CTS-HMAC384-192 crypto algorithm per RFC 8009
> > (i.e. Kerberos 5, hence the name) with custom-defined key usage numbers=
.
> > The implementation allows a given key to have/be linked to between one
> > and three usage numbers.
> >
> > The existing CEPH_CRYPTO_AES remains in place and unchanged.  The
> > usage_slot parameter that needed to be added to ceph_crypt() and its
> > wrappers is simply ignored there.
> >
> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > ---
> >  include/linux/ceph/ceph_fs.h |   5 +-
> >  net/ceph/Kconfig             |   1 +
> >  net/ceph/auth_x.c            |  88 ++++++++++++++------
> >  net/ceph/auth_x_protocol.h   |  38 +++++++++
> >  net/ceph/crypto.c            | 157 +++++++++++++++++++++++++++++++----
> >  net/ceph/crypto.h            |  16 +++-
> >  6 files changed, 257 insertions(+), 48 deletions(-)
> >
> > diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.=
h
> > index c7f2c63b3bc3..4e81dea14b7b 100644
> > --- a/include/linux/ceph/ceph_fs.h
> > +++ b/include/linux/ceph/ceph_fs.h
> > @@ -83,8 +83,9 @@ struct ceph_dir_layout {
> >  } __attribute__ ((packed));
> >
> >  /* crypto algorithms */
> > -#define CEPH_CRYPTO_NONE 0x0
> > -#define CEPH_CRYPTO_AES  0x1
> > +#define CEPH_CRYPTO_NONE       0x0
> > +#define CEPH_CRYPTO_AES        0x1
> > +#define CEPH_CRYPTO_AES256KRB5 0x2 /* AES256-CTS-HMAC384-192 */
> >
> >  #define CEPH_AES_IV "cephsageyudagreg"
> >
> > diff --git a/net/ceph/Kconfig b/net/ceph/Kconfig
> > index ea60e3ef0834..7e2528cde4b9 100644
> > --- a/net/ceph/Kconfig
> > +++ b/net/ceph/Kconfig
> > @@ -6,6 +6,7 @@ config CEPH_LIB
> >       select CRYPTO_AES
> >       select CRYPTO_CBC
> >       select CRYPTO_GCM
> > +     select CRYPTO_KRB5
> >       select CRYPTO_LIB_SHA256
> >       select CRYPTO
> >       select KEYS
> > diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> > index abdd35be263a..decd2867f8f1 100644
> > --- a/net/ceph/auth_x.c
> > +++ b/net/ceph/auth_x.c
> > @@ -17,6 +17,22 @@
> >  #include "auth_x.h"
> >  #include "auth_x_protocol.h"
> >
> > +static const u32 ticket_key_usages[] =3D {
> > +     CEPHX_KEY_USAGE_TICKET_SESSION_KEY,
> > +     CEPHX_KEY_USAGE_TICKET_BLOB,
> > +     CEPHX_KEY_USAGE_AUTH_CONNECTION_SECRET
> > +};
> > +
> > +static const u32 authorizer_key_usages[] =3D {
> > +     CEPHX_KEY_USAGE_AUTHORIZE,
> > +     CEPHX_KEY_USAGE_AUTHORIZE_CHALLENGE,
> > +     CEPHX_KEY_USAGE_AUTHORIZE_REPLY
> > +};
> > +
> > +static const u32 client_key_usages[] =3D {
> > +     CEPHX_KEY_USAGE_TICKET_SESSION_KEY
> > +};
> > +
> >  static void ceph_x_validate_tickets(struct ceph_auth_client *ac, int *=
pneed);
> >
> >  static int ceph_x_is_authenticated(struct ceph_auth_client *ac)
> > @@ -57,6 +73,7 @@ static int ceph_x_encrypt_offset(const struct ceph_cr=
ypto_key *key)
> >
> >  /*
> >   * AES: ciphertext_len | hdr | data... | padding
> > + * AES256KRB5: ciphertext_len | confounder | hdr | data... | hmac
> >   */
> >  static int ceph_x_encrypt_buflen(const struct ceph_crypto_key *key,
> >                                int data_len)
> > @@ -65,19 +82,19 @@ static int ceph_x_encrypt_buflen(const struct ceph_=
crypto_key *key,
> >       return sizeof(u32) + ceph_crypt_buflen(key, encrypt_len);
> >  }
> >
> > -static int ceph_x_encrypt(struct ceph_crypto_key *secret, void *buf,
> > -                       int buf_len, int plaintext_len)
> > +static int ceph_x_encrypt(const struct ceph_crypto_key *key, int usage=
_slot,
> > +                       void *buf, int buf_len, int plaintext_len)
> >  {
> >       struct ceph_x_encrypt_header *hdr;
> >       int ciphertext_len;
> >       int ret;
> >
> > -     hdr =3D buf + sizeof(u32) + ceph_crypt_data_offset(secret);
> > +     hdr =3D buf + sizeof(u32) + ceph_crypt_data_offset(key);
>
> What about to have a named constant for this sizeof(u32)?

Already covered on another patch  -- this is the ciphertext_len thing,
all pre-existing code.

>
> >       hdr->struct_v =3D 1;
> >       hdr->magic =3D cpu_to_le64(CEPHX_ENC_MAGIC);
> >
> > -     ret =3D ceph_crypt(secret, true, buf + sizeof(u32), buf_len - siz=
eof(u32),
> > -                      plaintext_len + sizeof(struct ceph_x_encrypt_hea=
der),
> > +     ret =3D ceph_crypt(key, usage_slot, true, buf + sizeof(u32),
> > +                      buf_len - sizeof(u32), plaintext_len + sizeof(*h=
dr),
>
> Ditto.
>
> >                        &ciphertext_len);
> >       if (ret)
> >               return ret;
> > @@ -86,19 +103,19 @@ static int ceph_x_encrypt(struct ceph_crypto_key *=
secret, void *buf,
> >       return sizeof(u32) + ciphertext_len;
> >  }
> >
> > -static int __ceph_x_decrypt(struct ceph_crypto_key *secret, void *p,
> > -                         int ciphertext_len)
> > +static int __ceph_x_decrypt(const struct ceph_crypto_key *key, int usa=
ge_slot,
> > +                         void *p, int ciphertext_len)
> >  {
> >       struct ceph_x_encrypt_header *hdr;
> >       int plaintext_len;
> >       int ret;
> >
> > -     ret =3D ceph_crypt(secret, false, p, ciphertext_len, ciphertext_l=
en,
> > -                      &plaintext_len);
> > +     ret =3D ceph_crypt(key, usage_slot, false, p, ciphertext_len,
> > +                      ciphertext_len, &plaintext_len);
> >       if (ret)
> >               return ret;
> >
> > -     hdr =3D p + ceph_crypt_data_offset(secret);
> > +     hdr =3D p + ceph_crypt_data_offset(key);
> >       if (le64_to_cpu(hdr->magic) !=3D CEPHX_ENC_MAGIC) {
> >               pr_err("%s bad magic\n", __func__);
> >               return -EINVAL;
> > @@ -107,7 +124,8 @@ static int __ceph_x_decrypt(struct ceph_crypto_key =
*secret, void *p,
> >       return plaintext_len - sizeof(*hdr);
> >  }
> >
> > -static int ceph_x_decrypt(struct ceph_crypto_key *secret, void **p, vo=
id *end)
> > +static int ceph_x_decrypt(const struct ceph_crypto_key *key, int usage=
_slot,
> > +                       void **p, void *end)
> >  {
> >       int ciphertext_len;
> >       int ret;
> > @@ -115,7 +133,7 @@ static int ceph_x_decrypt(struct ceph_crypto_key *s=
ecret, void **p, void *end)
> >       ceph_decode_32_safe(p, end, ciphertext_len, e_inval);
> >       ceph_decode_need(p, end, ciphertext_len, e_inval);
> >
> > -     ret =3D __ceph_x_decrypt(secret, *p, ciphertext_len);
> > +     ret =3D __ceph_x_decrypt(key, usage_slot, *p, ciphertext_len);
> >       if (ret < 0)
> >               return ret;
> >
> > @@ -207,7 +225,9 @@ static int process_one_ticket(struct ceph_auth_clie=
nt *ac,
> >
> >       /* blob for me */
> >       dp =3D *p + ceph_x_encrypt_offset(secret);
> > -     ret =3D ceph_x_decrypt(secret, p, end);
> > +     ret =3D ceph_x_decrypt(secret,
> > +                          0 /* CEPHX_KEY_USAGE_TICKET_SESSION_KEY */,
>
> This looks really confusing. If we have the named constant already, then =
what's
> the point to comment it instead of using it?

The named constant in question has a different value:

  #define CEPHX_KEY_USAGE_TICKET_SESSION_KEY   0x04

Notice that the respective ceph_x_decrypt() parameter is named
usage_slot, not key_usage or something like that.  The 0 here selects
the first of the three available key usage slots -- the one that gets
set up to correspond to CEPHX_KEY_USAGE_TICKET_SESSION_KEY at prepare
time.

>
> > +                          p, end);
> >       if (ret < 0)
> >               goto out;
> >       dout(" decrypted %d bytes\n", ret);
> > @@ -221,7 +241,8 @@ static int process_one_ticket(struct ceph_auth_clie=
nt *ac,
> >       if (ret)
> >               goto out;
> >
> > -     ret =3D ceph_crypto_key_prepare(&new_session_key);
> > +     ret =3D ceph_crypto_key_prepare(&new_session_key, ticket_key_usag=
es,
> > +                                   ARRAY_SIZE(ticket_key_usages));
> >       if (ret)
> >               goto out;
> >
> > @@ -238,7 +259,9 @@ static int process_one_ticket(struct ceph_auth_clie=
nt *ac,
> >       if (is_enc) {
> >               /* encrypted */
> >               tp =3D *p + ceph_x_encrypt_offset(&th->session_key);
> > -             ret =3D ceph_x_decrypt(&th->session_key, p, end);
> > +             ret =3D ceph_x_decrypt(&th->session_key,
> > +                                  1 /* CEPHX_KEY_USAGE_TICKET_BLOB */,
>
> Ditto.
>
> > +                                  p, end);
> >               if (ret < 0)
> >                       goto out;
> >               dout(" encrypted ticket, decrypted %d bytes\n", ret);
> > @@ -341,7 +364,9 @@ static int encrypt_authorizer(struct ceph_x_authori=
zer *au,
> >               msg_b->server_challenge_plus_one =3D 0;
> >       }
> >
> > -     ret =3D ceph_x_encrypt(&au->session_key, p, end - p, sizeof(*msg_=
b));
> > +     ret =3D ceph_x_encrypt(&au->session_key,
> > +                          0 /* CEPHX_KEY_USAGE_AUTHORIZE */,
>
> Ditto.
>
> > +                          p, end - p, sizeof(*msg_b));
> >       if (ret < 0)
> >               return ret;
> >
> > @@ -384,7 +409,8 @@ static int ceph_x_build_authorizer(struct ceph_auth=
_client *ac,
> >       if (ret)
> >               goto out_au;
> >
> > -     ret =3D ceph_crypto_key_prepare(&au->session_key);
> > +     ret =3D ceph_crypto_key_prepare(&au->session_key, authorizer_key_=
usages,
> > +                                   ARRAY_SIZE(authorizer_key_usages));
> >       if (ret)
> >               goto out_au;
> >
> > @@ -542,7 +568,8 @@ static int ceph_x_build_request(struct ceph_auth_cl=
ient *ac,
> >               get_random_bytes(&auth->client_challenge, sizeof(u64));
> >               blob->client_challenge =3D auth->client_challenge;
> >               blob->server_challenge =3D cpu_to_le64(xi->server_challen=
ge);
> > -             ret =3D ceph_x_encrypt(&xi->secret, enc_buf, CEPHX_AU_ENC=
_BUF_LEN,
> > +             ret =3D ceph_x_encrypt(&xi->secret, 0 /* dummy */,
>
> Ditto.

The "dummy" aspect is noted in the patch description:

  The existing CEPH_CRYPTO_AES remains in place and unchanged.  The
  usage_slot parameter that needed to be added to ceph_crypt() and its
  wrappers is simply ignored there.

>
> > +                                  enc_buf, CEPHX_AU_ENC_BUF_LEN,
> >                                    sizeof(*blob));
> >               if (ret < 0)
> >                       return ret;
> > @@ -656,7 +683,9 @@ static int handle_auth_session_key(struct ceph_auth=
_client *ac, u64 global_id,
> >       dout("%s connection secret blob len %d\n", __func__, len);
> >       if (len > 0) {
> >               dp =3D *p + ceph_x_encrypt_offset(&th->session_key);
> > -             ret =3D ceph_x_decrypt(&th->session_key, p, *p + len);
> > +             ret =3D ceph_x_decrypt(&th->session_key,
> > +                                  2 /* CEPHX_KEY_USAGE_AUTH_CONNECTION=
_SECRET */,
>
> Ditto.
>
> > +                                  p, *p + len);
> >               if (ret < 0)
> >                       return ret;
> >
> > @@ -820,7 +849,9 @@ static int decrypt_authorizer_challenge(struct ceph=
_crypto_key *secret,
> >       int ret;
> >
> >       /* no leading len */
> > -     ret =3D __ceph_x_decrypt(secret, challenge, challenge_len);
> > +     ret =3D __ceph_x_decrypt(secret,
> > +                            1 /* CEPHX_KEY_USAGE_AUTHORIZE_CHALLENGE *=
/,
>
> Ditto.
>
> > +                            challenge, challenge_len);
> >       if (ret < 0)
> >               return ret;
> >
> > @@ -873,7 +904,8 @@ static int decrypt_authorizer_reply(struct ceph_cry=
pto_key *secret,
> >       int ret;
> >
> >       dp =3D *p + ceph_x_encrypt_offset(secret);
> > -     ret =3D ceph_x_decrypt(secret, p, end);
> > +     ret =3D ceph_x_decrypt(secret, 2 /* CEPHX_KEY_USAGE_AUTHORIZE_REP=
LY */,
>
> Ditto.
>
> > +                          p, end);
> >       if (ret < 0)
> >               return ret;
> >
> > @@ -1004,8 +1036,9 @@ static int calc_signature(struct ceph_x_authorize=
r *au, struct ceph_msg *msg,
> >               sigblock->middle_crc =3D msg->footer.middle_crc;
> >               sigblock->data_crc =3D  msg->footer.data_crc;
> >
> > -             ret =3D ceph_x_encrypt(&au->session_key, enc_buf,
> > -                                  CEPHX_AU_ENC_BUF_LEN, sizeof(*sigblo=
ck));
> > +             ret =3D ceph_x_encrypt(&au->session_key, 0 /* dummy */,
>
> Ditto.
>
> > +                                  enc_buf, CEPHX_AU_ENC_BUF_LEN,
> > +                                  sizeof(*sigblock));
> >               if (ret < 0)
> >                       return ret;
> >
> > @@ -1036,9 +1069,9 @@ static int calc_signature(struct ceph_x_authorize=
r *au, struct ceph_msg *msg,
> >               sigblock->seq_lower_word =3D *(__le32 *)&msg->hdr.seq;
> >
> >               /* no leading len, no ceph_x_encrypt_header */
> > -             ret =3D ceph_crypt(&au->session_key, true, enc_buf,
> > -                              CEPHX_AU_ENC_BUF_LEN, sizeof(*sigblock),
> > -                              &ciphertext_len);
> > +             ret =3D ceph_crypt(&au->session_key, 0 /* dummy */,
>
> Ditto.
>
> > +                              true, enc_buf, CEPHX_AU_ENC_BUF_LEN,
> > +                              sizeof(*sigblock), &ciphertext_len);
> >               if (ret)
> >                       return ret;
> >
> > @@ -1130,7 +1163,8 @@ int ceph_x_init(struct ceph_auth_client *ac)
> >               goto err_xi;
> >       }
> >
> > -     ret =3D ceph_crypto_key_prepare(&xi->secret);
> > +     ret =3D ceph_crypto_key_prepare(&xi->secret, client_key_usages,
> > +                                   ARRAY_SIZE(client_key_usages));
> >       if (ret) {
> >               pr_err("cannot prepare key: %d\n", ret);
> >               goto err_secret;
> > diff --git a/net/ceph/auth_x_protocol.h b/net/ceph/auth_x_protocol.h
> > index 9c60feeb1bcb..d097b3651c99 100644
> > --- a/net/ceph/auth_x_protocol.h
> > +++ b/net/ceph/auth_x_protocol.h
> > @@ -6,6 +6,44 @@
> >  #define CEPHX_GET_PRINCIPAL_SESSION_KEY 0x0200
> >  #define CEPHX_GET_ROTATING_KEY          0x0400
> >
> > +/* Client <-> AuthMonitor */
> > +/*
> > + * The AUTH session's connection secret: encrypted with the AUTH
> > + * ticket session key
> > + */
> > +#define CEPHX_KEY_USAGE_AUTH_CONNECTION_SECRET       0x03
> > +/*
> > + * The ticket's blob for the client ("blob for me", contains the
> > + * session key): encrypted with the client's secret key in case of
> > + * the AUTH ticket and the AUTH ticket session key in case of other
> > + * service tickets
> > + */
> > +#define CEPHX_KEY_USAGE_TICKET_SESSION_KEY   0x04
> > +/*
> > + * The ticket's blob for the service (ceph_x_ticket_blob): possibly
> > + * encrypted with the old AUTH ticket session key in case of the AUTH
> > + * ticket and not encrypted in case of other service tickets
> > + */
> > +#define CEPHX_KEY_USAGE_TICKET_BLOB          0x05
> > +
> > +/* Client <-> Service */
> > +/*
> > + * The client's authorization request (ceph_x_authorize_b):
> > + * encrypted with the service ticket session key
> > + */
> > +#define CEPHX_KEY_USAGE_AUTHORIZE            0x10
> > +/*
> > + * The service's challenge (ceph_x_authorize_challenge):
> > + * encrypted with the service ticket session key
> > + */
> > +#define CEPHX_KEY_USAGE_AUTHORIZE_CHALLENGE  0x11
> > +/*
> > + * The service's final reply (ceph_x_authorize_reply + the service
> > + * session's connection secret): encrypted with the service ticket
> > + * session key
> > + */
> > +#define CEPHX_KEY_USAGE_AUTHORIZE_REPLY              0x12
> > +
> >  /* common bits */
> >  struct ceph_x_ticket_blob {
> >       __u8 struct_v;
> > diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
> > index 3453dc303315..b54085d8d5f0 100644
> > --- a/net/ceph/crypto.c
> > +++ b/net/ceph/crypto.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> >  #include <crypto/aes.h>
> > +#include <crypto/krb5.h>
> >  #include <crypto/skcipher.h>
> >  #include <linux/key-type.h>
> >  #include <linux/sched/mm.h>
> > @@ -22,28 +23,68 @@ static int set_aes_tfm(struct ceph_crypto_key *key)
> >       int ret;
> >
> >       noio_flag =3D memalloc_noio_save();
> > -     key->tfm =3D crypto_alloc_sync_skcipher("cbc(aes)", 0, 0);
> > +     key->aes_tfm =3D crypto_alloc_sync_skcipher("cbc(aes)", 0, 0);
> >       memalloc_noio_restore(noio_flag);
> > -     if (IS_ERR(key->tfm)) {
> > -             ret =3D PTR_ERR(key->tfm);
> > -             key->tfm =3D NULL;
> > +     if (IS_ERR(key->aes_tfm)) {
> > +             ret =3D PTR_ERR(key->aes_tfm);
> > +             key->aes_tfm =3D NULL;
> >               return ret;
> >       }
> >
> > -     ret =3D crypto_sync_skcipher_setkey(key->tfm, key->key, key->len)=
;
> > +     ret =3D crypto_sync_skcipher_setkey(key->aes_tfm, key->key, key->=
len);
> >       if (ret)
> >               return ret;
> >
> >       return 0;
> >  }
> >
> > -int ceph_crypto_key_prepare(struct ceph_crypto_key *key)
> > +static int set_krb5_tfms(struct ceph_crypto_key *key, const u32 *key_u=
sages,
> > +                      int key_usage_cnt)
> > +{
> > +     struct krb5_buffer TK =3D { .len =3D key->len, .data =3D key->key=
 };
> > +     unsigned int noio_flag;
> > +     int ret =3D 0;
> > +     int i;
> > +
> > +     if (WARN_ON_ONCE(key_usage_cnt > ARRAY_SIZE(key->krb5_tfms)))
> > +             return -EINVAL;
> > +
> > +     key->krb5_type =3D crypto_krb5_find_enctype(
> > +                          KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192);
> > +     if (!key->krb5_type)
> > +             return -ENOPKG;
> > +
> > +     /*
> > +      * Despite crypto_krb5_prepare_encryption() taking a gfp mask,
> > +      * crypto_alloc_aead() inside of it allocates with GFP_KERNEL.
> > +      */
> > +     noio_flag =3D memalloc_noio_save();
> > +     for (i =3D 0; i < key_usage_cnt; i++) {
> > +             key->krb5_tfms[i] =3D crypto_krb5_prepare_encryption(
> > +                                     key->krb5_type, &TK, key_usages[i=
],
> > +                                     GFP_NOIO);
> > +             if (IS_ERR(key->krb5_tfms[i])) {
> > +                     ret =3D PTR_ERR(key->krb5_tfms[i]);
> > +                     key->krb5_tfms[i] =3D NULL;
> > +                     goto out_flag;
> > +             }
> > +     }
> > +
> > +out_flag:
> > +     memalloc_noio_restore(noio_flag);
> > +     return ret;
> > +}
> > +
> > +int ceph_crypto_key_prepare(struct ceph_crypto_key *key,
> > +                         const u32 *key_usages, int key_usage_cnt)
> >  {
> >       switch (key->type) {
> >       case CEPH_CRYPTO_NONE:
> >               return 0; /* nothing to do */
> >       case CEPH_CRYPTO_AES:
> >               return set_aes_tfm(key);
> > +     case CEPH_CRYPTO_AES256KRB5:
> > +             return set_krb5_tfms(key, key_usages, key_usage_cnt);
> >       default:
> >               return -ENOTSUPP;
> >       }
> > @@ -123,12 +164,25 @@ int ceph_crypto_key_unarmor(struct ceph_crypto_ke=
y *key, const char *inkey)
> >
> >  void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
> >  {
> > -     if (key) {
> > -             kfree_sensitive(key->key);
> > -             key->key =3D NULL;
> > -             if (key->tfm) {
> > -                     crypto_free_sync_skcipher(key->tfm);
> > -                     key->tfm =3D NULL;
> > +     int i;
> > +
> > +     if (!key)
> > +             return;
> > +
> > +     kfree_sensitive(key->key);
> > +     key->key =3D NULL;
>
> The key->key looks strange. :) Maybe, another name like crypto_key?

It could certainly be named differently, but this name goes back to
2010.  I don't think a wholesale rename is in scope for this series.

>
> > +
> > +     if (key->type =3D=3D CEPH_CRYPTO_AES) {
> > +             if (key->aes_tfm) {
> > +                     crypto_free_sync_skcipher(key->aes_tfm);
> > +                     key->aes_tfm =3D NULL;
> > +             }
> > +     } else if (key->type =3D=3D CEPH_CRYPTO_AES256KRB5) {
> > +             for (i =3D 0; i < ARRAY_SIZE(key->krb5_tfms); i++) {
> > +                     if (key->krb5_tfms[i]) {
> > +                             crypto_free_aead(key->krb5_tfms[i]);
> > +                             key->krb5_tfms[i] =3D NULL;
> > +                     }
> >               }
> >       }
> >  }
> > @@ -208,7 +262,7 @@ static void teardown_sgtable(struct sg_table *sgt)
> >  static int ceph_aes_crypt(const struct ceph_crypto_key *key, bool encr=
ypt,
> >                         void *buf, int buf_len, int in_len, int *pout_l=
en)
> >  {
> > -     SYNC_SKCIPHER_REQUEST_ON_STACK(req, key->tfm);
> > +     SYNC_SKCIPHER_REQUEST_ON_STACK(req, key->aes_tfm);
> >       struct sg_table sgt;
> >       struct scatterlist prealloc_sg;
> >       char iv[AES_BLOCK_SIZE] __aligned(8);
> > @@ -224,7 +278,7 @@ static int ceph_aes_crypt(const struct ceph_crypto_=
key *key, bool encrypt,
> >               return ret;
> >
> >       memcpy(iv, aes_iv, AES_BLOCK_SIZE);
> > -     skcipher_request_set_sync_tfm(req, key->tfm);
> > +     skcipher_request_set_sync_tfm(req, key->aes_tfm);
> >       skcipher_request_set_callback(req, 0, NULL, NULL);
> >       skcipher_request_set_crypt(req, sgt.sgl, sgt.sgl, crypt_len, iv);
> >
> > @@ -269,7 +323,68 @@ static int ceph_aes_crypt(const struct ceph_crypto=
_key *key, bool encrypt,
> >       return ret;
> >  }
> >
> > -int ceph_crypt(const struct ceph_crypto_key *key, bool encrypt,
> > +static int ceph_krb5_encrypt(const struct ceph_crypto_key *key, int us=
age_slot,
> > +                          void *buf, int buf_len, int in_len, int *pou=
t_len)
>
> If we have really many function's arguments, then, maybe, we need to intr=
oduce
> some structure?

I wouldn't say that six arguments is "really many" -- on x86-64 they
all are likely to be passed in registers and it's a rather manageable
number in general IMO.  See how the crypto API method that this is
built upon takes eight arguments, for example.

>
> > +{
> > +     struct sg_table sgt;
> > +     struct scatterlist prealloc_sg;
> > +     int ret;
> > +
> > +     if (WARN_ON_ONCE(usage_slot >=3D ARRAY_SIZE(key->krb5_tfms)))
> > +             return -EINVAL;
> > +
> > +     ret =3D setup_sgtable(&sgt, &prealloc_sg, buf, buf_len);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D crypto_krb5_encrypt(key->krb5_type, key->krb5_tfms[usage_=
slot],
> > +                               sgt.sgl, sgt.nents, buf_len, AES_BLOCK_=
SIZE,
> > +                               in_len, false);
> > +     if (ret < 0) {
> > +             pr_err("%s encrypt failed: %d\n", __func__, ret);
> > +             goto out_sgt;
> > +     }
> > +
> > +     *pout_len =3D ret;
> > +     ret =3D 0;
> > +
> > +out_sgt:
> > +     teardown_sgtable(&sgt);
> > +     return ret;
> > +}
> > +
> > +static int ceph_krb5_decrypt(const struct ceph_crypto_key *key, int us=
age_slot,
> > +                          void *buf, int buf_len, int in_len, int *pou=
t_len)
> > +{
> > +     struct sg_table sgt;
> > +     struct scatterlist prealloc_sg;
> > +     size_t data_off =3D 0;
> > +     size_t data_len =3D in_len;
> > +     int ret;
> > +
> > +     if (WARN_ON_ONCE(usage_slot >=3D ARRAY_SIZE(key->krb5_tfms)))
> > +             return -EINVAL;
> > +
> > +     ret =3D setup_sgtable(&sgt, &prealloc_sg, buf, in_len);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D crypto_krb5_decrypt(key->krb5_type, key->krb5_tfms[usage_=
slot],
> > +                               sgt.sgl, sgt.nents, &data_off, &data_le=
n);
> > +     if (ret) {
> > +             pr_err("%s decrypt failed: %d\n", __func__, ret);
> > +             goto out_sgt;
> > +     }
> > +
> > +     WARN_ON(data_off !=3D AES_BLOCK_SIZE);
> > +     *pout_len =3D data_len;
> > +
> > +out_sgt:
> > +     teardown_sgtable(&sgt);
> > +     return ret;
> > +}
> > +
> > +int ceph_crypt(const struct ceph_crypto_key *key, int usage_slot, bool=
 encrypt,
> >              void *buf, int buf_len, int in_len, int *pout_len)
> >  {
> >       switch (key->type) {
> > @@ -279,6 +394,12 @@ int ceph_crypt(const struct ceph_crypto_key *key, =
bool encrypt,
> >       case CEPH_CRYPTO_AES:
> >               return ceph_aes_crypt(key, encrypt, buf, buf_len, in_len,
> >                                     pout_len);
> > +     case CEPH_CRYPTO_AES256KRB5:
> > +             return encrypt ?
> > +                 ceph_krb5_encrypt(key, usage_slot, buf, buf_len, in_l=
en,
> > +                                   pout_len) :
> > +                 ceph_krb5_decrypt(key, usage_slot, buf, buf_len, in_l=
en,
> > +                                   pout_len);
> >       default:
> >               return -ENOTSUPP;
> >       }
> > @@ -290,6 +411,9 @@ int ceph_crypt_data_offset(const struct ceph_crypto=
_key *key)
> >       case CEPH_CRYPTO_NONE:
> >       case CEPH_CRYPTO_AES:
> >               return 0;
> > +     case CEPH_CRYPTO_AES256KRB5:
> > +             /* confounder */
>
> Frankly speaking, I don't follow what this comment imply. :)

Confounder is a random string that the plaintext is prepended with
before being encrypted.  This is an established term, it's used in RFC
8009 and some other places.  Think of it as a kind of initialization
vector (IV) in the context of CBC encryption.

The comment then implies that in case of CEPH_CRYPTO_AES256KRB5 the
space that ceph_crypt_data_offset() accounts for gets taken up by the
confounder.

Thanks,

                Ilya
