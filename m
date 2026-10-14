Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CACA3FF8A5
	for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999724; cv=pass; b=iepdpC1KA2zk0dOlkqGM0R2vNCehrGUKcUN3aAv+nfBqRSTEz+GRIcZTbmfpngEVrfrCtPYAtfk0lY5msm1X92hlCeTkBg9H7GBqDwoUpRwSu5yoGtkeeFmFdTROt37RIiETuHlAHzFV458CHabUSJCyo3V6bNOXOZ1HAEYzml4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999724; c=relaxed/simple;
	bh=eeXzCvcse/Jv5mvLFh5TSfXBVG+2naR0d1KoQe3JgmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gr4/QN5NE/RNIKFm2Lbzqdrt+xocf7unku9xZhC4YOffxrbEKA7/F+WHAfC4Sc6tI4XsAxqu37tdejrCSNhg2vUCJavWAGgC8dZewm6xxMpbqnnDCqqA3YIA3jvQ8MzXNs4+o905ov8U0GSGsj/SWv+6gf0mAqxAydb5tzPJtlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=We00uoRR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKWm9/9n; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="We00uoRR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKWm9/9n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791999722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eeXzCvcse/Jv5mvLFh5TSfXBVG+2naR0d1KoQe3JgmY=;
	b=We00uoRRBWVRomDaXzZZ7KwN1RO/4K1H3N0DIx2D50ms7d767aSYBa4Bxkn6UsJJIEvK70
	qT7rZ9bRz6++7QpECU/YXrB7pWEMca9QjSN0Cd5M6nDL6J6b1HEym7aiS58GyVobMbMpIW
	L0mKtDL8JTba0FEfjuseba2Jro2ObUI=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-9gq3XvkwOVmnmyl0eBGoYQ-1; Wed, 14 Oct 2026 17:41:54 +0000
X-MC-Unique: 9gq3XvkwOVmnmyl0eBGoYQ-1
X-Mimecast-MFC-AGG-ID: 9gq3XvkwOVmnmyl0eBGoYQ_1791999714
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-990634bef80so51468241.0
        for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 10:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791999714; cv=none;
        d=google.com; s=arc-20260327;
        b=PBWLa9bT0/s3vFGb1nehSF/NBOzZMbPeoQOZIqZukZc0Kr3GnJ4o1eC3wr7mZFVLRs
         l3KZGI4eLzOv7XdopTNFXPoClz0ug6zanL/v/jl0ZVdgXrtFldRWztK1E7RTrFcicU28
         1qCJbcaPE9Q9ythSxL3oa49Nqt2gbD+usonb1QEsIV3R9HK4RCPwWDsPGkN4AnnnUECC
         HH2N9mGdY+kq35Z+hHTbiEPUQoNixM1T+gSf8BV4zZ3feJuOdUkYpfaX0dosnBUj9Mfn
         87N5b8p5Ey8Quh8A1H5pHK50dZ+XMrvw5YuVcBqwXSiHTvDuJWh9vnTbCXKv6j5mrPyC
         33xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eeXzCvcse/Jv5mvLFh5TSfXBVG+2naR0d1KoQe3JgmY=;
        fh=43p9rSy6iDy4p3HeiopvV+euQ21hdLl1VK9t/YSam9s=;
        b=UIyv6H0GoqnQ/0LvpIZzT9Flxuw3zYwsRfTDL6FXD2gIedzaI6vC8HVEB2RwU3Y/gF
         nteOGhqUn1rq8jvbPP0nPqP/YY12O62Hf4vQ69V2OHiz6LMHKdtrfTf+DuB89rqmOoUb
         FOcNS8PCsldp3d6KomC2cFkECgddnaFda9BKsLn4b0wX2HbaDqrliOAW9IOV4SklyZzi
         OGC/asxs+nRhTFSUU1ZrWaNoQdcCTICpTyPMuM44MmkzAvlxQI6JFiRdECNixn8I2hVW
         vRvci0HOBHOcIOJvG2urH7f0aXYukZdRiLDHtZPIfHwTZYIdI5mf02/QVWB6/HIgvVbK
         KSfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791999714; x=1792604514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eeXzCvcse/Jv5mvLFh5TSfXBVG+2naR0d1KoQe3JgmY=;
        b=OKWm9/9no+yXxt5S7jbCssD9nd2UgOFIXMoRvVf1/CIsKkjasIcG2Ka2F+iL0pGENh
         BIHA/iEnsApuLMjzWxqv3Df4D+na2PxjYVbJl5epz8B87GoamcIoBOZJBrbkRVRt8JLB
         1UPwbv9itOIu/BlhaF+DVTourWvR9ZwTK13fmkiufqAzYv+1xnWFTOqMkN58GJjliKZm
         nsHxCP63AQdmp9PR4m98C+fKTx2kEUqTZfnhXdczFSk+7ekjRapc5fi2d5ifo3SIiOQG
         00TQFh3nvyHWnySTgxsYbJz/sntf1hoZ9fpan484gBhfB8eLfBk/RCYAwdoM0fciK3Ti
         UG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999714; x=1792604514;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eeXzCvcse/Jv5mvLFh5TSfXBVG+2naR0d1KoQe3JgmY=;
        b=0Fa7FoDBvRtY5Bq0cRo5KZOQOmsBsL0u5KuEsaocfFbkTyqIILTsEIm++eirOPEJRw
         WPoLbQbJNfu6oqzFr+xlHfdK6vDQwbw4QdMKMQlXPrVbmLIGjHT0DrYO5nrGF3Eo1okF
         wjDr1gErei8EhWQA4Y+FjC2S9SKwzYN8USNaI0g/Z0Dlwwq974eaqELClHkcVyCrTt48
         AsIUqWjpIEaFUYehViXq8bczjbmyC7spv62/XUzcZ4qS/AIizZLC5jgsCH4VKUY2uP8V
         BMzpL6BbpB3eNlI4RHzHfTUm8hgZQvmlYE2TV4XS9xoQXSMJTxxNAdIIOw3R6ydiswwX
         yXEg==
