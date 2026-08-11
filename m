Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EE51A3160
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458191; cv=none; b=Zfbo8iXYf/3PPgW++fiqGHb0vrQZcEqQfX26LEKYpryf9GGn/AuSPdK0a3qfbLiJbdwFbPIVdjNqThdrH+Q/VXpOGZsWTwdZgG2+HsXC/3BgWN8chOpJqpNWBLTc6h26zGYEGN22tAZ4b/FM642euzsUQzK9rg6c2Pe3sCCsuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458191; c=relaxed/simple;
	bh=WCncai4k7h9PCVwDGIPP9Vl3IgvWV9hBsj1M0n2naZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKZef9NefehD26IqYtX5rzHDAPW39fFPQftok4cfGkTfvUsg843E20jESZ8C63I8ClAVtTB0oIWh3X3h5DiDtlOVsaHy6Hkv20/4G5JUM+9yZBPt6DBEY3boCFmIl5znlrgTVuFXwyR7XLJ7NEC8yiaUllfMU3Q9K4PEsaEub78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANV50W4F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPKIMYnk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANV50W4F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPKIMYnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786458189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WCncai4k7h9PCVwDGIPP9Vl3IgvWV9hBsj1M0n2naZA=;
	b=ANV50W4F35z7fwwjgnGwELZ6rgB8riQtbjHA3gQhN9Xme4KnXs1nA+fPSDo3rRGb9yj6zZ
	F9xK4vSQ5gWdQLY+7cK/KtscabwJ+IQuCx449c0H8ZOdx+ukyRVTZ9Y0O6Y1TspBfwP5yE
	zPrHrSmy5O+j1Z43XOX0O8bWnhYf3Rw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-MLd3blPoOemcGdFoib2SyQ-1; Tue, 11 Aug 2026 10:23:07 -0400
X-MC-Unique: MLd3blPoOemcGdFoib2SyQ-1
X-Mimecast-MFC-AGG-ID: MLd3blPoOemcGdFoib2SyQ_1786458186
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c1f548718d0so313851566b.0
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786458186; x=1787062986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WCncai4k7h9PCVwDGIPP9Vl3IgvWV9hBsj1M0n2naZA=;
        b=dPKIMYnkBeVhsQzaMzcjSkJzs9mEahMlXb/1wgPle9vrcA1VTYSMUtaDunj9xcZvhf
         hdia1u8mlJ0h0/FU6EzQWootfkrzLNT4jjvpBiWYeQEL4cJkKdtTFnMJO0X5UBGYhxA/
         I6KkJiL3rIkbhWfThOPDReIiP3zplMDVUVpcGoFPPARq1G7x4p5JRJy/GJbi2WZzdEUM
         jzTR48QdZVDeNqj1pw3ciHtVmcJkNQl08U7hJ8+ijJvHWDWSKQU/K5iaWlbLWVNclzF9
         5LqSgxuI4fXh8Jlfp83Hd79rPjRrsPP37D8owr2aNunIp6wH7kN9CQfGUm6WuisHhLGB
         CeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458186; x=1787062986;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WCncai4k7h9PCVwDGIPP9Vl3IgvWV9hBsj1M0n2naZA=;
        b=FTw6jBVYECZJQ7AuSFP8SktWhoyFO2mHrZZmUbYSTT2KICiT6PyPYQKw2h9oVSDFR7
         ZJxX3WUEXRcABk88zFJRY22UpH/UY2zpvZnkqqTupfgjpXHalEoVAOgyZfaaipn2gDGY
         6NeZhHCGFW3XbyqbuFHgyDvPLcPA4E+vqdegQWJX3OfKwcxrAIUheibZpXOoXsZv8JCw
         DYbMi454xv971Rfa5wZ9co9i0TeQtLXKC9ty9NAfR2KtBH8zz43SjbXn6djA6whd68HA
         /fn77Bprz4SwgqZHgEj3eNerIFHN8awfX/ztjYaP+bfgi7HTi2NyWRZaaBElxocNW9/M
         k9tQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqb7arH4Z8te7SUfFx8Qi0dHsBfFojJSST5r202+50qaYpXd95mC8V/DQqQTvSM9ET2kYdTONPfr/4u@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7I0TInxUSBTgbyiuEOOl4O75Zji+eZE47t1WOhD/Nl1c3rqZ
	q7PGrUAsCqSP8ymVTYVxMxlXMf0VQksE9NU2cJkSDjwGSNvu0bFl9TPFTV7vwBY3DwzsusDOxjt
	WMumUQPZTE0lEzLkd2ZkHRRwE4T4Z1nKjR0aeDHvGsxIUv2SHmGKq0Yz3joFA23I=
X-Gm-Gg: AR+sD12udMbwilrS2pRYNyCBvaMqxtCAjJb21PWo1gf6zeB0denNSUlyPc4iDLNLh5u
	ZtpNi7gyBL0gRDifrIVPKRBGN1uHwv/DaRzSCCHnk8hPB78AJDal6p1EZ50ncSQvlsobBLbkKc1
	3eAp1r0G2ym8lFN7qkyoZPtpUVzPm3kQIiSuere8Of0Ne/fvPcC+Gm2YZT+iBIg6eIHs/Y6/RK8
	D0uWguVPDH0H6f6Ckk07vW7XdJDBdcjsY/SLuLjTctP/RMKdKxOCWbLI0fqzDX9jKoXtXyfiTNU
	28BEW7VSURiDdnu1CVn4qrjlpJfmc2Jx54QYsm79pjy9Ong8Jd7vdnQnlYQrHAJHl8FVPKFc2md
	ni9FPBcrn8oZv3DIhyL6yEVUNH1Iooq+Eiw==
X-Received: by 2002:a17:907:1c0f:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c20e6200250mr222534766b.24.1786458186267;
        Tue, 11 Aug 2026 07:23:06 -0700 (PDT)
X-Received: by 2002:a17:907:1c0f:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c20e6200250mr222530166b.24.1786458185632;
        Tue, 11 Aug 2026 07:23:05 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e43203fesm62381766b.41.2026.08.11.07.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:23:05 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH] ceph: force a cap message when a deferred revoke can't be acked immediately
Date: Tue, 11 Aug 2026 14:23:02 +0000
Message-Id: <20260811142302.2700578-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707213659.8939-1-max.kellermann@ionos.com>
References: <20260707213659.8939-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Max,

There's a bug in the new clear_bit() call in ceph_check_caps() —
clear_bit(CEPH_I_FLUSH_FORCE, &ci->i_ceph_flags) passes the mask
(1 << 15 = 32768) as the bit number instead of the bit index.
clear_bit() expects a bit index, so with nr=32768 the kernel writes
4 KiB past i_ceph_flags, corrupting unrelated memory. The line
directly above shows the correct pattern: clear_bit(CEPH_I_FLUSH_BIT, ...).

Should be clear_bit(CEPH_I_FLUSH_FORCE_BIT, &ci->i_ceph_flags).

Could you respin with that fix?

--
Alex Markuze

