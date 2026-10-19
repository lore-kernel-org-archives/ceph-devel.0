Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264D14E50CB
	for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2026 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409668; cv=pass; b=WthCXqrdMpeklzSlXyzhli090RD/ss4OxF8h9qkXlq2mdLOXt86SMXz1aYTcjsMGjWOYVndpvXLw1GQdEFwpFNIkSHwB1Whzet2a6n9ZCO8BMvBigGX9fOfjlDxWxbkPkNwStcowBodZjG6f6bKMtIt42A7AbpIbT6Sh/e7X9qI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409668; c=relaxed/simple;
	bh=POe9ttyQGtTMETzZLC5iEk+Oy1QBN1MrzCp2qXRWNHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugmSbcU3cW3FfEg8SSAqqNYZw8hU+w7sx3kPSIi6yg3JiK1Dky8qBPQkneO2aeIUCi2KQ3BNii+wzm8Eut4gVZulkc+5sVgZTnfJGyh5bZmOQCiEqIyQnWdH5KduingSXxiQ+PJe2yPVy7VY1kZIs8p5uQzEVwPLdgRzdfmadeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=LhlcDpD3; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="LhlcDpD3"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso267854066b.2
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2026 04:34:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792409661; cv=none;
        d=google.com; s=arc-20260327;
        b=KPIbHuW9fJRjRovwgakYL5Fq6V+zUeek1wfdQAxQlVSUwV42Gok67Cjd9sioV9NWmU
         NL0AH7LXi/dVHWU2tH4oVOgnRZn07BDzelplPB2DpZ/3Bm/ay2myFHqQfnI/Ep7zv9r9
         Y/G0ahz0QnH9LbDLyyIsOOYFI3hSOLYwFRkOsIJZcqWAI/plq+StS/VdVUPTGSDpSLTC
         9aAmqcwjaj39p70ma/Ge2drdg3VRilVjUXRQ1svL7iIrZDmTeUeqw1CH7JqiJ4ifypQ2
         TJf5k8OtjMERqbtFwceeeWLDivh09x+pj1L0PevbaUlxzsz0cX/FsB9spWJkQW+X0y0D
         JqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=POe9ttyQGtTMETzZLC5iEk+Oy1QBN1MrzCp2qXRWNHE=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=Otw1iMhmhE3+UC/yzag8K1TP/2ckznPOj8zyQatU06kjio2aZtEHPx9fPlkuiBSG5W
         XNCiH1VD0zbJJXukt0BS7Ne+5LQfPe/xGqi+o4OlOZpq+ZpT1+OCsey+u7sHyqV7E+jR
         cENvd53hdU/UahqMPfS2m1guhn+fFEvRvVQyPBPSNG+TqmsJaqyRUWgTqn/3WnFqPIqt
         WR8+4/up+bNTGSXV06IH50Vt2KY+/hDVVKquupzI6viKL2bhl4TE7PsP4HqZ5wOI1iAI
         sLwvbIbYhjr2MeAI5oNE16ulBElDdqGffWSMsL3OLEYiiVP91a8tw6Tnjg60z3O3KydF
         uNMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1792409661; x=1793014461; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=POe9ttyQGtTMETzZLC5iEk+Oy1QBN1MrzCp2qXRWNHE=;
        b=LhlcDpD3rCkxdzIcbY0cbaMXsWQcQYju9SfC4Qfd0rUqT7ZNu9DcgAAIMWgdQeq9pe
         RertrXoqZrmoHOnq3dS+A86eMjo6Fpb4M1SZARdrUEuoULkHzV3SjH8vjn7yHAwsSFMU
         yNfzgiGcgz+POq2jgkG7lPTgFkixUtdApNxEZM7byjgCIjCW1fwJ5586IU7RaGdVs5qt
         CJGhxg2P9KSdJdu9XZiEauuv3WI2hSVsjKEvL8KRUPUnHlrWNYnXuz6dkROjFy1npKyk
         g50Sqd15ooloIVfLunG4UpaoxtgEUDKO7v+iuXBokBqcdbgG2IN8wxbBS89LCs9U3TPV
         zs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409661; x=1793014461;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=POe9ttyQGtTMETzZLC5iEk+Oy1QBN1MrzCp2qXRWNHE=;
        b=sjO+PCL5tdwKogdZ4NIQLMb15hoXUdVQHf2KBLiOKKi2a2GdzPEB0uyt4KeLnKkkJg
         FH0abwQnfPzjm5Wi7qOni33zQxo+lgT+LoOH99TM0YskDZwiazetoi6kknczJ7gRvhNk
         FwkU+etmsYGBu0SA+QaaFbnKyTCR2+DkkERfda9B5Y0v93ltXiJ36MtAyw+ZsttholgI
         ERjvnWUdjVyIGu3Mr+X+FY7S9ymmPh1uzcm7zbuvmK0bHoUXJwjvxHs2jq8c7UnFKi3P
         +FQJzyKw4zEkzxCiYxZGFnUKLpGUlze7Pmsj5bi3cE5die98njpcEWgfURLk67c+Owcy
         HUpg==
