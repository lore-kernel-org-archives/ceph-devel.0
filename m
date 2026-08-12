Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F60F317145
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 05:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514318; cv=pass; b=ieJdwUj1t/YoX4V4ZSnMLUDrN/2abeq1nODjezo5wB93DPGSgujafGEUPQ3kHsbMFHeNXzMKJkFdfAtx/Ji0dO8AyaRuZVjFOzKY31m+54uOvxfHm6L4uwtzSpH+Z0OjgIiszTRPAtk+xKGrNhjWTHH83b3flD8c0YyW7Nm5D4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514318; c=relaxed/simple;
	bh=psvVkcdFxHmT6g/J1OUO92i0N0siWrRzqlOMeSiNRrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=At3t+L7NtzemROCUSogeREiYr8bU2EmP4J79p+FyVTmDX9YtZj3DnOcqToT3bshYaaBEwUbzR5e42eQzbjbVw+mRF6Gwj/p6h/XwefVFO23bAOYMid3MY+AkzHkpRYaRlxQQT7XHOxlOmxqV9j7n+MxFzYxZMWK1Q+gNICwDJyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=Cxxuy/al; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="Cxxuy/al"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2055f5a993so59544466b.2
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 22:58:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786514312; cv=none;
        d=google.com; s=arc-20260327;
        b=MJ//Zf2u128vb+IPqXue8QNCWH1DF4ZhEMivfiL/KNvy1PFmplvVGP0kqG+yhXdEon
         qxcTeGi7M9M95bIMkDV94K1UT5j8uAGzgPrfMGqpV/kVTn6tzGEecAs01+7j0JL8ZZi1
         HS175r48WzMd0N2RafQsurzKr39NnqFEDf4EudaLHAOPltzJ1vqiTV0j+LtaIYD8Kd9v
         Vh8i4itTzn/5Bfb6uWCIFobBsEpctyxNiXughFzGkYzxNFMGvSn3I/I2aBg6EPnnSbfi
         WLRvojZ/KS3CBkKm8OdFn2XlW9sIoEeBw04Znnjhf+PhnGml37pfZk7Sw3WQ7EnXBSdN
         1b2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6ESe6ru+Imc1pBvhPRyXrkB8S1KKItKctErUabr12Ck=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=brJ1kuSRuPCBCMZdAo9mr7w+ItQ22VoErRJ0v1j3AZWKa8hIoYaby+ABDkGRdJ937P
         gMRkNXTmWgECSIyRJ9f3BNu2wCyrYcdcMW74eFPaFv/XERTnUHWzEHe7HjYAlPC10epX
         OITtWLkqEj476PPNi+cPEr/+6lrmMw/kApZJ7Id/mukVj042RuW34MA08HL0N1Yr0CKp
         5GblZHk5fjRLntTl6kBzLwpC7pENstnl2H7zBFuxSu10olWP1m1N+5DHUqg+ldQJPXFT
         vhaKPn9Ih8I/mDqislTHM+fraIPKXuvk2cgJACp6kFZTqp9xvIZyV4oMp78K2ovnz9Sl
         LdGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1786514312; x=1787119112; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ESe6ru+Imc1pBvhPRyXrkB8S1KKItKctErUabr12Ck=;
        b=Cxxuy/al1G3RCszNFx2UiYEQQBgKNqN7LW3e0EWi/wfoBhmOSYipAorxYzClr0vnmY
         z786NZ7QyXk7EAxEu7jf+/J7D5YZ/gKvzDoizOEvzL6nt3iQc8upPrqq6aITT5VkhJTC
         of4aOdv0sNmM8JCNwzYQTihHCpDLS0Cn4e3+Yiu9LvUJZVWUiLsUGpp2SwlV31TY2v2Z
         580TxGU4CSpL1h7siAK9hijZepb8vD2CYOxvJgDjKSMawl8nrDFj4xCzpZnusAnSDtvi
         9RFkjgiE9z28gxC3bzeekXGXNpJh2iLw/R3rr1MbC167dLKcxm0W0iQCAbDlq4CC+TOp
         Oypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786514312; x=1787119112;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6ESe6ru+Imc1pBvhPRyXrkB8S1KKItKctErUabr12Ck=;
        b=lQEoVbceh8bF7fPEC89FMhcObrfI8Yqtqb6bE9YHjtAmqJJtizlnNk6ub9+ZrOlyIs
         /exlgg5EaYeO/7lhDUTKFKBUOg3gk7CxQtzplHvPcbItW/WtjJggmrJ5LrgU2MawMEfv
         myUiFY+dX08uzd4DjH1Mv+XFa3BtFHTLFqmf7+YQZPYfZtQc9WQodWiubTBVWo8vbhw2
         6pL2FSVjXks1IPNmGCTfYOYvXK2tqwusMzSHdhD/y07Vco6VwfE39hx45P4CF/VLz1Ja
         zk8HPFoY+UJDQSKi3ESYv+IB1agdiHRMYaYxAS1sTsZU2FWdDMqax3umKXxbHwmdhV6Q
         7Wgg==
