Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C043385528
	for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2026 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141311; cv=pass; b=KNqpAasTmiGtrA8ZkVQgjeeJ4XRMHi9/JGjq6M7hrS90z+EPJYp1XuVIG/cMMKBozdoqbI6jNqoDu40Ann6OFLk05F6VUmkMkFD9Yd2z3ljGa44ZbiLUDodKjXpYau+R00+2Ag3kCHuD+uFSsZ9aBDayd8w9UWvnorcnCL0WNSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141311; c=relaxed/simple;
	bh=Q4ib8gUIRl7s8kF9Gl9OyKG76XX49+I9rBDHVIBBGzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALgN0YX8m6ohQB+bc6BnreXeE57opMnjHpFRrvCRlaXhTaOBbMjVeigdexSdflbh4HqSCu4ftiqhoLabLbwVdWT0TdA8CChu3HfbhYEVuO5pIoxOmB9jH8zv+LoCWCP5xqWQdQX5+sHrfei2p2pl47Waxou7G4VDuYwFutvxbmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFfeBN6O; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFfeBN6O"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-128cba36eceso1434833c88.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2026 04:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773141309; cv=none;
        d=google.com; s=arc-20240605;
        b=ELseXrh6l43Gn9P+ppZC1DmWhvCNCnvfGUQ8vj37Dleb8FORPdc6ze4hnhc84xMvaO
         KZuuMMjF7G2dvmPx8zgWkUgsPxdf6orqBzOrB6ulhfOmvV/P3l+RTDcmlCtE8AUKC80j
         adlCM9aMditp+q2vxjbz7k4qYfO081HHXXt7IXO1pOnIRk34dKiqiOTENtg+pMoHO7gZ
         p0U/VnDwEpI0sQ1I8KwdbV9wff4zLcEYByc+pyXD5E5TFIjhKugJ/wc8nfmAJJXLgl7R
         B1e1pnQockLSRPLrMxOuwE1zFowXyNPsbvp2KVabsDjpfFBoE+cHSOVfBrWZOSvFRxWH
         H9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pWGnhgVXkTa7LbWD/8Ldc3qdEVL8etFyKY3NfyYZWE0=;
        fh=qRHVn4YWLV5ka8wlyBXVswyhP5ChimidqL60uAjCDMQ=;
        b=Cx9Zh74ZIsJ/aK8EqaNPXgQXFV2hpTGeLNxsEKVWtWdVw+2Ezw2jEB2wrNxrSpiqdV
         5BHRIEHXCgD5es6lJ0s7LcEuCrrEWY6+eVvdE1QhT7ME5sUNEGU/o4koQgHrotmF/knY
         /ChcUF4CibakRHRyyr3c4g5PJNk/mbh9B5jjDphtsaHsmIYACy6Cx3WeF7zm4FbBvnxS
         4J50uLAgCs2Egdk1c3/v9JZYqko635zSc+4pas4W7obiQtHb34GC3vWOQJRdDDWDaddP
         HQbnZotcjD6gMwShwXDXZP2AtJCqljybDVHdtGNnjtXT0vcUmFVRs1YX/BnwkRdDyU3a
         lWtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773141309; x=1773746109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWGnhgVXkTa7LbWD/8Ldc3qdEVL8etFyKY3NfyYZWE0=;
        b=fFfeBN6OCHmxIVCQKSkJMegYOOFKWNvt4wbypFGnJLWpulSuoVJ7f4Pdu+/M2XTy+V
         cDpEk+TH0rJ+98HyoIyQEjUzF7VtsgzmcOLMr6TGsRMaTPOeKB0EQMc2tLTtXaZ/+f6H
         9ZPCc5kHVwDiqyIhgtu4isJ3drqlByq6+eOgcn3KSnvAhWRivINreElBz0eNieRsrmpX
         VKIEcVFlVEtyCN7u4uqlZub0fPxYszcOvzULFCEhc9wIb6vCVr5gbqVGH7lEu20uqsEE
         Tk6MsJxY31om9u15dBGXdQ1UsRYGoKgcplkSWeBDre2aUoe4ZtMTbpf6TSEELhh2cwJb
         uWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773141309; x=1773746109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pWGnhgVXkTa7LbWD/8Ldc3qdEVL8etFyKY3NfyYZWE0=;
        b=CsblQHWon3nF1/wtysOyb4vGGoyRp0AYacEzzcyeXlMQKg5VmGQi50NPLeE+EnwjGF
         HoeA1U9HGcKacjlqvMEj2VAAORZZE2BMY0CuISNafVmB6+IqFWnEWuWtHPq+zwuIh2ma
         fHmh4qoMNN+tVj87elQL7YGlNuZ6BNzrw2yOogZrdgXl9nJMTGJBMQlCiwq3mwbHKkFS
         Q12yqyx2p9FTquHdoUIV6T2FWtgqXIijbaNv+x6sbKmhzO/nJnIaMfx98R9nkizlJ1Nq
         Nx4gTYq79ZF4NECf9EqnV/CE+6tAHhVJPAfnG2GaYDmrL+9SHwrW0u6alz/WOjeGM/Dy
         zHRA==
