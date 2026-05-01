Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946C9463
	for <ceph-devel@vger.kernel.org>; Fri,  1 May 2026 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654994; cv=none; b=tNtoNJyPss7aKrkI4qxu6f4UATDLkb2Ks0NZfiY9S4NgOVtUpPBPDrwnkbyDXrMXIWHLyq89yJmFqEoaYKeHK5IKNWk/vc2OlG/aI4rtl+uUyUdnNQXKa1Gyiwzbuuh4I7ES2+lN8J5/6g/v0LDK1DGhgkeJupm/cMfjHyLC0Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654994; c=relaxed/simple;
	bh=R9Zpj5UoXr6b3dEgaHj8wSPGBB2EXcFoP5SMtHv9Aq4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lNyJga+JgAfhicdd/40p/zO8MTvq7J1aOWfEAUbLrmLcvkGJPi1ewyYuJw/WCBaX9p1SJpevIA8WwEME/0niTAy8BvfV5HVT5Rke9EIZJFy8qSQ76bmdyohgq8W9sbq2h7g2fmDYpOJPci0l8kCJv6WXd73lbJiE7AFd3hma/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=0wzOIpvo; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="0wzOIpvo"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6587cee8b57so2341200d50.2
        for <ceph-devel@vger.kernel.org>; Fri, 01 May 2026 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1777654991; x=1778259791; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R9Zpj5UoXr6b3dEgaHj8wSPGBB2EXcFoP5SMtHv9Aq4=;
        b=0wzOIpvoUCLapy7MGyhgj4ABtjBGBdfzEjq/h1Koa+DMcXhakMyOh4oxqB4lpIGERz
         i1OLv1ok5XCUdzZJMQBLHAXEvG+LFXXkumItROjUeppIoZeoFflrWpukErufKCF+roiM
         7USt4Q7lQveeO2kdIJcU4hvT1ham8ekzZGQgc5/7TsSeEJKLCmxZCazpAJ+ney8bYvcx
         W+D0ss24p9dbPDzy/NoYjZVWenus8/T6xmFJDcYIeiu1c1v214VN69Uan9Z52VleLweI
         lY6lKQbiESHv3a5q0FNja8tD9K3yEWnW5odRPyUwtpvJWROAcf1Aiqiw3j/6Qn20sA5y
         jPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777654991; x=1778259791;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9Zpj5UoXr6b3dEgaHj8wSPGBB2EXcFoP5SMtHv9Aq4=;
        b=j2UdPPtX63ClfmFrmqHYS0TEP0v1/2Rt8E3Ts/idtgjjUqRUAFVLkGLzSScn7vX6az
         0I2dD61xx0x9sWYWp7qjeO7nEBEfU4DQ9aMlEX7bEpjcmmflNQzthGJN2TEO82pve0bM
         JSYFgvuGMEHlmdWQDBa9pJ7Zp9UzNKk6QUO/p2+Fbz3BNxP2hQu8J+bTvKBtfuwxn/5f
         UNWi11YniGEF2fsr90GfYdwKmaKPF5m05CumLRRmdn3p+OM1KmotkD476toQMUOjqKDe
         eM2AoB0YmuijA1PyUdqZ4YNP5v3gsFGCwYSA5WcKg3iegAzpW/XjqOTiVr6eJzy/BiNc
         QW5g==
X-Forwarded-Encrypted: i=1; AFNElJ/1J1Z4Yq9cBBo2/k0uJpXnDgwRGWOImW1bjgNAxD/LOE3mzIMcC5X5iZncrOXWex31PghAjxzwY1Cf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0MIjjuthdreGBTdBnwNeTyCUzP7lYydEy8mJZbKnpyODJgQtK
	cxnt2G5VZ1frQPSxLF54KhwR3Rx93qNUtI6O8SCuhYrISBiXkxjEasF7rSwtF96gmwk=