X-Gm-Message-State: AOJu0Yx8kVk/qia8n+JU87QVPzlyH8Y+6FvcQniYuCl889vCgUmxhEf6
	MSWsCM6d4g87FX9tFBhJrggh4488SFbarnJA1D7wlN3+OodX7fVdsTCvrrKYZQoTUksJNjLYAs1
	uetcvxKnNHTCJuOf0AdxsFryXC/4Ubh2DN/WoLv1DWg==
X-Gm-Gg: AR+sD11VKbvVekI1HKKkn3cWV4Mok72AmPHwnFbjR9yiMpjPzpQCAcqYQ1ePnvP+74u
	IbOl+JTBldaon90h42RVQm1eLzrArLXCYtC3nKkOvBtUOH0gtcPeo62YrMZeMAMsArprPDgLcUa
	eurfod2BhjCa9nFJ3zNh2BfRb21tuv6L9lgV4tw++KLbeXSUk23xLycuGoc0QXTVoqSubhVrs1p
	qqS99rUjmqOvyLp02BPtRv5F538jBhBQ8eoIWxFr3FigsQGQJAvKX5hdbagjNFWSa1Zk1PEqL0p
	jgJ6Fm83+smCZNnvumGk4+ixrLo2gGEB6thsOpmK+D1dDQ==
X-Received: by 2002:a17:907:c386:b0:c16:8adf:f183 with SMTP id
 a640c23a62f3a-c20f2f0a7a6mr111488866b.14.1786514312592; Tue, 11 Aug 2026
 22:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811-ceph-mdsc-mutex-optimization-v3-4-d031114419f4@clyso.com>
 <20260811134309.2689490-1-amarkuze@redhat.com>
In-Reply-To: <20260811134309.2689490-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 12 Aug 2026 13:58:21 +0800
X-Gm-Features: AUfX_mwA2VKU4vO2K8-MUNj7aC-BnpZP3824kU5zYqS2duNL-Yj2ubhhk-BXHZc
Message-ID: <CAOJNxRJkJoSi-8FfV-o69ccCxMP+s=+ZwA42W_LX696CUZAK5Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] ceph: move mdsc->mutex into __do_request()
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Thanks for pointing this out. Yeah you are right. Let me fix it.

- Xiubo Li

On Tue, 11 Aug 2026 at 06:43, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> Two issues with this patch:
>
> 1) kick_requests() list corruption
>
>    Requests are collected onto a local kick_list via r_wait, then
>    __do_request() is called for each entry. If __do_request() puts the
>    request back on waiting_for_map or s_waiting (no mdsmap, session not
>    open yet), it does list_add(&req->r_wait, ...) while r_wait is still
>    linked on kick_list. The subsequent list_del_init(&req->r_wait) in the
>    kick loop then removes from the wait list instead of kick_list,
>    corrupting the wait list and orphaning the request.
>
>    Moving the list_del_init(&req->r_wait) before the __do_request() call
>    should fix it.
>
> 2) Double dispatch window via r_attempts
>
>    __do_request() publishes r_session and drops the mutex before
>    __prepare_send_request() increments r_attempts (which happens inside
>    __send_request). A concurrent kick_requests() can see r_attempts == 0
>    during that window and collect the same request for a second dispatch.
>
>    Bumping r_attempts or setting a dispatch-in-progress flag under the
>    mutex before entering the unlocked send path would close this.
>
> --
> Alex Markuze
>
