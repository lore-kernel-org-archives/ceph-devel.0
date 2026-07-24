Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE31368D4C
	for <ceph-devel@vger.kernel.org>; Fri, 24 Jul 2026 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784915972; cv=none; b=qIZpT0+rUArBIbL6CEN5Q3Rb2ac4yj6I4MbM4csDjEMb0d/9Z2vT19z3X5cgf8BJ2eZoOyygHXbwKtMGGn89BhYUHytgm0q0Zw94Ozkge5LUrBOaSJms0nkVt2GDURYdtwA2OYMVvRNo47uORugQ7uJ6Zj//4dh36SYEV4LORcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784915972; c=relaxed/simple;
	bh=LH0cre7tbNznI97NpetgP7082ANkOnYKNe1B/cTlZIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=niwubIdmaBjBZr2tMO6mLZj5T3RnV1cvps7Y9OMMTBUDX4c/r5T8iZEU5Ow03X4i/krXVkdU2ClQVMcUg02fLuUmlSsSioQOv+wc26mZUq6pu6y68OKfMx6wL0w2OlGMQaQrW++IH9JGjmwSWuPblkO7KyhSFhb8lp5NLPcuajE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=F7R0tooi; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="F7R0tooi"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81062fdeaf5so16084517b3.0
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jul 2026 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784915970; x=1785520770; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5LJ6OcJsLdNztGOsxSUblIxSQsg3tRm97yPkBJXrpU=;
        b=F7R0tooiq1jqNDLs3WNjd+mXT2LV9L1FX7wuzFEmhybLkP3nRFEggMu9vmbRcU/ook
         WXauBT+eRCkSjkXaXoE1TItcC59x2EE4psr6GAQFVN2MAR/OtFC704IwmLdW55SXEJq1
         KwWMT8fgF/3o07dckHaXdDVCBo/PWP3wNHxIIL+ekxJCTFbW71/x5558MCYlW1gxI5HY
         OGkRblkw5lpJ/QtSxy/SRa3t7qyJZsXM3gAx5v/j4SM+M0LB/g8v2D/Bj+E3O4Vbs05+
         yUBf2UQZHl1p7V9j1iZiRE5F+a+Y8tP58VgIte/AMftfJWZooHRbfTYHDGuARjpn7rYC
         tLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784915970; x=1785520770;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r5LJ6OcJsLdNztGOsxSUblIxSQsg3tRm97yPkBJXrpU=;
        b=VFK95rz6pICmoMvfLwcRh31x8STluhMjL+BAQuSfhZR8/6kfcMhMmV6asXxjJj+2HU
         c+T+Rwmcfe4wTvymuc3zU9OwRFe+g7n9JuQErx6zoFDGSxx4We7XnaNUb5IdW71j5z5O
         bO7kfAmjn10vl8h/af36WOEFSdOjFjQdb7h01DbBkH/mbIcxjkSrmoXoQ9GeZHyZazOC
         t3H9vIN9v/5WOz0o/7xy2tiK9g2pocqzLOAvF6YjK14Y8Jm2L9KKOCv3V26dO1k1ZbaJ
         tHxRpNFyY/DzHA5z8h+EOQx6rn8WLXn/iqqUJPzRIwBI48EYj2z8lzO+Jy1vneVIBwcz
         v8mA==
X-Gm-Message-State: AOJu0YzMIy9GvkM5pVPPN85wXQOcOsWQyW9LmqpypGyG5IdCZ9UEvdwN
	BWd3Ij9Kc0MistnmnRAsUeBNwo/dzkc/aDT/i9qK/fm7M7MibSKtvCSKwfhbC4XpX4A=
