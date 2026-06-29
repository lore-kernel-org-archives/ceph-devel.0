Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690243E486
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782751574; cv=none; b=B7SH/KNz2AKexPBeHnZsss+7GhiYt/6VO6bBo3ijIE1rIkzr/lP+SuDlmEYnqArYuGd1ewVLM6K4Cth6YDTayG9v03infJU02+BJyQ2SxnSREFiqPMvz/qacYU+ytMYmNyr3aCmuB2Jbc6GAbnA4NJfsBYKfqzL6AIy1CVnpthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782751574; c=relaxed/simple;
	bh=FmobGFWHAA5FfbefEKJI1DPPMV98ZJK9He0pAAY1UIs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CSrkeBpghS9GejrCbccOJnwlOmhGSj3tE866fczIEA/snuewFs7MaO0bP4IMkBwk0OYYVacHfGslHjnSKaRjxhrZYpLaELRhI2oyL2wO6kqhrld0dPg+HbKojY67JQ2x4SwDU7ZmHFfsFowHcvG45Kc4l+5sMqbR0UVacD/b/8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=efFT6M9M; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="efFT6M9M"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80f602d8785so12713887b3.1
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 09:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782751573; x=1783356373; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FmobGFWHAA5FfbefEKJI1DPPMV98ZJK9He0pAAY1UIs=;
        b=efFT6M9MiuXFZ8ltSyevLBhkSNI/xpOwIR+3r6n4e4UCuAV1G3OeDeOEeE3yduQb+K
         PsmWoNPiYZmvO7e/jifM5CgxFD8XguVQT1wPdvkV2y8PFW3+s4XYESmnZiEFNCeC0HaP
         MaUKiexakAH+KOsZIhprLd893rVNyeqO+7AO5rf65vtA1wi2YjiFpqJwPWICn3jl95Ia
         WOAfQYHa3YR3LeTfRsJB3o/ZCtpFtRljhrDV0xSeZbNGeTGAMNrxcPX2NP1oGK9FqGek
         ghvCeKCGremZojB5UA/qwfkz+bXKo4XKWwkFEHQOX/Eyfep94BfsSw4mqiJR1VaWghjs
         eCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782751573; x=1783356373;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FmobGFWHAA5FfbefEKJI1DPPMV98ZJK9He0pAAY1UIs=;
        b=a2qJz4rp08ZCWP1OY1uylT4apl4P7nXICovveNTQY2lYsw78DGMIs30IqZaRnznt2o
         MVN+LMP5xrSTAhIL1O+rcm1dlyok71zaqiYqTBAK0j5GoeRmMWQXNuYBvB9mnrgdHF36
         y6B6kS4VxQN4azm8CIg56p2sGj1Mp1fBUKYtzgvhRQx86lhoHfm7L9bLqm2I2138o/c1
         f0O8EcQsq1FycOIallGldTZirG7v7N2LaSZRSk+i0c2m12bJWdBBjnslQRCU8UBaGWOB
         UvqMnOjlPjhefa91UBZBcp0je0YPe5QmldHTfNg6LhLRAtoszelp19qCzkySe2ugRTTh
         aPBg==
X-Gm-Message-State: AOJu0Yw/vPq73K9Vxnob+sqYwe/yQ5o3iUil0SMAumjSbmQQPx3ReQ+v
	CZR/jLgatyqpE1EgyxfDFVoj7j6T2AGz/bTLRzbmmZW4/tc7lIEyBOLCfYmmH0J6DzM=
