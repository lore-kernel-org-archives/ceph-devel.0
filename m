Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793640848;
	b=o23mWbEVBDgNOvC5zUjkfoNZUNShiv3KypE+Vg8sDpzteHo384koQq0s24MQaChM7u4W
	 BpsObRg+thzdhgtpnYghB+5ECxIRulLtmfyZY/YoBJXkmOKjxd+1xHR5f9FFiBE1xVh0B
	 HpyJJwm9WQmKYXvSdLo1IbS1GRE87WJ7TGkCap2npw5Vr+FS45R4D9GEpacN7iUamlst7
	 gO21LLI2F3YhvJI4k3+1NJyALo2GisRsRkDjTv2l64ROTu6dmmpWZb33/WkHH/J8pYsTB
	 yCUa1bZ+I98gY9XDVvwusS3DzsOUDJZyBcPcoQKXRJH4erCBJaDpMbrf3xkdBt4i+VQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793640848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jAbGNR1GG2wMSfrTw5y6/CFWdZUJUh+tcsQZI8cuJpA=;
	b=lXAWDHa0yOsH89HBWh9UCw6o7aIfEV5WbbWhzKxASoXnw0K4w65nBvXawnJ2eX+32ftC
	 YHJUnaMFWnZj3QfRL+YHfkymDrFmbcTMIxg7ZtnqSM3Ho2NuLDVvBnv8/x4PQxCLSwCM6
	 mEFIR5SHNqKDNtcozzuPmdW65v1zD/QR9//P72vD7EGP1VQyl/FOT/7ma0KNfh6OWC0hx
	 O93pzmDVxAzrkRDiPr5+p5+OZH8EbHiwL3fWiq5ueffqyB1NGmK9JPBGmcyjy7xg8gSxQ
	 BBXTQ2EN+d/HhKSpUe5IVHyqFaEvoyA7nWFgIvybaMpD0x884ocWWGHLTQp1W0Tuo2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+qOkeif;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6148606C3E3
	for <ceph-devel@vger.kernel.org>; Mon,  2 Nov 2026 17:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6148606C3E3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E+qOkeif
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c4be28b82so3490105f8f.2
        for <ceph-devel@vger.kernel.org>; Mon, 02 Nov 2026 09:34:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793640846; cv=none;
        d=google.com; s=arc-20260327;
        b=riNJrYwc1MTSLy/WbTylLxiQt8r7Amj9TFxORVsj++d+DgnTQ8WaOscb0E0LXHqqft
         1RFt9VPDK8dyng40UWyVQ30IL01s02uZ3OH1qiyikVCyKnvCPdQuao9dKB5f4eylEFig
         FcZ3okSqeoXYDh1CvNbWCbYnVvEQBX4x63FHzq0diPAV3XPuTRwRCiJHMl2Hn2HmLQli
         A5DwKf27gnkykypsrjfcjft8GmIuRJt6eJKFT/hvnodLUhE3m7CUsdK5HPEsVAxoBtUM
         oQIq/H8AjkdtK7nEL3M2GOFe67syNbb6XZOskb96ko7Ip8672IeXbp23ZC57jzh2vOe5
         a/tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jAbGNR1GG2wMSfrTw5y6/CFWdZUJUh+tcsQZI8cuJpA=;
        fh=/zrRnALERaRhH+4qo1gx5uPN71E9cwhb75nQaVqAgAI=;
        b=ICBO9dpkGGRBb0S/O/65axazGyCKWH17pLHC9awqDcrwnBOclisuJjD+33SzjwOiNJ
         ihwTbf71CyK9X21uFmJ2TKsQ7oGUVWyUE+7uSne0JB2T5IjIre2+vQ2Ec2KMZ0tElpuD
         zGfAneYa4dbMz3CSg8g6hmkBM5y5LJgL7qMzyS6QM2svlyd9rh3jHIYbwgv+xSr3qAiY
         LfHOLe4tt9eQxRv8KAsVGWY9wfcRARbrI5AKlKvEKu28PL2tDwjnQQJJ1br1BQrUgF6W
         8nDcQ/HqCcVXQlcOwk1wtkvuvw0o3o0t5YwZutfg4yrGhtSfEJaHun2FrR+nvGwW/rIZ
         TYzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793640846; x=1794245646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jAbGNR1GG2wMSfrTw5y6/CFWdZUJUh+tcsQZI8cuJpA=;
        b=E+qOkeifSJTrTp5WxNztdO8u+cYOm1xGbuoc/0SSuVFl2PFxOeG8/nAeZORpGZHXSF
         pALfopJMxI7WQP3uTa1eSz3+KwSwWTbIrPYCJIEiWx22VsgSLRHXSw4ziIAyKXuUdz38
         uXpdD9A5ngJ+KXIWhwi4a+V9TS9LfpYDmn1nTC9Fhy1wintK268fTLQjtbIiOICI82Sr
         ceMpYP/iPWqFyEuocxNGVtUyoybPlppmWBb8gdAIQOEJBgC1oFNEmZIS6PazIZhPxOM4
         IVD9AXlcjQX9x3bCvEFF69npEqAFE1WQZuQGpAqCJl8oPF+qw39hHcMzt8WOQ//TX6oP
         ve8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793640846; x=1794245646;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jAbGNR1GG2wMSfrTw5y6/CFWdZUJUh+tcsQZI8cuJpA=;
        b=yFWUdPHSkEav5QVkyBuCk5BoAHBLwP30/NBV7juTds3a9McHqQ/xmdWX6miquSoEZC
         av4EjqlS9CYBlBRTGJtR8Lyp+ixYiDa+WVrDR6Kwl0oCq8Q4GM5J517zDWAhDpl2pZLN
         GWMqrbga3jv2RpAcYfYP4qoHTybKCMflQGngm8AiBCt2mSMWNcyiGmzBOTSRj21iaRTV
         rlop8DSOosQ/s6Gz2quOiMpdetLP76S0twDJ5IrtnH80zQO7ICJDXPxQqu46YEpkQ+oc
         QiyNUePZfvZEsAEOWKL3MUx8iT1g0NKT872fHVbyhprkqwU32mTSOKRLHfpzfRQ/aZdz
         d15Q==
