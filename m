Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C46368D63
	for <ceph-devel@vger.kernel.org>; Wed, 13 May 2026 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654846; cv=pass; b=aYgUaY1ujYLt59Rf0aesWmb/jq8wqxR66SpLSKncVWuEJJ3Yujd7hfquWmZ/z5aXsD8pudeVstP/O6//simdxyOdYc8A9T2dB7sqjkCCN8iVUxOqQPP+DlOJKRVavu5byzll4+xzkgYEdgiAQwAG/o91xBXa0EUZPXYazFlNKKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654846; c=relaxed/simple;
	bh=XM6pCuwc7lTQbCV+752R6/uFPfqmf6ea6ECwvhcYe3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O0La2GlRjYPjurUOHQvf6Z3tns25NQOYv/J+Tx/plwDj85W9P8RaJ5Afo5hgPsTAw2uHPJvP8rxbxgfpV5S5WLJLcZFJLknVUSnuHTbhWx57r+8oshzb2Ive/xG32sHdHWnDmFwv3WBEMeGBUeGZppLE7htb3QAducSY8uO89fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNHRr+dD; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNHRr+dD"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56739adfa1aso4282156e0c.0
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2026 23:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778654844; cv=none;
        d=google.com; s=arc-20240605;
        b=INrbPERe/c2fRGOHWyfmWnNjG950HyM+jvP3LXMnZ66QkB2G9R2EbPur8NEtZmn3Mv
         L0C4V1TUFm17OpUCQWSJhOZKc+vutI0DBmYrw5otETFof8yoor9mY9vyD/cgKb1V6w7A
         FwwrfX7KCJNWfrHr6bmXDPi3kZJk2u6KoAWY+MxfRmFOApYXzPf2El60Hq39J19EO1FZ
         mYT9hje/nzuiOo7Dctf+BhYM/dH+1dMcOAIpT7RfofWhYZjcm5XzCQGhj7SFV0d67OD0
         pvBZkjPgJS7180Ehd5myXWDTZVzdXNVAo4sX1Q4wv2tLNrX17tucumBKVDPLYgUoA0Nd
         dEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iLnRtps+2IH9pgRnGUH9pQy6tAFL3jG3TCkI0L3GGjg=;
        fh=pJtmtZmhMaTKNahthK8lsWa1V6MiMfJxSht7bjp8cgc=;
        b=jWS9PnusQ6UBbRIVq4oyX5HLeFeYeZ0ImXKxCUyjOUbR5tftciKQySnSGruaa5UAWl
         Pq8Vf2aN5Z/WG6+lX6gVEUoc8IL4DeyeIuCwr6TqKi02dqrZJfkWqjCOUJeO6W3uOiff
         JwvbRe2Mp+TqGkvBJWZZnQGzomcLKW3g8WKyOM6cgl8VYFUw6lGxoarzB63OaQrQDhzM
         6zXQJAmbUhCSHJESIYjhySuPv72RljWZLWQinHgnnRq/N4XYkHuRg1+lEoyqJHGGpDiR
         usY9JG5MwjoZiXGK5DegKyl3g/nS5N8j1KGnOgWhY3bOqADB0zfnP/mttg1sytuuiCi6
         IotQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778654844; x=1779259644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLnRtps+2IH9pgRnGUH9pQy6tAFL3jG3TCkI0L3GGjg=;
        b=tNHRr+dDNOCfBGGI5wwfjOZs8h/Y9sh9LsErn56G4TFQPhfheCIhbBpZTBR6gFSBd4
         uuOCRFl1HN1pxPiwNstEASsQAEUjQ+NPgM62BCv8xSnsQwo7uVg58rAHeft6OPedBfEw
         Nqhifjsndhzl7V1gFOzurJ4FqLL/yRapsm0w5wrT+oNovOmTgGlTxcBAHr0mrGpsyAZJ
         s2qQaLW9Q60EpG9d7Y/5jS9QjSzY8pclhUUnCnq5uSuiVBgHSjmI6etbpiPUw2COgwYt
         sA0mQoGYo4o5CnZqxBS3hhZfsLyNZxQ3tpV9NwTmgq1dVF6A1ZprL+aFOInKJMttwtwS
         3L2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778654844; x=1779259644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iLnRtps+2IH9pgRnGUH9pQy6tAFL3jG3TCkI0L3GGjg=;
        b=Q4l7gTdsQXJd9LQbsZ1pZVyqd0X9llHM/e3tPMNpKrfN2o1aSFmbNLH30cMpYCbazf
         X8UzAL5jdpQdWwAM6Iv9NeSV5CPdq/B/RXuYrle5PWSz2ZS5mIETywTg+Tx8h5JfFCAx
         9E2YT5GjbwOpavu01mrNNmYCmXXRxxte6ycsx9TEy/2UuJW7+7rivi/AcTKAIchIKNEy
         wiNZiEkrH3unchXIZTWTTsyuT4mNvWsJqP5LKwgHaJu+dtnkAuuJ5+UFDLyVuYa22XgT
         wMDo8GODQ/fS5TGOzvfH5tCOIWtVuwYXaWqfVuUv0WzgX6jpY509IaCIAX2FKybfP2nq
         ZQuw==
