Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E067224B12
	for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2026 19:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776918; cv=pass; b=m0OkCWkH77p7wHL6teZsgjW3iA5WNPj2s4DH6fCaT3UrcZjTSd6rjc26bbftHUQpOgCI5nk705/hnyydEklSkK/u/FjPRfm3X8PHZiBrJ0JBtPDpuqVTmaA0l1Qifq5bSbtmdgSGP9YJSVd3yNARKrz3RWPHysdra7rM8tcag6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776918; c=relaxed/simple;
	bh=at1k0kn6fTTPQA+HIlCY+DsBGv8Sub72wHsmakW5ET8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i6mq80LpNpBKcwHgvxFuwUMKSRwdaf6yX9hVCPaTFM/ET8v/My7Ed1YUtwjaB8zFdDNrWngW20XKvzbfkyPAyyEXGG8CPX3mN+h5yCwoE0hvIjhsbeQaBktUHoKqaflao6I6QW1SZKMS5QbjPk7WTbLQYh3ARDrDnt+680ZVKng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeNbeeS1; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeNbeeS1"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-128b9b7e3edso109554c88.0
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2026 12:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773776916; cv=none;
        d=google.com; s=arc-20240605;
        b=hgPJllq/yq8VuFoEY1UBvxuDPmYikkVwFndWD3i2T6/lNgijcZPt/V3/WBWLRsA+P/
         lSTs25uZRg4kMWq69Mu9gztQNUgrydmCBEGynqGtFfb658O8Av9nAnuLYrBoqRAnS4IA
         jppCFQrpwbTDtkes+e6A4C2VPWiWtCfH4FglzZMJ9f633UvRbvwo3tyg8FZpdAJuxj2N
         ufuhI/xMd8tPISmUfFJeY4TQhOh70kfWwyYtJraTbQRDbb3dzqcqU57IX5hbBbReKEjw
         bx/IaIzowSqOuhZjRekN1WsRdBFK9Y+oMAImAa1yv28ZNpgg84/Wsz6KFzERYYee3Vqr
         AQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OZR68tqLqYaTbBWC4ZvIpqSiIjzkYBPYPzLDQM+z3q0=;
        fh=JdszBmq6HqnO7sTMwr4K+1emcij6GUkI1A/mQxJ4WMI=;
        b=e16TLCYaSAzezRtMrGwjm7Q+YbGwGGe6Sne3asWsjCsoT9ewvgHJhj78PIiuiGXAE0
         nUY5T3kDUUP5PmhcxFtb46rvHmbnRl++YkmNQj6m43F7SfJ0b1WniOLGpzfKybpRGIEO
         vqLeL0yYI7hi5mtN8h6XB06BGrD7UyQTunyLkNwya//VnaZB0gSVp/NXFAkBEHY68AzO
         Z6cBHHc2lRFD7KPrsGjHn4FJcBg+M0WvJ+eJcWabQ2l+XhgcTjcWhfOpevB4N88YMlHn
         6AqHvIY/UXH01cwDwJt+Bw7iku+0ivAAwEHC2pKZxoRceqGc7nX0BkdiZE1W8CxDmnKO
         Eu/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773776916; x=1774381716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZR68tqLqYaTbBWC4ZvIpqSiIjzkYBPYPzLDQM+z3q0=;
        b=WeNbeeS18DXloST+3zj0LIqtOnaOlwx+UePsxO9z8O1k8pyUucRmxBzWFVrwqlbYIT
         dyLZn/heIKGXYS+tE9pIIhawteiy3jHD7g4DVmCl5OvYjk2Mx6keFwIYZWjDHAl4PNgm
         4MkuAfDhza68M+N6APFuvoQ1AvsfBhZLyWgivNGTGKFApG7IE72pphw6lRaNHvl07VP/
         2rePJxQ216466V+b4iaakEt7lC/xds+Y3KWlFvdDR/6hBJnhSqvv2vcL9QQQxsljzIat
         MutLuCdLMZ/k5FxuY5zNlWZqd1FaSxvuvQCrABKk0AocCkBFObRWmFTBY+U+TOC2pnfu
         NjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773776916; x=1774381716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZR68tqLqYaTbBWC4ZvIpqSiIjzkYBPYPzLDQM+z3q0=;
        b=oC0M+JfU3uFX8fGaOGKm/VKFU5Y3tDpQpCBcq/k9WVUPrSNAUKjcXsF5JLbVj8z6sy
         SfR8O2SsFS3QeRmh6/cDBJUufj99saIBJ1Opgrz09UTW992/WcSI/KiE2ocBU+lrjfVd
         9i2rbfj8FyDIfvfplqLy57vghXRqYD+xDoZJJfDnwxh9SuhBb8Cbb4sR/x5mQWHxnhyn
         jjJk1+fRcbPQZB2H2BKofuX7g2XY0JZGlE6cA+LhcWQgOa2S9Zyos58ibCUaStQaHn2C
         LmsvtcKRDsMBywo0vUdX3k8L1oiWTWDQHbkyNLrg1+fGxLmq0W3hX4orMiW7GczaEzo5
         KnOA==
