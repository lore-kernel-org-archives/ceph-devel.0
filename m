Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2563A4267
	for <ceph-devel@vger.kernel.org>; Tue, 12 May 2026 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778600471; cv=pass; b=PLgySRhouMBT2VoJgx3pCRKeyLy25T6lsVqa5bm0t287I0EnRik4Zx974P6pHPJBdA2MpT4DIA39lTzEYzjxRwA56TCifHW3zcYS0/DHjRVRNHI4kWtCMix0r312jPFktvjBDWPBis5hQoB1iKtOlvmM3RAWAD5Q9PuA+VR4D9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778600471; c=relaxed/simple;
	bh=mtRorKtoH8sY+GrgWDJ10fL1Ph7mr9nlH1eBU1QK3NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tm+6+MmfI/3ODzmewewVMk2g2PP3I2E/1qiN6TJcxxY0AOEVNzr0DLSDexVbhXK3xqCELkzAjAgzAR6kRtiVfv+Efezu9gNVpOBKQ/IUTZeC+F4Skc55lC51zef/vXNyTUwp3NwCeII6DEga7coMJWU+j24josLi/B1xIQYsTpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuSZN+RJ; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuSZN+RJ"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-631ca15d35aso2325093137.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2026 08:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778600469; cv=none;
        d=google.com; s=arc-20240605;
        b=QvtxYxS1DApPd6Y23xhiFj+54Jm1PzwOWK2UjI1cWoPOylEY+ffYgDqLra7IUxEKB8
         9EQ9UXqdqB7bZU9HBIo4GOcdMD0vIMZe9yrTlMUQuS317403o1InOjMDCiHpjBrciLiJ
         nqPUa1ExJbrNk9cLJmJZ5Cooc0jkJ7x6TfTq+OBnFIZy0jbNeTYotZrlnfzJoj4p1IkF
         m5QvfyUzeTrodpBKEdROwbumpVeU6Mj/qquDPAzOmO2RyZrMLK5yAdsNovp4+psDoiiN
         LwM1YGf1KPGDeHyVDzkcIMxGjprgZoelgp+5duXwAkqkIvqWKkMdxtf4MmadPpuFl73S
         hGCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wto9758LyjCIXSqq3h6+N28AXpbO+keTcpiG1MzoAdg=;
        fh=7gQvVhDgCgeBZjGsbbpHCIrpJbKluacy6WBOML31tsc=;
        b=HC7ofBGWdjZQsdUtnZ+LeA1ExnUFa1s0NGnV3LSKpyQSI17qviS5ZITRkgEY1mQY3N
         IQwn0mtntInt6bza8Lqx6mphgcJbcMm3l1On/vpZjLcvHv2H02G58A4NXB6c5xu0jENZ
         PbuWw6cNiMlMN2EfJ5mIbc/p386B74GfuoJB5rBM9eW83de0ajrBak/6PkaaEmTvfsr0
         8Jl+mohtJU+KjvWFNpQ38bw+rykphvqTQ5s77SUrQPbf7hwULcBe59zBw9FWV7J5NpGw
         WYUKfMNibf0pZWSzUOv+tkTH3toxnH4H3wxRO8xMaU1z5WxRvPFFenwIYCNFgMqtOfSf
         +NyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778600469; x=1779205269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wto9758LyjCIXSqq3h6+N28AXpbO+keTcpiG1MzoAdg=;
        b=ZuSZN+RJgFB78jN5z3IPMWdA808xh/v0DaONw9/vy5rpjljORAWGPwNuzXOmTAEngD
         7qvQMmavvsmQFopkijj5U2QeiddNpHF8q0ItujY1tRwJZAIoHItb1g0HAjAYAe1LXQOe
         fcP5dXWse8IP3Ne0FZBNtHxqxRr6w5D8nacAFddkAzUgZmfE4WmVLfezxwFCUmtWZbZv
         VqdDXSaBB8/T3HBb+hkdNphQLqzoHpSEs4xp6RNu6E9vU8zvaDtrpxnXss4p1xx90e31
         Np4dbc/FBTSaxg5zpESqAxYTYVQZBmWK1fkLOPn+J6ydjTkVs9Gb39xUvmXE7uSHQaw1
         rQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778600469; x=1779205269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wto9758LyjCIXSqq3h6+N28AXpbO+keTcpiG1MzoAdg=;
        b=dMQkf2vP9vIBIYAy+u2VP2xyvwpyUqJThTrZwUkUJJCB4iqwHqYqtMCwoC0QZ+7F6L
         1AShptY4wSjcMm3oxa7eGzseu28zUAtZIK/Iio1XFE26I/bCaf7QziPnNtscV/Z13LkX
         /NM6/NjClsdn2zKotQWlvcIwpI0BJFULBMo1abNiyBMDaPShoWeBzJ7drkjGrAjE3vpO
         SRTmXttyXhqjsJUDdC+UbETzzlNInPn8sQn//OuVyc0LBvwTWtS3cPaLZroZEDHYqsHL
         QdKgeZK0NPjCrHymLdu5tCRitPWBq5nwzI1SoIoCffcxIqYi3NBwNAypc/JA+pjraTyr
         sPzA==
