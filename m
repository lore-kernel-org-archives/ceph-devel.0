Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792667632;
	b=r4sDYUREQo+bLTCzei8k7XxhiFqAdjgCp/Jr73lciFm7B4BsselL/fCiNim/YpEEIBxW
	 BZ2M8uZZlAKZRvyRUsRqswciqX2k48YcmIX5CMTJUCwxWa/2TWefSQTDp+DNKpZ4JFRzj
	 RWgedkL3j1oHqyc9/J0IogZD3kFcaZVpBysEmZkacB29xOZPwg7gNkSVaIkT20uvKkubR
	 A8zjHNgQHSEcaV+jDMyd9aEFU64qCsqniL2keHPQjGPPZ+9ds6b4kjY6ds8vofSgnmqJr
	 pdEcXq4+1YOHXwglVLojbdpPUZRqgqdcq2oHMghHKm6jQHTLKnL0nC41a6fPbN2bg8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=3Gjhe/tZHZCKm58pSSHOwVKZFKUlWqZcaWod8T4qc7E=;
	b=HlVdJ+36nzUdSWAIUfWbDkRJIyzGUwICwP3P3nqRWzFmQIbC3Bps739ZZpfkHUTDxXZ9
	 XcvkFfsi/HEqIdK03yM4KAsKuWeCQ4v0DtZ5xpCXRdZUi6Gt4ovHfKSw1pOw/vVpS9xRH
	 Hrwyx/af1ep4slPJG0DGz4doQrWvCvVXzcXRPVBpVYQR/arDBSefBFLJcf9xBl9dsIVzP
	 Vv4Bf4JYrZe1r31oSiSiK3jbANCAmWCIECeSz9XABmmLOpviEWg9zjRVbJFN2BYcHqelz
	 9wZH16XmEGdyJEbTyO/L2THppk1Fl8J0D/cMlKPZZ8ts43l5oP9QPznkB7CRyZqReeQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=Pi3a11Gb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E561606A322
	for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2026 11:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E561606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=Pi3a11Gb
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c263415982eso232345466b.0
        for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2026 04:13:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792667629; cv=none;
        d=google.com; s=arc-20260327;
        b=Lo53bv+lBMFR5I+Jc/GLeFCWK5vrz6j3ReuLXtzZbLcC2SJFcnWPk1Sv0mMHB5gsUJ
         k4mKR6325f+QJJIHGeVEgwQiIh7xbB/8QkAmZdRddp2w6BEUVP2UuC2ahUc+eq99+3EW
         lOLROxJX4pHoWfHd9pvAWJ3DLRCeW/Uu9py14mAJa3PZsOlQrWTD97B9rtriRA9PStFw
         mkAtLwxLbcp2oOYv1u7BCW/gzayJr8mju3nR2bCj5/OLhITE7aX2aFPu/PZGDgKXfMRc
         RwfMpgeqzswORFgMK224wq+5v2D2v2AOvmK4CNS2mG6c+Q1j5l6z1fcJK+HZgl4LUCPv
         hyYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3Gjhe/tZHZCKm58pSSHOwVKZFKUlWqZcaWod8T4qc7E=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=fNPaXqzzRvJnM84moaPmYJfAcuA2rOKvZ0UDmXPe5Kax2p4rtYIbwodxakM79FxeHM
         lMBNa+48nHYeiiPBhL729Y1leJWTQ9mRxUbJqDb4wllqfhUh4/VXeHnHlSIi0G0emnbg
         TjHJzJIeyqB5rBtT3s2dFUi6Cbh+FJ5+/cIe7FELWNnrS5vdkO8bzxKPzpTeQDSbIs0e
         UM4+9w6542wtt9S64QmVzYDu+FWl9bd4XwvG3UBtAve4i9yZETWQTnV9brj2w66wEwiS
         xNTuuqsMEAunCwUUShh2YjmPBY+1RfW5YvmaAGDBdSNZepxTWpN0fB1kRRyZfHPVT9k+
         8c4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1792667629; x=1793272429; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Gjhe/tZHZCKm58pSSHOwVKZFKUlWqZcaWod8T4qc7E=;
        b=Pi3a11GbYR4l4lzMF6jCVSrreIZwY4HvOEDbf6PUXRqu73a544dWKKT+JV2H3wQsEF
         54m6IpBXrV9aGXiRJ8YWTi0wVDY++Z88kt8mm21yYbIakWFk5RhVA4Z7icbtYmYSwyxG
         1wIn3GtAadQyLe3asKKJ04UffxGTW/x9XdanFkgHoSxnyDZlb/vMMLAnE/CXDzz8oN87
         rOOqpyVsp+nizJaKV8ecJHykPkG//opzPvgLULdEqdqytcBC+yiCBaIn5kTwRsxTcePX
         xEq/qF93rccmF1k6ao5cz2gB2WcMF+xP+OH/JEqFhjB7TqMA8jjnenzQucI5BJRl5zh9
         QArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792667629; x=1793272429;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3Gjhe/tZHZCKm58pSSHOwVKZFKUlWqZcaWod8T4qc7E=;
        b=iPkrnknQWkDC4PmPAWAxGRNZKN8MinEzpc2xNoN2G+orK8wAd/X7YOshDIvMM61h8m
         oQnaXxDfHoHKo3etahchHqrGcjBg4Bgn2Oj2QtKUpxXM2fxWUaD9k+svvYhbp3x3lHJt
         JVVZyx7jekqK41paofWFAKLCHwxCXZ5uRuT+SSgHmHtTsl11jJCvqnugKRR1rZhW2mwa
         rsm8Qn3OrXZkC/Syz2ecdcC4NoPSCGMBK3dhgUt7oDGCCwAi4EBoWLCrXXASJvMz7ALB
         g+ly6TL7x+iskiScvNU8Y0ieT7UA9tyyPTvHFJv6bRfCA/0K3meiUILWi7P6UhCBTukJ
         2r5w==
