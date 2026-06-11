Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA63314B7
	for <ceph-devel@vger.kernel.org>; Thu, 11 Jun 2026 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150105; cv=none; b=rI4lsMqU6482L2nxo2fEJefK5+HCpgBwq4sfE3sV6sdyoMs4wTYdhXkOKR4SosCwJ6YWdKPBXpiOiOLhEzUMQ1ve8JmAJXBpbCvqTKx8AT2a96IzXkMcAvRNw1CECX3boko6tRoBAksx5vkh1B4oRxbzLzaBTgx7GHDudacZpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150105; c=relaxed/simple;
	bh=wXwCm5UiEWaIPzq/R1cEA+pTAsqQAjfeaWr9+UwqVfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K8w2MAQkY31tv6zoSphu2jaP9Kopru0THNTyG5PCWC7SOJeU8ffPpEjfJ+0MBZQTBJuCouPrjY5+agq8YzFPPYiIMlsQxHq7kFgWTPIZuRa+QUo2gDoqCGrq9MmtdxS7FHBOZe53s/ZD3n0ScBznETZkrQGTXMZXif32WoZklio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=YA+jmjFR; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="YA+jmjFR"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa69131836so6784451e87.3
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2026 20:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781150103; x=1781754903; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wC0xf6KeGtW4w30oD1OuMvOYJITd5lYd26UEwSzqoYE=;
        b=YA+jmjFR1IICnBw57eS6WMRQLICYiGBWCKcn2jsqjspSULC89d+lzbh2QKowY8mcMX
         9UX/RjUU5CvSEoZJn3XW84ekuSH3dbkoMoYRqM1TuNlcq870Pc3hm+F9Zh2nbp3+vv9s
         oG+AuvJHrRko4Q7JzcYDaw+W5u6U5Ft/Zaq4lq77JAnxY5ulZj1GPkn7Q+SbeiQpMkSP
         xiUUP2PtNtohSRy7cq5Iz7rC3nkeDjaRSdjU6s5YyokhIx2fFEE7w38kFBkqVkZxfKGx
         NJXhSqowO8HWj+2v+ZJP1Tct3gjO07YRo5EX204cnV4jpc7PaLocG4R5dqBcY8ORFIOm
         90cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781150103; x=1781754903;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wC0xf6KeGtW4w30oD1OuMvOYJITd5lYd26UEwSzqoYE=;
        b=sK6/FPnRNIvFn4SiC/uIqSjOiNDEO/n/TMfMB70QOeBTIEfgvm0UwBPbGexDRYDtTd
         vHKn9fYGxOZyLoJwvn2en418NkkAKlGPZCJqYzEIJ5rxtoJ1ZpJTCcwwsSakccf5Vy51
         ZcYbi8Ay0Ac7X81WTPE2jcbzrLGC9Rl0+DawlwknHGedSX/fduXUSqqIMN7Pgnrs3cmi
         8cSHYbv0o/yImv3RP6Cm7OqZlMpT0xsZUUw3kOlFUU0kJImkSWcRMv5w4tJjVnGPrI2U
         Be+uf6QfpGR7lhZpmyMSZC9PpDNPFB5YdO3Tz/F0bMe2ZvIkxf2XdnTliRv3SN16GrTd
         OIbw==
X-Gm-Message-State: AOJu0Yzp2qnSkxwaOQwx7LkzkmXLtuSncYt8hDNsfryoKJyPTS2Qmh7O
	3YXAwXrJKtADWywTc5923jRM1ruC/ms5R2zrhXeY2QKTvm5Onbj1p+sNeq7P4EvAyCs=
X-Gm-Gg: Acq92OG75fiRMefcSeA+W4e/MJimoMvhg2AITi1fmOQgElz2JPL6F8Iy8qOTadJdRJK
	pqB+UFSvrwJfSiWBjRNat1kNHC7/ikEztuiQzclGKteRA4BCsFYHNbpHstVT8XSFkel2u2D6KhE
	u2qWlpnhfaYCpBjfuo11DO4KJEYwS5mjRGGZGsFMFWYnSL8QL28NkqYvG4qH1Mjsegg3+5u7Z6+
	2UFTs9NHgNtXq0fju8j3qzygUjPeImxavvB/It8XwcC0Ljl1tbJDUU7g107HTJ3i3xjnY1shrIl
	Wp8nziL0zrI0fUqadTACzT4DStawddcoblXUXl8t+lFv/d+2m8Edf8OlUAhsLjfMeMCJgUSPcYb
	gXbIWqOv1Q8+MwH6MWN1Ze7EMGn+b9jx7GEFwgt1OL2hQ2/64c59z67xlmfP1Z1/4cL97v1NnrF
	Z+lSVh58lJWQjiUyiWDzQ+btqi8c/v3tHrwlJJd9lYhEUaSlxGk1seive8bQrYJFKw2xBuxRbcq
	ml2D8tFSdS9NtOGPt9k2H7bxoiAuKb9YqfLw0PWoYWcLU5FhW3f3e2cMDVMTI7T46E=
X-Received: by 2002:a05:6512:15a2:b0:5aa:6b8b:8c9c with SMTP id 2adb3069b0e04-5ad281b7520mr274625e87.42.1781150102804;
        Wed, 10 Jun 2026 20:55:02 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b907269sm5957785e87.34.2026.06.10.20.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:55:02 -0700 (PDT)
Message-ID: <814a43e4110884c2e45074cd0601c8063e1a8226.camel@dubeyko.com>
Subject: Re: [PATCH] libceph: Fix potential out-of-bounds access in
 reopen_osd()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Date: Wed, 10 Jun 2026 20:54:59 -0700
In-Reply-To: <20260608084618.966702-1-raphael.zimmer@tu-ilmenau.de>
References: <f26c5b29-f72d-4c7f-a87a-0aa5e53cbfbc@tu-ilmenau.de>
	 <20260608084618.966702-1-raphael.zimmer@tu-ilmenau.de>
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

On Mon, 2026-06-08 at 10:46 +0200, Raphael Zimmer wrote:
> If a connection fault occurs on an OSD connection, reopen_osd is
> called.
> If there are still pending requests for this OSD, an attempt is made
> to read its address from the osd_addr array in the current osdmap. An
> osdmap contains information about the OSDs in the cluster. The value
> max_osd represents the highest index of an OSD. If an osdmap has
> previously been received with a max_osd value smaller than the index
> of
> the OSD to which a connection fault occurred, an out-of-bounds access
> can occur when trying to read its address.
>=20
> This patch fixes the issue by adding a check that verifies whether
> the
> OSD exists in the osdmap and closes it without further attempting to
> read its address if it doesn't.
>=20
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
> =C2=A0net/ceph/osd_client.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 1b31e2d50ec6..5fc79c29aab0 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1388,6 +1388,11 @@ static int reopen_osd(struct ceph_osd *osd)
> =C2=A0		return -ENODEV;
> =C2=A0	}
> =C2=A0
> +	if (!ceph_osd_exists(osd->o_osdc->osdmap, osd->o_osd)) {
> +		close_osd(osd);
> +		return -ENODEV;
> +	}
> +
> =C2=A0	peer_addr =3D &osd->o_osdc->osdmap->osd_addr[osd->o_osd];
> =C2=A0	if (!memcmp(peer_addr, &osd->o_con.peer_addr, sizeof
> (*peer_addr)) &&
> =C2=A0			!ceph_con_opened(&osd->o_con)) {
