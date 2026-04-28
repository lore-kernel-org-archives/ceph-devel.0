Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F5C3F20E7
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777373768; cv=pass; b=GPNVzIaRJmLO/hN40aO6VLOkD1GSeicBYqVQ4EWxAhXkcDNcoIPPgmx2GluueZu90FWpR++BUUDxYSvumCQ7lycpYsyhIe3F6uS68/UHoDBaBYlTqedNSZekALdXmgYPlo9lHvMkAFAa/ulpehnoM3gHoXSWjwvqzA1qwB0oEcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777373768; c=relaxed/simple;
	bh=lff1hoDpCPItfU6fZpTVDIoZLH7jRUz0pJNfc64g0V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UU2D5QV+O1WbbJjG84U3IYhx4OSToqojTIJZdXAwsIQRUggDTu5yYBkG5hC+ywRwjhqEOJEyUFJyvecmjy9iaWhQn55773jTaZVPNtKZx7gL1b0i7/4pwalZEojL28wYqRFx147e3cKlfXVgDd+QqBrFYRbphTRgzoHulSuMD+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ah25uaGH; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah25uaGH"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c45281a06so15350917c88.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 03:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777373766; cv=none;
        d=google.com; s=arc-20240605;
        b=c0Jq6ZD0weowJpiKzLmoGVzvAJwPM+XsF555ciOaG0ygm7EIkVByeQBi+s9F2vGgpN
         jk562eoEsPiFD8XELidihXAMz8VHwUliPhJi5ozRYWF+6hvZXWZYCTTiTxhqQeIdY7mZ
         e4GRUy4PtuwI14eGiF+QnjZbiicQ4FedosTaCNynOcjpFv55BWR4CJEICy9IQ6ZjWogn
         YKqYVmHV914t2ZGYtuBZooFS1WguDp4pMWMxd1oqYo6LTI9z7HOOIWBKYnkcX/+lASjf
         01HeYQxlN+9GyP1x5vz7p5znr3SCic7mgJnsdxQrOsXy32sjRwQXAa4LzbObWkOpjOuV
         iBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lV8BTnIKNJ5WohKAsYPUW23XyqmMf4gohs540Zwa2bY=;
        fh=I3jP7wOfd91HzvaWs0v4JJNsk04FN6uJ2G96cmpazwE=;
        b=BY9iSCfboGb9d51WHbual1YpJCUOMXoBLnFayYo2yxe+dWhsmKhsY1nshl++rUMb97
         MLinkcm0YS6df4s0KSKzbQ3f9O8Lf6Q/1UBIFggEqcME8kwLW1TwbmnEZLm0AU+qcO9w
         evQYxMUxodLNlgTAiGuhEFQzcL0Ogp3ayCOap+y5AGFAl5VFOwMStfT+wvxrer1N+Fph
         Rdc+c6kigrRSYSRmwRfGAnGb+EuLUZxATW7wGJNkfTeJfUXQCUBpHVHXEVJB8w1z6+B+
         fFFF3mPXF62g1OdT2RQBSf3dQJDSNovEeY7LV5uLh9ggzKhIBd3LIzTt3zr9mKRbJCUv
         FUmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777373766; x=1777978566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lV8BTnIKNJ5WohKAsYPUW23XyqmMf4gohs540Zwa2bY=;
        b=Ah25uaGHUf3Ayk+r0NlQGfkhzHMQ28SjedC+MZw1aem4AhPM6uP4D8I9zbqMRJRaiX
         vRCrvDIgvBH2ZyD7hGl5f2OTuGW53NCXODr7JSbZzvUjB57wrJgs7VaUzQnqpWfzVhfU
         zwkkvZn77sl6Dp0dQhIvX8j6B2gzOS/C4n7GZYhsOCeFeGqAjDenYJiY2cB+0KxYSvns
         vH1aCuBlMerVY0xHMfmr2Gmdx6iKpDJhWTsn/gcv0qLnm5b8TDpeK9O5YngEC7TqioQv
         iSV4YP0GXhsOsmJtmIULYxhlK9MHdn3qQ1hEbZJBNig1We68fv/s8x3IVAlpi/+CHl9b
         Bnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777373766; x=1777978566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lV8BTnIKNJ5WohKAsYPUW23XyqmMf4gohs540Zwa2bY=;
        b=YKDfhPDc0IiraTqVAgB0b0cBFGAgQV07z05FbYLzkMKBaZt3kQDXlnSvoe6Ny9NvG/
         68J2EvhdmvQt6pfuehlsGGLoR++SOjnS6Tgob8BFcsgNTr0dDFV4GVQHWLU03dmNAOd9
         gcXs74NXNZ8uPnU+z3UduaKCR8nXXr09gjaBlGCZ20RIl91XQdMS7bc5eh4p4EdPbTNu
         KkfSC67sQF9Zr5CyDFLlN0fR9McJfafp2Vw9dwlD5oS6waCIDnxo+P0E0opF3FRqXWjD
         9cU/e4noI0CUI+qhc3NEo9U+k7geQFtJn7ykStTYTo409Xy5NIYyzOo0m+R6YxPqcd51
         nGkw==
