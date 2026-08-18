Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632A3CF1FD
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068699; cv=pass; b=C/pxTwI+UcJqRMOcT2PY3rlOm6E6CnLCu2HBqR6diNjzYe6gbeb0Do1ekq3Umqw2m0gTCW27I/jlUR/V2zHU0Sy6n0/PYNZF9hk7ssV/NVk494JZpls9wGrs7ph5Lh6xfpzLCCs4F860z7AfTgL6oVjFgeJqRKVBB2bLZIfWwuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068699; c=relaxed/simple;
	bh=8a6/sKr2iZ1HGXhy3Tv4v5AMtO/q/IJTFom+UiXb4ds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfRUUW3gljAqzplsGs5ejZSDlIZ6Qo1RHXILLS2YjF7Y6UQCnpkiClPavEpFpyLa9WqaBeMjEwHcINdoIFY+Imq3fnZLCfSU8+AKaVpcHWkoM8jlV/duRIv9SayIjj3AAUK41BUDajMKJL6wJiTpCg5fDCww+rtRA8OGsQQgFoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dYbfyh90; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dYbfyh90"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso2248635f8f.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 08:58:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787068696; cv=none;
        d=google.com; s=arc-20260327;
        b=nCycYicuGG2WEa8kTxF5F/FPLQO2Aw56tLO36LTyYsHaTogOWCIy0o0pZCjZJPsB4i
         t4HELUl2Sn2BlGSzndzOClD4dXnYe/2Ww48TMRtSotGsHdT8U3TjRBvPOBCw7mniwNsh
         0NG8pn4YOi3/SXd8keQkBx2vrBJhcZasQGXXVqVzovC0JaMZ2fSRVNRczDFNSXonA3Dj
         WL3ffRK6yqQi/I2uSeWtIFpNfYAYnViVxORscUU7CWvgbOl8alaUcT8xuVnISaOQ8pww
         MSnGUHBV5sb/tdhvN3IRWUKxg8YnhQYU59lb+7O1vh3olxq1igo9kWk701axJ5RQKnG2
         HwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8a6/sKr2iZ1HGXhy3Tv4v5AMtO/q/IJTFom+UiXb4ds=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=XNOO4GhzTFQmqsSJWd9uG1SXQSUaltZP0XgBN3UTT9aG1s1wZUtyuqeEM03/8fYBAd
         M5MK3JE/szZ8DmGAeu4rWdtsmR/kNb8jV0ngtZbPVXP/0DenjkC9NFVFvrOETNMofNQI
         Sci0hIrASpowPwVVtZnQ0L1KVkakev+S0MsJUxpC/PFy0vTyDUILNc2PVuIm9nG0Vmk8
         bkaPbdoc81qY4O1PpnlVjM4Eyh0wmvYxAtUgrx62AVcW/lww0k7n0lL/f7gL8EYkJuqw
         Qpu/AfCX3WXteChyjPib6rhZGEimy/RWxhMIqu/3jcUq3Wo51UbWUVuaZkgrSiMXAADz
         n0Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1787068696; x=1787673496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8a6/sKr2iZ1HGXhy3Tv4v5AMtO/q/IJTFom+UiXb4ds=;
        b=dYbfyh90ITtoY0q2WvEiLmbj5aqeHB9VkfCT4U/cIVIo/T9Y8mYlOfRWLb4Oud0Go0
         S6wXRfT0Hp/rfSY7a1k7YJpt4WbyB5lt/CdnVovzWmpSiTR3J+AZt98L+qciBmxIGp5l
         dppT53QWhRKiTv90Dc9ngxQoT5UlUBuOp5WSv8U05/AGTOCUsE1QdatZ1GzY6c985KMW
         IIocLFfl6q2hXzpcyb4GVHYe42VbJxmcShiZXfxyVN25+7AkGHcTicHfYIOHkLgCA0XY
         V8T5sFDzTCZJ0pNL/+sJtg+PDvN00wCo84tP+BzBkwNiMnRkXg9StN4oL0C7lZb7atV3
         REMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787068696; x=1787673496;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8a6/sKr2iZ1HGXhy3Tv4v5AMtO/q/IJTFom+UiXb4ds=;
        b=RYGo9m80fCsTZQM6iLoWi5zOJ+Xq2uYievPhEsd1d9psk5nZqi4W9JRxAeIrGLGZks
         JoxOETU7aWsLxn2WtCGCBzprbhLYoNG72TpoPPkqwyIYmEObI5fHdNbUvH7LoKBk0jHo
         2HfWlwatIv2sB6VgDGVpZdBdwFZXXakEFqgnBL3Vc0a9CUuSTXETDv1OedpWizu3d8vj
         bZkT8huQhZ+XWGBgd25/WczTs+FSF+BEdqxiYnjLc0/MSWTZQNZX1RHP4MqRSjc6oQQ3
         DTesneY/lL4sjEJq8icSzxwguwAlRKHjkd7w+OLDkFIF2hywjSODyK/upz5AaSQDcnGn
         RQXQ==
