Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795549778;
	b=M/SlspN+kjoluCg2in9rD2NyiPbXBCoh3SmY/1nDM6rrcFGLOOfJrAIJezFMHH9C0DbU
	 aI+2GOnRZRKhgRAuVlzdK2L37baXjC7EQaAgLpdWQgj+Wt8g0l8ta7bbymNZ0p+ihDOO+
	 NU0DABOBOLYKbjUWnEyb/RwmyWkzoot8n47vJxpfeZ8qyu4aaV6aM99tTnHzlAzd0qWZl
	 JErP1/bprbPB/j/ARr1pxgVggOyGzrXPLenpNAPNkYqy/BLLjzIfz+c+CcmTW0y5m9Z5+
	 De4A07OtXLZbC5P2rVkmClGmCQ3x7fhsV6rvfdpo2dOupg77Su59a9cITnnlOioqS+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795549778;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:X-Google-Original-Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID;
	bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
	b=RppnQKektVba0VXGHQYb3+H045kzFe7ey9ecU+4N0MlAKN5Vg9zQhb/DdBL3PyrWoVZc
	 6TVYbK1Cu4YdmscpYhO2d9h1eUXrBId7Nn5+PDsqCMpn4jqRMr2PaFyRIADSUuPSxL7Cm
	 PnTM8MoLP870XItx+FD3nODHzMAT1GEAgVQkl1Y1RVRuyjFK6Ov/+3O/X7A4yiDR2bqyJ
	 +cOwe+sAb3xAnp3AumYYNkE+2X8b3aQJ2ZfWy6m8A2Ll6ZOnK2JZPjKi/8LH6WZhBe2l3
	 gsnXm946OQjLxnjQqTHH/w7k+HGP/JUvJPFevXMnqK5nRjJMJxPCxpKrqW4bv02Ps6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aDmM7zLc;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HLlPW7Xm;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EB9606A321
	for <ceph-devel@vger.kernel.org>; Tue, 24 Nov 2026 19:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38EB9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aDmM7zLc;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HLlPW7Xm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795549776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
	b=aDmM7zLceHw+Pv3PbnMhdPLM1MasbGoSN8LucQ3XgUPA5HVq2kngUH3m2mFilUsIHMFg+3
	YSntORcqzeCLZnkxQefW85pvUecwFehDYAfZ2gv+srXYBV1596F8ZK7zEyt2liXNzfoZKT
	brMsqZu9AJiJCLmItLcwU/IwE3XOQRM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-hd9NU_TrPIu1Dbrr3jZWzw-1; Tue, 24 Nov 2026 19:49:34 +0000
X-MC-Unique: hd9NU_TrPIu1Dbrr3jZWzw-1
X-Mimecast-MFC-AGG-ID: hd9NU_TrPIu1Dbrr3jZWzw_1795549773
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c506f007ae2so478084066b.1
        for <ceph-devel@vger.kernel.org>; Tue, 24 Nov 2026 11:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795549773; x=1796154573; darn=vger.kernel.org;
        h=message-id:references:in-reply-to:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=HLlPW7XmMZL3h5Zr9AQeASMCWvRDdPL1MSCDxvE4aNU84lN1cPZwjW+Zf3w6Vufa3E
         Mjj3CKumVDVzI3QKMmnQf2KfAIZ87NZrsIEOdgiMjgePBcCwBmbB6uWPul9bKhkH4QNQ
         SDLP9Utq9WTYiN3OGK0x+ispB6ShbleAaw+z+EM7OH7CvdCRD1KLiWwF5pZSA7GoI7uX
         J6ToIXnPopGzeM7diwpgt3/KMZXrhguMYX9ofW44yuFsGpxJt6iLj+MaMXMZkkSvZTTj
         wYnW2kzKAWTzBpvGgHxcznTQMHEGpJaNBAgf+GzbvHh38chlUYuzY6iQCQqcUYyF9/XR
         +dVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795549773; x=1796154573;
        h=message-id:references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=xJ+lh35W74Qmfqa5U888tHcO8Q9mPA9c75MkZZRxHnNZ0eZAFX1ThP7YDOEJmZvLm1
         ecc8jX4z3jJMkbjDBzJVvdsLLcPmSvWm8f2G2STW1DZL9gkuikxhqcVgOX5YW7eqFUIS
         9ySW7HLDwj1sgKUm5dFcHje6+HhmSploYT/FOvgu614wjF7gXS0aRUNEuJqel42SYFFv
         5h2BsqBeyAmD44rzSASku3a+icPwwJo5HpqKDfSvSgrxsxMuP4GIgoiPt6q4/SJMpFSb
         FZPVs4iVUxzwGrgaNloZ6gK63+AUEm5jEPKWoxGqTTgC0dRlOzHKiHepE2hqMzO4+CCC
         v1NQ==
