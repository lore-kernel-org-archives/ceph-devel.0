Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C713E44E8
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349254; cv=none; b=OgEjasWKBnzuK/pwWyZm+8x9LZfcN1RvM0rrAqytqujRwH9TlW/HxzTR8uKjoRK9lWQneGrqf9twkIPmhrDtRQ4N+HI9WUxCLFwZMR4iTVCjJwopkpUHiiXm/xb+gLyMatBt245tef6lZQf1ZUnDu9jCq+3MPoJYg3cLlBfS3BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349254; c=relaxed/simple;
	bh=lCTPtFoxtcyLzZC5JIDhZpR9SAAGT/fE/e8C9bYONAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WMutbeKM3rjgNJEQtaiAkj5ty+TnJqPE7/KKI4JtgbeSUhtPqjBFyXgYCxt+n0NCXA+ou/C/gqAIkg1RO7TAdFwUdI72EpGcDyuT+Q9HthZQCBwyTKGvVJXkC7wwFiXF2mI16S5kJuwP/BOxHRM6hRH68nfHU8TQ0jnuvqh6zug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrfnutsN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gt4AQkUe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FrfnutsN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gt4AQkUe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783349251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
	b=FrfnutsN++Dcr4Sa8I3BeYCi/ZBGJkuQFpJhKubGMVcRHZusvFYfHkLCOR35FJJHg9joKb
	/mv7wxWCVXyNOGXWbA84NaA4E1MUwsKt9sR/r20czhxzo6+GsY5XfEFe3K5kDp8QaIKO+I
	zZVxc3nY6Ipthf1duOS+GdA/ml65j9w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-5UEW8U22NpipudtDwOOzSw-1; Mon, 06 Jul 2026 10:47:30 -0400
X-MC-Unique: 5UEW8U22NpipudtDwOOzSw-1
X-Mimecast-MFC-AGG-ID: 5UEW8U22NpipudtDwOOzSw_1783349250
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1d7886cdso64936501cf.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783349250; x=1783954050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=Gt4AQkUeNazxWWDvmM2jClBDV69q9JfKCL/VOiIS3K5sPDY8/p0TzrEVJ19d9Gd6oQ
         NlFwAR9PR5Lmeob3SPTfMakHpbkNrnY423gshG4X0m34Fw4abzWy677PmDiu1YD6uuoV
         RxWQmF3VxyuFObN7zKyy3vtdS86CgE8KOrZWm7M6IBVuyLM8iSmljsgBROEcFJpKn4Ic
         9OZZDy9mBIFJPYbwH/a9rKOgicbLP1jrt4GOdUVkOk29YX/uu4b5hzh1JeR7a7pJj1we
         1lCCPwjy5KzD/nebbfXedwSC+L28IWBdCyv2LyVbQ/3I0TgFI1Qf+IZcW7/vUSRHjQwR
         G8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783349250; x=1783954050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=NPUhjw+2w8b4ldufbEjFUzGhfqeyKzoq0PXs8rqibKM8W93A4UDEVxDE2lRI53nubm
         WkWbDDWfD2bWnDyl/GVSEFYL5zYMOiDHJo0XO2NAeH3spG3BFvPgIeX3YmppTzHpQXP9
         2oxBtfiwt22TY5k6THYjNgjoaGpNq6kMXSskbWC33lSEtzsP3X6E+unjPXv8QuC3wW95
         kXgxxC0UCNkpjfwO46dqDkpnFzHu7JXgXXKHbDEX5YpXCq91OXicwMF6dovvdcJVLP5N
         VtK/6TSIH8MVsCSIwXc0e6PNMhkarKIrXmmMUoJj99P8JrgpbxdUukIfkqJdyi0ZCCST
         Tf7Q==
X-Gm-Message-State: AOJu0YyNRM2q2b82h2GJQ4yxvhfu/pOOdhoU2UTjMxEmYwzI9u3PQg6W
	MtiWm21WYCCj1hf1a2MeM8AMyC96+c6ExtOM9Fzopz/tFM8xwU7GpzB1MdJklHIiFOaYs7igWuA
	4sAd6kYkQCIwnHldmSn1H+c6NJT0j74IxmlaWchYqX/voDhoM2tbPFCaVKo3IFIg=
X-Gm-Gg: AfdE7cmCK6s+N/V4arvQnIVLa0f4Sya0PyDPL7tBcveBRIJT+XoZiKGkoJRuvWZ5AQc
	d+NA6yATQCimacMunTSR4LFgH664CCW2d5/b6btPZpRC2D0NMsF5q/UIRdTZP8j+y9CREJrWx7T
	9eAeN+O1yue6w2l5RWfcjfzd8hPl/5l2f5hNTtkLLYiL/41fXmw/W4bQCbTRIF2BAJI1gDfjaFm
	9rer8U7S748VgKNCtMn3HczZScdBbmD0QRN5mXRbRWsAU2oo+iYkJO5w9SMOJarvz5UiRKFilVj
	QovaJyOGaAzhszsqF8FwjRmDuxf9UDcjmVStcIqRRBy+v9I0NemgFSU/lKADvbda6wXg4bpWd+g
	1ExAK/g+WuyTR0fqV9EeFN/KHsMRQCm8qCvc6iMbWf3O/
X-Received: by 2002:ac8:7dcf:0:b0:51b:1f2:f38a with SMTP id d75a77b69052e-51c748932a4mr10115041cf.49.1783349249832;
        Mon, 06 Jul 2026 07:47:29 -0700 (PDT)
X-Received: by 2002:ac8:7dcf:0:b0:51b:1f2:f38a with SMTP id d75a77b69052e-51c748932a4mr10114721cf.49.1783349249387;
        Mon, 06 Jul 2026 07:47:29 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2d727sm98380111cf.15.2026.07.06.07.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:47:29 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: fs/ceph/messenger: add separate lock for `out_queue`
Date: Mon,  6 Jul 2026 14:47:26 +0000
Message-Id: <20260706144726.1982347-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703193803.3689912-1-max.kellermann@ionos.com>
References: <20260703193803.3689912-1-max.kellermann@ionos.com>
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

