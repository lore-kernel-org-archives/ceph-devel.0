Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAEE284B29
	for <ceph-devel@vger.kernel.org>; Mon,  1 Jun 2026 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780340157; cv=none; b=r3i7vM+yWu/HOIMs2cs5Zpin9yz4fq6ob9gR1Lf7isbYiZhAkZbhuMExTT42lP2fqr8+JkfVr053JqjcyhflII95dDE7dsid1vQfGcHzwJ58aNaLTwajUAIbPKYY5Df8sbNlvlCaT2nXl9QG8z7+wUUpoAEW7mj4FsaLmvGwb4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780340157; c=relaxed/simple;
	bh=doOQMnNcVaYWaBgPgmUVrVXGvrzEqsHddJ1hAwFmNjE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H1CxLodUD+/JmgQD6ah/ID712s8Z1p1pOf7mDh1L1Yq6ZLds3L/VH2WvmTBqM5gJEQBJy4hZ0mhgBAW4IdF9soT7CUN8slSQylfiiEzPL7jnhEU52cALPFoh9An/cIWWthiZnodJpfeJO/4NH+YZZb573iqcV7Uk3HRU8MuDMQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=hPUrPGex; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="hPUrPGex"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4854d5cc708so7096574b6e.2
        for <ceph-devel@vger.kernel.org>; Mon, 01 Jun 2026 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780340155; x=1780944955; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oG1LxZ8CqrU+63v1aB1WRuPWyjhZAZrK1u9WutDY3fI=;
        b=hPUrPGex/jYFLMcUNmksZezXpipVqA54CRrCaMawp5+nTcHyjmz37w+XzlGb1WND9q
         1f8oivCA/Is73w185DsjTtbN+dxysQeN5cc9Z1OBqSbhbbMkeNxu9ELvUcX4tRYR4YuT
         uwNU1hdb8RMMj0V+6G6l8+Gi22u1tA4UVuMpylMMABauwTqT7SlrxeWFi1hk/8zMevRu
         5ydctQ3F4+vLXARVdlG3CAmmFjHJKNhoArycJYDFl7QZ4NW0eqELotnFLKoylStZM/xN
         RuoJxc5SZP4BiQb10e85l90MQMXaMd+qGng8Kr8XUxjcTNdsfV88Btoa4KxIOHWRKIxn
         BF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780340155; x=1780944955;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oG1LxZ8CqrU+63v1aB1WRuPWyjhZAZrK1u9WutDY3fI=;
        b=cRX//dGE+/xIt/67Y9BTK1egGAJcy5lblCaO0zMMnuOd2Gja48DmtFYK64O9feGwkC
         msmk4Gwg1yKflwpQtL7mCdXMe1VDoNUkKlKl12uwPJvdTWLVLWnfW6co06gOzqUj9rcD
         A6B+eZ5IJ66OBjtTtkIj0qBxwspyc4j0IgPboRm7/2KU2noX+43pLEtXz7aUw5BEhMz9
         RRMRk688s2fnZeF1xZGSkL2HQsJQmSLGX5QfjeB4/7VTGgsKcHY+grYA+wIgtNcmjf3v
         cbazc7X2Eok41IzhQ58q3XPpDuCowDOJqCHI00iA7B1d4cb+xRfCNeQSKZMSj9CMA3LH
         0NcQ==
X-Gm-Message-State: AOJu0YzIQ7hDMRPM5cNtlHe5jiq4Di7+4slz7/TGDTe+PqcRUWXLsn7Z
	32t3UMNEIbwUtLVk83N9B5cXZexhq9JIMY4DKai4XR9p12GgQPLyjNgYaHJJ9TLV4NI=
X-Gm-Gg: Acq92OER9nOTDtOSZbfkKc/JWG8/A3gnz5HhAusTCXgvCudDDcFqoaN8y2WAwRoI50a
	bWP7ro7w4wL0tEq/cdLV4Tes4stwjb/4aM7RQ1Dy0eLBkYHUGR4Ri/avOEUqItxCqSgicwoQ3ey
	aq1i8/HjRgAjX7jInCUiesfAl3HNjgAKbzpr1XBYPBKS4rqJyuug0C/Zd9osij8c/y3qgBLwpMA
	ofEnctShZ506s6YkCI0udmqMTew3fUwvMww5nqmOFLVbIXQPsR9I/EoZ0pnTtNq4BNXG34Oqf41
	MdwJdXoAd2n3LV8OVW7CLZIXwz4wPZHaK9fj9c9fJx3eouJgQU70rmdSeeJDoEghTWL3rULsxKT
	YDG6m8u/5+TyIykvoLRC/nSSWyolH2M2TY+xu4xNglogm94deJsxJE0kQAXX+iEhVssV5F9DHjs
	9AjHiERRv0OsX5yJjc9+P2duszbGLvJRjejXSWEK5bPtpfygYKmNsBSi7lbS3arbalUYMhacga1
	9vZSybcYq3m+tKpoPGfUzr0G+xo/dVbGAPpRILLhunD3L87nxABZVJ3fOf73JOugMATULY=
