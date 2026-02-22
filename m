Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67516DC28
	for <ceph-devel@vger.kernel.org>; Sun, 22 Feb 2026 07:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771744796; cv=pass; b=EDod00mqc5ZkriECrYQJrirpZ4ygQkA9xEL6ARnJHdwCSpcg3yCeCM5s1RuNAKbvIgB3zrevzRNzT0DC8nRxqQqB7Ba98e+DnbvNuJvJZJQTbBoQrBdCQDpw42469dL+nWfwZmS0v9p+rmNBJca41Iw/JyJL0mYhC/h3SByprKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771744796; c=relaxed/simple;
	bh=0lDfK3AuaNxxPB1Mx5JPD44YULX91cix/sE9XtEee8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdobE2f49SmPRRSGPjrUB2uGZU9+5EIYVxLPKfWcrPZtcBO93acWtv9mUcbr4owAudTUvK4e0utsD8lppXfDmsoMOYJk8xkQTgeVBxFnlFCruAj1e2aKIZkaXKX88sUUuJvANJjBuxguomLZbuwgoTGpWBdOFJ0/lKFdRqdHpSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwtvKFVx; arc=pass smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwtvKFVx"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5663724e4daso3399091e0c.3
        for <ceph-devel@vger.kernel.org>; Sat, 21 Feb 2026 23:19:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771744794; cv=none;
        d=google.com; s=arc-20240605;
        b=Q9YFc6mAgcpoQqHnpTKFikAd/DdQXCUqUp4cGFFIS8ysjvKIkNp8ZYuyankMNzSj0e
         nGUmk56yCz+FDs/M2uoW8lhfawK0jiUSgK40nEDzbmElYLtcwnm2rFUdxIdSnS3VsEqF
         LNedDr/BSKTeSbPlmHxYrd4r16H1Z4Us9QO05tV2QOiz7ux/XiQjObK/Q9MovoqIFSUi
         4mOYZK3rk7G5+RrooJjJb5I981X84tsYcYFK0POY7afD3rNDZPPa+49YzqYG2bB9ZGtZ
         8vS+PiuXhumRwmpFmTyLp3ASO3/4vdEpA4tnD5fcVA4ZSEvKxjpPu1jM/rVcHKA2BmL8
         Pkjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        fh=rN4kPyTYcyrvuWH7eY6Hnz12E6UtvEZeKIifaXVIoEM=;
        b=aRoDdeSxZXfPcXQ5cxL06oSy6mBeHFIWsupL2WH39lYr/MJhAhX2/0zxNVjg6pJYY4
         JFjPfIXDNlwuoOid5GVmG0JLpYCsFLOArtIKiny5Wdix4CU7R09iJbRJLLgHtPG+6lIN
         w8wQCb+RyQarYp/624EeaQuxwALwJlyulphxMbI/g7Rr+aadFi4rFuBM075qf0KfBNVk
         XiPx2vPJcXsycCRnOSeq3JPzjpjt+LUoJc458kqUOocosHPioLPoUJzhpqHy2+TlA4EF
         u00MlTPRsO9MGf3vJM2DVb+QtYyRl4YgfiSbF8z+hQdy+zdrzQ0TnBcznT0kY+81pUjv
         DlTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771744794; x=1772349594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        b=iwtvKFVxJY411/9ogEeNuKuIL+swHngOLh4yrtBI6Td3Zvrhz9GAxS6djLXc2BeeOf
         nwptn4OPwALolDkNO4yfUKWVGz6BTUQ/ZjsrhDkQelUcEp3u211ABAUwyaGfWUa3xyIl
         8TncN5e/ul82aK3psRyH0mTUkoioWE7HxKEG5Tl+V4ZPPo1duell20yNXLiz/uGQbSYH
         7yGlXL3++eZgdVawMupcKZlupPjYixQ8Rl23W+szYf64S6Jow0ieM/ciHxBMW07CFwOu
         mPqgTy21kVuM+pHA2DPgrWsLpiGUpwbZYMi/pXNbvGHP1UIGZhLEeFn1TM96mjwZUN8t
         bpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771744794; x=1772349594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OILCq3HcP44ucOZfdh81GCluvZoTsk6wk990N+3C0dA=;
        b=UiH2eMCS5kfwcgZ+NP5zgIS8Sy+0PMbpQdltCieZu7tGhZtleWIzM/2JtwUwPL6Pzk
         cuTUAaSKBzpd2Dev0giAPwmWCIuSf3NGDtdIBaDJkATGeDxGsxkh+s3BjkRQw7UDFLt6
         PNFPyro9iOIWWdePCnDZ9G6NODhPJtzD//j5flkETlxazFAQOqxd4QDCrO+jAG+705hB
         s5HTBWKn8AeTCiBJ8QQVNLgK/ARCp0nK2jdLyWLTDO0/xKl6J+DcMbCLDpS8Mmh15HbM
         8vqpjGTo3KS6yeAZZeP3wOITTdfXHVHgRI44BSTvck1JqwRIdggiU1C7gpeygStz4pl0
         Zo7g==
