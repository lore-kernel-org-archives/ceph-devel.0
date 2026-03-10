Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C82F3B52F6
	for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773168055; cv=none; b=mqYpoJ6fMcPDAZaG2Jnl/h/IUhTBi4Tedt8N1/iMECubcgizhgLpjoBB9By4nwug/SXD+Jdi/PNFibXn7TnxJp5li2QZ07d73W3GYxs5p8veVRMP1MMZa8KA7w4eTKPuNoKtj+LJVtE4qGbSYBASqpbQoMZNIkju+IpazJAXdI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773168055; c=relaxed/simple;
	bh=67BO0RZg8rxb/E50RmGcBJlsPR5Ae9xmCy+Q7v8QtDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obpF9d47ETscXfhi8iycuu8WmcXU94DPM+NQ6AOaBRn6a2Aku9Kk7etdXD9uLyGuY24gORivJ7iUf6vHUYKPC4sSQkqCUd5gu4F8nkALFAo2+EbKle3KQmehYJ92kiyzoTzdIEKFtBcboMqDmIDRSGCuG52JVwBvlj4t4du6XzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kH0xiiWz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH0xiiWz"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a9296b3926so102507505ad.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2026 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773168050; x=1773772850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bjFZ9oZWWc3RZ4UdO5rq+AZbr7uPDX73K58gh1+yuH0=;
        b=kH0xiiWz4KeHg8qM+UQYFRGEoaB5YhGQ1/l342lI48vVjCWqHFWSBUDJtSv8g6YdEb
         WUvbLXs80bxV+xnMTu2IxnxqQ1WawTtw06PwWKuvZNeHk5D3euuYdO1/s0++E4FpGP2z
         +c3ttwFV6WwPOQpNHM7WUIHZNaqG5koiMMCxTax1rBk+j7pB0850FJbGseMzgmcav/Sc
         D4sAVnEuBVkUt07E/ANMW8DM/NJ+n/hx2N6JUcXYsLZYrFMsnwCK7vKttbH8x8ketzgA
         AEJgLDRmf5idGKEt1ix0VwO4x51qzzz9/bjh5SLZJM6RE+ISqePxLY2ZYvsw4O/i3F73
         NyLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773168050; x=1773772850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bjFZ9oZWWc3RZ4UdO5rq+AZbr7uPDX73K58gh1+yuH0=;
        b=MI7OJCvuOM7BZidvP8SKF2F4rKjmHk7P6TGpsn0OWB58XN30Dxt+x5EpBMBNM+q9/8
         sd8IrZebwLHvXH62pLF53TJ2EOYZoKgsjd807Nr31c0VM3d41SJ7Ds222VE6TJ1b8wmm
         yL0oT8QfYLOJ6JANu9DtL83tNXjcm4QRQFGYnzTVrgqj+wGd1SxEyYD9MFMxeqR1EkTi
         hRH8WWVLD0zsJeIVYlHzc0yOoSJiS+AX5H2d6KM/m1ONmWyaGNyN2dDE6TyGKaXjwzvV
         4/sEpDUKVABF0bzAuVR6uwwfyafoJFZtIm9WlD8D99q6yMQm9BytIplXyBlljqaMmw4R
         aSaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG3dqT/U/R0FSPhW42aBO6etB307iQATtSNvkvjbYXR3VfutdyuBY42q/wHrM5W51KS75qi56i+W49@vger.kernel.org
X-Gm-Message-State: AOJu0YwfL3PoKkhdB9ENs/wSSnAZbSvP3tvAEhtMlZH943xii+IRIDK2
	5+JphbITUReKVeI3DI+EZjYeup/xuNKMDwvIw62AM0wZeRLUP8dblBAPpHSK+TP0
X-Gm-Gg: ATEYQzySphdIPAGZ9FrtTcO2hMkER5leXdADusvID/EweL6CNTn8UYOH/a93VKdj/Bc
	y1D98ZQLdvzH5Gmf8iTBEl6FySvAhqst0T6UL2v9nKOoM2AcLRKsdJJ7CGwB+eUWAOpND6KHZTg
	4PTjDthPKikqG32OX098A/fylfJUC/Jt4kUU5zwIrnAgLxDShAYnS+aU10c0feBm4wT8K8I2TDV
	K4Q6N1/IRyJKjeTK3mHaqKtn97a/Z4Ga9nEx6sz5BzhXVV06biFU4I++ZE3Myz8EoYE8Mru4tj+
	3IfUMgofkWFk6rrHRIZoihE9OBAQgT9Lr/G1QriV7llslKgdjWvzIFKJQn7DDrZAMl6gdSK96JR
	r0kiDElllYDRxaM/NCfeTPa8fbZv+xueU2U1WjFTrt3fbt67GYwY73fQyRiW+JAQx+EJdHkRWKJ
	jCYRtG4WMAEaYTSk1dutqSNAGMZ63tTXbFtJcBey6ML0BjOQ==
X-Received: by 2002:a17:903:28c8:b0:2ae:5671:7071 with SMTP id d9443c01a7336-2ae8252cf0fmr96662285ad.43.1773168050081;
        Tue, 10 Mar 2026 11:40:50 -0700 (PDT)
Received: from google.com ([2402:7500:a44:85b:2953:97d3:b283:95c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e58592sm220535625ad.14.2026.03.10.11.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:40:49 -0700 (PDT)
Date: Wed, 11 Mar 2026 02:40:36 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Subject: Re: [PATCH 00/61] treewide: Use IS_ERR_OR_NULL over manual NULL
 check - refactor
Message-ID: <abBlpGKO842B3yl9@google.com>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>

Hi Philipp,

On Tue, Mar 10, 2026 at 12:48:26PM +0100, Philipp Hahn wrote:
> While doing some static code analysis I stumbled over a common pattern,
> where IS_ERR() is combined with a NULL check. For that there is
> IS_ERR_OR_NULL().
> 
> I've written a Coccinelle patch to find and patch those instances.
> The patches follow grouped by subsystem.
> 
> Patches 55-58 may be dropped as they have a (minor?) semantic change:
> They use WARN_ON() or WARN_ON_ONCE(), but only in the IS_ERR() path, not
> for the NULL check. Iff it is okay to print the warning also for NULL,
> then the patches can be applied.
> 
> While generating the patch set `checkpatch` complained about mixing
> [un]likely() with IS_ERR_OR_NULL(), which already uses likely()
> internally. I found and fixed several locations, where that combination
> has been used.

Thanks for the patchset. However, I think we need a explanation for why
switching to IS_ERR_OR_NULL() is an improvement over the existing code.

IMHO, the necessity of IS_ERR_OR_NULL() often highlights a confusing or
flawed API design. It usually implies that the caller is unsure whether
a failure results in an error pointer or a NULL pointer. Rather than
doing a treewide conversion of this pattern, I believe it would be much
more meaningful to review these instances case-by-case and fix the
underlying APIs or caller logic instead.

Additionally, a treewide refactoring like this has the practical
drawback of creating unnecessary merge conflicts when backporting to
stable trees.

Regards,
Kuan-Wei
