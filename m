Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF0367F31
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 09:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416317; cv=none; b=q4WUxMbeyGNHtk4U/8cqJZKIC7/dLqdBJ7cUOymFvVwuCVQNIpZWSbeBBQztcYZVKLBfpDpqluVbBjGyQr3zaooBXKQ394FEaNC6cV9eUsbJwiC66kasmFnLCscA682xGWLOMa4px/DeIDtphMX/q5VjZyyT1WeU5h82LoFEUew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416317; c=relaxed/simple;
	bh=lCTPtFoxtcyLzZC5JIDhZpR9SAAGT/fE/e8C9bYONAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MQNPYxbX+hmMjHc/f3ySZ3lm+7outabbyk/WEkzqpWbZn8N6+g+c0dsKUv0V59+c9F8EU1RExfR2bMlqgkwT/88W83/dvw9vsatIUQUzKIpIgmxTSYtkis0hny16+J24WKt3CfgsQRq3qb/gHaHVst4ZHh6zISOKcqKDrKdLF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpCHdQ6d; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rt6HFh19; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpCHdQ6d";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rt6HFh19"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783416315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
	b=RpCHdQ6dpAJrNfoSgyv1t0v3CtJwhy+4YACaj5+WAQvunloLKUH79+ykRMsQDIcVoRAF9n
	T5figgSdBJ/P6cMhL2Bn9CNo8c6az7K7jCMfFj8mmP+jxm3lBLuxv3YWFRAFtW5lhFXpAC
	7h0yAa8gxHRzYDMLieaoLfin+FZbyeg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-0Ip48l7HNPuwyMfRPZltHw-1; Tue, 07 Jul 2026 05:25:14 -0400
X-MC-Unique: 0Ip48l7HNPuwyMfRPZltHw-1
X-Mimecast-MFC-AGG-ID: 0Ip48l7HNPuwyMfRPZltHw_1783416313
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c12e5e49423so265301666b.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 02:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783416313; x=1784021113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=rt6HFh19hWe5+sKYiXRRuj81pZ0idAfSTtC4EP3piGeZOIfrq9ShJEHIjja5BEotH8
         QQK1EcbukhxbFuaXhanBxdE4qkHaz4doEfr92nwtJqQW/nS11PDVA2Tg0/Ez3ER7Qfez
         Mri3icc5suMN5awizcC9h2uryxmCpYptR00k2UuWvyI9JNh3mSQAGWz5C4Rx9Tf8Cvvf
         O9ypYGH/P7JRRu334qOWP0n/3Zuk8Ob8K1m63XJHaXnY176FI8mMta4Bz26wQjmpUzL0
         3Gfv3fKCYTIucI7rdRY0UmxqAoMGSI2rBdRUIQqgJr85oil+PNX6yhzATVyTlSP68zZD
         pu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416313; x=1784021113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=X3DTj84L9LRsXX2QUeBksHs4Uz/fG8E10s80Ig5D7jGEIzh9yZws7bz1wTSQjoovN2
         sHbMa+zGIkOfoZkNFtii+0MZrhWw6sCs/tP/UqLznEtxPxU/jNcCuXkJNwGA2jS6bOIS
         C+O/PrCv3vEWzJZwz9FMREG4+XpUePGMul3AWOw2V8U4OrlzbXT7Kus2pOyxWyCLfZKX
         KFCmdZ2336/EzraJ1COLQwmumdcNNlrzvNAFA/waiVGe6qn6HBTE5WHPfO6sqZ34VYo6
         krWcevcpFL0D46qSee38M51d670s+EVtk7qgv1TSNjBO17YKRvRC5hX2OfMdiSRa+Se8
         ogEA==
X-Gm-Message-State: AOJu0YzqxmQcNSXJSQbbMgYaNgjy+ywy2Y5R7muxbVZyODIk7t02SdfP
	3hc/LUGG5ZfEis2ON4umYw9ae0svy6v1vdRG2PoiX/1N1CHG7LoePiqwHgino1GF0Q2/8IERx/O
	V/+zOItxxECfKy3EoTl3gghqFjWFBj5U4sPPEyTQ1KSBM4mub16LWMCkJnYKtt8Y=
X-Gm-Gg: AfdE7cnk1QEAGTic+l+Mybp5B9J1VIdkXW3lF++tXPMxeVEZH+i8Xh4njJleLSrDB2A
	/n8F7LTtIu94THzcItRvYBdmWiSOufALsZxgz0fA88Xd0je1UEnaEfZKIAfuMFvBmCSCsLo14af
	ibJ6ug8KCqpJOStcOJKYcgWLAqrqK5hcVezHfLSMi+/OHcpHsjSM6v6cBddCi0dR9mLOYoJytvd
	Sg0NZ9ravXx26Wklue9JSJ0D8nO8yiGJoSevqTgqxsd4Jn95lgbX2W/HlNB9AE7VlrGA4qzBnwZ
	soXQOvjxP9LhS5nAp9GkErV8P8G/0SPuIOYeFWOq+qw3H3OuGH7IFgFyqx450DbI2alFN7l45xx
	KpMUqtSarF1KyJmY2yBR/cXhtBaJK6L0PV2Y9AOnDwaZv
X-Received: by 2002:a05:6402:1590:b0:698:f7d:4e11 with SMTP id 4fb4d7f45d1cf-69a856a552emr2254781a12.1.1783416313216;
        Tue, 07 Jul 2026 02:25:13 -0700 (PDT)
X-Received: by 2002:a05:6402:1590:b0:698:f7d:4e11 with SMTP id 4fb4d7f45d1cf-69a856a552emr2254774a12.1.1783416312821;
        Tue, 07 Jul 2026 02:25:12 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19d79bdesm5315097a12.19.2026.07.07.02.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:25:12 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: max.kellermann@ionos.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v2] fs/ceph/caps: skip __touch_cap() most of the time
Date: Tue,  7 Jul 2026 09:25:11 +0000
Message-Id: <20260707092511.2186973-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706145925.3989710-1-max.kellermann@ionos.com>
References: <20260706145925.3989710-1-max.kellermann@ionos.com>
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

