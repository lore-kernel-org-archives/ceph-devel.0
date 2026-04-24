Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B3C3F7875
	for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2026 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056890; cv=pass; b=NTJGOPQ/Xmyb/9rWPKtsKtus83KU04vxNIbinQIWzOkNbMdXAQHxTx3nMYW35CIUiywKS+nPea7/RJoV1uUU85iGuFF+Q/W1YRkpbDxLptPbLkHRNil1i8CMJdWBt3K1qJxcjgT9i60+05VjZF4I447BWdHVwx4YV53+vvB2hSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056890; c=relaxed/simple;
	bh=0IfX7qYcLUvKK+oZl1Uq0uBhiBKUJq06eYQE/9o+R30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7w5LJ/vEdk9PqYPpsq4k/l+AOsdXT9bFYFVyA4CFWcc+0JpImPUw1x2DE3GtEihypgCygrDh1sLX3Ewrn8T7hIh6AVMZ7wQmq46L+Z9aAopLdryfJV7zqGWQQdsvC59X3GWCpK/E0306OngOaJL+DYe56usCmh0x+iV9vUivSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNL7gwsK; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNL7gwsK"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c726f46baso10268785c88.1
        for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2026 11:54:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777056888; cv=none;
        d=google.com; s=arc-20240605;
        b=cAiNQzwxl75DINAeppIZmUJRYLnRqPMF7Js2j0xiY8tS7txyVWbVm8B1RjjGBcpYng
         /8DJvwKwM68J9FcU0WhtZkQh3+/O/PJoRzeorAR+hr5WTkOhFR9T0BGcx/SHr9HaQcAn
         9pZD3Iw1oIvnB7cckTyy36BYExtmBtpSxaPNVvv0PRzya3z4WbNtxUXDtozDk/5k0fB1
         /udsAZxuwPLqQ+QNy2bd4h3qft0ISwLpuHKSlGueAhBp1J8ZXlxV9Qg1eVcj3odBzqHp
         fCRUasxH5ZDiumZZkZ+nYvD6jNjvVJ5JE1qztoXvkFK8N3WuAv1OK+SUHFZHwc5w3Rrt
         o3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T1DvfWVZgGxHf3iSflHv+mA+eheazDkqGe7dYxY9SPE=;
        fh=2H0Lt+N2MG9NlMVTXMuJxDjWjYn21cK5l1nGndtQCUo=;
        b=Oc3iN5ML57X6mqrh0e+bsokuJ5Mepu06VvZd7hxJpPr43Vk8Tv3Bv6K/B3ZDMPN98S
         TrAxfZxOZ4wQnp7a89NyBONOPWiVgAryZEBhdOPaCPuk4vlz+cm9AU2WJkQojfaHKefR
         VGOE10YzhhUizt+9hGsxwQnSzympyYQQD9ifk/93brRK2WuOm70NRjHZX/lCfU31+xXw
         xsJlYRFNnbNNroIV7zUnyn5EVV6XhtYIGt+j755YgU6xN0vwHwIsmGJMpEjUNfNFJVVz
         K8uP8s/hO+Y5dzb1evTBKE16MaSQKZer94WVPSoMoqyreIQXvptVVySOZJeD6Z8TLwss
         JbhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777056888; x=1777661688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1DvfWVZgGxHf3iSflHv+mA+eheazDkqGe7dYxY9SPE=;
        b=NNL7gwsKUeOgrh3826BjKre2enOATIX7QQM1ihDnZUYdjrYqZrKoifvuJUJ/PKWZst
         5IYY0T6jb0+rW0xY/teCdgNtzPV1sjkUzAiZCJYGaO3a6mUXEfZN4TdHfW2dTQwefmFt
         LgaUGgUYuS3+7C9/WlVITXX9tGpS+q97rH5stdhiNW079Ntxlllw6kkV7ZslLGOZW/zT
         ZGqsEXM1GVMigD1f/0R4GmpLn4w4oTZMV+aINRN9lNy5QPNXrtr5VaQR+a6cAlezupOk
         u+KL6e7eRrr4GYrbTq5+OgVV7UGJ7vUD5OA8OMYQdxecobb1uK8lczhoocmlLkqOWyga
         NYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777056888; x=1777661688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T1DvfWVZgGxHf3iSflHv+mA+eheazDkqGe7dYxY9SPE=;
        b=it+gPMIfTbSRAej4pUAtcv2PRZd9xIccA2pQD7aoE8jree7bUUxvcFGsV+Grq9Ua6U
         3WovCSU13F6/pRrDrkFeMM64FL2EjdnxJNVv6ezRH7rAD/MndREJ5zQMadUIICJcrkkR
         Q0HuMf6QNBj6auGB8n1lsOrjdAzSNj0FLvKBKq8FZ6xVe4Cbipz+iI8tQwbzkINPJV/D
         mfWU9519iMVbWP76LG2DOZ3GFbIjpzqcXML3vceFts8lPJysaXiYwGrwn+PA7TA13baV
         H+lmQJpycjnPni/v6SrapgLkvMbU7TfY+C6baF25w1MGftkj5oXx6ex53prFrJdxvvOh
         B5tQ==
X-Gm-Message-State: AOJu0Yz//q8rcW7UyX4KjS5B3nPwCCTDl0G/daWk5krgVfRPPThUfnuQ
	YcH/TiRUpXH/7KKYaY4Q6dzMbeNyvcnXSrpGStEw60SOmF8thK+lv7hmOPJAFWDp2z5vIg39akB
	uCEhwG0t7ddGiVcVsXa4IsFxBFhi/Duc=
