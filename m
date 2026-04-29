Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4471413237
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 18:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489189; cv=pass; b=V0XoY9xy92Hg5A9AdcCFlA5rtsF+rqOwMdS1ert14fuyiRbs5JC5l+AMaiVaWbbqigix/7/J5VfQUQ+ujcdRmcnDw25Zm4xqGqGR3HQp71RFAnc4minbYaLivLu0o7qrs4BBLvHNy+D3PWwFAfXJqGF+1i8slPnvPh1l6M/+yag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489189; c=relaxed/simple;
	bh=ETEpwvog7amcbPjyek3cTY+8sS7WhfOgn52QljsD/fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfDYLHEKWDI/UiqE5rUcqyqEhZEm5zHZX+M46BN5T4WMJog3CuGQhLgqhHXgg/PaLi4TUTjyQ6ickw+6sF/XxzfDtbjDdvViUpcG3cCu/ohf9Tw9O3f5gVmGTFv/db3kdAs/QeG+bdXcO+qvfnC00N2jeQ3BgQa41cFP9VCFHy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DH9dzwy/; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH9dzwy/"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-6120528b8b4so43225137.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 11:59:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777489185; cv=none;
        d=google.com; s=arc-20240605;
        b=aNT8CnUKpoz4xv+5AZUfthTPo/kBJDhW3k7HjgQ1AqouU6lZf7Zp0yZt8wct+Qokfb
         mfdWw1u3IaRTa3ATJxnq+nCWFrG7RNef1vk93S4uPgYCbdL1GqPPZFNcwG0apJr4yfSi
         bjJsEjDf/5npMa9VQbJcPZYbjArxLTfLIfy2xtSm99u5wgf4c1dTwmvUyGKwQTumDWtX
         yHNz76eu4Fyim+ROTl1bbBQziw3md/FXmU3VpJshJv5rvxkH0utzZkyWC1D5tZc9y25Y
         Nage1ZuoIOvllxTQLcEByP0TVfrXhv23d5f8tKB84G3WnyrD74gTfVGm/AjsXyPNxBst
         LMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2KCuM1P9mBYmxC7Bw7CC87mRRZQBSTPRh1bUme1YG24=;
        fh=ndDzVHfVcJyVlC4JrG085btohmOY+UaBkeMgWfl04NI=;
        b=I9p3JYOzq/qrgrRXAR03xGCgWsyXU/5j3OKulX8exd6NwmqgYf7ej+KrhldnFkUHSz
         fvJq0fn+7qnuJEeSF/0KkFSvvijdh5a1j7257FDtTyUewrBGFHb9bD1WZD5t7HMhMW1J
         ebpYTCZ5LRrvJberXQxzYBrB8kkaRz4WCeTyIGkjKdA/5hZunRRlrbboya68w3Ftte0/
         UP8J4NzQgn6KAhMYGZPj7WS2flG5ujoW48mYCpLXlmblCTzAwZy+34D/YCNv/TpB0/T6
         pb/OrDcV0J0IFCVEHUYavhrlrBCzyXcfFo3/AzpZSZmIAC5XVgWT3XsFGov1KZjwdwMK
         WC3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777489185; x=1778093985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KCuM1P9mBYmxC7Bw7CC87mRRZQBSTPRh1bUme1YG24=;
        b=DH9dzwy/V+Hqm8Ltelhly0nGrPBX5tC+j2E125lIERbY/0+R51XT4XOhdrrTqsJp6T
         b8DV04XY1aosNWjf+09d/TVuj/A7AIhKjW0YWGAPxc6Kc8vJZMDla/z38GwEyx5SWVay
         j3hsUrTthArMAcajqxyRb1IAnKXIuUodYF4jbN3pv7F2SDKIeZ4yjcOoGW8OOXkr/h1i
         bupRuYMEbTkYmq0ot24Un/K1weTguFd9Chyxux2XArDsPHfHBbVaRBDFfHd0fZz3zs9V
         6a+O+0go+DZi1pkV3neJjh2haPczwywo9f/+gq1IBDacTj2NHKCG1sOp2vCivkMsMFh6
         ybPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777489185; x=1778093985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2KCuM1P9mBYmxC7Bw7CC87mRRZQBSTPRh1bUme1YG24=;
        b=Tp/hgXUrAiCDmF6zH+ExFBiEG9sUKZ6VFkxTM486Y5Ti+cvQn2lWuT5aIZhW8mKu9a
         kHs0FSqR/24c/B3pecQ7SEQOlHPZ04aKQhBz02rRNNwK9/bvTE1KU26WfMPevLrnCvBM
         FydoFL0lDVw1UB3qmqdylf8HmZ10lMFo9YwI1KdTFUCipTIIpZ2g52xkoJp7avcEn3es
         QUE+ZzThbtGmUSRoQWf2yVlIoJkYJ8KLUwjbtyLVF7iapQXZVu6G1MwdekxEK5x4CMyd
         Xo8S94qI9S7Jau1TbNmtaxPuOU0mCW+e5Skypk3hiC9vutwjy6wo3GfIH/bxBnGVzw8P
         OFUw==
