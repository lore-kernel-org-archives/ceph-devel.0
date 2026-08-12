Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560CE3546C9
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 07:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519741; cv=pass; b=pBPmT92fUyz+THq17GV7/hiror6+YZetgkkkoavFhascJcpb4CoUuvNevZhuV/FSuXjmM8iAAzKH3RVWUmLCQc10Ivqt0dD5HM+qGQWDluDGSZ+NmM/jBtGZpDZkRuCqbKgIwnL2oatcziAL/8FRPfvrFjAKcyh+eu6OpmyXjzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519741; c=relaxed/simple;
	bh=roNHi5DEZrdywah9r1Su38F1BpjBYK8AYINaCtPNveQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/Q1FOAr1t+4nh/EXSOw5871oXRJHQZlimdN4ycGsMcDNuVht4cuZsWS5riXTTVSfBJL+SPoCa6Ad4y2xcaqSndoiJdz6EqrHxGYb17tlsgvKJ7E5SNklhgnL4lqsLe9/JSe3lC919woJkt3fYtG8id3433v/tIoAKMl1Nw1EuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=j/5k3tNg; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="j/5k3tNg"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15f020a223so78241566b.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 00:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786519737; cv=none;
        d=google.com; s=arc-20260327;
        b=YY+Jl3JxpcxZpLUuAnS+ysb4xFcAUpmF/6KdvFvql9NzstMZNESDNHIJdv6/1XCko7
         dEjYl2bx0BE3dD6EqEHJZTYx9f1IW4Io6NK8ShdRGKK1AG5GcYC9yb95Z4cuxVvQN6il
         oN3FqHNKudsnIAK0Z8AJ8QFFlzRDsnfSluwDYxHcB31PzewgJOdq67X2IHZksjaNIzmn
         /ov4WEgpG9b1E+T/xqo99ssLVWCBn2Comek8r0G9NJHvnbGNdq1YTlopEW4ZXTVe8DVd
         HDDFoTBAsCglozHasXYc7Ou8hu4pMsUW1cNfD+Ht6oTAGBOvdgHF2NZwBz6wx9zJrDwc
         iCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=roNHi5DEZrdywah9r1Su38F1BpjBYK8AYINaCtPNveQ=;
        fh=yLso7DSkLMDz68a9lEb23vlLVl++gFeUuVfPkmgwLWA=;
        b=Q/5LeD+HpNKy6OrUZpbQzuTzztkDvndpIEKLHw4OT7e895x6jTU0DNzgximAhgOFXo
         jF1gQMx1piZ/Ax2w8haDzMiNH8KKY7EjUCXOa3lqpPuoijCOsh7j3fm4zbOjkxNixBiY
         oIy6KweZdoDtC/ypQLyuomGsjD/mfx9C9lrbbF5SWgvS/5hbVHdMtiGjDceqGAxWOkWb
         TRNSKgMFGoDe5LuRSvkrVkMB5eEQP1Lxy2TjR7/dWwhSE10BgXIt9MDZbaWBRVJ2YNa8
         dxe4x0nARgvLohgQu2UK6pgVq8uQ+xveXz06+Sn9qtfT18Hnh+PJ2tyg+F2NK3oXFjgf
         yvZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1786519737; x=1787124537; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=roNHi5DEZrdywah9r1Su38F1BpjBYK8AYINaCtPNveQ=;
        b=j/5k3tNgYWv2+Fn+NekdkASzMIfmI4i94mzsz2AAgXXDVjZ48WLkOIdjmhCTzxrDPo
         rA5Ad5Vqr0g+xdWzo6jLdV9ObMpXW85erWpulSd430DQ32U07/wrUT/qmA0qPD2a7VCV
         5UkVGP9Bq5d8Nug5fKWZFpXiJ/dvMUtWiGa1lQoHFKzDUcnA6a3MnjekF6etAUHEUXjk
         4zPT+fhNh38VMrfYuFHg5Aqr3icDKypGgiPpjzX5lRR9x39fnT8YBIYYtFcasmO0en7U
         iopu4LemJ5be9dhnbu1nsOsvr6ysFPW+jEPzY2ZSbuPQERolwyiDh5ZotzhI5WWTa7Ob
         aNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786519737; x=1787124537;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=roNHi5DEZrdywah9r1Su38F1BpjBYK8AYINaCtPNveQ=;
        b=skN3uysxC/HIOUlzT/ysro97OeqIDxHNRC3j+SfhdpRqNTzQwDVFbwgiGrWpSL1axe
         Hx4WlBpD+DGi5Vrrifa8FXLq102DNDslpIQV5+uxzOYsMp2pLJIKPLY4gQieqzZe3OyL
         m9XKQ8Cz92hSNijF4BqXRlAv+PVw/rrMbjeDR9CCG0+XfHFfwo/HYJIVaNn93j1AH/V4
         sAHH4ALcHJVmZ0w9MHPg16heKV39IByNXaFgr+a0K0/VVUFHJ82C02kD5AQLlkZiCgsq
         74DuCE5+hDbVeEh0UOANi9zLUDYB0LKoivmF7gj0zExp7RTBMvdk0C/1EMXtNXz+irjZ
         tTiA==
