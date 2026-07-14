Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89482348C78
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056082; cv=none; b=FF7wkqWR4O8uuZCG5kfHE6VBOqPEv1Uo9gsu9++GyvLHKuRUD0foCbSU3b+KmRch/gOV/G1S+3OvVg9GGDsax8FLI7isNwyZ9OAcuJTYCtiNVLOYOeKM5J4ruVX3FIjfn90ES9bmNkg5K9Xqs/t+SK7JEzV0L24monGNFVd8mrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056082; c=relaxed/simple;
	bh=a5Ois1WMQs8rTTjc0Y/JdNvVFDh49pZ5pw+zz1csADo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jhYJfW61y5a/dCEbUQc4MHJTMwIrSoQsq5oMchkk3Re3OlY4dKJXhQ//0INkmA4JiwCJos+3rLxwn4bif15F/RxbN5C4YJ8TgWuKU0jnjNwMlqNqgJk3JJVs6BpYbp1OUDpKLCnCJKgQKbNB16EtQoGg+cgw5fnK9ot73bOeHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=UhqYdKMO; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="UhqYdKMO"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8143daf89c7so13958227b3.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 12:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784056078; x=1784660878; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V8icvngYTkASi8PIKv+u7q/bHN+TIAGT45yuyjtfpfQ=;
        b=UhqYdKMOcHEy8LK6U6WpmVMhHmD1mXiYWtA22D+/594wfM4QcE4FNC8OPgg+hkZZSR
         6/nNMZnrSYJLFKu74aQqOW0FRpZnxe5sORY4gNjOhtxel2A+FlAWLxV5uUB0oRkxjRM5
         vHGJ0k7hYq0DvkDTj0r7JDJhp+GxJ0l1gF+29anuLvP4ZaYbKcz2faEwZ0L/hSU+n7As
         a+IlrMmVjHXOMja1wnfdonPyN5r4CuvbJgDeKH21mV45lN4bzzj0QZDm9NqxZA+XFZyj
         fFt3Vj+yGttuzfrJbpeQ2hWdJuDun5LAEeKPFK21tIjaCgZlNMr3y5R5Uq8SSpxkOL02
         9Jvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056078; x=1784660878;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V8icvngYTkASi8PIKv+u7q/bHN+TIAGT45yuyjtfpfQ=;
        b=IDHYDzgrVWuxQtiOL4EAR4hpO9BK93oiPXnstLgiYbCxVOFMjnN0pfIq8j7Rw+Z+kJ
         +npS/87PFRLkJY9KehjECw9zviz8pP9oqCmb88Bztrqd5h/K1bhTaY22NLClyMJnLhRO
         oXpI5BF5tyT9BOPCgSJhY/ZD63ehM1MXbyg0fxYxz1JPaxBigOjY9S1J1HI0qbIw3A16
         iZA13BRcAyi7RKhCTKvd+4zyoJHCWb/fjHPh9aFMA2sajv07fs3KsqFZ1QNYhq+m2u64
         pKCyK+G+Ac07FSl8a9b4tvrd2HkjhkmwB37Lpnz6w/FAqbNHa6DYj92DBVUYyYt4Wk+W
         hDvQ==
X-Gm-Message-State: AOJu0YzHNf52BhJb65rTmr7IXQFyanDSJU0UkM5+U5OOXZhSHuOJaBRC
	tg931dXd/9RvPS1DCbs4VDpFoYH/PmZa//7Qg08V+aOoguY8NKvQecN6TJ7VoFx4bpU=
X-Gm-Gg: AfdE7cmnzoLp76zgoN0QULLCcCUOZbeBdPH/TRLw7pm+7cWuqkBT8dF6GsDLJmQUmHO
	G3NHFdNOF2MSp129cO/CW7dz+ZL0hBRnqwudUz3LEGaIzWmEW1Xzcbo0VOYbQY5a7VM591m9oNF
	x097rvaj9N3Nk4J/bvIQUXRLT7HCcEm/CfiawStVdQHemvPqeOv4JoZqZEFEg77FCWoEmD/7Qs/
	B6W5ifObqVHCk1wofEMtH2rjk2r9sH/JPHeWZ84OFWK3TQyvP9LF/q1AhUlyW4Zd8KQb0ljBp2a
	qB9hvKDJwntZqEqUJkddUKqGpgPN2IshxGYC4nqt9NUPT2YvMxXrKf8Hd5942x8vLy9mlXe2vB8
	WWsPa+Lh48+JxUsIMzDhLPom1zqKV5UlAxJO9TpGmC/+hq/vrmNLTr4faX4kqIVxL/CBmtH81kw
	0Rf3D6vFPJ+i4SK4J9AvLaHVPOlUvHnrUjqkAsTp0Rg+f8r8DFZMq1TTVz2iDjJ8HakGYzD5Hux
	eaI4Ynp1tkA54VYC1ZoBXF6EZjG2So1+sSeac7JgQWlwA==