X-Gm-Gg: AR+sD12swpAat1hJvpM4jokfT/EsMvRCNS95EFv8ow48r8jP6T04y/nuoXuTc886Ibp
	eTpe+0UIsuv3wzBGx9X6y2JB1HmK8vouVnQO6ubAkPQDvRAbDk1G5dNid1Oi9/y6PB7lFyfkD7X
	Y0Lf/sZIGcf6w3FXxgUtP5oOyIMxyTEKKVArvvicoTvEFSbL5y8ryN9FrOPFQSwyCHnm0QzD5w0
	mWFrKSe6/LOHs8Xetplw4i03rPqtYilIFS2FXiqzQs8wbbqnF8lNtQPcPdS28E02wyGF6zaIjAK
	+nP1L8IXXgIcxif8FBOrvS4lg/I1BreHlfqMyluWjmND5j8r763FKZ8JqQoUhZ5auChMHYt+p3v
	UBgJR81Hl0yO60s/Wpkv7D1GPESBUMxfmEsZzkLI/RDk+H039B8yPs/BQFyRlKS3Umgq3DNfdoG
	g6AGKZ0DSPO/dA9UbLbu8hp26jLg9ll8xgVAIzIOwrMyXECfmTqZXWCqy3c3mSEPUh4JaforiRN
	MQ3LUg+azEL5bnsGRZ9JN4LVtTNjXDYlufSBSGs6B+13QeefQdfXUP/1SrgqiERZdZJm3/RtQaJ
	ubYFog==
X-Received: by 2002:a05:690c:e647:b0:80d:ec6:ea1d with SMTP id 00721157ae682-81f63f22625mr3164197b3.7.1784915970131;
        Fri, 24 Jul 2026 10:59:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:62ee:74f6:cfbb:28e0? ([2600:1700:6476:1430:62ee:74f6:cfbb:28e0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f6590119asm3503177b3.37.2026.07.24.10.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:59:29 -0700 (PDT)
Message-ID: <103949f23bb3169381422344cd924d6897171e71.camel@dubeyko.com>
Subject: Re: [PATCH] ceph: fix mds random selection readiness predicate
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: =?UTF-8?Q?=E6=9C=B1=E4=B8=80=E9=B8=A3?= <zhuyiming@kuaishou.com>, 
 "xiubli@redhat.com"
	 <xiubli@redhat.com>, "idryomov@gmail.com" <idryomov@gmail.com>, 
 "amarkuze@redhat.com"
	 <amarkuze@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	 <stable@vger.kernel.org>, "jlayton@kernel.org" <jlayton@kernel.org>
Date: Fri, 24 Jul 2026 10:59:26 -0700
In-Reply-To: <F5EF2BE9-F97C-4E06-806C-E0EB694F162A@kuaishou.com>
References: <20260724104920.6493-1-zhuyiming@kuaishou.com>
	 <F5EF2BE9-F97C-4E06-806C-E0EB694F162A@kuaishou.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 11:40 +0000, =E6=9C=B1=E4=B8=80=E9=B8=A3 wrote:
> Adding the current Ceph client maintainer list
>=20
> > On Jul 24, 2026, at 18:49, =E6=9C=B1=E4=B8=80=E9=B8=A3 <zhuyiming@kuais=
hou.com> wrote:
> >=20
> > CEPH_MDS_IS_READY() is parsed so that the ternary expression can
> > return true for an MDS entry with state 0 when it is not laggy.
> > This
> > allows the random selector to choose a down/DNE rank.
> >=20
> > Group the ternary expression under the state check so zero-state
> > ranks
> > are not treated as ready.
> >=20
> > Fixes: b38c9eb4757d ("ceph: allow choose random mds")
> > Cc: stable@vger.kernel.org
> > Link: https://tracker.ceph.com/issues/78648
> > Signed-off-by: Yiming Zhu <zhuyiming@kuaishou.com>
> > ---
> > fs/ceph/mdsmap.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> > index d8e46eb7e5eb..450a4dc9662e 100644
> > --- a/fs/ceph/mdsmap.c
> > +++ b/fs/ceph/mdsmap.c
> > @@ -15,7 +15,7 @@
> > #include "super.h"
> >=20
> > #define CEPH_MDS_IS_READY(i, ignore_laggy) \
> > -	(m->m_info[i].state > 0 && ignore_laggy ? true : !m-
> > >m_info[i].laggy)
> > +	(m->m_info[i].state > 0 && (ignore_laggy ? true : !m-
> > >m_info[i].laggy))
> >=20
> > static int __mdsmap_get_random_mds(struct ceph_mdsmap *m, bool
> > ignore_laggy)
> > {
> >=20
> > base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
> > --=20
> > 2.55.0
> >=20

Good catch.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
