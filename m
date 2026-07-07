Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90BB229B38
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416417; cv=none; b=vGNLBeZ7IFyiDdW53hVnEZagCpSSEv0s3mpxzlGoNmC/1VvlBZGOUjtnVtom59C9NLDO+xxD66u6Bqc4/9e0MOAr+/iYUJj9HMcpndbiutVF69fmoOwRbyQvv2g/5i2zM3fABaMvChN5lN64RM710JNm0ScQpOu21VAfH5UivoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416417; c=relaxed/simple;
	bh=lCTPtFoxtcyLzZC5JIDhZpR9SAAGT/fE/e8C9bYONAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tnSTpku1tOiB6t8LskUuQVXCzJTODfoAhNbfxf5fr2NDH72/jd3mnAIeOzawcGbAJvXwJlrPhPvp6hXKx1/F0DY3yl3JrBCK/iaGEm8RZpUyOSXGqrUOF7EzlkhzuHxplijly8h6S/CwCgqeiUAUECp7Mu62anysZ6fHetER9gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WZ8Jbax7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mxrNmqf2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZ8Jbax7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mxrNmqf2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783416414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
	b=WZ8Jbax7vcDbEZs7mdPqRXbsG6hmBTo5lWibyupFt2BNf2hPm3q6XAiH2Dq1x1zmCVtakL
	WdtEvlTvSk39JdWXSAa1k6BT18Dya1J7wv9Ju+gGzP6xpJs5azDWpQEMY7h6KkmctsEEra
	ww6Ud7nkmiZMmD6VguVNhuBMFPPGLWs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-PcIMsUFtMg255egjX3PRpA-1; Tue, 07 Jul 2026 05:26:53 -0400
X-MC-Unique: PcIMsUFtMg255egjX3PRpA-1
X-Mimecast-MFC-AGG-ID: PcIMsUFtMg255egjX3PRpA_1783416413
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-69845e41e68so3503877a12.3
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 02:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783416412; x=1784021212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=mxrNmqf2ICOi5dQ8azbd1uRiXOUb/4HCpchYkm6hRn/aKFDh7BHVTZ65cbgtIcKZTm
         p4hdKX3j6oOrp+N0CxTigGItBHobDe2saxnCTVmlmplcaiehmXaUpissyMYllYY6eZRc
         948Kr02Ptwy9hMggSq/izUcLRM9/Z30qg6tuMsDonAzRJY0HbvaLQPKwezRXVZAE6HCh
         QqhcLABJAwIrd9p1HIgYZ5vmqhO44I2DajdCTDB6+YdzPVVR7xQ9swh8gIDdS3ZJPK9j
         Yl4RKWJN8uh8kPytSzZSGfFHOv4IRxTmYv1f5RbWrnVtxe6HqfJ/8FfvUkyvXcs5e3sa
         VEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416412; x=1784021212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=QxoUgLZEHUH70lMGaRPEaIVRhUq2+ZhaKvhg6L5cCiZUEk2aShsRlHE/wH69rT1TM0
         ezK77TSEW9asFvxZp5CmmZTG0JyoKPQzJPVHV9dt55xyOkLJBgSnu5tFxbepm65gLhNl
         8dVXBlhuU4dIqHU7oogdJgVsVbGsVfjXUTwEPTOhF4Twa7ehLaW9qJy9BmKb2UEZq8c5
         rN2XkQnIv+sbePoca9Zy4VD7CI+KfgAy5e5RzmUKADq29qsy0TpE77gU79I7JaO7OFa7
         8u5WSbydaelCU+ByqS7rSKsbuRQCU00ZWmUxPaqfB7Olectt4Buhd2dQicCMWvWetyd6
         6AtQ==
X-Gm-Message-State: AOJu0YzpJH1kTq+/gM7PEL53w72oq+MipNic3X9y4agHITQkHFm/MRWu
	QMt5hRmjPwe3NrToHfolJGcy11molyOgMnkwzh8XReQgLvtW1Ys0JOYuleKzQXm9o4VTFCbZwns
	tArjhddi586BOG9P1QusDzPwAHwKKArFHby3EoSPU15CsrWGKwnp8NvLErKqSskw=
X-Gm-Gg: AfdE7cnrjE+EBCG8xeymDc6+tD2GBbooqOYc4U0xUHVcxvzHYwC4ENbL3sZT/4Y2GVH
	ZgvWogpKWsQP0JN7ymp1kDG5G7xRXbF2LpJmdW0JkJBNPvdN5TnSW63U0g5xaeeUbx4ngKRRCs3
	NEQXerH5uafCJn2qIAhH14QMcM3knddkpNgulTN1C//+RcNefexvcM9fXxaNj9Q8SYDGsgRShGm
	LkzeH4LAaIBA+Nb29p+l1i4N+q7Ul3xZgINV+flFXVoVaq+tl3tBagZseM68BmRfMO2h/zHcuGL
	CgEnD/QdBANGFO64j3aPRk8xrI0xLqt3v8pf/DCiquNjfOvIGDfc+xoMgCyhZ3tCmWPVGFjxT+5
	TE2+ojVeFvJXbSI3uRZfo34oagI+IUu1AQ2CCdRMyJbBa
X-Received: by 2002:a05:6402:51c6:b0:698:b81b:74c4 with SMTP id 4fb4d7f45d1cf-69a85bf7e5amr2456731a12.35.1783416412579;
        Tue, 07 Jul 2026 02:26:52 -0700 (PDT)
X-Received: by 2002:a05:6402:51c6:b0:698:b81b:74c4 with SMTP id 4fb4d7f45d1cf-69a85bf7e5amr2456719a12.35.1783416412124;
        Tue, 07 Jul 2026 02:26:52 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19daa799sm5253806a12.23.2026.07.07.02.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:26:51 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: max.kellermann@ionos.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2] ceph: fix hanging __ceph_get_caps() with stale `mds_wanted`
Date: Tue,  7 Jul 2026 09:26:50 +0000
Message-Id: <20260707092650.2187886-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706150659.3993925-1-max.kellermann@ionos.com>
References: <20260706150659.3993925-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

