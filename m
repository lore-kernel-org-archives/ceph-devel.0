Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB05D372B3D
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2026 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674687; cv=pass; b=JVZAoAaJceNqbw52LYu4pd4XvetuC+SMxTmXFcgkaLbma/5vymnraKqfq+jgX19QOJEKvJei17wa8kYhKF/tixXgFBF1ydiKvU/GnMboJ1r7La8ahT6JfPnzYMdUIDRlP0Pa3QZf9Hrzj9xYKpObDg4xrdgRmMXOOuslRB6n4I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674687; c=relaxed/simple;
	bh=6CMMHMAm83swb1A52YcIzcwxVobyR/2gao7M5xyE1Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1BA+qcbRe3arkQ2G5uLYVjnV/E2xXg7IVWnt4KZe+p8BvFraeoF0oA86RLprZgJrAKjrPoNqzP0Fv9W07QymzALHZ6zDAsEy7S9oslajU7LT88ilKR61ju1Z5X6whS3JZihA3e3rSD8I5gCFaC6v+QPXlaM4mWVpIpr95Rr2p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvCAzh8N; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvCAzh8N"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12339e2e2c1so445608c88.1
        for <ceph-devel@vger.kernel.org>; Thu, 29 Jan 2026 00:18:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769674685; cv=none;
        d=google.com; s=arc-20240605;
        b=ZBhrTRIyfto1HlXoMKhrzPrr4he9nQLY7Ghk6Hzs+nmgOG+zqjLA4/wkWZ0MRyRBNl
         y3PnJIxnyQU8w828SgJ2P/6miRGGfilXeChlz54ieCf+PGqo5hb5/xetpf4I4ez2mAoi
         FvLonwUUSpYW6+jfQIrQ7Mu4ZqnO4evXqG4SqAH71DNtTYygGKpjEPyWA73qIXoPZkfK
         0rHdbyLAlM7A9ePbV9++pIB12xGnOTmJQnDR9Jk1wmb9lyS19tTu6eF1+Ec63bo/hjCa
         j2EUB33gVH9ZR08oFlsfus9455rCjSsJgZB+9P0tpvk7PznmtyRQKxpyZIMe9K7ssNiR
         Ksew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7wAk+BDVMPKCwcuryA0cv8GSRpwUD085xIMaymIZssQ=;
        fh=D1e4OHpRyrDipzsfYikirxIIWWvtZiwEJENyMeAbPDU=;
        b=agveELEjH5uBTaYUHUgDjLhcCRtq2IBPkjEB3QnVu/s/5tbdvBPCbeeFjWwBwDOH4H
         wr3uXevK5ESF781c7YYgFQ1jJNc7UIQavfInNL0jULbSU6W+eThPEkzAbFGQOybMtVil
         Qg1k5f7uJoTlaETViFm1w7FYbblR6O6/AtXSYLccPF0GPV00P7bHevh8KBuGdWpMxetA
         hLpfN3+P3FYENzUajmkNbeiD8HqZE7hAGTkiJ/EEm1k2oajBa3G0mQRHjEQqK3OOg2co
         1OPcRyUIPX44mKmGkbWWZwpFu7CdTXOlnIAOkZBSS7IYgk/3EqvCP4K4vTHMHYKAeDCA
         j+NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769674685; x=1770279485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wAk+BDVMPKCwcuryA0cv8GSRpwUD085xIMaymIZssQ=;
        b=TvCAzh8NUFFgJKWfIzYQz8dEkk+TjVMAvyz5WGL+/bQyVBpTTyulqtITn6Ot2Cq8X8
         hcz2F/UySICL6SSyJxx9JymKPb2waDLC+GDOfKACcXW+Dd8YFg1PxOTf3Y83AKswz5tm
         m6ck3neTWzq/jJFemGV+/I+80J0Ck67WvPv/EA//DV7T4KLFcKEAMllDZD4c8QGQ6lGc
         iUZJwRUYwP3Uve0R8CYOn6+eC/9B67YrrA/dH7IDV4abg4GgEX7+Hu/Rx6ZuFEXrn/56
         2PvnITsQ48rKLk0eXqOR1AtYhlkmqWQq6ASpg+TFkLjwaHG6IezIbiQmWhrRF/m0i5ay
         nODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769674685; x=1770279485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7wAk+BDVMPKCwcuryA0cv8GSRpwUD085xIMaymIZssQ=;
        b=Haj8vfb8m8zB3qRdlQzxyMdCb7vMKIcYJUgw96zwcyebgLVlv5chQXW/xpuPmgfvlN
         Qs2TGoQSnUDtBKavjGlYWXxyYwa9pX6PGd9qjOvybZsP1sq2+EIfYHYhqno9kWnbPfba
         4Xzl1RR+/CnGPNemzAtrkV2bWFTRh25DNPYfYrgiALnPW7kYd5WMHWpqjdQ3hgxBageA
         IwRZaV8U6Q+gnXWU0wJl20VGCswOg7EoAzon/D1x96lFAjyuk15QqVOenOfYBcZv7TUW
         vIakGtDwOp3GBuE0S7iWQoCXdC5BdVv8owpsq3F0RzAw8X6PQ6SdzU0l5Kc3nngmzCBA
         oQWg==
X-Gm-Message-State: AOJu0YxE9CbtCwejSzNirVtQCbzc5Zbm4fOqcdLSOK8vVIS3+6AaQFsk
	ectZYKT4wxaredjTCWDZtXINu6S8dQ1JZiFldQ99yDcKx0xF7HTh7H04VoomGSAAEyVVF4BmhuR
	xsemSYJYKQ30vYYbb4GF53uESJRvxTGA=
