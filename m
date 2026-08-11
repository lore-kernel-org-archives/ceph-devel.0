Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3FB2F7EF3
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413500; cv=pass; b=iWb00q4PXl3P8PhURs+h5f0R/2qc8Ubw2jVfz+9Rn5f7/vW5zLQLF0PVhBcualB5yxaCAxhthGbxPxknG3t/VI6mwc3ADKRwmjL3y0snRhD+NojLBBib3HfZ3t3KfrZkTZCU1xeAqCtXrzcxpe0tFUJv7058rVNRiT4yGj9YzsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413500; c=relaxed/simple;
	bh=/Nc0L85uX8CiU0Hst8uyFALvjoyELNKfyeTTS3WxcD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4o8xokHZL+61dZLMLOyGMvLNs61U3qGLsDmQYAjAfETpvBTnOeGHz/ABdyRUS30uXrcd7X4OWla1VNuWVSMJDmV2TqkrMSZafER83OQrhJTt1F/cmSJ9h+104iTBFWJWqpbxALZEhpGzlMfUgrz5Dr5qWCj8svEBDHU8neUYBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=IpaNRhRw; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="IpaNRhRw"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a051904222so467703a12.2
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 18:58:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786413496; cv=none;
        d=google.com; s=arc-20260327;
        b=reYdN21PtQG5t4vKYGlFzLQhFTSkNrZ6oFkvBAhDmPHc+wKrUxBiLpIKo+lHn8QuzV
         brQcJS9iPYCyYk26Xmct9ilVE01/REdHPY/cyVobpH91dNBVriKB75BIIGrJFmURbhHp
         SycglPDf3bzGOzts+TVxntfXtjp2lpUOkNzW+mfRlSJIMbSKgh8mxESO1JM8Xt2Uj8OT
         NrPs4jfJZr03Yh4o3GvO8BuzAHdPT9liYCbsJUH+8V5q800k4+FDj5EXshDf8f1uk4iE
         su/XfKp+hgylT8WhFvqKoFxyo5Av+ZnQ5xHRbjjpFINYJkFKgTlLyTqPgPMzfek964VO
         CQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Nc0L85uX8CiU0Hst8uyFALvjoyELNKfyeTTS3WxcD8=;
        fh=lIj2fP9TLY8J0+u4Z5gxpYmcsDjYZerPZxdPGefRbRM=;
        b=aS9CPww776IBkH8YzcCFzUdJDUwLve16gARMuK5xuIwepqyFmxcmScUUOgvdwiXa9L
         qqP6fbhT8DcUVMfjfJwg1FLFk4Wa2uZQhNP4W/Mv+GhPIac/8+jJo/yXkprbzf04LObN
         /VVbVAlxFM6qWEUef6sOi7aK2D7ckg9Ls134pidJg43NAaHhoo6iwvPHo+Pr7Kjaduyo
         IZYDKia/OdLZ7SAcpKrqYUZof7fgk/ZiW9hivKNiLkvNcOZZ/JnIj6YXFGk59kKCZiyz
         Qy+dIfPBOGr/zi3kSIyTPRk4EXm//MdP70/wd+HDVXxxGY1p+ReluPngGKbIldBbeP50
         BVKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1786413496; x=1787018296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Nc0L85uX8CiU0Hst8uyFALvjoyELNKfyeTTS3WxcD8=;
        b=IpaNRhRwevTJmBEhbJcLU5bxTl1Fz9ukG/4jXj8mK4Fu7z3Mmojk/hf+/AYGx6JngP
         t0AaTpYUWNTNr9YEzuMOL9vxsoamJnIXV2+ch8sgE+eq42yMWA9PYPrEb59n6QToVsvp
         I6/e7klMxJZrUO9a1TQDpK0wC9MsHYxjZl+GarHHmGRwGeokeCTJpRXKMAgvqS1IH/ms
         csrfxyBd8kFC2Sodk0SHw+6jDOjoauaVshkKrpTABF3D15KeQfiMDaSqPwP9fWdqbaNH
         mPq2eNDnnLbM64gtzX8mt71MpSaJajCMH/RXaUkK49KK7UvjRX+7d1FnlPu0o6cA4Mrd
         dQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786413496; x=1787018296;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Nc0L85uX8CiU0Hst8uyFALvjoyELNKfyeTTS3WxcD8=;
        b=iTsnPdQkZKHdxo6QQzRTDwKEceiZnbM7vSEa0h/Sl6YLADuyYXVQEfmzhbDZtk5C8g
         YI0Q4n7gA26JbCBRkr/nRw0C6iNxPySP+X4/vTLwpvnyP+ZjWIFY6ZwmIGy4Dvqs1dOr
         mqNlSZYGrq64w7PfJTDk9ouvtXUmRHjPkqIvYStzDFjtw6WWrH4icr3QXSdx0O6BHN7G
         pVtvtTxoTiKJmV8xSEp0Wuq8I0SQ+HxSHlK+Qrp8agy180bYFq70Uz1AeTKCA4tm1siA
         lhhdjyWMY+hWeOSjNiyigwJEzNH1YHxrybtYNNg0j6OdnJdkTtOr5bFON/DeXNPmLVRW
         /4OA==
