Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF448362156
	for <ceph-devel@vger.kernel.org>; Tue, 21 Apr 2026 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776806246; cv=pass; b=t80f6Ex70NhkbTEc9HRk1j3hA5JYTOcJ/BGjUxwthR3GhJgG1WY3/4XlQ5H6UgSwI0m/2oEghALgFL6mGsmmruTd3Ij73wWcozbVUvh2ny4wDJ81XiBzuGXtvitNgtDWNKstg9q1W1ShV9rwm/45h4NurHmPU7C90wxPyb1jh90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776806246; c=relaxed/simple;
	bh=0K2jpikuuITVdx+O5tGnLlbTrG4zrake+LBN1BmRIvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPNWGC622dIyJ2Szuz/44pTXP8Ts9mKEr0ZoL0aaD0absizIOa3wvkqUbgpbnJ9QS9cc8IzLSw02rHtmzszJW7b5JTF11DOH2K7UzvPS4uNkASDLyp7jLB4ZJBJ3FRYMf9hoAtG5TWLr9ClnfI1y2pUg+F0B3UsOXeoh2Q4l/4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpSgxpDm; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpSgxpDm"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c565dd3a7so4127885c88.1
        for <ceph-devel@vger.kernel.org>; Tue, 21 Apr 2026 14:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776806244; cv=none;
        d=google.com; s=arc-20240605;
        b=gtE+/KkKpnV6vYgG5cec55dlUxZbRIq9tH4XQls7EuebfDlZrGEnGxkBesSSR5nIF2
         8Tido/cILNPHrR0HwNUCbNYCgdNTMo2Um5R4sfxbYFa743fiHQipazirPjLVQ4YPAPrx
         uY6vsSvs4XsUUPL/0BkCWA6/i8tx2pBJaVnRkuHzAcRKoMfJDOAMtEDZDGk/PKY4Ox7U
         0HlS1pxhvL9TV37jvt14xUDpDGrey6MIBbL4C3L1hUapH7q0HpauKS5gkdDnpPlmlKWU
         qpruVIGfJU6CTtV9BewV2E1ldPwEWmBLXA160mINYXz8R8nsOCh4BickDz2uE5MYQFYx
         h5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+0dJw7727xdU3YZwZFaos1G6Xo/LkbeLaPOcnmM7jeE=;
        fh=U2QgAT1h2zR+EWC95kfJyndcrRuYBykfPN5Zdd4i7bE=;
        b=f6i63BZs/Yh3cr/S+yVChechCHTNlgtc/byedE7uiCMra3fPOSXgHV3vVPQBikrLbA
         TWYwe5pbemjMOyatzpxSzaXe+kBG1EsJ0KIt51g2yVmaOxObDjspyayk+hugPuPBkhjS
         rVrwseuAc3/1CAz0yZ+2bG8QrLpGEWDU77n0FPlH725nfHH7cfilj5+7tgoLTd9KryiA
         tVPUsxEEWC6JUA00+IQYynFNCgYwmTZw0672uON4h6SlOwEBC3lqwG3QF1/etvxby4t3
         nnblOW0raza5/5rdGTSUtef3nyohkQAWxZt9X08gP2J1D/xPn/uR+7vh6Nz3LVxhQzfy
         3xuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776806244; x=1777411044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0dJw7727xdU3YZwZFaos1G6Xo/LkbeLaPOcnmM7jeE=;
        b=lpSgxpDm1JvXadsxDuO+XZBUSC+mHM3rx2AcYO30RDKPmHhhbSz0RKZZXbH38Y3lnq
         QTZT8gWK5uRSalH9As0zyNYbM9Izbw6HZsoURngpEqsIymv/EDp4CJU7PX0cDVtOAJpk
         ni+fSrbUdF5EyDcZo9JIdTH7SgCPblb34e+ReUX9t1gFQTkk0fPdEGzAu7DDd4QDxI/c
         0EN4p4M+4SOCR/quuJ845zkrRUni+Mu7fC8AYejfKi3jDwEQ4jGOVbknflXb0CT2cCsn
         3t4n1jt8i0vrhxSzRJJXvqyEf0yLR9wXBkOfcuaTTI26+H8QDvGT1SAfGNTCZz0VbMS+
         Xf2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776806244; x=1777411044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+0dJw7727xdU3YZwZFaos1G6Xo/LkbeLaPOcnmM7jeE=;
        b=BUTMdMVbFQys64BoERrO53uAU7Ro6WHkGKqbnYJFslCK28m21aWrri664YthvcfwSn
         axegej8Uh8I/Qvt/3rjdEkXjOg7fWDDeFgcn7lTdj53j7/ZdX28xw8tHajAUoTSGnrd5
         DZkwvd+4oJMfthK6fta6zT/r+iJMhT+eVEJ5IXg/M2OEfg2NUHgo0gf6ubQU+VLyFhLY
         nPs02Nstrv/ayrTX5VgxPqYCno0Ns3iz3Heza29LkacDeqmFx6q4VJ3CsXzYRhjLOv4A
         s2v9wCVyoVbNSeppT7+ncSBnkhJ2HSOBRH5dP8MwqUc7Kdj9hmK+2jeSqDZLVoYpLmre
         Q/6g==
