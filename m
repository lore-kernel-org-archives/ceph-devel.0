Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B3040B6D8
	for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863790; cv=none; b=kJd8+0t5Aasnd1YwBp46SPEvYP7O0swOeY64jQxtf65Tp9mA6FCyu+GKyhCynK0KSAe9pfgqjTegjnA2oGUJZmvROczyEg0TzTOeck7wWKPzN1IW5ZICok10j+f0RCNLLKK5Y+0R8GdPzsmDE1pb83HPxez6vjT/DdHS8sEczxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863790; c=relaxed/simple;
	bh=7+Rt2qzAcD4IjdxEToLm+AnkPrCGVlDqr/Ek41GToTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NKqVkoYXidkda7ONV7ww1c7EPU5he+s4vPTyk2Pj7PvauLfdTG0IFR9i65ViMxZ2WXN6I3XtTTj5mcutrunPGz+yFoG4Te4b+sPivd3+xp2H22P41cp6mbsMKG3w+X9NljgCJZz6qjurQPTlWZUkLY7736vcTBjtCDBmQpPzgGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=SBgHvqld; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="SBgHvqld"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65dead17c24so38155d50.2
        for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 09:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1778863788; x=1779468588; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=btKpAOh+PKREiy8pssiYryJxMIh/DLaGTqNCwb2cU/U=;
        b=SBgHvqldQQAu7Rasw7dL+jGxmeCiULiBY9dxPnQXyqQACHixFiwod6MIlXZkyZCIhf
         aHJ1jSzVf6sSGukIlxo2XdBi3R8cFCfFRdsfrAlkPHwSP815wCNajuE1pFKpMSDDwJMK
         FOOYvWBcruxyFj8F5H2VNqYVrK+j3ewjKijzrYe75MKDUzJ8777DG4vDXu8ciB94P2Qw
         5hzgG62X5euRUhTwH0/i/Uy3OynZcky+RNXiSVongp9bvbo7Oz46LZggmjGVi9WYwXOx
         hQBhp4ESxXIVcomu4riMUHn2nUS17X9+CHexvTipMNfUpFYsFCHncg3zbWCS8hYKh1WO
         lpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778863788; x=1779468588;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btKpAOh+PKREiy8pssiYryJxMIh/DLaGTqNCwb2cU/U=;
        b=G9Rfyu0fX06/QqWIf0DluesU7heRWa8zrKsBSuAqHzuMaBHawWNxspFD33gYg1xfXs
         ziGnf8cGh/Ag4R1BIO+NX/kaLYcbbNb4XKU3umqpFb5CElQIlw/rmBF2VcXImGN8r2p8
         vpeptB8PQi25b+XChi3zkk0fK1S5rSKTssJYl4YKI+nF7qArE6AZgGXYc1x+rHoTe//6
         O1IJZ+LZ1ZfItcwdvYjIhbQtTxZQwi/s22ijoNSF6eaABDigD+3imZ6bJbNp22niiuTy
         qiq/dWK5nxwaFOb2BMpmykGxKDgkUQ0JZjJU5f0PJCgtYRBUhlRhWqjMPrefbRXbFRjI
         ZvSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+DLDngfRh2XC8qvI/ey/f+JVclAe4LWj0nflOU6vh3XPQPL1yFcc0DiVL5T/l5SCd2dVQsXzKIHdSs@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNsV9O0YoVPaLDVQuWt5649SaxCDJizgvTjt5ZpNWdFNtVpHW
	szApJtmxNfTq6oJWpwVdn609CyJgxLlHRrj7BxJ4JK4WQcvW4EJP0hqAmrd1lJTRLsI=
X-Gm-Gg: Acq92OH0dmzh+8kAjYmqlEDW0pIM1EaTYM1L9dYSuuZgSub+1647SRsnCUDSiS91ECM
	IPkdj/Hg6AMzDrTLB9qpHLuEUqRBdxcxkxBazDVWJFc+/Q+3V0iZzectdZwHbv2rg7jdZ/9RUIW
	5bVr/jas7vzk5F7xhjmWJplBYKIC7dY2Xg+Zp7y8j3GeMNFXeKwmNzRXSit4Fiq9DYTcBbBUDj0
	iVE8dCyL/1ic6xmNBJ6WO5l7FEttjc3N/EvGNPp0YRbzbO8vhyoBxHT7MoPP9C2MpHc8gWmsehk
	COkmlM7ceiG8IgsLoysau+cDQGovQ/1GB7x6jNXjQcinAsB7xWc9/fcuz1wGhBgVfvQjg9BDV1T
	Mxexb0ZHr4yQtgL1phzGAzjhSgn06chTZQ+74sD3xa+TLhzNUtiUnVx0lVJBkp4Q3VNEL6crUtX
	Gf8jFwr6X0HwhpWq1ETNaKicWc6YGpAHGhqPZBVXTn/W5P+6crGWv4DVjFUXy0pyjlMK4mCMteM
	KcyMbwEix3gR8w6nEkzV8zvMaIfNgK89drjl8OQOCWhgL5mPSz7ez9YMw==