X-Gm-Message-State: AOJu0Yx5mF5joKSW8Yv5FzeF81EkJuGpR5TRTZnubQFsjUHevW0rpbxG
	TcyuKYIpwwWLV1Qhc2sCzvBEJSbxCEzYw+RvoY+THY09llSM9A3utB5MiaIV07cyrRl2nyqK1B+
	rV0pY9M5CQ/rIgFrFch7vidKkWoSdeN8WJNKQ
X-Gm-Gg: ATEYQzzdZiExDKtbJRZhzVRJHS84/oA4OyNW0HhHWeafBYwBj/3We0Z3L+6C2QEoVC7
	UmER3aJN860BeZnWtclP9m+qCH/fUa2yNpvLrkUWlVlc++VvP9bvsE+kcTMp1N+Lem/Cz0bbRw0
	vFsGXzuMbY/anBiH4iCiYsW6n6M61DE2EDHvF55T8IhYDpXJ78jEjm1WzDhrSZEUhqCVWO7Y6yq
	D9+x0yICE649C6Deo1KbhSj3FOViJIbXbRv8as3FiehaEpoTZemYQwmsqBwlw86yumrYvQ0vtMg
	+6YWYrZ4RY8Tzp4lXQ==
X-Received: by 2002:a05:7022:49c:b0:11b:baa5:f4d1 with SMTP id
 a92af1059eb24-128c2d8e759mr6915660c88.6.1773141309085; Tue, 10 Mar 2026
 04:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310070515.518225-1-dongsheng.yang@linux.dev>
In-Reply-To: <20260310070515.518225-1-dongsheng.yang@linux.dev>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 10 Mar 2026 12:14:57 +0100
X-Gm-Features: AaiRm52WjIUUBG2CDEfbn34qSpn9mhUf5mYciQphgWd_G6eXLRcCEOZZ4tOkYbw
Message-ID: <CAOi1vP8VRAPxjBMJ2uZNKEvKVmqG1hx8dUWcOVTovKJv5OOQhw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update email address of Dongsheng Yang
To: Dongsheng Yang <dongsheng.yang@linux.dev>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 8:05=E2=80=AFAM Dongsheng Yang <dongsheng.yang@linu=
x.dev> wrote:
>
> My easystack email will be unreachable soon, update my email address to
> linux.dev one.
>
> Signed-off-by: Dongsheng Yang <dongsheng.yang@linux.dev>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 55af015174a5..0ba9a0509cf0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21955,7 +21955,7 @@ F:      drivers/media/radio/radio-tea5777.c
>
>  RADOS BLOCK DEVICE (RBD)
>  M:     Ilya Dryomov <idryomov@gmail.com>
> -R:     Dongsheng Yang <dongsheng.yang@easystack.cn>
> +R:     Dongsheng Yang <dongsheng.yang@linux.dev>
>  L:     ceph-devel@vger.kernel.org
>  S:     Supported
>  W:     http://ceph.com/
> --
> 2.43.0
>

Applied.

Thanks,

                Ilya
