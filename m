Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745C61A238F
	for <ceph-devel@vger.kernel.org>; Tue, 12 May 2026 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591285; cv=pass; b=CuYml/hXWDTEvWkDdpILVJyN7XV4wWJm/tF1KURZYkhbVBZhrsUTiERIHdE7hVQqs1/mD6SclotXuGtw39SSeHNhB825bIyFXd5sPomDD4sb+Xqc90pKr5wEfqHtSF7ZFrBBSNQl/s1RLZdIRczcrvYI1IbQjtCR5BDg5swpA9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591285; c=relaxed/simple;
	bh=+vcfNdRtvwQHAPFi9qeID7iVjTEIACNb7t52akS/Gx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXYN4jj49DBqzzA6dNMEryHbe3LgZLu7994Qybc5ny5pCBGjfolekmpDLkqx0JlzOnTlLuX61VTjoPLw04wNnzaGgHzeOOEji3nDU/3qAqcptbbCXziN+RDPuUeaXD6HEff/S5qKcINHyiR/SxogvzvqK9D1NlcR1Xiss4xl5Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEGrDJvt; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEGrDJvt"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651bc5494b4so526653d50.1
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2026 06:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778591283; cv=none;
        d=google.com; s=arc-20240605;
        b=D9E+73t9fx97oyRJcIzrqkGW1MtogcfTOozyaPpg78WGzY7hHCVz8vsQkMuiWzVuFv
         AYtXKfhCaiA40KYFsuRWEeGY+QjiQklEZGbiLCWmbRiYacSADNcBf6QmtxLgS5RFPZj5
         guKcx/D/hpqrac4csiP+siaGxM95kQ1CS4ory0+78bWuR2nWc46/IFe1dgkUnKAPVrBp
         rhKQ1OAeU9/+nGIE/nDBh5m3/GcVX8nFspyYgFEhe6Nkhm4MLtK3XykaoCuoveq7cXna
         S+ZW5WfVjWklDBAyP/QSgsqM7TZgpDrbkpptbEC60olxGtyPtAtCeOsDWYw23pQObQoM
         SpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vnBWAAshyrw9uW2waQU9UJFxrzx86ul1N0tkpGj9Dmo=;
        fh=sQlyFi2iQ4NoPEJKwNQEVN1b1eRdwbEiC0EcQVfIP7Q=;
        b=k8wu1LFyBW6QDiISQcrSBNQWVQJGEs//8PKEEZR5jVz2YZt89z8w4Hf8ByCPsWgNmM
         BQm27N/8FSFFhWc/DOv9qZuvjV64MinnGzaemaIWS2h1HxzJK4nLTV2iyDXkgEmv074Z
         l1kOR6UnNBhM5/qMBOlJZNGwOPNI7E3WLf/E4mU4c4qpitbAV4oiRwfnLDPrOL6eJBSU
         jrSmqxqZZtDiYddVmatTKML020HKSD5sBZohPaHiuAIccFk6Dz+lMfCi5EJfpXGeHc2l
         LpF1gGmr8vbHTxaBSV8jcBpsepGZFloqBh3VXVt0H1qnLBcPdrPW0lqaTZjGBOodBwcn
         QbAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591283; x=1779196083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnBWAAshyrw9uW2waQU9UJFxrzx86ul1N0tkpGj9Dmo=;
        b=fEGrDJvtHpIFtrTWjkSoGKqDTEQcVkexN4jqkdq4Th8fzXv9UTKn/H7MMd8olzktqd
         2qVppYWSG4KHLvBTv3QKS2rbh4j+YD674sTm1qS7+gFGDg8nnkzV4OCMKG6vQlPS0l6n
         HnJVvajdgkMF0uoiN4iFMck+1LrImvydCGoJw1xynC6YuSBYBAmXt4DIYqK+QFs7lygI
         QuUY46kyQz1i6/B/pxWxeyVQXb1vbPYoK4OE+1wGDUyqs1nE+rZ84qnl+5DiWlRGICmQ
         WNsPCeAKQZt4Bmwhi1eEo+WluE64FdBACfg+ocN/mJpHj/KLZ2ptvXO6LUs4IvPmpwUR
         0/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591283; x=1779196083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vnBWAAshyrw9uW2waQU9UJFxrzx86ul1N0tkpGj9Dmo=;
        b=ElH9nsbNeI0E7Tk9LDviUeRaWCI9jTNSvBJcORTtuvom2CUV+7EaHf5pMuXAahlBFx
         YMInWhQ51PUFv7DPHGDj6j4J83lk94+cBMC9I7uwv5Z2AyKz8U3JvDI9RSvFj1AUqdb7
         mUqW2WkTIRsgjBQsADnleKHBGSgyMKnPm2vIgGSqAW/COGp4oHWa9JCJJukgTZt/xHVi
         s/X0n7BmtRTjVWalH5eGHWVJ8WaZa/o8qYRhBLcSpgiIGSNzS2al4MYKzy9uQwCVYpJ8
         6cpaxjcS4/d/1YnITeMuU2ODOpr3o6wq7bBVlD6NAV0mLJPnx4PRuvP1b12Du2tMPxkV
         GPuw==