X-Forwarded-Encrypted: i=1; AFNElJ8b7zyH2rANyyVxhi2GbIzODg/D+zhlh6CnKMoZFLU16CwqCwn/UsSu2y2rKDSIYq13WNGZ/vWgp0CX@vger.kernel.org
X-Gm-Message-State: AOJu0YxGSEhOYHH7UiP7XpSZE9mEliFD3Sk4c+09cOzfrsQI5RtEuphs
	WcbreF4lR6Ag2PJYtFCd0IfE6XZP1tixzWBZvZezdX++cLej4XoMQxpyDebhZqSIpYqlQaGEHto
	bvOyfjROFT6ttNB8urMf+Hx5Ux/9XoV4=
X-Gm-Gg: Acq92OGvc+w4JiumhqwBFh0zJSP/VRh4kJ96Orsnib4MlEVM6LiOqkMtRAti0f1lI/d
	a6OTppYdmobd2ac5HjZv4qoC5wHaSHwjMlEWbB4pC95PVO6MJTF9ieRpu5C5dTONCxKbwvtQ9GV
	6srenybdFtt8i1FUXwF86das5aWHxllazR+JLxc5VjhuzsbxN7GxbS0/dimUUdxmIrGufZxhtla
	pIPd/5AUFCRD3VD57WwIlnTDP+hlNp0SdH7AYX6DirZPrrj0P8Z5Ngrtsjmi5ENILC6V17jxtVv
	/ExZIs0=
X-Received: by 2002:a05:6122:daa:b0:56c:e871:31a8 with SMTP id
 71dfb90a1353d-575e6fab3d1mr831094e0c.7.1778654843912; Tue, 12 May 2026
 23:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512161640.1449577-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260512161640.1449577-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 13 May 2026 08:47:12 +0200
X-Gm-Features: AVHnY4IMhTUJCjyRjXaJa4npWDp3zU5V-n_-0wSN1XD1mmnKfI_Hiq-NF-Ch2pk
Message-ID: <CAOi1vP8OyYgsspjQdD5iZwJASaVmhp06eshBw9mw11oevi1v2w@mail.gmail.com>
Subject: Re: [PATCH v2] libceph: Fix potential null-ptr-deref in decode_choose_args()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 6:17=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> A message of type CEPH_MSG_OSD_MAP contains an OSD map that itself
> contains a CRUSH map. When decoding this CRUSH map in crush_decode(), an
> array of max_buckets CRUSH buckets is decoded, where some indices may
> not refer to actual buckets and are therefore set to NULL. The received
> CRUSH map may optionally contain choose_args that get decoded in
> decode_choose_args(). When decoding a crush_choose_arg_map, a series of
> choose_args for different buckets is decoded, with the bucket_index
> being read from the incoming message. It is only checked that the bucket
> index does not exceed max_buckets, but not that it doesn't point to an
> index with a NULL bucket. If a (potentially corrupted) message contains
> a crush_choose_arg_map including such a bucket_index, a null pointer
> dereference may occur in the subsequent processing when attempting to
> access the bucket with the given index.
>
> This patch fixes the issue by extending the affected check. Now, it is
> only attempted to access the bucket if it is not NULL.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/osdmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 0752a3808b91..8b5b0587a0cf 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -388,7 +388,8 @@ static int decode_choose_args(void **p, void *end, st=
ruct crush_map *c)
>                                 goto fail;
>
>                         if (arg->ids_size &&
> -                           arg->ids_size !=3D c->buckets[bucket_index]->=
size)
> +                           (!c->buckets[bucket_index] ||
> +                            arg->ids_size !=3D c->buckets[bucket_index]-=
>size))
>                                 goto e_inval;
>                 }
>
> --
> 2.47.3
>

Applied.

Thanks,

                Ilya