X-Gm-Gg: AfdE7ckbx2X5k5UWCLZEU1wfx5yXbQLZJhisBVc8W7QRPyIe6qQLnosLUfavAek5EEz
	RKgFD4mMA20QwzlUanJ1FjeO3Xv21PoX3eXF/Gq/P0JStzz41cpJ2QhwawYHJU64yd6lfPBzkul
	nMp5mo+RAuPfUPiQNwKJfkn2eRgh7TJMYf9BwFeiFiTEcrjLYxUhOv/MMFkkTabqqzVy+5yRqw6
	ggFH1ZlUxljn2lCYVmkugXwXe+gFYCw5oBpGPiMlnt7Rk9fIITxLizXlY/+CActKaXin5OHcfPN
	uJRLkaOAuAeX6FDg6fpUzPvc0K0wzhbDNXeUC4/seJ17s4AkDp7vXu9iu4JfI2uKlzotuw0Va3H
	ubp5B2WSLWU4ClyJBy8o2iqeDeiiEiY6gPZyFPZRRHEQj1bqleILQF5aytjjCDq0vTDJGx6f0/A
	5ft2e68xBuDDjRwm08RLhhDOffauRDgBnNunN04gJtwRaiQscf4kAIA3P8mcVltvghIor1eFLcu
	IrV9DCqiaARU+dYoINWTX0A0SXc8213Z8hNAYzwf98W3I2EyHagX7+y/Hg+FTNVcl+04tj3WVMM
	zzbVp6I=
X-Received: by 2002:a05:690c:4c06:b0:80c:3848:bde5 with SMTP id 00721157ae682-810d7ebe581mr3552677b3.13.1782751572734;
        Mon, 29 Jun 2026 09:46:12 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810ea95252asm101077b3.48.2026.06.29.09.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:46:11 -0700 (PDT)