X-Forwarded-Encrypted: i=1; AFNElJ+Pyq1dfNxVHWZF6W/L09knDHwUE6OKBuWzySJFtPi6f9dGtl5om2yaV4ssrcMNpHQ4gl9tfr/6NWjS@vger.kernel.org
X-Gm-Message-State: AOJu0YyB1Qaz6ZvuyKNTYT1DsgeIWkQfGsNvmbfleQh+Mfc0v/kD52Ln
	XK5hIJ+nHz/iP8ShhkIhx/BdQVsxpwqc9PawsOD9pIr0HcBRHaiA9GDWE7aW+hvhnnZ75XyhVqN
	fKD/sg3zMZzC8BFMAe2bNkXHYVREGrdo=
X-Gm-Gg: Acq92OGEeil629cn5wQHH0sfxCrTYxjHP8oNm+6DuhloYiK9Bs8oRUFM6DucSXslz+c
	9r7sS/QAOUI8t7ezFn1vlME30RCxSLvWQ0HdHRPyda0EVDGIPoWl2S85cPrHU2BKdjNjJHoUg0d
	hE1OxamAKXXQvgF74e/qUFbrcYLHZi/zpPNOiF6zJBTkEXstIrP2vOxatfNrte2cIgF6mZA2iaG
	S6oYhZjMEvQh6+S+Z81+IufLMgC/yob2voc6ei4EFBYKfl/x5FFfFjolFO4PGC2T0LhWtqiHffM
	awtg2Rmo
X-Received: by 2002:a05:690e:13ce:b0:65c:322a:7ac3 with SMTP id
 956f58d0204a3-65c7b70bfbbmr17655158d50.2.1778591283371; Tue, 12 May 2026
 06:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512123404.719402-1-dhowells@redhat.com> <20260512123404.719402-9-dhowells@redhat.com>
In-Reply-To: <20260512123404.719402-9-dhowells@redhat.com>
From: CharSyam <charsyam@gmail.com>
Date: Tue, 12 May 2026 22:07:51 +0900
X-Gm-Features: AVHnY4I7C6CzYKo5rOIaKeFxn1UK1vSWmDrEYuJGWgiJZva0dOf3Ebu3U-sXK3A
Message-ID: <CAMrLSE5jFZwmUrx5GWhz4AD9QpLsF9VsdaMJxiDa6ukXqH8RPg@mail.gmail.com>
Subject: Re: [PATCH v6 08/24] netfs: Fix potential uninitialised var in netfs_extract_user_iter()
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, David.

It looks like ret does not need to be initialized to 0, because it is
only used after being assigned the
return value of iov_iter_extract_pages(). In the zero-length case, the
loop is skipped and ret is not used at all.
What do you think?

Thanks
DaeMyung

2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:43, D=
avid Howells <dhowells@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> In netfs_extract_user_iter(), if it's given a zero-length iterator, it wi=
ll
> fall through the loop without setting ret, and so the error handling
> behaviour will be undefined, depending on whether ret happens to be
> negative.  The value of ret then propagates back up the callstack.
>
> Fix this by presetting ret to 0.
>
> Fixes: 85dd2c8ff368 ("netfs: Add a function to extract a UBUF or IOVEC in=
to a BVEC iterator")
> Closes: https://sashiko.dev/#/patchset/20260414082004.3756080-1-dhowells%=
40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/iterator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
> index 154a14bb2d7f..6903028b7162 100644
> --- a/fs/netfs/iterator.c
> +++ b/fs/netfs/iterator.c
> @@ -43,7 +43,7 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, =
size_t orig_len,
>         unsigned int max_pages;
>         unsigned int npages =3D 0;
>         unsigned int i;
> -       ssize_t ret;
> +       ssize_t ret =3D 0;
>         size_t count =3D orig_len, offset, len;
>         size_t bv_size, pg_size;
>
>
>