X-Forwarded-Encrypted: i=1; AL+hErHvObOtgyob2O7ocdWbMnMTAxKmD7lyFTlzzmbHOk6d37+2DgAGaLu21emZ7E2URuh5GPgdqPSwkQDA@vger.kernel.org
X-Gm-Message-State: APuU4Z9urqdQezaYGPqnK3c7GY3DP3rdGU7yacelBZBvUyKi+B2QQnDG
	hVttciUrEJLrJWMl7o1t+is9WjiiZ0/SsMWOmTnlRDII/PozzA4hFgzhENVJAIIyERvsLLOyPeS
	Gm4Luu9/AJ3ZMbwXGKbLHg87mkyBliQqkCLz66TnYaLNetcW11rpvdfJhIopgFZc=
X-Gm-Gg: AZFdTZfbydofADeOdI9qT5xrO9le6Szu2wwrxffQiVCh8ujdQIJntjI+7CCglElJqY0
	6VXcVTG4OqS4SFwoTduqYwiesHyXJvGqS8hWV0rtOoVdT+dsmHHZcje+Ta+U0RSvKqQKg/c8W2H
	aocbjYSP4/q40lrMhuR/4MW3RBc4DdE4MMAvCUzp8GklgXpJCg8n/TuTAqlWIcn2TavLMJMQdYs
	bIbkFNwMvloZA/ptXdi19guETTLAN++velpbmsImhfMlWcoaDjM/I8aMAbKvwn0u924LOdB8lcC
	iAmVxBB5F9LL6l6mFDjvZPGO5aNwf+pC6sfdQx1en5fz0BiOFIc4aLxuSBMB2vbuO4DcZo54R9c
	hBl85fLHxQMlNBow0jIerxdnXFcX3P96KnDxqHS194C/cUfa3dMjkvZPUUXXVUTCXghixn9xsDc
	vKEKRaLE1Shxrx1FAtP7DI/J1nrur1IQAqd48VoW5lL4RIwOrsye49/TTPg5Af5/zjr+4HiZ6tE
	SCZp/FTGUKLvKvabOdChRgMhUKo5WeZlT9Yxjpsi5bMuOoUY2qq03M=
X-Received: by 2002:a17:906:9555:b0:c50:52b5:e17 with SMTP id a640c23a62f3a-c513a5e1d53mr1092678166b.13.1795549773461;
        Tue, 24 Nov 2026 11:49:33 -0800 (PST)
X-Received: by 2002:a17:906:9555:b0:c50:52b5:e17 with SMTP id a640c23a62f3a-c513a5e1d53mr1092677366b.13.1795549773126;
        Tue, 24 Nov 2026 11:49:33 -0800 (PST)
Received: from [10.251.64.7] (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513acfeda1sm582835566b.6.2026.11.24.11.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:49:32 -0800 (PST)
Date: Tue, 24 Nov 2026 11:49:32 -0800 (PST)
X-Google-Original-Date: Tue, 24 Nov 2026 19:49:21 GMT
From: Alex Markuze <amarkuze@redhat.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>,
    Ilya Dryomov <idryomov@gmail.com>
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>,
    Jens Axboe <axboe@kernel.dk>,
    ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2] rbd: Fail rbd read request on overlarge result codes
In-Reply-To: <20261124171329.387727-1-raphael.zimmer@tu-ilmenau.de>
References: <20261124171329.387727-1-raphael.zimmer@tu-ilmenau.de>
Message-ID: <179554976192.2581833.4790922156703763995@redhat.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list

Hi Raphael,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