X-Forwarded-Encrypted: i=1; AFNElJ/8QQaeE9rCXRKtiP+Vi+MyZCy426dyZWPSG5M1mLVUxPcOPAx4Gf3bKCOxGzN6+cGV3O21VjpxwYsP@vger.kernel.org
X-Gm-Message-State: AOJu0YySWQjzk9Wm4kuy1HIy4ZTvv+Se7qsDcAxuBWLi4K6WkjcxQLsF
	FKrbLuqunuk8gXf09viSCYBp9TwO4LJDgFpJwO7Pd4JUxprIWaFlDR8GZ/Cxli1sdRkCnD7UbR7
	tWioSTlJDzUufdbRf5wLWYg5SLVsW1k7h1UJ5
X-Gm-Gg: AeBDiesC5yMNl1PMlQTcdd9+epdqrHsg4qPtSY/BvYLc1Kuawgi8PCbSupUGoKwEgEq
	XnGi5xGgLUYlhN1eOrfJoEV8lYzGcY804PfORDVruz1+xWh4YSpmHYlVUnTUX3b6ldmbm3fJCCS
	/nHvCOe+3WAIWbvtOTphJo8c9X8CKhRllITgwQ/ygHQiLXzLewrJqbzApV/J4xuIhLDANP3jkf5
	ZQove16U8GLMmSy/o8IBlLfoPDI+L9VaynlBQ25VzWqJR6BNpc8pwjsW2i8/WPa9E42Rp9wahQ3
	VBpnlCT7jXjk93JXTg==
X-Received: by 2002:a05:6102:4b0c:b0:60f:928f:bf98 with SMTP id
 ada2fe7eead31-6280a3a7eb6mr5064592137.17.1777489184952; Wed, 29 Apr 2026
 11:59:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428121546.148369-1-raphael.zimmer@tu-ilmenau.de>
 <58f52c8a-54ae-4982-ba68-a9a9d138f484@redhat.com> <CAOi1vP8NgWN3LseLR9ynP+gEWQ8E_0_e=CZAOCpwBpPQr_Y+wQ@mail.gmail.com>
 <ad0638ff-6591-4732-996f-73f15aaeb9fd@tu-ilmenau.de>