X-Gm-Gg: AeBDiesOsdAhwbLbc5CMKEb8ko3DqWXa0BFgiIRf7cJ8ozswH3huCydMHFtMk11fNQu
	t79IOdmHkuiAjNpZLOqS8zMlgEcy841EfvTeDjZhBVkTrUcGMLY1iKm2DPaJOwZARn7CU+tYuL0
	2OwTSuxcKH2H5XPbLc7TdFxWz18o1ssd2VfFd9b6b2/hSeGkvLevDDVuV5nIvZZLdeS3Teui6WT
	UozgkOU0sdXFohgBZlRkd91YMNWXdKhKke8I+W69ZZHcqL6fvoqAbJvZh3OPatKoU9ClWbuQT0n
	PhUa2TdyEfhJ50rI7g==
X-Received: by 2002:a05:7022:60f:b0:12c:44a5:fb4f with SMTP id
 a92af1059eb24-12c73f6c49amr18058531c88.10.1777056888193; Fri, 24 Apr 2026
 11:54:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423100904.2336750-1-k.chai@proxmox.com> <CAOi1vP_=Z9n8aEBZtqLuedfUDka2_80xc28NKWcR5ijgZwUT0Q@mail.gmail.com>
 <87y0idhpfa.fsf@proxmox.com>
In-Reply-To: <87y0idhpfa.fsf@proxmox.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 24 Apr 2026 20:54:35 +0200
X-Gm-Features: AQROBzCzaKFDpGGMBI6whTw4CTiIQKoT-glnodYhyhIl9p289tdxgc_eJ8chpTY
Message-ID: <CAOi1vP8aOtKbcJFU40W_-Os__G9oahNrkMHS4gRaEcrjs-1cNA@mail.gmail.com>
Subject: Re: [PATCH] libceph: accept addrvecs with multiple entries of the
 same type
To: Kefu Chai <k.chai@proxmox.com>
Cc: ceph-devel@vger.kernel.org, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 1:44=E2=80=AFPM Kefu Chai <k.chai@proxmox.com> wrot=
e:
>
> Ilya Dryomov <idryomov@gmail.com> writes:
>
> > On Thu, Apr 23, 2026 at 12:09=E2=80=AFPM Kefu Chai <k.chai@proxmox.com>=
 wrote:
> >>
> >> ceph_decode_entity_addrvec() rejects any addrvec containing more than
> >> one entry that matches the requested msgr type (LEGACY or MSGR2),
> >> logging "another match of type N in addrvec" and returning -EINVAL.
> >> This breaks legitimate deployments where a daemon advertises multiple
> >> addresses of the same type, most notably dual-stack (IPv4 + IPv6)
> >> clusters
> >
> > Hi Kefu,
> >
>
> Hi Ilya,
>
> >
> > My understanding is that dual-stack isn't supported in general:
> > https://tracker.ceph.com/issues/65631.  The respective references were
> > purged from the documentation with Radoslaw (offline?) ack.
> >
>
> Yeah, you are right. I was overreaching. Dual-stack and
> heterogeneous-subnet clients are not served by multi-entry addrvecs, and
> the patch does not change that.
>
> >
> >> and multi-subnet deployments where tooling picks one address
> >> per listed public_network.
> >
> > Can you elaborate on when such tooling kicks in, what exactly does it
> > do and the use case in general?  It's not immediately obvious to me how
> > having two addresses of the same type/stack and simply ignoring the
> > second one is better than insisting on having a just single address.
> >
>
> Sure. The narrow case that remains is compatibility. Admin tooling built
> around public_addrv and ceph mon set-addrs produces addrvecs with more
> than one entry of the same type on the back of that behavior, and the

Hi Kefu,

Sorry for being dense, but can you expand on _why_ the tooling in
question is doing that?  With the dual-stack being explicitly not
supported and the userspace messenger unconditionally picking the
first address, what are the use cases for adding additional "dead"
addresses there?

I'm asking because Xie Xingguo's commit [1] mentions dual-stack
(already covered above) and in the ticket that I assume got you
involved [2] it seems like the user was able to implement the setup
they wanted without resorting to adding those "dead" addresses after
all.

> kernel's strict guard rejects the whole monmap. The handshake contains()
> check is the one concrete reason the extra entries need to be listed in
> the addrvec rather than dropped at advertise time.

Can you point me at this check?

>
> >
> >> Match the userspace messenger, which since Nautilus picks the first
> >> entry of the requested type and silently tolerates subsequent entries.
> >
> > Do you have a reference to a specific commit?  I'm wondering if it
> > isn't on that "merged more or less accidentally" list.
> >
>
> The pick-first selector in AsyncMessenger::create_connect() landed in
> Sage's commit d1a783a5f733, and Xie Xingguo's commit 50d8c8a3cce3 fixed
> the loop to actually honor the "pick whichever is listed first" comment.
> Both shipped in Nautilus.
>
> Would you be willing to take this as a compatibility fix, with the
> commit message and the comment in ceph_decode_entity_addrvec() rewritten
> to state exactly that and nothing more? If you would rather keep the
> strict check and handle this on the tooling side instead, I am happy to
> withdraw the patch. Either way, thanks for the review.

I'm all for reducing the number of inconsistencies (whether intentional
or unintentional), but I would like to make sure I understand the
background first.  I'm worried that by accepting multiple addresses we
just confuse users into thinking that dual-stack is supported and then
they go on attempting to implement "a second subnet", etc.  AFAIK those
things aren't tested upstream at all.

[1] https://github.com/ceph/ceph/commit/50d8c8a3cce3bfbfc9be5acfa60bda165d5=
9e2bc
[2] https://bugzilla.proxmox.com/show_bug.cgi?id=3D7518

Thanks,

                Ilya
