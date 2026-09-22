Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4445453A3BB
	for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075736; cv=none; b=kFRmzPB9cB9l0zkkH4/pf1JTwx1enc6IUVvYB/yM8VtmERt/CcRDT5+11FQpdCoVA016jEpiJkRmvi+TmZIk7Yc1Om+Bg9tX4pBibfgc1xCSwIzQdag4HHAqgpumIm/5JvCmgvTbFRCceLXqnJfYvkVZdZxjmHMACjd9haSql4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075736; c=relaxed/simple;
	bh=lCTPtFoxtcyLzZC5JIDhZpR9SAAGT/fE/e8C9bYONAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QHapjS7+WbBOfK9BaJ8t/C2TlaGVhHVef4u6o+Q9nWsjnXgaypIsa9wdMJN3IAhb4OCXCO6vuff+PxIFw1bocY+F0n5nH/mttfZRicagcEPAnaNe84H2kA3n8kpe7gHOIitjHqzGqOLg0NTLRHBNRtEJi1G/7b6PU761T/DhenY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGUCMkyo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DXtdrlM7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGUCMkyo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXtdrlM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790075734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
	b=RGUCMkyoiMnLglUzKeAoQ4U6WpzMav/VCzJphauSzZRYJocKY+dA8M0K142uWt5R2V0F60
	kt2fuTXuGsEOtpDZXN9YpVtBH5HVaiWIsclA2WWz2EHUTQWF1n2DJliKKd3CEiXSLTyNwV
	cSIsFdvDgHjoQ5EOqn/AWmkAjUdrUm0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-HbdTvwYqOIyK9uMbc1iqEQ-1; Tue, 22 Sep 2026 07:15:32 -0400
X-MC-Unique: HbdTvwYqOIyK9uMbc1iqEQ-1
X-Mimecast-MFC-AGG-ID: HbdTvwYqOIyK9uMbc1iqEQ_1790075732
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9124b265371so84064636d6.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2026 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790075732; x=1790680532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=DXtdrlM7tiAW5CNvV3gcWUlvy6tYGuTRn2YGMm4wJmmJ0DUgjGSFngOOo1txwJbddP
         98TGjIhg+Xa9sWOcsVAe255PmWl8lCck/WRlSkXw2hIf9rcvpTnntGi8GLsScD4O6e7V
         1CTLBetBmkR0kOWM8jl4XGUf+0yPo8xEdcf43ukzkS5iCgOWmasgZ1YYFAqGPQeiybsw
         KspicUUN2sxShLT9jrOAHci7bHw4zGBjbY1qjY5XSkZX10i+F04h8vPiCLw1ZCP2BVzM
         064hWcw2/9tDq8QXI8bOZA8qQtQRDRRnsdv7AbAbMlBYG6pVlxb/cEQN6+VF+888YTro
         LA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075732; x=1790680532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=zTskdvgJEUl7AKM5RdqGZl7ols0nwk9HB63qUYJBWkZTDoZgFEUWJE/arVh+Kx1DyI
         vO1OXxgdXeU8CdGKIGrn/U6O8MQvImidklxVHlUB+wct9H7UsTsoi9aSOWx8mnVqF+ut
         St+U2ytLBLKvrMc7RAAXZO7l4AkJuas0/RZFEdLGHaV1XJJc27/goieuKjyyOAE6j+9Y
         2JMhEmCGYUfYm6ETFKG8FZG8KmChRFKAb+clK0l++3cCPaMMCHJVWGAxVZgSFV7j3ytx
         fYUm0nn4V5YB8Pu98jIzzTgCb3GtJbQ9mtBc7nfAACDWz2opv6nb5RkcerRjLBs2E0+j
         twzg==
X-Forwarded-Encrypted: i=1; AKwUvBwaQO22Xw1vVjxHZUacY/YEHmmRM2AfQOzCoaiAyVvLep6WRWHUKOZ4kT2SpLsYqBdSua0DQfc6kN2Y@vger.kernel.org
X-Gm-Message-State: AFuF++mqi27PLbTkz/bRGm2C/qz6GYKD6pTSZjhCk4wXzv860tuUx7nv
	G6hlRBwpDR/3EFiIg7l1QqGCJQxDPDOSqZGHDmqc0oRSUKqWLnKE6WZviLOUnz4XseV/L69Shyo
	SEgfbUh34xeWgNQA8li+zQK3H0VGkE8uyT27Hb1aD07ZfRnGoUe//iwG2YU7FLxc=
X-Gm-Gg: AYBFou3Y0IYu5inVupJBgoRL3DIaaaISHjKgHRBiUzbeAw+oMAqpPQVsWE/DrAX6z7N
	AUqgDX7CnPjOuJ1CTP0mCjlFiRVZJNsbiFpqhzExQ3KfasDsVO89PDYvQy9mIcKCRlge/tITsQC
	H7LYqaWT1FZt84Wg1njATkl6CzIz2nPmAMI/1wdOcDDmFUVRU/2xNrpiu/BGz5iWv5AOYCfCrs7
	uXpUmiAJP1grQa3QVMjgCtp98Jsp1p65iUo3aBgD68diVArb7qj5rT2j7rlLs/w5iXTMJ8XWGcr
	t9CL4zC5TS02pHIJOePIA4bFqmjAFn3sodFAJF0JLehjXSJh5F6cC3pGQecM6VcAyQDAEtcpLmk
	44J6oZ5UGjjJJ8G7/p0NkFKGYuXlsSYSiuqs0uLQQv/fXl/FYcwW4JAjgIo9AmV8NvpF90fAg/+
	BBqaNIxsviibjHag==
X-Received: by 2002:a05:6214:428d:b0:912:517b:40e1 with SMTP id 6a1803df08f44-914008cfcf0mr33622156d6.40.1790075732104;
        Tue, 22 Sep 2026 04:15:32 -0700 (PDT)
X-Received: by 2002:a05:6214:428d:b0:912:517b:40e1 with SMTP id 6a1803df08f44-914008cfcf0mr33621596d6.40.1790075731505;
        Tue, 22 Sep 2026 04:15:31 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-914024ed0d6sm13269176d6.30.2026.09.22.04.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:15:31 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	ceph-devel@vger.kernel.org
Subject: Re: net/ceph/messenger: print TCP connect error
Date: Tue, 22 Sep 2026 11:15:29 +0000
Message-Id: <20260922111529.767406-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910123951.1241279-1-max.kellermann@ionos.com>
References: <20260910123951.1241279-1-max.kellermann@ionos.com>
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