X-Forwarded-Encrypted: i=1; AHgh+RolSNP0zeL3KqRCUOVneJW4AeSLqRF5WvJ8nwVZfYCoKlu6A9r/c4gcpMa9R9WPYzRH9nLlnBPDTzag@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+G+92sSuvt4otvbAj5FUbgg9SmKRc/hmsXYbbZ5rcKkF6G56C
	zaTPXIlJtMkguDaKcvh/ETJqXNasUC8yRBfURsj5l4naSlBUVdMx+6TLE1JjRWvaUtdB7cYwfl8
	gz9Tznaw6DKM00Ww55bsbgzSPQl4KytIPYt1/VcKdMA==
X-Gm-Gg: AR+sD11GH2TymfcASxbU/1HCLZBT3zI66VWBondv5unbtnGmoDuZpczoCG7tWQ48EF3
	7+v9p3dgbA8xO20zuYr1Nx/MTi2BHGg2O1gO6d0MCXNKuTgJNkmkuvO4C08+4VEiTEihOlWFvUD
	F/cIKJ70MI8N9nOeUwq3egsBJ4NRSvX3LCo+M2oXXYJywt5QDUFAnvfNOvKuIWN1R9Kzk4pew0k
	Xl6tIr3XYtGPFyMXNUYrw7De8vdlN30jL0rkf1iXnkRHi3eHqnhCnHpfP9Y1fn1CuyucF4aTPrR
	GByU0nSOsqe5+eHbHs6Gp7WrPU7Yrwg60w+ed5S4FNaqFg==
X-Received: by 2002:a17:907:3c88:b0:c20:ef18:ddcc with SMTP id
 a640c23a62f3a-c20f2e98eb4mr136636366b.11.1786519737326; Wed, 12 Aug 2026
 00:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-b4-gfp_nofs-v1-2-c06b40354ec9@clyso.com> <20260811165456.2765891-1-amarkuze@redhat.com>
In-Reply-To: <20260811165456.2765891-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 12 Aug 2026 15:28:45 +0800
X-Gm-Features: AUfX_mwat6J0QVjLxmreni_wT337SYSzFoOe9YtqYZA2LEsWvMnOtR9FTwcNf9s
Message-ID: <CAOJNxRL52oUaPpv7+h50xmb99fQzbt86CKfSUWdE6w7B0dqT8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ceph: use GFP_KERNEL consistently in __ceph_pool_perm_get()
To: Alex Markuze <amarkuze@redhat.com>
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alex,

Yeah, I will send the V2 to fix it.

Thanks
- Xiubo LI

On Tue, 11 Aug 2026 at 09:55, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> The patch misses one allocation. `rd_req =3D ceph_osdc_alloc_request()` a=
t
> addr.c:2468 still passes GFP_NOFS =E2=80=94 only the three calls below it
> (alloc_messages(rd_req,...), alloc_request(wr_req,...),
> alloc_messages(wr_req,...)) were converted. The commit message says "thre=
e
> of which used GFP_NOFS" but there are actually four.
>
> Could you respin with that fixed?
>
> --
> Alex Markuze
>