X-Forwarded-Encrypted: i=1; AKwUvBwuAf2hKX8wktIUdvEs6gaIltOQeQjidM0zdHhbE1TfrFX1LgsBmsk16dN+rnvx9L/bA0mT9pAayNiK@vger.kernel.org
X-Gm-Message-State: AFq9FYIpJvYYKu6L2/v/Y8s8LW5bdoMbSr500QJI6mw3+swGBEFpWeew
	QXDXQamRod7bR+N0XuiWfAVRss0bCYP/aTZxGAn3PHRMlJjNejb8/AtLOcswOV2JFYAbXo9Fy4r
	3AJ41boPJPNM4urJzrUI20DMIqXL4TYhzd88mUfX8K3jul4rFuRZFzAYjE8Ifnb1RZB+B8Vg1vs
	0i+jRTO04t4oE+x11gmth220/zHGrDMzd07DDXTw==
X-Gm-Gg: AYBFou16wgxASmLlQVlK8EwsDA6kKXKiTCgqKo60mjhJmfh0QNdfY3dZtTMJbCSELPp
	w03SxPKqsa/ZSOUnA4bOcAl1T9t7Ryjj6UeziMFZZOS6214HfIqkj2pmZoYjKDxNuFOaY4QWCCN
	Mare7xq6mas9Yg47bqQ5q2dBp0Jeui2Kb9Edcv2sgFrcYEvsxpmup91WHEMqsDe2HwjZ9Vl5Y7m
	d4vTgzV1p3OKU8j12hGjQvjhzjdWdNRO1qLv/di
X-Received: by 2002:a67:e7cb:0:b0:7c3:ab54:105c with SMTP id ada2fe7eead31-7cb37254ae6mr4053292137.7.1791999714125;
        Wed, 14 Oct 2026 10:41:54 -0700 (PDT)
X-Received: by 2002:a67:e7cb:0:b0:7c3:ab54:105c with SMTP id
 ada2fe7eead31-7cb37254ae6mr4053286137.7.1791999713611; Wed, 14 Oct 2026
 10:41:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com>
 <b8c135bf-927e-454e-8bca-cbdbae133d51@huawei.com> <CAKPOu+_Msno=mux+FUc-oV1-ywRFujJcnKS2HNv0sjtRVtUP3A@mail.gmail.com>
 <CAO8a2Sj2UbocxY+_MRdcH1TWht=UJT+ANWmzqLY9MQxZ0ujUpw@mail.gmail.com>
 <CAO8a2SiVWYSR6s=Z34QcfPVNVSLGk+YQQza4DDEt8_8+j37AHg@mail.gmail.com> <CAKPOu+9x_7WQmKhW==AmLoSzuPrUqeSV+JR69-TaovjEhuj6Ew@mail.gmail.com>
In-Reply-To: <CAKPOu+9x_7WQmKhW==AmLoSzuPrUqeSV+JR69-TaovjEhuj6Ew@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 14 Oct 2026 20:41:42 +0300
X-Gm-Features: AclHuK9vXikgVqTLHZRCnTWV-IrIq4ErflAGSoRJjlbKe3B9fIi5Q2ybZN6v5sw
Message-ID: <CAO8a2ShEjqyNA41ujmF5GfOM+YbJvXqCHKO9V++KBkJCXNOSUA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] ceph: don't unregister an MDS session before
 removing its caps
To: Max Kellermann <max.kellermann@ionos.com>
Cc: "chenyuxi (D)" <chenyuxi19@huawei.com>, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-kernel@vger.kernel.org, xiubo.li@clyso.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please use the ceph fork and the testing branch.
Since the last merge with main Linux the testing branch has grown by
upwards of 100 acked patches.

git@github.com:ceph/ceph-client.git


On Wed, Oct 14, 2026 at 2:50=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Wed, Oct 14, 2026 at 1:28=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> >
> > Max, Please resend the patchset, the tree has diverged since this
> > patchset was sent back in September.
>
> I see no rebase conflicts with linus/master nor ceph-client/for-linus.
> What other recent changes would make resending necessary?
>
> --
> Max Kellermann
> Principal Architect
> Hosting Technology
>
> cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
> General information about the company can be found here:
> https://www.cm4all.com/impressum
> A member of the IONOS Group
>