X-Received: by 2002:a05:690c:c16:b0:81d:2254:8504 with SMTP id 00721157ae682-81e9016d68emr106602767b3.56.1784056078291;
        Tue, 14 Jul 2026 12:07:58 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9b87:2209:14fb:1802])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e950567eesm89008147b3.13.2026.07.14.12.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:07:57 -0700 (PDT)
Message-ID: <b8ada95978d282df87ed12d9f631571c4ab74574.camel@dubeyko.com>
Subject: Re: [PATCH 5/5] ceph: narrow mdsc->mutex scope in
 replay_unsafe_requests
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 14 Jul 2026 12:07:56 -0700
In-Reply-To: <20260713-ceph-mdsc-mutex-optimization-v1-5-9ae5ac135c34@clyso.com>
References: 
	<20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
	 <20260713-ceph-mdsc-mutex-optimization-v1-5-9ae5ac135c34@clyso.com>
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

On Mon, 2026-07-13 at 17:46 +0800, Xiubo Li via B4 Relay wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>=20
> __send_request() is lockless so holding mdsc->mutex across the
> replay loop only serializes the list iteration itself.=C2=A0 Collect
> the unsafe list entries under the mutex, then replay them without
> it.=C2=A0 The old-request tree walk uses xa_for_each() which is
> internally locked.
>=20
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> =C2=A0fs/ceph/mds_client.c | 16 ++++++++++++++--
> =C2=A01 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index ef54d19ace2a..6c5a8c651d3e 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4673,12 +4673,25 @@ static void replay_unsafe_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0{
> =C2=A0	struct ceph_mds_request *req, *nreq;
> =C2=A0	unsigned long idx;
> +	LIST_HEAD(replay_list);
> =C2=A0
> =C2=A0	doutc(mdsc->fsc->client, "mds%d\n", session->s_mds);
> =C2=A0
> +	/* collect unsafe requests under the mutex */
> =C2=A0	mutex_lock(&mdsc->mutex);
> -	list_for_each_entry_safe(req, nreq, &session->s_unsafe,
> r_unsafe_item)
> +	list_for_each_entry_safe(req, nreq, &session->s_unsafe,
> +				 r_unsafe_item) {
> +		ceph_mdsc_get_request(req);
> +		list_move(&req->r_unsafe_item, &replay_list);
> +	}
> +	mutex_unlock(&mdsc->mutex);

This loop is done right.

> +
> +	/* replay unsafe requests =E2=80=94 __send_request is lockless */
> +	list_for_each_entry_safe(req, nreq, &replay_list,
> r_unsafe_item) {
> =C2=A0		__send_request(session, req, true);
> +		list_del_init(&req->r_unsafe_item);
> +		ceph_mdsc_put_request(req);
> +	}

However, this one has issue, if I am right. No ceph_mdsc_get_request()
anywhere in it. It has always relied entirely on the caller holding
mdsc->mutex for the duration of the loop.

While this loop is inside __send_request() or
ceph_mdsc_release_dir_caps_async() for one req, nothing stops another
thread from acquiring mdsc->mutex and completing/timing-out/aborting
that same request through the now-fully-unlocked
__do_request()/wait_requests() path, dropping the last reference and
freeing it =E2=80=94 at which point the next loop iteration's xa_find() tou=
ches
freed memory. Am I right here?

Thanks,
Slava.

> =C2=A0
> =C2=A0	/*
> =C2=A0	 * also re-send old requests when MDS enters reconnect
> stage. So that MDS
> @@ -4699,7 +4712,6 @@ static void replay_unsafe_requests(struct
> ceph_mds_client *mdsc,
> =C2=A0
> =C2=A0		__send_request(session, req, true);
> =C2=A0	}
> -	mutex_unlock(&mdsc->mutex);
> =C2=A0}
> =C2=A0
> =C2=A0static int send_reconnect_partial(struct ceph_reconnect_state
> *recon_state)