X-Gm-Gg: AeBDietjwkTrKGow2qddj1hapeQHDJJwxucuLl369FzkXlXyUQEOPBDmz0OjlFEU81w
	rxzlY+1KCt/eHzdfu99BuQKUBcDERsC38V/XG4xHvcHsXjU+1IJU4fXcGQd+CkjhBuCBj1BHXBz
	+MLSVmUhZ6h0R9tnK9BvG/qXxoYclC4PJoHYVPwJgB6JwMbcc/dKMsTNULmlgaa4lBSvw+9IoEl
	OS/ZvaNgmnQpx+BFNKXqWkayrqZ7Atiiwx4eAHHAx8nj9Of2/LS3kZy1wk6T8rs6CAE8h9917qG
	ABzPrb2QWLLoRmV8BS1EgxnMdXv8dWr/K73DZNRJreZJp1nuDGBSG/tC86Xk8cWTfZhK6QzD7oM
	/9k/WZ6gohpkGQwnvoUirQtTTL7Kj0dovNULg22aga989CGH++bphp8hH/jGY2s6WYTAafoeBKx
	lzIvs98tErOfhbXO01dqt0XOkUkijZGrM/8x9oeSDJr/i7MOVqJZuXLZYXI7d4CoPi2bXzw7N0p
	ExsG0LQ7oI4+wOq7IyfFXxB07dmMtBOekrefFIjDqfBZL8ZP06kHkAkjhKakAp5lmull0dBhkOr
	pYA2dA==
X-Received: by 2002:a05:690c:e4f0:b0:7ba:a726:58da with SMTP id 00721157ae682-7bd771049dfmr1680067b3.24.1777654991597;
        Fri, 01 May 2026 10:03:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:5426:cf79:65d3:bfd0? ([2600:1700:6476:1430:5426:cf79:65d3:bfd0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6655d954sm13323647b3.18.2026.05.01.10.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:03:11 -0700 (PDT)
Message-ID: <2a70150e66ab67106ec9196eb7cd2ccbebe771a7.camel@dubeyko.com>
Subject: Re: [SECURITY] ceph: msgr2 monitor data_len mismatch can trigger
 client kernel panic
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Willy Tarreau <w@1wt.eu>, Dhiraj Mishra <mishra.dhiraj95@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, idryomov@gmail.com, 
	amarkuze@redhat.com, security@kernel.org, ceph-devel@vger.kernel.org
Date: Fri, 01 May 2026 10:03:09 -0700
In-Reply-To: <afRoFf4QVANv3i-T@1wt.eu>
References: 
	<CAG8b5tT0cqjS3D-q6Z=ufv73W69ZXfRA0FTm85uf9OEL34=-GQ@mail.gmail.com>
	 <2026050111-comprised-unreal-7b2a@gregkh>
	 <CAG8b5tSZX4OtkwLDgBCtWJPhWSoQgh9rHDzxW3bja9GkrciG0A@mail.gmail.com>
	 <afRoFf4QVANv3i-T@1wt.eu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dhiraj,

Could you please send your patches not as attachment? And, please,
don't forget ceph-devel@vger.kernel.org. I never review the
attachments.

Thanks,
Slava.

On Fri, 2026-05-01 at 10:45 +0200, Willy Tarreau wrote:
> On Fri, May 01, 2026 at 12:39:58PM +0400, Dhiraj Mishra wrote:
> > Thank you, for the guidance; This is my first time here.
> >=20
> > I have attached the text file and the patch; let me know if any
> > further
> > information is required.
>=20
> Thank your for the fast turn-around. Let's leave time for the
> maintainers
> to take note of it. There's one point though, the sign-off in your
> patch
> lacks your e-mail address: "Signed-off-by: Dhiraj Mishra". So if the
> patch
> is valid, maintainers will not be able to apply it. I think it's OK
> to wait
> for them to review it before updating it, as there might be other
> comments
> anyway.
>=20
> Thank you!
> Willy