X-Gm-Message-State: AOJu0Yx1cx+mkcTKCtpDxAsu6sFFcJ0aHtouAN72RwplLY/SM2xwAFpF
	Ad+E5TRX+wQoPjUkt6iEv2q7tpf7Z2C9cwGZQAqALzFOb3xVHPYywO5fn1o2ke9ICr7yqM5Pw7c
	Pg4F64qI9AlB/eYBaOG6UHNVpnbcqqyne0Wl8wXkXqA==
X-Gm-Gg: AR+sD10t+OhlQFwGNkBOTnZQTOe0H4uI/PssolR2F7KMo5T5jLOLyeq15e+yP4oIeJi
	OQuKb7tF0hKKlo79++cpe/Jd60Rpg6sEIAPJUDXwYcbYwUcwKv+uKuwqOvPdYKLSmdgBQAl0zlz
	AFMtL5g6bnf3QpMZKoqse3nppFGtTcWt63HF05vxzIbOWZll35ka5ZWNFugz1TSSTjzhqQuOTD4
	DOM62Tr9b2bHMkKst9EGM01mW5jpfotyesLTXrQX7qW7nA8YB8fnwsGQ7Ysg6Jb9Ce5+2dMIOZl
	zwibl1uvpIw5O/Bij2LzTv0XA+1cDXj5rSdK+caJ39ydbnMh6Z2M0ZaS6Q==
X-Received: by 2002:a17:907:ea8b:b0:c16:126b:98b4 with SMTP id
 a640c23a62f3a-c2039c03283mr2338161966b.3.1786413495759; Mon, 10 Aug 2026
 18:58:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOJNxR+9tBWfnQ3-wyBdYeJ-ipVM+0oyULtUGk15C5-xnXHqcg@mail.gmail.com>
In-Reply-To: <CAOJNxR+9tBWfnQ3-wyBdYeJ-ipVM+0oyULtUGk15C5-xnXHqcg@mail.gmail.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 11 Aug 2026 09:58:04 +0800
X-Gm-Features: AUfX_myD6jBq2H_PKGnq5y8ycO-8JTaqXFBlOO1F8ByH7mAYawanFCsS4G9oiOg
Message-ID: <CAOJNxR+XiUxR1GNUgd8T18x2KH8kstWtpxwL-mwwE0i_qospJA@mail.gmail.com>
Subject: Re: Survey: Is anyone using 32-bit builds of the CephFS kernel client?
To: ceph-users@ceph.io
Cc: ceph-devel@vger.kernel.org, dev@ceph.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

Thanks for the feedback.

So far, I have received several replies regarding the 32-bit CephFS
kernel client usage. Based on the responses, there do not appear to be
any active users of 32-bit builds, and I have not received any
objections to moving forward with a 64-bit-only implementation.

Therefore, I will continue working on the patch to remove 32-bit
support and proceed with the 64-bit-only approach.

I will make sure the change is properly documented, including the
deprecation/removal of 32-bit support in the relevant release notes.

Thanks again for the feedback and discussion.

Best regards,
Xiubo

On Thu, 16 Jul 2026 at 16:53, Xiubo Li <xiubo.li@clyso.com> wrote:
>
> Hi everyone,
>
> We are considering a performance improvement for the CephFS kernel
> client (kclient) that would be significantly simpler and cleaner to
> implement as 64-bit-only. Supporting 32-bit in this case adds
> non-trivial complexity and ongoing maintenance burden, so we'd like to
> understand whether continuing 32-bit support is still necessary.
>
> Before making any decision, we want to hear from the community:
>
> - Are you currently using, or planning to use, 32-bit (arm/armhf,
> i386/i686) builds of the CephFS kernel client?
> - If yes, is this for production workloads? Or legacy/testing purposes?
> - What is your platform (distribution, kernel version, architecture)?
>
> If there are no active 32-bit users, we would proceed with a
> 64-bit-only implementation and clearly document the deprecation in the
> release notes with appropriate warnings.
>
> If 32-bit support is still needed, we will explore alternative
> approaches =E2=80=94 for example, keeping the current code path for 32-bi=
t
> while the new fast path is 64-bit-only, or finding a way to cleanly
> abstract the difference.
>
> Please reply by August 6, 2026 so we can factor your feedback into the pl=
an.
>
> Thanks!
> Xiubo Li