X-Forwarded-Encrypted: i=1; AFNElJ++lX9RtUd32093/GJeN0i8QjUE8/1oX/TD9iQnu2ajDDUVYpMwJjmF6y6O4F6JV0WNT5RenL/a7UuG@vger.kernel.org
X-Gm-Message-State: AOJu0YzSokXv34oV/x3MGuJp5InlzWNqpH4xmKNSusmHyvzNQpg+zHvU
	8rdQuuJCEnCxEaq6szBTuSMuZjLzMhsG3Lqlo02nZIX/g8Xq+erx1DOK2HPL6rvmldTw/i/63Qm
	wXPaNDWzcJx/qbJZIXhnFFBD2NdKWeZs=
X-Gm-Gg: AeBDiesf6zp3SgfKgM3aQBP6k/QL6tMOJEHLz6qMRZdTdqmWa98+JqgQVQj4fUx/RfT
	H+0N6O9brOOIHd0ybZK8rAHhcGI64ZkGZRHxTblJsP7FBRStgeIYV5JLoVDpmSWa2b/ocUY/HLm
	qFiExWpj5JpIA97iM1xA4HbnIXCV/kkriiy1oKea6It/knb64i3gleIeAz287X8kJt6kyOh/fIv
	t6nPCJvZHumDMEBt3j4ZI3/fEpR42n05bq6d32PfOvvyQUSayNVfj6bh9FLZji4WQXFkPUocMpf
	vTsNqyByR1cC7AQN6w==
X-Received: by 2002:a05:7022:ea2a:b0:128:bec5:1b37 with SMTP id
 a92af1059eb24-12ddd98e4damr1136087c88.16.1777373765835; Tue, 28 Apr 2026
 03:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428081849.131286-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260428081849.131286-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 28 Apr 2026 12:55:54 +0200
X-Gm-Features: AVHnY4LP3vvs9RGejJ0RpGP4--Nl86Use3AH2KDPyKJiW1EoueJD0yT5IY1gNEs
Message-ID: <CAOi1vP9pDt4Re-Y6hh-wAZQd+Gps1T+cazHzPp7Fj3P5UWVeyQ@mail.gmail.com>
Subject: Re: [PATCH] libceph: Fix potential out-of-bounds access in __ceph_x_decrypt()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 10:19=E2=80=AFAM Raphael Zimmer
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
> ciphertext buffer is large enough to hold the ceph_x_encrypt_header.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/auth_x.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> index 692e0b868822..bb65d5d52b6d 100644
> --- a/net/ceph/auth_x.c
> +++ b/net/ceph/auth_x.c
> @@ -109,12 +109,14 @@ static int __ceph_x_decrypt(const struct ceph_crypt=
o_key *key, int usage_slot,
>         struct ceph_x_encrypt_header *hdr;
>         int plaintext_len;
>         int ret;
> +       void *end =3D p + ciphertext_len;
>
>         ret =3D ceph_crypt(key, usage_slot, false, p, ciphertext_len,
>                          ciphertext_len, &plaintext_len);
>         if (ret)
>                 return ret;
>
> +       ceph_decode_need(&p, end, ceph_crypt_data_offset(key) + sizeof(*h=
dr), bad);

Hi Raphael,

Using ceph_decode_need() here seems semantically incorrect because we
are way past decoding when decrypting.  More or less the same goes for
deriving end from ciphertext_len -- we have the plaintext at hand at
this point, not the ciphertext.

How about something like

    if (plaintext_len < sizeof(*hdr)) {
            pr_err("%s plaintext too small\n", __func__, plaintext_len);
            return -EINVAL;
    }

Thanks,

                Ilya