X-Gm-Message-State: AFq9FYK8u8FC/i1402FwMRfkeNxUeUVKPHyAaWn8j7ZaNZlxq+5PAHUN
	kEgppHTMN7h0btbL0DV69ChyLH9ywCyyJQ1PBVJA2UJM5QdtuvEnIYkHORN+hcmTNvh7xfC4hVV
	hbcbkEd0hikuMyhJgCCqs4r/Ot6r2MMKu2T9sxBbng3G4twleFuWuB00=
X-Gm-Gg: AYBFou1SbFLNX8jbp6JDG+iVq4wBxudQmcbDu2pZSPAurg4D+baxyWNl62mN1GN20I6
	NKMejluDYk/rMrvIFVkSaEhHSfU94Va4SjKdlVMZk+xwVqbJI2uRnbvFbCF5TKL2odwrE3iLgqZ
	SljlieSsbem6/9kNCjnzuzZFrU53TVBu2OEeG5ARXtQ3uXjiR36kto3qOWpiovSgbzdjBA2qWI8
	kN1i2y5m+Wmy8ZfFh1uKX7QVVYhSMOShUxbr5+9d4PuvmhC/Ri1E4JIOyxUeJGYtrwaRkPIMEn/
	7islUi1DgCmYWQajzMos3bmj6vQ7LQQLeShRanG+JwIea0S79+CW6E9wmg==
X-Received: by 2002:a17:907:9347:b0:c29:63f2:99bb with SMTP id
 a640c23a62f3a-c41a10c2ddemr516739966b.47.1792409660766; Mon, 19 Oct 2026
 04:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014-ceph-metrics-percpu-v1-0-38c5a24fec6e@clyso.com>
 <20261014-ceph-metrics-percpu-v1-3-38c5a24fec6e@clyso.com> <20261015144756.122551-1-amarkuze@redhat.com>
In-Reply-To: <20261015144756.122551-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Mon, 19 Oct 2026 13:34:07 +0200
X-Gm-Features: AclHuK82W62FmsRwstbtRd_GZg-jiBAa_TJpRqDnerkwqus2UsTPZ9oI1zJ7eog
Message-ID: <CAOJNxRLtyyC5rbiHMWrLYHZ3ngtLfOhkBDYF74_J09_JFzYk2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] ceph: accumulate subvolume metrics per CPU
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Fair point. I will fix the issues and send the V2.

Thanks
- Xiubo

On Thu, 15 Oct 2026 at 16:48, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> NACK. Please respin.
>
> The per-CPU slot is cleared before the tree insert lands.
> ceph_subvolume_metrics_fold_pcpu() and the subvolume switch in
> ceph_subvolume_metrics_record() copy the slot, zero it, then call
> ceph_subvolume_metrics_fold(). If kmem_cache_zalloc() fails, that
> CPU's counters for the interval are gone. Put them back when the
> fold does not land.
>
> free_percpu() runs from ceph_mdsc_destroy(), which only flushes the
> messenger workqueue. OSD completions still run on osdc->completion_wq
> until ceph_osdc_stop(). Flush those completions before freeing the
> per-CPU memory.
>
> --
> Alex Markuze
>
