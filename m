Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73A036C582
	for <ceph-devel@vger.kernel.org>; Wed, 11 Mar 2026 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773237991; cv=none; b=jeW/ayT3wl74xkc1uPk/lOekzkfj/hrC+VQqBDKsGjEdkTEgqcu+FT4S2xk2N9vjJOhrOISH9zbY1YxkaQfeEBE7ZGKcpxfEgiycn1XfzaeSaife/2ywMbojmD57iHda6EjYXtW9VDuNPkzrUoOWtQ94SguuHw5baPYOlLukkn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773237991; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcL6a9IRmcOPZbFZvOCobJBWAekm2F3r0vGZ8KokIANxdZZ7G6tHb6cf7wPHnTvVmNCcGnZip5ZsjG+S5VTRGiP07lGT7MX8Yp8Oco4v+0+BfJLQ4pPP11c49pd+NmqOgJ/w0w9zfbU5obH4KU35rHdsB4oCrbOrCLTFWxox7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b93698bb57aso169057366b.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Mar 2026 07:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773237988; x=1773842788;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=ibVoBypJ+QKcAPEtMROeDjdF+vp5CTua+rJRIsltzj6Vwo2s0zDTULAKhRFhnfhBRc
         at3CgmEHTUMG1njjeltgi0GY7ySJg8cZ5F0eJZ7uVprQENWJ48E/MiHv5VqDtP/qN7/U
         +P/Wj3XBY3BLjuJKuGbhaSeQmHg/GrmmoHlGbRtpB8grnGhPQ+PfukaZKJ/vu3bfRUIs
         /f/Mmi4ecdVSPC+8ZUxm9oiAm6mOB37S3YFmz+uJpdjXiRbTTOFbis7zcj9FDsrGhdyd
         aufZrFKf6BSKmNojB/BHcyuNYPrQbDh7svPzkrTDQlwY4heXIl5FpqhoiBa0Bv7jeU7v
         saiw==
X-Forwarded-Encrypted: i=1; AJvYcCUTr5I1XU/FxeRshtwCpHUoWeRc/f3R/zXo5uzD0g2jjKXUkTSvplb16RyAGSjYHp6UC0cfObOnVnfc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9UFaDWo6CELM1qd9H6P5WJ53crcgMEbXQDsUuQIiuToA9Eeah
	i1vtTm0ZbdWaodxxvAQFjCWnSQcvg4KVE2GVJ+upilTUr1DUsj59d46yYxcj79jnJ1UJug==
X-Gm-Gg: ATEYQzzQpTF2EbvAYytZWMODl/9sCP6DlBN5Iuxcuew8OAc8Hn+R+SCGxzW5iKZLAWE
	tQGZxCT15O7R+qYwPyOdLfdaL7WEwdqIHYd8e3WGWrl8amDg1st/x/rsR92grK4WP74Yo7la/uh
	mrfyrYio2D8l/yDy2Og/z+njzudwH98HaIfkx9qKt7ER5YRXW7SAbhtEHRNTSVZa3IPADUKl58/
	K63aw07i1euJRLPV+sxGo5x5N3jks17+M6edSt9Sr5KAzB/+SX9UXcLIgDP1EUFEyHC6RHZdWIp
	ANz3YvZMCILVoLWyVzh3703YSOfuUS5FCqFieyGTmXMzwSxd838VHnmM58DoAcYhK/sKoDpKu2r
	YQvjaU2zwpubFUDwpxQTVLlvr33hXA41B4EvwVYuZx8G+JVCzaocpKjXV5zcfYM4Z7ly4SyY2Im
	k4TJss9Fwhm4WzBYIAIqy44SEp1Tb3QsOzpqXH0IYHPBboB3GcscA80IZRssyC
X-Received: by 2002:a17:907:3e90:b0:b94:82e:55e2 with SMTP id a640c23a62f3a-b972d8122d3mr146873666b.22.1773237987561;
        Wed, 11 Mar 2026 07:06:27 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972e14ab67sm58615366b.44.2026.03.11.07.06.21
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:06:23 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-660be63279bso1531045a12.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Mar 2026 07:06:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpKGL5fFkktGuZL+aCFrHpEISnRfQ/xXETfB4OZpeE1VM+g898avdgmEkR5MOxn4vZ+v6LeDHupfY+@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