X-Received: by 2002:a05:690c:c4e3:b0:79e:9cc1:edf7 with SMTP id 00721157ae682-7c95ae490a8mr51259507b3.13.1778863788375;
        Fri, 15 May 2026 09:49:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7ec4:8c87:a1b:125e? ([2600:1700:6476:1430:7ec4:8c87:a1b:125e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c7f55b85edsm32209507b3.35.2026.05.15.09.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 09:49:47 -0700 (PDT)
Message-ID: <f919b66a7cc03dfd22231b87353ebeaf864e3d0a.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: Fix out-of-bounds writes with oversized
 monitor reply messages
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: security@kernel.org, ceph-devel@vger.kernel.org
Date: Fri, 15 May 2026 09:49:46 -0700
In-Reply-To: <20260515133129.1595265-1-raphael.zimmer@tu-ilmenau.de>
References: <3f154565-9f37-40aa-b34a-be6f5c2b4463@tu-ilmenau.de>
	 <20260515133129.1595265-1-raphael.zimmer@tu-ilmenau.de>
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
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

cc: ceph-devel@vger.kernel.org

On Fri, 2026-05-15 at 15:31 +0200, Raphael Zimmer wrote:
> When processing an incoming reply message of type
> CEPH_MSG_STATFS_REPLY,
> CEPH_MSG_MON_COMMAND_ACK, or CEPH_MSG_MON_GET_VERSION_REPLY on the
> monitor connection, an already allocated reply message for the given
> transaction ID is used (if existing). Such a message has a
> preallocated
> front segment with a fixed length of 64, 512, or 32 bytes, depending
> on
> the message type it was allocated for. The actual length to receive
> into
> this buffer is read from the message. If this value exceeds the
> allocation size, data received from the network is written beyond the
> end of the allocated buffer.
>=20
> This patch fixes the issue by adding a check that compares the needed
> front segment length to the previously allocated length when
> retrieving
> the message buffer. If the needed length exceeds the allocation, a
> new
> message buffer with the needed size is allocated to replace the
> previous
> one.
>=20
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
> =C2=A0net/ceph/mon_client.c | 11 +++++++++++
> =C2=A01 file changed, 11 insertions(+)
>=20
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 66c0d6d6b33d..b84dd2bfe77b 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -712,6 +712,8 @@ static struct ceph_msg *get_generic_reply(struct
> ceph_connection *con,
> =C2=A0	struct ceph_mon_client *monc =3D con->private;
> =C2=A0	struct ceph_mon_generic_request *req;
> =C2=A0	u64 tid =3D le64_to_cpu(hdr->tid);
> +	int type =3D le16_to_cpu(hdr->type);
> +	int front_len =3D le32_to_cpu(hdr->front_len);
> =C2=A0	u32 data_len =3D le32_to_cpu(hdr->data_len);
> =C2=A0	struct ceph_msg *m;
> =C2=A0
> @@ -721,6 +723,15 @@ static struct ceph_msg *get_generic_reply(struct
> ceph_connection *con,
> =C2=A0		dout("get_generic_reply %lld dne\n", tid);
> =C2=A0		*skip =3D 1;
> =C2=A0		m =3D NULL;
> +	} else if (front_len > req->reply->front_alloc_len) {
> +		pr_warn_ratelimited("get_generic_reply %llu front %d
> > prealloc %d\n",
> +				=C2=A0=C2=A0=C2=A0 tid, front_len,
> +				=C2=A0=C2=A0=C2=A0 req->reply->front_alloc_len);
> +		m =3D ceph_msg_new(type, front_len, GFP_NOFS, false);
> +		if (m) {
> +			ceph_msg_put(req->reply);
> +			req->reply =3D m;
> +		}
> =C2=A0	} else if (data_len > req->reply->data_length) {
> =C2=A0		pr_warn_ratelimited("mon generic reply tid %llu data
> %u > preallocated %zu, skipping\n",
> =C2=A0				=C2=A0=C2=A0=C2=A0 tid, data_len, req->reply-
> >data_length);
