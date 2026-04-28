Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D89359A6C
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401786; cv=pass; b=NvHUv4aB3FBrsRhqmIMvBGEjtqOFaQ+HWVs4kZ+cEYnKixNVcGsAHSaVWaE/ZY58V+H00sRpkgC+nDBjGH5pfB68X+Rdtl7q3EmV0WQU6R3Bqs2CblwXxASU/5sC2lQHO1l9Mf6Wi4MMOVTnVUR1s43g2efW+pqCtJF5NOAqLQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401786; c=relaxed/simple;
	bh=/Uv2s2H9uHWMzRAeaCR934eu/abmxB7hjBwW+xRCmh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uRQc5jluDZ7KNIMkwvNwuDDyO7/g/6OsdYkCzWrDkRfDdfo/LmjHUUbYaYRQAcZZuGMTmxxCx2PqvfSYn/CdJa6FUr5Rl2cAUiTF5ApIS2CnuQd6XJHS+7Yui3lzEZ86HPBhlCAwVk/UVmWvmF/Wk5R5VkBWXzOOFZBV1VJbKPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWBvuHfw; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWBvuHfw"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c637089ccso4349337c88.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 11:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777401784; cv=none;
        d=google.com; s=arc-20240605;
        b=Cw4ZFxua2O0tDlNkZNkCuqCWqMOI9EwNZd2D69NfUSA/ZsIm/A8M7CgiDzijHufJes
         QQr9s8l96aOfQIfkpN9TbJGt1LBGKwmfgqlqGZ8jDFeGDPcrS6g4hgBoXiQi+Bw+bqTR
         rNN5frTEEZ/1CzsiqjYi2+nOyHHSjOv+3NcerniEL8ngPnu2FwME07IlmmL4L+rx+PCF
         EZNazxaWuPgvur1OKWR+BtQvyuJLdx7g9JMugSeVVPh4qyyhuwbHG8tgAoe08/9cNkfM
         LXtVzEBpjsV6kLXI5NqhmIFU9H9L/fJqs8eeaKw+j2MuKRx1QYTzjbC/i57eky5PFVhq
         0mIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ExlWjiDJS55UW+FbLP+PlWqlTF2JE1jySv9F4OIAJR4=;
        fh=0iBZhTqYm3ujFtdL99JNB9D5TJHo52+DRpCPXaXAM6w=;
        b=lC9MdYrdEdiTOl5F47dB5/0RKoH9pLkoqA+5tvQxDYNXFilnTpYLh3jvKN+MWdw8lG
         6bB37oSYH50EGkLODB9te90eDVfL9tGZ0J6TYhJSenu03a9+NWu4P9/uh2gknSBffEvO
         42o2ElltRtmkpbGDUhc+k+fekRVUtMdvBYvCIyS9ZN5EhY1mtjH2TPXoAnpxXbxkWiP8
         2Pqw+0pHmwnP/EzZ+sAKe9+7uv4ERZhnV93xRwYP7LQPdISu0AcZHJMTEvh+zAKKIkXZ
         NHS4iYGnssAD1JIgaodJ+m+QyfqOA06PyYckGPBgtzenTX0AOU1Ea83ajXsK4xLwkn/q
         Vmzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777401784; x=1778006584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExlWjiDJS55UW+FbLP+PlWqlTF2JE1jySv9F4OIAJR4=;
        b=JWBvuHfwzChh5Ta4DvEAiBT5n6bGpzoG96FQxkGzVn1kI3DuEnFN6aD3MVsmt2EY0Q
         5qpFtHyoJ4HGGSQHjIgdmGYU7jxrQuOkDpd0XHu/E7wcri8N0UMm0GX3+sotlww4yccW
         HMJzhT7/jeoMSiJf7ieGxuEn8VUPL2XW4b43/c9n2c8w6QaljyLWZVhJEFN7l6UcGuDj
         LLWVl0YVJvb8JbcN0yrt+y1QacnrCGCz3xdHtSRVC+mdlfOSi7y1cmyD/XiYQHTMw5r0
         DfuUny0/CrP75qiOqbeCJHJA/gQmQkeF7Ml6ZIAZ90DI05NietZ+y7NPwODq6kgy5C0x
         5CEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777401784; x=1778006584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ExlWjiDJS55UW+FbLP+PlWqlTF2JE1jySv9F4OIAJR4=;
        b=hlImnTZWn7Yr3IjVfoamw9xila7BUlUgYVHjggappxtlFI07T9lFEpkOBNedwoFLpf
         0MLr18F42/Fb6x236LDjXkPSuvO1w6cHNTlZWNgRrB2ukiUitwHe0X6aRTMCurjP4NfE
         ybWy1ADeWE+0roXG4dcuZyC7VqxOzfq33OWz1YV/YukyVhY6CZv6IK+r/ndZmF+MdkK7
         X4CQQ7ZlzxpiCmmnTu64diLbjmstB/bBNkEBT2CcGRDKQ/u7OkXNhB9sDB/zpYRhyHGq
         p01R3bqVgAQJ6gjklaNrciZWHeo0muiYIFkQXgznbshMP892lrdOGyRVqz3NfVUV3OZX
         OqIQ==