X-Forwarded-Encrypted: i=1; AKwUvBx8L5I9RkpYymPG1auJgMh9tA52wCd15YfT+phmxS5f86Il3tUD50cftEX4RbQpnxZz6sLOfNk1r/tL@vger.kernel.org
X-Gm-Message-State: APuU4Z8HQbJBeNSAP+LN2iIKEl7XFoELTDm0PHjNSujknzPQvCWcpz9U
	eUvqSHWcMGWoc3lqANIgdCApttqYAiSXQ1ZjkyAYsrwQ8InLJmQYDpANGzKt8sRQOtwZy4NnxrF
	KQRZ+cBBWIqKujbOo0RLRf6k2mND8lBM=
X-Gm-Gg: AYBFou3O13qscVidWUENufWMsKk10Ql9baNmd36afV1q/07rm9Rq/5nth04rKbNLSIt
	OqqChNQx0MqvIvRyCW9gy3wQ4/hupQXZM0UZo+IDOr/j93nQW8WBoTOKjVx5FNa5TbNPyUUkDs5
	5EuTr3UOuzELYzYt/SXVJKuKyPlV1+uGH9sikmA2RCCBTv9Qw1oSK0hWgxjn5xgpcSnVXOvpJ3k
	1fGZ66c+nrzN/eaFRRQotLkTHXxpxs+sV4JrZ+as91T8YwrsYkLxweCT1mSapFOhp5fzHOK3149
	gH6tiIw99TMJcPjnUnY2Gs3G9GowiOYb5pkw8QLFa7RHipfxS5Ek2Bly6ufKtokamXwAgmMjc//
	yOz6PYcN402TQscD6mDHRtroBe7WO2+TFpo2d8MgyNkBfu2p6iY0/BTj1E0RNrptBdK1xiTuE
X-Received: by 2002:a05:6000:46ca:b0:48e:679a:4aeb with SMTP id
 ffacd0b85a97d-48e6e2bcda2mr16546491f8f.3.1793640845959; Mon, 02 Nov 2026
 09:34:05 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260824184159.240821-1-max.kellermann@ionos.com> <20260824184159.240821-8-max.kellermann@ionos.com>
In-Reply-To: <20260824184159.240821-8-max.kellermann@ionos.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 2 Nov 2026 18:33:51 +0100
X-Gm-Features: AclHuK9BDv3bfJrzCxzgPonZehTi6oa3H0neVRrPnpht8tLYsHQ9tmBMkXvOf30
Message-ID: <CAOi1vP9nBoxBD9VTmMm5KnWj4zp0mdeXxTkzLR5tdBrmKrQ73w@mail.gmail.com>
Subject: Re: [PATCH v5 07/11] fs/ceph: remove i_truncate_mutex, use
 i_fragtree_mutex for both
To: Max Kellermann <max.kellermann@ionos.com>
Cc: amarkuze@redhat.com, xiubo.li@clyso.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 8:42=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> `i_fragtree_mutex` is only used for directories and `i_truncate_mutex`
> is only used for regular files.  Since these two fields will never be
> both be used on any given object, let's merge them into one.
>
> (This is a minimal diff that defines a preprocessor macro, to avoid
> refactoring all code lines using these two mutexes.)
>
> This reduces the size of `struct ceph_inode_info` by 8 bytes.

Hi Max,

Only 8 bytes?  struct mutex has got to be at least two if not three
times larger than that.

Thanks,

                Ilya