Message-ID: <8d2ff1bbb16555bda9c616ffec722273ccaa4eb8.camel@dubeyko.com>
Subject: Re: [bug report] out-of-bounds access in ceph_con_open()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Mon, 29 Jun 2026 09:46:08 -0700
In-Reply-To: <2e10a5e1-14cc-4f8f-9ef5-76a7f7c0fa9e@tu-ilmenau.de>
References: <2e10a5e1-14cc-4f8f-9ef5-76a7f7c0fa9e@tu-ilmenau.de>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=mQINBGgaTLYBEADaJc/WqWTeunGetXyyGJ5Za7b23M/ozuDCWCp+yWUa2GqQKH40dxRIR
 zshgOmAue7t9RQJU9lxZ4ZHWbi1Hzz85+0omefEdAKFmxTO6+CYV0g/sapU0wPJws3sC2Pbda9/eJ
 ZcvScAX2n/PlhpTnzJKf3JkHh3nM1ACO3jzSe2/muSQJvqMLG2D71ccekr1RyUh8V+OZdrPtfkDam
 V6GOT6IvyE+d+55fzmo20nJKecvbyvdikWwZvjjCENsG9qOf3TcCJ9DDYwjyYe1To8b+mQM9nHcxp
 jUsUuH074BhISFwt99/htZdSgp4csiGeXr8f9BEotRB6+kjMBHaiJ6B7BIlDmlffyR4f3oR/5hxgy
 dvIxMocqyc03xVyM6tA4ZrshKkwDgZIFEKkx37ec22ZJczNwGywKQW2TGXUTZVbdooiG4tXbRBLxe
 ga/NTZ52ZdEkSxAUGw/l0y0InTtdDIWvfUT+WXtQcEPRBE6HHhoeFehLzWL/o7w5Hog+0hXhNjqte
 fzKpI2fWmYzoIb6ueNmE/8sP9fWXo6Av9m8B5hRvF/hVWfEysr/2LSqN+xjt9NEbg8WNRMLy/Y0MS
 p5fgf9pmGF78waFiBvgZIQNuQnHrM+0BmYOhR0JKoHjt7r5wLyNiKFc8b7xXndyCDYfniO3ljbr0j
 tXWRGxx4to6FwARAQABtCZWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPokCVw
 QTAQoAQQIbAQUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFXDC2tnzsoLQtrbBDlc2cL
 fhEB1BQJoGl5PAhkBAAoJEDlc2cLfhEB17DsP/jy/Dx19MtxWOniPqpQf2s65enkDZuMIQ94jSg7B
 F2qTKIbNR9SmsczjyjC+/J7m7WZRmcqnwFYMOyNfh12aF2WhjT7p5xEAbvfGVYwUpUrg/lcacdT0D
 Yk61GGc5ZB89OAWHLr0FJjI54bd7kn7E/JRQF4dqNsxU8qcPXQ0wLHxTHUPZu/w5Zu/cO+lQ3H0Pj
 pSEGaTAh+tBYGSvQ4YPYBcV8+qjTxzeNwkw4ARza8EjTwWKP2jWAfA/ay4VobRfqNQ2zLoo84qDtN
 Uxe0zPE2wobIXELWkbuW/6hoQFPpMlJWz+mbvVms57NAA1HO8F5c1SLFaJ6dN0AQbxrHi45/cQXla
 9hSEOJjxcEnJG/ZmcomYHFneM9K1p1K6HcGajiY2BFWkVet9vuHygkLWXVYZ0lr1paLFR52S7T+cf
 6dkxOqu1ZiRegvFoyzBUzlLh/elgp3tWUfG2VmJD3lGpB3m5ZhwQ3rFpK8A7cKzgKjwPp61Me0o9z
 HX53THoG+QG+o0nnIKK7M8+coToTSyznYoq9C3eKeM/J97x9+h9tbizaeUQvWzQOgG8myUJ5u5Dr4
 6tv9KXrOJy0iy/dcyreMYV5lwODaFfOeA4Lbnn5vRn9OjuMg1PFhCi3yMI4lA4umXFw0V2/OI5rgW
 BQELhfvW6mxkihkl6KLZX8m1zcHitCpWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29Aa
 WJtLmNvbT6JAlQEEwEKAD4WIQRVwwtrZ87KC0La2wQ5XNnC34RAdQUCaBpd7AIbAQUJA8JnAAULCQ
 gHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRA5XNnC34RAdYjFEACiWBEybMt1xjRbEgaZ3UP5i2bSway
 DwYDvgWW5EbRP7JcqOcZ2vkJwrK3gsqC3FKpjOPh7ecE0I4vrabH1Qobe2N8B2Y396z24mGnkTBbb
 16Uz3PC93nFN1BA0wuOjlr1/oOTy5gBY563vybhnXPfSEUcXRd28jI7z8tRyzXh2tL8ZLdv1u4vQ8
 E0O7lVJ55p9yGxbwgb5vXU4T2irqRKLxRvU80rZIXoEM7zLf5r7RaRxgwjTKdu6rYMUOfoyEQQZTD
 4Xg9YE/X8pZzcbYFs4IlscyK6cXU0pjwr2ssjearOLLDJ7ygvfOiOuCZL+6zHRunLwq2JH/RmwuLV
 mWWSbgosZD6c5+wu6DxV15y7zZaR3NFPOR5ErpCFUorKzBO1nA4dwOAbNym9OGkhRgLAyxwpea0V0
 ZlStfp0kfVaSZYo7PXd8Bbtyjali0niBjPpEVZdgtVUpBlPr97jBYZ+L5GF3hd6WJFbEYgj+5Af7C
 UjbX9DHweGQ/tdXWRnJHRzorxzjOS3003ddRnPtQDDN3Z/XzdAZwQAs0RqqXrTeeJrLppFUbAP+HZ
 TyOLVJcAAlVQROoq8PbM3ZKIaOygjj6Yw0emJi1D9OsN2UKjoe4W185vamFWX4Ba41jmCPrYJWAWH
 fAMjjkInIPg7RLGs8FiwxfcpkILP0YbVWHiNAabQoVmlhY2hlc2xhdiBEdWJleWtvIDx2ZHViZXlr
 b0BrZXJuZWwub3JnPokCVAQTAQoAPhYhBFXDC2tnzsoLQtrbBDlc2cLfhEB1BQJoVemuAhsBBQkDw
 mcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEDlc2cLfhEB1GRwP/1scX5HO9Sk7dRicLD/fxo
 ipwEs+UbeA0/TM8OQfdRI4C/tFBYbQCR7lD05dfq8VsYLEyrgeLqP/iRhabLky8LTaEdwoAqPDc/O
 9HRffx/faJZqkKc1dZryjqS6b8NExhKOVWmDqN357+Cl/H4hT9wnvjCj1YEqXIxSd/2Pc8+yw/KRC
 AP7jtRzXHcc/49Lpz/NU5irScusxy2GLKa5o/13jFK3F1fWX1wsOJF8NlTx3rLtBy4GWHITwkBmu8
 zI4qcJGp7eudI0l4xmIKKQWanEhVdzBm5UnfyLIa7gQ2T48UbxJlWnMhLxMPrxgtC4Kos1G3zovEy
 Ep+fJN7D1pwN9aR36jVKvRsX7V4leIDWGzCdfw1FGWkMUfrRwgIl6i3wgqcCP6r9YSWVQYXdmwdMu
 1RFLC44iF9340S0hw9+30yGP8TWwd1mm8V/+zsdDAFAoAwisi5QLLkQnEsJSgLzJ9daAsE8KjMthv
 hUWHdpiUSjyCpigT+KPl9YunZhyrC1jZXERCDPCQVYgaPt+Xbhdjcem/ykv8UVIDAGVXjuk4OW8la
 nf8SP+uxkTTDKcPHOa5rYRaeNj7T/NClRSd4z6aV3F6pKEJnEGvv/DFMXtSHlbylhyiGKN2Amd0b4
 9jg+DW85oNN7q2UYzYuPwkHsFFq5iyF1QggiwYYTpoVXsw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