X-Received: by 2002:a05:6808:1247:b0:485:41fc:71e1 with SMTP id 5614622812f47-485fb701f84mr6950718b6e.21.1780340154971;
        Mon, 01 Jun 2026 11:55:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7a3e:ac53:80f8:78b4? ([2600:1700:6476:1430:7a3e:ac53:80f8:78b4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e695bef47fsm8163997a34.12.2026.06.01.11.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:55:53 -0700 (PDT)
Message-ID: <ae39b876e5def88318b15b1e289ed60824ecbc4f.camel@dubeyko.com>
Subject: Re: [PATCH v3] libceph: Handle rbtree insertion error in
 handle_backoff_block()
From: slava@dubeyko.com
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Mon, 01 Jun 2026 11:55:52 -0700
In-Reply-To: <20260601073216.3828014-1-raphael.zimmer@tu-ilmenau.de>
References: <20260601073216.3828014-1-raphael.zimmer@tu-ilmenau.de>
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

On Mon, 2026-06-01 at 09:32 +0200, Raphael Zimmer wrote:
> A message of type CEPH_MSG_OSD_BACKOFF is used to block/unblock
> requests
> to specific PGs or objects. If this message has op code
> CEPH_OSD_BACKOFF_OP_BLOCK, handle_backoff_block() is called to block
> requests. In this function, a backoff struct is created and inserted
> into two rbtrees for tracking them. Both insertions use the asserting
> rbtree insertion function by calling insert_backoff(), respectively
> insert_backoff_by_id(). If a message contains a backoff with the same
> begin ceph_hobject_id or the same id as a previous one, the assertion
> in
> insert_backoff()/insert_backoff_by_id() triggers a kernel BUG when
> trying to insert the backoff.
>=20
> This patch fixes the issue by switching both calls to the non-
> asserting
> rbtree function and ignoring the message if one of the insertions
> fails.
>=20
> Fixes: a02a946dfe96 ("libceph: respect RADOS_BACKOFF backoffs")
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
> =C2=A0net/ceph/osd_client.c | 22 ++++++++++++++++++++--
> =C2=A01 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 2ff00070c181..1b31e2d50ec6 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -4427,8 +4427,16 @@ static void handle_backoff_block(struct
> ceph_osd *osd, struct MOSDBackoff *m)
> =C2=A0	backoff->end =3D m->end;
> =C2=A0	m->end =3D NULL;=C2=A0=C2=A0 /* ditto */
> =C2=A0
> -	insert_backoff(&spg->backoffs, backoff);
> -	insert_backoff_by_id(&osd->o_backoffs_by_id, backoff);
> +	if (!__insert_backoff(&spg->backoffs, backoff)) {
> +		pr_err_ratelimited("%s failed to insert backoff\n",
> __func__);
> +		goto err_free_backoff;
> +	}
> +
> +	if (!__insert_backoff_by_id(&osd->o_backoffs_by_id,
> backoff)) {
> +		pr_err_ratelimited("%s failed to insert backoff by
> id\n",
> +				=C2=A0=C2=A0 __func__);
> +		goto err_erase_backoff;
> +	}
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * Ack with original backoff's epoch so that the OSD can
> @@ -4440,6 +4448,16 @@ static void handle_backoff_block(struct
> ceph_osd *osd, struct MOSDBackoff *m)
> =C2=A0		return;
> =C2=A0	}
> =C2=A0	ceph_con_send(&osd->o_con, msg);
> +	return;
> +
> +err_erase_backoff:
> +	erase_backoff(&spg->backoffs, backoff);
> +err_free_backoff:
> +	free_backoff(backoff);
> +	if (RB_EMPTY_ROOT(&spg->backoffs)) {
> +		erase_spg_mapping(&osd->o_backoff_mappings, spg);
> +		free_spg_mapping(spg);
> +	}
> =C2=A0}
> =C2=A0
> =C2=A0static bool target_contained_by(const struct ceph_osd_request_targe=
t
> *t,


Looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.