X-Gm-Message-State: AFq9FYLyG5AIuONhoDyCp2tYW7moNoCmonOY/+lJJLYijO39i9TWRRH9
	4n/l0pwBzDseZKP0ppEcuHPWqw5baeZxwnUjWV5Mo+H6DYAj3ifrl966Upw/U5a2ywdjkP5TOBu
	p5en/9MALsD6o6xo5j9zOvd8ghPXQ9+pURBqIzdawrxuWfw60EzHvACs=
X-Gm-Gg: AYBFou0E+baETFG6n19NLRqV7kYyFtU6paNjKXB6XbWqdXK/rqGW1ZO0WluFt+9366g
	JSXoE1338he8DiMXpEByMGkSU/GTjVOkB0nvgJX/LR26FLgjY/FuQOCbPungaBmpM6ajylSKoYr
	AnjA4ekGg0RVVJ0dANdB/ek7Q2BX1+NJrcZX3avBPcK44hdmnEVWror2D+ksB1O7I/hn4uN9fsu
	AnspMnbz3xLiPeB0SPywCBP66b0eL67peNrYK1rcGQIvVUK8xfMCEtSD0Nyiv/m0a/or20zn791
	xJolT5hTMjYHrGkVFHasAHkFa9P6Gjjuei9nS0/mARvAIoFdjtW+q5yQG+VqUSVIWEkmFxpgAlq
	S+23nnW5A5Bh4XTWhNdg64d/wLtBNl3Qq4L0uqgzV
X-Received: by 2002:a17:907:6e8c:b0:c31:be58:5dde with SMTP id
 a640c23a62f3a-c4679780524mr486097066b.40.1792667628821; Thu, 22 Oct 2026
 04:13:48 -0700 (PDT)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-b4-wip-ceph-ra-stride-v2-1-59a582388197@clyso.com> <20261022111030.1896752-1-amarkuze@redhat.com>
In-Reply-To: <20261022111030.1896752-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 22 Oct 2026 13:13:37 +0200
X-Gm-Features: AclHuK-x-1xNNy1OjHBVhMoIIScBQh3zAwukZM38fxbntIg8psszolkfk8iyqdQ
Message-ID: <CAOJNxRLrZqnoEmwZ5D8Xq_TMpa72RabppjTcXi3ywbwt3OrtAQ@mail.gmail.com>
Subject: Re: [v2] ceph: read ahead along the stride of strided record reads
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks Alex.

On Thu, 22 Oct 2026 at 13:10, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> Thanks for the patch.
>
> Reviewed-by: Alex Markuze <amarkuze@redhat.com>
>
> --
> Alex Markuze
>