In-Reply-To: <ad0638ff-6591-4732-996f-73f15aaeb9fd@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 29 Apr 2026 20:59:33 +0200
X-Gm-Features: AVHnY4JE55PW4TaKB-K1Nq28tfuSbBYxZeLXsJ9zS2TFxUxnu-8gFQ_-Eu6-Idk
Message-ID: <CAOi1vP-bmNHhi342EKW=5rHxMY9VGo0FhgmiO6+uy0icerrF6Q@mail.gmail.com>
Subject: Re: [PATCH v2] libceph: Fix potential out-of-bounds access in __ceph_x_decrypt()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Xiubo Li <xiubli@redhat.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 1:04=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> On 29.04.26 10:41 AM, Ilya Dryomov wrote:
> > On Wed, Apr 29, 2026 at 2:51=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wr=
ote:
> >>
> >> Hi Raphael,
> >>
> >> On 4/28/26 20:15, Raphael Zimmer wrote:
> >>> In __ceph_x_decrypt(), a part of the buffer p is interpreted as a
> >>> ceph_x_encrypt_header, and the magic field of this struct is accessed=
.
> >>> This happens without any guarantee that the buffer is large enough to
> >>> hold this struct. The function parameter ciphertext_len represents th=
e
> >>> length of the ciphertext to decrypt and is guaranteed to be at most t=
he
> >>> remaining size of the allocated buffer p. However, this value is not
> >>> necessarily greater than sizeof(ceph_x_encrypt_header). E.g., a messa=
ge
> >>> frame of type FRAME_TAG_AUTH_REPLY_MORE, that is just as long to hold
> >>> the ciphertext at its end with a ciphertext_len of 8 or less, can
> >>> trigger an out-of-bounds memory access when accessing hdr->magic.
> >>>
> >>> This patch fixes the issue by adding a check to ensure that the
> >>> decrypted plaintext in the buffer is large enough to represent at lea=
st
> >>> the ceph_x_encrypt_header.
> >>>
> >>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> >>> ---
> >>>   net/ceph/auth_x.c | 5 +++++
> >>>   1 file changed, 5 insertions(+)
> >>>
> >>> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> >>> index 692e0b868822..9e64e82d0b63 100644
> >>> --- a/net/ceph/auth_x.c
> >>> +++ b/net/ceph/auth_x.c
> >>> @@ -115,6 +115,11 @@ static int __ceph_x_decrypt(const struct ceph_cr=
ypto_key *key, int usage_slot,
> >>>       if (ret)
> >>>               return ret;
> >>>
> >>> +     if (plaintext_len < sizeof(*hdr)) {
> >>> +             pr_err("%s plaintext too small %d\n", __func__, plainte=
xt_len);
> >>> +             return -EINVAL;
> >>> +     }
> >>> +
> >>
> >> You just check the AES/NONE case, which the plaintext_len >=3D 0 +
> >> sizeof(struct ceph_x_encrypt_header). While for AES256KRB5 the
> >> plaintext_len >=3D 16 + sizeof(struct ceph_x_encrypt_header).
> >
> > Hi Xiubo,
> >
> > I don't think that is the case.  plaintext_len is the length of the
> > payload that was encrypted, it doesn't vary depending on the encryption
> > scheme (only AES vs AES256KRB5 -- __ceph_x_decrypt() wouldn't ever get
> > called for NONE).  For both AES and AES256KRB5 that payload is whatever
> > the original caller actually wanted to encrypt prepended by hdr (struct
> > ceph_x_encrypt_header).  See the comment on ceph_x_encrypt_buflen():
> >
> >   AES: ciphertext_len | hdr | data... | padding
> >   AES256KRB5: ciphertext_len | confounder | hdr | data... | hmac
> >
> > plaintext_len covers hdr | data... and nothing else.  Anything extra
> > like padding in AES case or confounder and hmac in AES256KRB5 case gets
> > added during encryption and subtracted during decryption and is never
> > surfaced by ceph_crypt().
> >
> > Thanks,
> >
> >                 Ilya
> >
>
> Hi Xiubo, Ilya,
> I agree with Ilya that AES256KRB5 doesn't require a different handling
> as explained and it would in fact be incorrect to check for
> plaintext_len < ceph_crypt_data_offset(key) + sizeof(*hdr).
> But I wouldn't say that it can't be called for NONE. It may never happen
> in a normal/correct authentication dialog. But with a peer sending some
> weird message sequence, you can absolutely end up in __ceph_x_decrypt()
> with a key of type NONE. However, in this case plaintext_len <
> sizeof(*hdr) will also be a valid check preventing hdr->magic from
> accessing out-of-bounds memory.

Hi Raphael,

I suppose what you have a mind is a fictitious endpoint that would
initially behave like an actual Ceph monitor, but then, after pretending
to successfully negotiate CEPH_AUTH_CEPHX protocol, all of a sudden
feed the client a NONE key in one of the tickets?

Thanks,

                Ilya
