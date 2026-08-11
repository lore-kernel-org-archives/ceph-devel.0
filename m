Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BB13644B3
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460599; cv=none; b=Mc1XHHtF2/GBLYKOmq8AW69vfOcgskwYMGb+RHz9vHi9p20yG70I62GGglQLjAwrOmY5Vfhj0JFPRJkxySoRjJz93R6BaycPjecdiJeqobghGbQik8GjasAi02FPSyI+4TUklFwbwnUJOVWe76EccjIoabWSqf75GEkGEs7c+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460599; c=relaxed/simple;
	bh=lCTPtFoxtcyLzZC5JIDhZpR9SAAGT/fE/e8C9bYONAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KAJGE+U089EhM2o+6UwYiDhkFL9N04F7GB5pOLjahvUlSz7rQPE9vze4Gf/haXlDrR5ppbOo9QsYCszNnE3tAZmOd159stV3zYDIzRURee1PcdwKGCIzLkunn3GJ2pM5g6pBqcPB1qoA94w4+dhZ8/Dcgd7ppmaPGnFoxhUSSzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAeb9eAW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V2awNMZ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAeb9eAW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V2awNMZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786460597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
	b=FAeb9eAWhMh7MTvawQ7dxybez4i6nXsT9pJQk1ScqIAQWgaVHcuYsrXuli2BDPAwaVGGeA
	fgIQpegTMf0P7a7XDJ18aZ44wEf5EeJ+5XKNpjj6i48F+O/ZgsJiwBUDUbVYMNvV4GH2SI
	amgCKyPhzn9+pS0f3ZiNd5X1kUq05xI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-rFo1KkPYOw6-QwTvb3W7kA-1; Tue, 11 Aug 2026 11:03:16 -0400
X-MC-Unique: rFo1KkPYOw6-QwTvb3W7kA-1
X-Mimecast-MFC-AGG-ID: rFo1KkPYOw6-QwTvb3W7kA_1786460595
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a18e266026so3054225a12.3
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786460594; x=1787065394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=V2awNMZ2Ne5pfkjySFnSpWdY8Y2oZaoVaV8sfTMd7HskQkM9DKy0PrSWY3m6J+x3UJ
         WKmsap5/vWFFWuHSQYhNsRfNMVs/EooTBoOcbILy1s8qTW2jF3TuvAklWYUnwwpgB/bv
         usrYd5S6Rq0RAm6PKH5hpTUjQQdaUyfxcaUtVnBajR0S7Yv5gJXmy4CVsynt9jnTATyl
         Qh6Dayyp0YH7lCwZBzouxXm8IJeztaSMxxI5zsaY6M+O2EwILje9PFR6fpyzhOG/RxR4
         pwFnnYv1gjtsqDSs/ljMUPKwQtUWPn21/PbADp/amRk/kUOTroZktMIJUBQxGKwtXD51
         tgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786460594; x=1787065394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=rO+pL0qfpyQCImeNy24m8foZ3QHhiWKR98d7Mperemgn0zODXNHp5XXD/YrZBpC0ut
         tzUMjbnw2k0+E1lo7k5UxcrXqgwqMzGVpQWOeieNmvMC5b1qaW39XNWjS9TUERkvFZWZ
         mm14LQGR94cfYVPnkaUhHWH2WZpnEV5Jr7tGeiGuAonj9yYeBedkjgHUzVPxcdYS4i4s
         TDROj3tZMPp8XW8A6vpqG8Heo1zYr11Z3Ex1Bu7ogcm9YuP3RY9ZQCyaVxctYLeBKoD/
         gzGuy3mCbv3LCYMMcS4zNLZMzTVjsHkNrUX0D72L1QUpUQHWpyMDKx5wjsXkeIQhNJNQ
         WqWw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4KcdyfCRXirI4MSECPcSDj25lsNh70DBZdFZv64cSkfAcGjfE1qjCMnm7XeQ2S9Tmu1TNIgdy2WCy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6c7hT724AM0gj4Qb/loHSHkNJS+vvl+oyoSRGte+MdY7zGPn/
	CCB95ILN1OgvXdVx9O7FZqye1xBdPDjajFjxXW3D4VKHHEjH8WWrUugMKRkVbzJR6z/mhgGOAh4
	VztO+wRdatVQODjqB3dkx1GOkDA6ihtsWPbe2kyijYJy0EqhZr0UlfYAWnojeviI=
X-Gm-Gg: AR+sD11cj8UlKk9wph0A3C/wNj3m6s8Rt+leUJIln7u1v2uaMlv2zanl5GbAPhx0DNP
	TD3KfNbUHH9PdlT3LZIsPsLgBRqz+xwQtF79pLK61JBvKcxpEXqODT8AXbMqaOVvWC4klgcetkU
	zGDfGbnOcUgztiWbuAK7BGq2DlO9dKIYRHjsFxig4J/pghCAbJp7JWjQ8JRPwuGuHK/rfzNEeaH
	WwyqTTOeQoyPogAV3cKpXKbtxwzTKEWAZvCms1/s34dD7ztgwMXonTw4oi6ee83xT/5PV+WQhke
	insID163tzpfcsXb6DV+wjhbmCoU1faJLMakRv/kK0+8TUmejl5v6e5hAIDrwfCh50n1o7eawbt
	q+CXk3doTYytcceU9hYTTLZTb7NyKk6jucw==
X-Received: by 2002:a05:6402:505b:b0:6a1:f93c:f0a6 with SMTP id 4fb4d7f45d1cf-6a3644f15bemr2209545a12.12.1786460594051;
        Tue, 11 Aug 2026 08:03:14 -0700 (PDT)
X-Received: by 2002:a05:6402:505b:b0:6a1:f93c:f0a6 with SMTP id 4fb4d7f45d1cf-6a3644f15bemr2209483a12.12.1786460593375;
        Tue, 11 Aug 2026 08:03:13 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a362ec88f5sm766234a12.19.2026.08.11.08.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:03:12 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: net/ceph/messenger: add lockdep assertions
Date: Tue, 11 Aug 2026 15:03:11 +0000
Message-Id: <20260811150311.2708772-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709105114.901748-1-max.kellermann@ionos.com>
References: <20260709105114.901748-1-max.kellermann@ionos.com>
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