X-Forwarded-Encrypted: i=1; AJvYcCXNcBKbzr52JDJ1UHuT6vaW9A/e6sowkiE5kDIAHcUATMOn1eVfyVcOlruQ8nM1tQ4cX6s5s5C/A3mG@vger.kernel.org
X-Gm-Message-State: AOJu0YwJz8pj/+ffyeDYcwgkLnRCOrxH7ooQYLhRR4WnEhTs4F9hAHta
	Grv0mkCwtr0Uzq13y9qZKLticav0Qa/JzP5ejUFA4rsSIYeQNBtLTVfbJ5x0GxyF4/38pTsf6D5
	rUf9VlU+pfJvOY/xvNatEKq2IYLZuktE=
X-Gm-Gg: ATEYQzy3dE7GR+x+GjArTB8hTHjT64dOZLbo9x5ZY/RwDgK2ieEpwOAUYhK8Yo4oEf2
	kM9Go1XUGujICceVML5TK5kePQbwJZDY4XXr1kBzVxkmTGaiZfVDyxsiX4hGsBKKoK7EY9A7gIn
	hGUIZfgM6nSfR3F0PxeoD3/I2PUc1efyreetPuffN4FrsU4SkimafBU55VroF/2qF8XbcsliW6N
	0xIesa2+BdJrj8xzLeg69YgRHSTVWhuWJAoWTYI+geel0bz+cROtrdQDdE5wyY+Ue5MqNTOF5wo
	yr2nmxg=
X-Received: by 2002:a05:7022:6088:b0:128:d24a:a5c1 with SMTP id
 a92af1059eb24-129a71b42cfmr402951c88.28.1773776916013; Tue, 17 Mar 2026
 12:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315232500.251088-1-CFSworks@gmail.com> <bbc55ded3e226cee35e04a071400981e2069eb3e.camel@ibm.com>
 <CAH5Ym4j6gPCR9UhM1ywkDmvcDAccNrL72LFLy468T4PfPTxU7Q@mail.gmail.com>
 <cebd075d8e2e7e926fbcb56b19ec43fe7dec6ef1.camel@ibm.com> <CAH5Ym4hjSxtVG1v58Yd83FYeU+8+S_1M2_5pPJmMs=_fHb7orA@mail.gmail.com>
In-Reply-To: <CAH5Ym4hjSxtVG1v58Yd83FYeU+8+S_1M2_5pPJmMs=_fHb7orA@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 17 Mar 2026 20:48:24 +0100
X-Gm-Features: AaiRm50NvrjdiizwGHwwvI76QCvgHLwjqKbJM9xXqNl3BgKYYWVZdHXFwxQ0QAw
Message-ID: <CAOi1vP88hEdnZXyib+toGumicWzoH+_iYbfFUut8Mvq+s_3xRA@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH] ceph: fix num_ops OBOE when crypto
 allocation fails
To: Sam Edwards <cfsworks@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Xiubo Li <xiubli@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, Milind Changire <mchangir@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 8:13=E2=80=AFPM Sam Edwards <cfsworks@gmail.com> wr=
ote:
> > I think that it makes sense to create the issue in Ceph tracker and to =
add
> > Closes to the fix.
>
> I don't currently have a Ceph tracker account and don't think I can
> add anything of substance to an issue report. Feel free to create the
> issue on my behalf if it's important for Ceph's processes, and I can
> Closes: tag it in v2.

Hi Sam,

It's not important.  A tracker ticket is useful for when the issue is
purely reported as the placeholder for investigation, log attachments,
etc.  In this case you both reported the issue and proposed a fix for
it, so the patch description is the only thing that matters.  Creating
a tracker ticket just for the sake of it isn't needed.

Thanks,

                Ilya