X-Forwarded-Encrypted: i=1; AFNElJ9c1OC5HGkGeFvWLs9E5sMk69oH9ifqa224stqs+/toATrSYruJHhn124DiJA9zC59x257rn9UDafcs@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Td0LYoIrBl7Qd6qgzYoM3NQvWiXFpwUnf654q9DUbRDsxeND
	2S+WLnwo0k2ywiczfQtXJ8i7ypoV7q+keCW8X/5MsB5zi5JFGHXuO2hOeptQc/KKXZaj4nGbOcj
	/DjT86+9XXFXKOPeZ07rJLzP7aZ7Sty0=
X-Gm-Gg: AeBDietBat+DWudMEehrCSgP2KdnpcRo5qNqwa1ya/1IcWEjQz2TYSLQHA3W4cbECRU
	PQvz2xVgfyVin5c66ouk1qnZ7FPQJy0L9QiNANQRu1i6MJJBXqi7qgCY1VaBieIrEzGSzPWh1am
	baKQ9/G4FnqpO4JXPb40THmEWJXgTg3MubWrZnl4/5w9BtYvSqsbxvQ57NVVkVsPXmI0Kik2t9e
	rSRJIhi3xBpCKvam1yhE+QK8cpg8BopxSWR4Wm3XvO+GJORwmEDujR6WFXmgTxVOe6MBZfx0nN0
	JT2Ico9nZr3J4T7GiQ==
X-Received: by 2002:a05:7022:621:b0:12d:ce36:8928 with SMTP id
 a92af1059eb24-12ddd90d863mr2359702c88.0.1777401784466; Tue, 28 Apr 2026
 11:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428121546.148369-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260428121546.148369-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 28 Apr 2026 20:42:51 +0200
X-Gm-Features: AVHnY4K0bMKutO9JdZz72t3tLixvUn-W9sCca5gNNp_jiNA9kNYT4bH6ezyiKWo
Message-ID: <CAOi1vP_NuvRnQZc+yvJgtUG3zFJca6+W+25jTNpnW4BsEgZbCA@mail.gmail.com>
Subject: Re: [PATCH v2] libceph: Fix potential out-of-bounds access in __ceph_x_decrypt()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 2:16=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> In __ceph_x_decrypt(), a part of the buffer p is interpreted as a
> ceph_x_encrypt_header, and the magic field of this struct is accessed.
> This happens without any guarantee that the buffer is large enough to
> hold this struct. The function parameter ciphertext_len represents the
> length of the ciphertext to decrypt and is guaranteed to be at most the
> remaining size of the allocated buffer p. However, this value is not
> necessarily greater than sizeof(ceph_x_encrypt_header). E.g., a message
> frame of type FRAME_TAG_AUTH_REPLY_MORE, that is just as long to hold
> the ciphertext at its end with a ciphertext_len of 8 or less, can
> trigger an out-of-bounds memory access when accessing hdr->magic.
>
> This patch fixes the issue by adding a check to ensure that the
> decrypted plaintext in the buffer is large enough to represent at least
> the ceph_x_encrypt_header.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/auth_x.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> index 692e0b868822..9e64e82d0b63 100644
> --- a/net/ceph/auth_x.c
> +++ b/net/ceph/auth_x.c
> @@ -115,6 +115,11 @@ static int __ceph_x_decrypt(const struct ceph_crypto=
_key *key, int usage_slot,
>         if (ret)
>                 return ret;
>
> +       if (plaintext_len < sizeof(*hdr)) {
> +               pr_err("%s plaintext too small %d\n", __func__, plaintext=
_len);
> +               return -EINVAL;
> +       }
> +
>         hdr =3D p + ceph_crypt_data_offset(key);
>         if (le64_to_cpu(hdr->magic) !=3D CEPHX_ENC_MAGIC) {
>                 pr_err("%s bad magic\n", __func__);
> --
> 2.47.3
>

Applied.

Thanks,

                Ilya
