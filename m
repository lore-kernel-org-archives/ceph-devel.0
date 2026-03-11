Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E901EEA3C
	for <ceph-devel@vger.kernel.org>; Wed, 11 Mar 2026 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235367; cv=none; b=U8Vqi9fWskES9fGuYY4u0YsChAcpTzjnj7IGOjEvzkS7XzYDPnHwTgiSbex5+NEyWOFQwEFpJ0Orp+TApX12r3ztwQAeiVON4A9W+xpvrMGf73t1RFGqPh3yt4IFhiY04M33huGjcmn30oD3Lm5l3/QMswTIZnYC7JtAOKIh2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235367; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuLLBDF5JSUu3JUgMgsn1lvftggWVpgxiQnpv3USDZWO/gHQy4NSFsIJkrqp73n1Y76a/VfDPdZOUzTfOUUiiqTt8/W1j1iLUkB3GHiZiY8pduFjvq/rYg6Z4XZE8qFo4GzlyS/jrSYjZlksi0zUIqeCzanHLMHRunCPfJIuH2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94de88e52e5so8500055241.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Mar 2026 06:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235365; x=1773840165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=v1/lYKmumAAGc+8tpIZG/kCmQEo/gBG7KJQ2yXMemM+QMYaW9G2FjJHG66Xtu+SIQ2
         TuuRWw59sjJISmxsvh9L2dvZ1zlH3B8VAv7SGXp2GMANEhtuuOd6qzbu8JiO2rXM8BSK
         pl9mGPU7RfQe8j2MmIkywUExZ5b2XYAKUziw3uVXTFQZomhC9sal64C+OhSwkdCuw6nk
         vK/twX+4BlLtmO5F7XciKJ4u1FFg+863OSavYRpyapEKsDif2Vxe+yNjx8RHdHhwKHOw
         ryw18UmzdDV0t39bV6I/i9vXV4Ifj1GMidQODrQNsIfnTEhHtppDyvYdzXzh5PYmepxG
         RdVg==
X-Forwarded-Encrypted: i=1; AJvYcCUB4XIuI5i1vI4CfbpS5hQAvEMO4mxGKjNXUGcaJX7sMbLuowlWavHdUhZKpYM9vwuIxe0OY3bAwjju@vger.kernel.org
X-Gm-Message-State: AOJu0YwcgfJ1UxrttIvQIZETKmKxA1foYtwItYAVHrQ9WlAB82ERhzI7
	P2yNUIpzsNmcJAlccvB2BW6pQNCdxQoRmug725Zwck4niHV1T0z6Kr/OxxpwYwT11Bc=
X-Gm-Gg: ATEYQzygBoMQ5zrgG/QH6tZSHAZnLbG3PPQpClOvxAPOtYhDk97zUhRJ+WZwmHsjL0O
	XaMH/WaUAgLQBDR8wom49A/pgwwXgzov9bUY0LyTJtwlNTRvgvGg2nOnvkcCtt7HCwyjHhVxh0z
	GDqKcZKv5rqyhghsNvayjtFHNFg/Y2ujxzUEWqiMs359s2zefK+iN8gPhZDfvD4qWgWpCeaft9+
	aOyxVJsHZpbxegoce6aTJ6oOS46WdJ3wZv1bMlF5piBcrjBItksAa2mcs4tl0VWExGF9EU1tN4l
	UkYAw4yeBOm797g8o3SwAS7kAG4GVUEPQdqYg9l+Bp98BS59IUKsstV0grpGjJHO32PgS0ZMwN3
	iw76uwfDO8hFyWx8PXlZVMqnUC4zn8WxXpye+I2b06SyLibqxeTAFsff7VVBaoB7ORVJGNkYJuF
	XP/lQRaKOoC1j4BbFtFtQspx1Wfm4if2d18XgGqssUZd2yyOYu5TIgPgPILUk3/Bs6sD+wBn4=
X-Received: by 2002:a05:6102:3588:b0:5f8:e2eb:43d with SMTP id ada2fe7eead31-601ded2f067mr1025186137.10.1773235365230;
        Wed, 11 Mar 2026 06:22:45 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-601de74a80asm699266137.6.2026.03.11.06.22.45
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:22:45 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-94dd0f3c4b7so8222598241.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Mar 2026 06:22:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFbKNPnLCNH2LiB+N50UzUKNLgFrPxVqfaVdblGxjYHXgAZ78jF3os8gLAQ8GIBuv5bgMHS9teqIr9@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
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
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