X-Gm-Message-State: AOJu0YwAje35ZHUz19CXEMhZJkkVf1bfgLrDQEYXh4nI3XpAKdyhNENw
	5vCIr9V5oMrpxh2ZSkqXk0j1InPKlpWE+7Jl0WuSv57WFRxo6k+VdisL4TtQO0aHLyesQB7VTme
	nJPG6236/FV0FlsyuvHZGyUE6f1ZD6Zw=
X-Gm-Gg: AZuq6aLtvhejrQKK/IoCQxK4m/FSS0UpiGNblEcREju0tuhHyws4RDNWnkh0taSuku9
	iSBbX+yJ7ZAMirsXs9xlFTPjYNcjTmTDr9Y+PvynqB+LEcn4O7Uz2q9SWBV0Opbgn0kedhNfHgE
	m8qWsc8secpJRa+siGsHRIZY5Ex2asWDcVgDzhV6taMQRTXrs6GJ+ZghzKUHcl89/2jtLEJyEvL
	DcWHqsDcrNLGCwXX3eSJ3T1gF+HLUEfnfM9vbkgG0v2Z2bLjXGuxNIk4mpUSUUjPvdJAYn9Nyi5
	SDEa0UsvVq/YDICtbgY0wl+vJ+JUANP9W4yg3KnAcNcbPSSz+G7ZoQ==
X-Received: by 2002:a05:6123:2c6:b0:55a:ab0d:bf74 with SMTP id
 71dfb90a1353d-568e489e04bmr2702083e0c.13.1771744793575; Sat, 21 Feb 2026
 23:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-sb5Mpk3ts1oVUHtg@mail.gmail.com>
 <20260221234553.2024832-1-safinaskar@gmail.com>
In-Reply-To: <20260221234553.2024832-1-safinaskar@gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 22 Feb 2026 13:19:42 +0600
X-Gm-Features: AaiRm51yAd7WZH0JTtET-y37usKeLDtT6X5Vgs22uOg_jqenzkdmMaQOnOQPf2k
Message-ID: <CAFfO_h4dNydbmKSTP8uD9X6ouEZTyJUGoTBXrEHWeHtD1B=p5w@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
To: Askar Safin <safinaskar@gmail.com>
Cc: ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-nfs@vger.kernel.org, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 5:46=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Dorjoy Chowdhury <dorjoychy111@gmail.com>:
> > I am not sure if my patch series made it properly to the mailing
> > lists. https://lore.kernel.org/linux-fsdevel/  is showing a broken
> > series, only the 2/4, 3/4, 4/4 and I don't see cover-letter or 1/4.
> > The patch series does have a big cc list (what I got from
> > get_maintainers.pl excluding commit-signers) and I used git send-email
> > to send to everyone. It's also showing properly in my gmail inbox. Is
> > it just the website that's not showing it properly? Should I prune the
> > cc list and resend? is there any limitations to sending patches to
> > mailing lists with many cc-s via gmail?
>
> I see all 5 emails on
> https://lore.kernel.org/linux-fsdevel/CAFfO_h7TJbB_170eoeobuanDKa2A+64o7-=
sb5Mpk3ts1oVUHtg@mail.gmail.com/T/#t .
>

Yes, indeed. They showed up after a while.

> So this was some temporary problem on lore.kernel.org .
>
> Sometimes gmail indeed rejects mails if you try to send too many emails
> to too many people. So I suggest adding "--batch-size=3D1 --relogin-delay=
=3D20"
> to your send-email invocation. I hope this will make probability of
> rejection by gmail less. I usually add these flags.
>

Understood. I did not know about these flags.

> If you still expirence some problems with gmail, then you may apply
> for linux.dev email (go to linux.dev). They are free for Linux contributo=
rs.
>

Alright.

Thank you!

Regards,
Dorjoy