X-Gm-Message-State: AOJu0Ywdx9+oO6nDpM5jvJTEFt+kL8KzCZm27TY+/aI00wht6RjtDdVh
	ih+iNQkvH7tIEgR2ZQdrq2DRWiuRMnl3wxozDyDZj3fkf1Dkukn+TiJ0mWIyNGiR6+NmlnG4alC
	g/wOg7kHgIksfuWFkksLi66ZE7/vG7Q86UzuMYDnL/Bl3mWeZsmRP2ds=
X-Gm-Gg: AR+sD10S5rh2/5gEPhtNfVBx9RRsqIok6F6vBS8k+v6pHs9WQ01gk5wtAC9qUe7C/aZ
	uZ7H1wvzoH5kLh2oGFWOHtNLgVF6crvR5JXgiQqPtHGJkTvgTJIqFyhqaun8J4v0uwnbUHrYl7U
	8tgoKGdenraI9zFF1xVR6cuXUPdwzSTtre0b6sTSIFju1594XFEpwozrccAdyn1dS6/Ysr+AuD+
	Ssw4BOc0hdZ5s2S/1ne9XBkWxJvRQ5td+Ji3tqbfHNy95j8BRRRs5+DJ7BgV7t0VJa0Ml3uNBuL
	WYckOXPIhXaygthNDRvNNf/aITNb4lZ5pILKQnBVcbmnh5YkfPG8Xzwt769Cinc=
X-Received: by 2002:a05:6000:40da:b0:481:5003:c654 with SMTP id
 ffacd0b85a97d-482a8ff6003mr16076662f8f.7.1787068696463; Tue, 18 Aug 2026
 08:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-fix-rbd-keepalives-v3-1-c344fbad63a4@cloudflare.com> <20260818095654.955417-1-amarkuze@redhat.com>
In-Reply-To: <20260818095654.955417-1-amarkuze@redhat.com>
From: Chris Arges <carges@cloudflare.com>
Date: Tue, 18 Aug 2026 10:58:04 -0500
X-Gm-Features: AcwNN1VRPD8WM4AvL67wAYRLjuZ0jmXmiSrqsyQkHnIa-DVbGtV0OWAi549UCGk
Message-ID: <CAFzkdvgUdzb_eR0Ljsk9ByKoms8Aiu8gQwKQwt2bSx0bz83Xuw@mail.gmail.com>
Subject: Re: [PATCH v3] libceph: reset OSD session when keepalive2 acks stop arriving
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alex,
Thanks for clarifying!
--chris

On Tue, Aug 18, 2026 at 4:57=E2=80=AFAM Alex Markuze <amarkuze@redhat.com> =
wrote:
>
> Hi Chris,
>
> Your patch is already in ceph-client/testing as 4a74ac97c553 with Slava's
> Reviewed-by included. You don't need to worry about chasing tags =E2=80=
=94 once a
> patch is picked up it goes through as-is. We'll take care of the rest fro=
m
> here.
>
> Thanks for the fix, it addresses a real problem.
>
> --
> Alex Markuze
>