X-Gm-Gg: AZuq6aL7RHaR3rF15KlKIoibZO2GPcyvdT5fL+yschNmfy+APTVoVI0zdQa22OThZzH
	IJroQ1JZN5IWo1UnchPhqbK4W1JUP4BQ4A4iFCrNkuWGRRST4LJBg+XlqDPl91QZhLBL05N0RGC
	GHzRG0Ty60QOLiy7ZzC1S/zYdtu4kLesIMr+gAEd5i+bVe+vloMARChfOTQfq0vB1m2t/WndVUc
	iNmN7tVMkpjOCmJp+26r8rWBBE27XQll9PZGlOMEhMYCo1kMghbvbJgBgT7WgzgVCb01TZPRHhJ
	CgbkBg==
X-Received: by 2002:a05:7022:ea28:b0:11d:fbf1:1e27 with SMTP id
 a92af1059eb24-124b105e89cmr874117c88.19.1769674684881; Thu, 29 Jan 2026
 00:18:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128103329.964466-1-idryomov@gmail.com> <20260128103329.964466-2-idryomov@gmail.com>
 <a70727fde6f4030181481f82f5c0c292cfd266bb.camel@ibm.com>
In-Reply-To: <a70727fde6f4030181481f82f5c0c292cfd266bb.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 29 Jan 2026 09:17:53 +0100
X-Gm-Features: AZwV_QgR5sSdDjZxzP0wFKgK8_hxcztu--lebV5pH-_ZASs0lpb-rCIYf7cMTl8
Message-ID: <CAOi1vP8ggM1eZFz0KodZ79rERke5Ue60-sEwow1enWOdnzwaEw@mail.gmail.com>
Subject: Re: [PATCH 1/5] libceph: define and enforce CEPH_MAX_KEY_LEN
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	Patrick Donnelly <pdonnell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 9:37=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2026-01-28 at 11:33 +0100, Ilya Dryomov wrote:
> > When decoding the key, verify that the key material would fit into
> > a fixed-size buffer in process_auth_done() and generally has a sane
> > length.
> >
> > The new CEPH_MAX_KEY_LEN check replaces the existing check for a key
> > with no key material which is a) not universal since CEPH_CRYPTO_NONE
> > has to be excluded and b) doesn't provide much value since a smaller
> > than needed key is just as invalid as no key -- this has to be handled
> > elsewhere anyway.
> >
> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > ---
> >  net/ceph/crypto.c       | 8 +++++---
> >  net/ceph/crypto.h       | 2 +-
> >  net/ceph/messenger_v2.c | 2 +-
> >  3 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
> > index 01b2ce1e8fc0..5601732cf4fa 100644
> > --- a/net/ceph/crypto.c
> > +++ b/net/ceph/crypto.c
> > @@ -37,9 +37,6 @@ static int set_secret(struct ceph_crypto_key *key, vo=
id *buf)
> >               return -ENOTSUPP;
> >       }
> >
> > -     if (!key->len)
> > -             return -EINVAL;
>
> Are you sure that this check is not necessary? What is the motivation tha=
t we
> can remove this check?

Hi Slava,

The motivation is explained in the patch description:

  The new CEPH_MAX_KEY_LEN check replaces the existing check for a key
  with no key material which is a) not universal since CEPH_CRYPTO_NONE
  has to be excluded and b) doesn't provide much value since a smaller
  than needed key is just as invalid as no key -- this has to be handled
  elsewhere anyway.

The important point is (b): I don't see much sense in explicitly
denying 0-byte keys but accepting e.g. 1-byte keys.  Both will be
rejected by crypto_sync_skcipher_setkey() later anyway.

>
> Could be key->len bigger than CEPH_MAX_KEY_LEN?

Not if everything is working as expected.  But in theory anything is
possible because the key that we start with is essentially user input
and therefore can easily be malformed -- hence this change.

>
> > -
> >       key->key =3D kmemdup(buf, key->len, GFP_NOIO);
> >       if (!key->key) {
> >               ret =3D -ENOMEM;
> > @@ -83,6 +80,11 @@ int ceph_crypto_key_decode(struct ceph_crypto_key *k=
ey, void **p, void *end)
> >       ceph_decode_copy(p, &key->created, sizeof(key->created));
> >       key->len =3D ceph_decode_16(p);
> >       ceph_decode_need(p, end, key->len, bad);
> > +     if (key->len > CEPH_MAX_KEY_LEN) {
> > +             pr_err("secret too big %d\n", key->len);
> > +             return -EINVAL;
> > +     }
> > +
> >       ret =3D set_secret(key, *p);
> >       memzero_explicit(*p, key->len);
> >       *p +=3D key->len;
> > diff --git a/net/ceph/crypto.h b/net/ceph/crypto.h
> > index 23de29fc613c..a20bad6d1e96 100644
> > --- a/net/ceph/crypto.h
> > +++ b/net/ceph/crypto.h
> > @@ -5,7 +5,7 @@
> >  #include <linux/ceph/types.h>
> >  #include <linux/ceph/buffer.h>
> >
> > -#define CEPH_KEY_LEN                 16
> > +#define CEPH_MAX_KEY_LEN             16
>
> Frankly speaking, I don't quite follow what was the point to change the c=
onstant
> name?

CEPH_CRYPTO_AES256KRB5 is going to operate on 32-byte keys.  And,
irrespective of that, having MAX in the name communicates the intended
usage better.

Thanks,

                Ilya