X-Forwarded-Encrypted: i=1; AFNElJ/ZRWK3nZ+Oxr/RmvQ0vnsgXUkIh69BdNooByD5br7dmgO5qA9dHMa/+6NT3RRSk2EQnbNpvGVwPVr5@vger.kernel.org
X-Gm-Message-State: AOJu0YwJbmoBZZbFlzbR+Ckl8/T1obzykmNy574ONPX3IYqhG2Fz64kH
	OmU8cNcCsBcv9yQm5gS12QEeo6mddTL+33CTBY+XXbi/ZmdPlzbnFiLg/iYC9m/n6CFg15OcOmQ
	Xl4rBoI7rLv6RWUg/ooaYO3sANSs3qLQ=
X-Gm-Gg: AeBDieup1sMyIG5hk0fkliFaO8XQ1VzAYJ0X7dDTDUAkTTwhIpGnpyqNH1ctoNHumKH
	um76ig7znjD9eKlEX2ffKF9usnzAFyhuVP4/sXMwVL+kFTw5lh2W3mLNJSZGZ19Oaub9UmiXB8v
	7REBINkASzItQXrEopKtdSw19ScGBkf/XF1tldhSCLFh62BsfJUmX4gKcE0pcnApZV5TYjEXmhB
	dB/NJIcxDJkl9mTqCFFBbsRGr7phtMB5WJbs73XUaZM4hyjYadJwu5PuIiPblWLig7mgebtjNCa
	KA/N/DZOrerPo/YOVA==
X-Received: by 2002:a05:7022:6889:b0:11b:1c7e:27d0 with SMTP id
 a92af1059eb24-12c73e28127mr12552094c88.0.1776806243864; Tue, 21 Apr 2026
 14:17:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402071524.3766233-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260402071524.3766233-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 21 Apr 2026 23:17:12 +0200
X-Gm-Features: AQROBzBwi2WVNHgEWGkwqVVVH1eDV5c9Dab40sGosJcwYOLmNg_eso_OLmPUfeE
Message-ID: <CAOi1vP9N9n26HEXPFpNniRtR5qc_nvxuim02J26psKpW-6iXbQ@mail.gmail.com>
Subject: Re: [PATCH v2] libceph: Fix potential out-of-bounds access in crush_decode()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:16=E2=80=AFAM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> A message of type CEPH_MSG_OSD_MAP containing a crush map with at least
> one bucket has two fields holding the bucket algorithm. If the values
> in these two fields differ, an out-of-bounds access can occur. This is
> the case because the first algorithm field (alg) is used to allocate
> the correct amount of memory for a bucket of this type, while the second
> algorithm field inside the bucket (b->alg) is used in the subsequent
> processing.
>
> This patch fixes the issue by adding a check that compares alg and
> b->alg and aborts the processing in case they differ. Furthermore,
> b->alg is set to 0 in this case, because the destruction of the crush
> map also uses this field to determine the bucket type, which can again
> result in an out-of-bounds access when trying to free the memory pointed
> to by the fields of the bucket.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/osdmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index c89e66d4fcb7..a87268058e61 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -516,6 +516,10 @@ static struct crush_map *crush_decode(void *pbyval, =
void *end)
>                 b->id =3D ceph_decode_32(p);
>                 b->type =3D ceph_decode_16(p);
>                 b->alg =3D ceph_decode_8(p);
> +               if (b->alg !=3D alg) {
> +                       b->alg =3D 0;

Hi Raphael,

Wouldn't setting b->alg to 0 result in leaking the chunk of memory
allocated for the bucket a few lines above due to crush_destroy_bucket()
basically becoming a no-op?  To be able to set b->alg to 0, it looks
like kfree(b) that each crush_destroy_bucket_*() helper ends with would
needs to be factored out into crush_destroy_bucket().

Thanks,

                Ilya