CC: ceph-devel@vger.kernel.org

On Mon, 2026-06-29 at 10:40 +0200, Raphael Zimmer wrote:
> Hi,
> I discovered an issue in the libceph module. It results in an
> out-of-bounds access in ceph_con_open(). The behavior can be
> triggered
> by messages of type CEPH_MSG_OSD_MAP from a Ceph monitor or OSD.
>=20
> The problem is as follows:
> When decoding an osdmap received in a message of type
> CEPH_MSG_OSD_MAP,
> the max_osd value is decoded in osdmap_set_max_osd(). Furthermore,
> the
> osd_state, osd_weight, and osd_addr arrays are (re)allocated there
> with
> a length equal to this max_osd value. Subsequently, decode_pg_temp()
> and
> decode_primary_temp() are called to decode pg mappings and primary
> osds
> for these. The indices of the osds in these pg mappings are read from
> the message, and there is no guarantee that they actually exist and
> are
> smaller than max_osd. If the message is corrupted, the pg mappings
> can
> afterwards contain osds with indices greater than max_osd. This may
> result in calc_target() calculating a target osd with such an index.
> If
> trying to open a connection to such an osd, the osd_addr array is
> accessed, which only has a length of max_osd, and therefore, an
> out-of-bounds access occurs. A concrete trigger path for this is
> immediately during the processing of the same CEPH_MSG_OSD_MAP
> message.
> After decoding the osdmap, scan_requests() is called from
> handle_one_map(). If there are any linger requests, this function
> calls
> recalc_linger_target(). From there, calc_target() and, if this call
> returns CALC_TARGET_NEED_RESEND, lookup_create_osd() are called.
> lookup_create_osd() may call ceph_con_open() and pass a reference to
> the
> osd_addr array element at the index of the target osd, which results
> in
> the out-of-bounds access.
>=20
> Currently, I see at least two ways to handle this problem.
> 1) Treating an osdmap that contains such osd indices as invalid
> directly
> during decoding
> 2) Treating target osds with an index greater than or equal to
> max_osd
> as invalid in calc_target() and, e.g., assigning the request to the
> homeless osd.
>=20
> The first option would likely require multiple changes and come with
> more overhead. Therefore, I will send a proposed patch that follows
> the
> second option in reply to this email.
>=20
> Best regards,
> Raphael
