Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13523C2790
	for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974823; cv=pass; b=TTVRZ4GvGVFUrzMNCjTICbC94l+ISTCaOkKOdvcnZFOE+Wjxj4JmfHRektzL5xDDoR+q7FgCyYXJAw038wXX+A0wOwDr1romlX8GhtuMAUgKvHFiQ427GpQAYJxQO+Z31d/+ZzdqnFbARdoXzck+d5cD7Y9juzIquDj5dqYBUxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974823; c=relaxed/simple;
	bh=BxvBfVACsPmDwWkhsEMNS/sYummmzVIv+k2Sin5DzuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqyfi83K2FVeFqF/8gug84DFQLh6ciKsPSDzVsoMOSSmcejMJj/k3DvqFQCCbQEnMUEtIet7BGvle6PPsm4A6Pdo8i2T68OhusfenGd7h4n4NVrewIPLG1bugL78ZPDFn40DJGuLoFtG0V18seM+oEhRzP85HACIgDdZ2heVpoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tp+sNeDX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mt0Y7USV; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tp+sNeDX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mt0Y7USV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791974820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BxvBfVACsPmDwWkhsEMNS/sYummmzVIv+k2Sin5DzuE=;
	b=Tp+sNeDX27sxYkFEG2YO9858YV2FNVp49Jqyz1xge8XadANa8I6jjYhMVMd0zz3XKwmpKr
	OQsKvZpvCO9LRlhCHFxJ+itsXwornyeXjmRvj+YT7HW5M7joxaWfrAqFwM9dCgFM5f35Qp
	cKP1ojMUV9n/K+Fk6tEqv9R2LFCcvlI=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-tjWRQYSINjKvw0SG3JSs4A-1; Wed, 14 Oct 2026 10:46:55 +0000
X-MC-Unique: tjWRQYSINjKvw0SG3JSs4A-1
X-Mimecast-MFC-AGG-ID: tjWRQYSINjKvw0SG3JSs4A_1791974815
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5e96da6866cso171350e0c.2
        for <ceph-devel@vger.kernel.org>; Wed, 14 Oct 2026 03:46:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791974814; cv=none;
        d=google.com; s=arc-20260327;
        b=jm9RkOvcCsSa5iYDpXfj42BKPfCoPsoWPa6VIfAzYqQrpCWGFTjeucrU2MyJ/6xFz3
         OO7KQ5PI2wOwcYX3M6n21x3lk0VMCe0zh3ODDEEK1en71fQYTe4tDf7RzSo37ky8Rl8C
         tWUCc0mKayJwwcEOk1n2ffxyIW2Ftq2Cksop2GzHqf7K5H8z0e1aekQM3IKWHNva0PwJ
         h9PWz9jbDjQtnuZQmY+eQheAanNTCEzwWGOw8Jl5+MqwIQYEVl3nHvVCYbOUoLtgsRsX
         vDc4l094I0mhNE80NbMFsUE9VP/HfiS2NyeIB6bv4Upf0GMa0FDNjYmaJcDqxN4jmEYI
         LeYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BxvBfVACsPmDwWkhsEMNS/sYummmzVIv+k2Sin5DzuE=;
        fh=3ZdSqnZeEYijb5R8GS4UVLJZy7ZF7TppLNLNBirYlMs=;
        b=q+rCreyfwKb968+QjVL5FcBVOuxlETH3WuO9bB3xAY5hNvH4Vs6moGCDog80gW+qco
         TqFOmnSE1mRcWvkvwaevyPHzlc2p84sfq+FNrCrlSMEmD6Y3gMb1IzwHHtij2fdEHFNt
         HgrLcNsezbndgc0N19UIaAhaODicpDiJYqGWB7jviXRt9mo9pXAmUowSHHvYdbZRzuVk
         yzRFrFuBoNVy5CNN2yOrelFWDj7ooNyGWnsWTmcAv37oYU/si9D8M1TpdEpKW4v26XBw
         MC6D4BAtbVPXakFjgulzdOZh0UZ09MZ+AyfrTZlF71FbdktFyimyQW0TEORnbB6ZL/wC
         5cAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791974814; x=1792579614; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BxvBfVACsPmDwWkhsEMNS/sYummmzVIv+k2Sin5DzuE=;
        b=mt0Y7USVDbpTm1UGzpiK74uBreyrHxdMM3y3NY/fszULBXMjwLyBXJYaMmsl8SCcZ3
         rwCCX6yXzxe5FJEvMMSWO3jhue+eaAnqzRo4NQ5P8lf/6w7br8nznHoOgG8MXUuEucZS
         omG9XKPBsD8110B9sFA42FDDLif/Y50I9oAP0fhI+Wv0nvgqyxA7sSKXImKF2eGQWelk
         i73rvb0XInsmlAe1qNAWlJyExki4zR5zVJC9qNTHq4qWiFZiQh3KSspQCxUJXgGgFAvC
         Xu9s/ekuMkE5iC2ttlFwC2Uu1JDtFWabLqhHAnV1gkKOCEo3DaibrnXcuPq2ani6vFNk
         bBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791974814; x=1792579614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BxvBfVACsPmDwWkhsEMNS/sYummmzVIv+k2Sin5DzuE=;
        b=C/VwTO93e4AMztl1haeP5WFDaurVEaZcPwFw2tga+KNgqhs363AaRaLyRzFgHKICIe
         z8UIp7bJeXk+PPxh29XTE3YBR+2cxHjEWpClCycFLtyfs5bv5xb7RcEX04uCmjxfYruw
         +dvq6C0iboUlHDcLedtFBOxAJX/7Pp2AB5j5devUC9yqxe6jABhEJ86eTkdH7p9VfwaY
         2hy/XFOcPB0xbzmwx4TG+pBUDs86uSqC7byZWcOcL6d6ld7V209tzSOt2qipCefGSSm4
         O2yC3k1iZdGxKpGiwb4rKAUtINsOB2nr7cWdjkas/OsgI8F7sYTK1HpFOf/ut9rjTY4k
         N5eA==