X-Forwarded-Encrypted: i=1; AFNElJ/T5TIPalQNxk5nUBWMb0OP6/9hBlbnC/mVEsmDcDl3IeqkrxX1YB7keShgnEYVNhvYPzVpPuablxlI@vger.kernel.org
X-Gm-Message-State: AOJu0YzA/hZla4u9b0p8nDUMeh3Mpmjk5wbfwUTU9CTRI1P9nIhszRSC
	UNZY6MB/N3fU3yHL7NrwynhL/NRE3viKQcaVe+VdJUj+d20ey7URATuXq7dBiRECrk1VspFUYwC
	6yhA7tPdlMVD/cjYq9gOZcdaUn1F575I=
X-Gm-Gg: Acq92OFw+Fv3ZIpF0Snop/Oye59CYFF4l+HDKJhNV+nlyveGs85UbAOo8OpqWoJqMN5
	DrHEX0HzoGar5E3Fy5m7JSNYubZnMaYBeDm9inCP/sUDiqYo9CUpf8nn2M4BBFD5RsVlmpC8pfO
	z29r8xDDISXYqeqbzr/plkBmtDcQQCgRMvC5rLAtW4co5wnBrMrm8xlpuJXLK9HCgyMVIS5JnTC
	AGqLCNYKeClnsYGYxzpJInZKQx18GfJl2y4Fp9GYE5u5zaqSbI1O1slvP2VDBJdMDUFVPgrCb8T
	yxWLdGguLOsw80vg6Q==
X-Received: by 2002:a05:6102:b13:b0:633:29c:361d with SMTP id
 ada2fe7eead31-635cba45842mr1773150137.0.1778600469262; Tue, 12 May 2026
 08:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512085425.1372864-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260512085425.1372864-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 12 May 2026 17:40:57 +0200
X-Gm-Features: AVHnY4LG08ijZKe_RjJaq5d4uLtir8bqds0eyEWy1RRpL267mDD3AKOVjafNhx4
Message-ID: <CAOi1vP-+DrSgR8gD6zuykZ29DwrBUgS48Un9s1n_FTinptAhjg@mail.gmail.com>
Subject: Re: [PATCH] libceph: Reject message if choose_args_map contains
 invalid bucket_index
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 10:54=E2=80=AFAM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> A message of type CEPH_MSG_OSD_MAP contains an OSD map that itself
> contains a CRUSH map. When decoding this CRUSH map in crush_decode(), an
> array of max_buckets CRUSH buckets is decoded, where some indices may
> not refer to actual buckets and are therefore set to NULL.  The received
> CRUSH map may optionally contain choose_args that get decoded in
> decode_choose_args(). When decoding a crush_choose_arg_map, a series of
> choose_args for different buckets is decoded, with the bucket_index
> being read from the incoming message. Currently, it is only checked that
> the bucket index does not exceed max_buckets, but not that it doesn't
> point to an index with a NULL bucket. If a (potentially corrupted)
> message contains a crush_choose_arg_map including such a bucket_index,
> a null pointer dereference may occur in the subsequent processing when
> attempting to access the bucket with the given index.
>
> This patch fixes the issue by extending the check of the bucket_index to
> also reject the message if the index points to a NULL bucket.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/osdmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 0752a3808b91..4a807e5faa62 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -379,7 +379,8 @@ static int decode_choose_args(void **p, void *end, st=
ruct crush_map *c)
>                         u32 bucket_index;
>
>                         ceph_decode_32_safe(p, end, bucket_index, e_inval=
);
> -                       if (bucket_index >=3D arg_map->size)
> +                       if (bucket_index >=3D arg_map->size ||
> +                           !c->buckets[bucket_index])
>                                 goto e_inval;

I wonder if this is too strict because what happens in userspace is
actually the reverse: crush_choose_arg for a non-existing (or other
than CRUSH_BUCKET_STRAW2) bucket gets "stripped" -- weight_set and ids
arrays get cleared/reset to NULL.  It's mostly historic and the kernel
client has never done that, but still...

Perhaps something like

    if (arg->ids_size &&
        (!c->buckets[bucket_index] ||
         arg->ids_size !=3D c->buckets[bucket_index]->size))
            goto e_inval;

instead?

Thanks,

                Ilya