X-Forwarded-Encrypted: i=1; AKwUvBxiwXDxoaKWw3E2koyRwoq7gzAcKBDJ4o8ABPRtBqCd6XmXxhi+O0ImVAsuZum/JjP5dYmBKOsSrizB@vger.kernel.org
X-Gm-Message-State: AFq9FYLF6nz8la2e2eyEFU98bk84l59tq/j56K8a6+oIAJBTRZw4alhQ
	hIP2rRmOtzVSnLgkegMzjX3vYAa/1u4ZH7c2ardFdXpWn4XN59x7W0AcXOSXAzx7Ebxq43EWlqU
	SsnY6RFZMRE+Df1TNaD80o6PAeLDdAJVysnCC925qecp3PyORUZ77rZtE1PzcJLtK52tsXxNlFP
	0GFQ0HSsyjqpGzt4o7r2bpKK2V6gbT8hOZjEJfYA==
X-Gm-Gg: AYBFou1YrxJzEbRMyxgwrk9saa1EzUcnuDrcls5zYE5P8qQwVeVkriunPNHWfJNpCbU
	/eLR/M0l/poHpu934I013kNy7mOiXSYpsWinKB6Ult9mVHp8PiTMeIQlIm3ivDuXx7Spdww7Uxo
	mGYJ9+z2e465O0sayk2UpqP6yVsx1Zh+ZckkH08uUtr7QnRqNVYC6P6DnTfd8/rpIxmbQZeuVOs
	wlEakzz8QvT5XPh0qqVX+wpumGgmqmhl6tIl8mJ
X-Received: by 2002:a05:6102:370c:b0:7a7:c789:881 with SMTP id ada2fe7eead31-7cb37281a29mr3959104137.6.1791974814508;
        Wed, 14 Oct 2026 03:46:54 -0700 (PDT)
X-Received: by 2002:a05:6102:370c:b0:7a7:c789:881 with SMTP id
 ada2fe7eead31-7cb37281a29mr3959100137.6.1791974813944; Wed, 14 Oct 2026
 03:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com>
 <b8c135bf-927e-454e-8bca-cbdbae133d51@huawei.com> <CAKPOu+_Msno=mux+FUc-oV1-ywRFujJcnKS2HNv0sjtRVtUP3A@mail.gmail.com>
In-Reply-To: <CAKPOu+_Msno=mux+FUc-oV1-ywRFujJcnKS2HNv0sjtRVtUP3A@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 14 Oct 2026 13:46:42 +0300
X-Gm-Features: AclHuK8FKbDFTguLGmZ45Nt-Pf5roM9971-VwqpKjaMzROf85V20p58VAm2pwos
Message-ID: <CAO8a2Sj2UbocxY+_MRdcH1TWht=UJT+ANWmzqLY9MQxZ0ujUpw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] ceph: don't unregister an MDS session before
 removing its caps
To: Max Kellermann <max.kellermann@ionos.com>
Cc: "chenyuxi (D)" <chenyuxi19@huawei.com>, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-kernel@vger.kernel.org, xiubo.li@clyso.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Since the last merge with main Linux the testing branch has grown by
upwards of 100 acked patches.
Xiubo acked your patch, which is good enough for me, Xiubo is back on
the maintainers list for ceph client.
I'll take another look at the discussion for fairness' sake.

Feel free to submit and argue for any other patches you feel are necessary.
If a patch solves a problem or adds needed functionality it will be
reviewed and applied as always.

On Wed, Oct 14, 2026 at 12:50=E2=80=AFPM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> On Wed, Oct 14, 2026 at 11:15=E2=80=AFAM chenyuxi (D) <chenyuxi19@huawei.=
com> wrote:
> > Do you have any plans to move this series forward?
> [...]
> > Is there anything still holding the series back that we could
> > help with?
>
> It was rejected by Alex Markuze, and he never replied to me after I
> questioned the two reviews. That's what's holding this back.
>
> As for my plans - I have more Ceph unpublished fixes in our internal
> Linux kernel fork, but I'm not submitting them, see
> https://lore.kernel.org/ceph-devel/CAKPOu+8SiwxT_44e63-EZ4T_4d-tGjwmk_Lx8=
i4KgZOL5JnMtQ@mail.gmail.com/
> for why.
> I just looked it up: the stack of Ceph patches in our fork has grown
> to 67 patches. They were either rejected or ignored. One of the
> rejected patches fixes a security vulnerability.
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

