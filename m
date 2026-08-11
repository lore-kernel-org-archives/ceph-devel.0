Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664D1432BCB
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458229; cv=none; b=UNCF4i+DFEjowHqOufGSdPz1AlxbOMXtw5w2EinZSlUMu6p9LAKeBEL9A3OWVsIfAfdx44E9YZj/q+mpcFnmAgqugE0w5eIiSsl6DPagD233RGXoDGVxwp56cCfTcJNbAgYb1iBS7J8MLSbuL0WIFkiyriFaXDzABxcp987heco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458229; c=relaxed/simple;
	bh=lCTPtFoxtcyLzZC5JIDhZpR9SAAGT/fE/e8C9bYONAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oHd+Yl6c4Bfrd9bDXKJqSd9dgjd+mc7kaiVxXvPdOSzf9uAGt4pGRnv+3LAQ6XM1MAjZgotqzuwLqet+N4WHMwlf344NyQmBQeC4K1/GuQSoE1Cy8SdqtsLqhpDOUa5NN3O+Y7ARuSfdKnBgeUBWwgxqfj69P7HnqUYwzivZ4MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COzRKaF7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxgA4FXT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COzRKaF7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxgA4FXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786458227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
	b=COzRKaF78tQiTi+K6hcx08dd/Y7pPb/eQ5kf7SSn+QmG8+laSdw1iYwZBSH9Ssvu9coWuV
	4RoEOYglHirLhA1wv5aNEJ3wtKfEMoSBSSf4jLnWgUBGWlPLoNS+eG/1dcqgtgaCDzuKjg
	h272SXx2mi74md/hL3KZnlq46a+349o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-2g39J2tlO2uBla76waneZg-1; Tue, 11 Aug 2026 10:23:46 -0400
X-MC-Unique: 2g39J2tlO2uBla76waneZg-1
X-Mimecast-MFC-AGG-ID: 2g39J2tlO2uBla76waneZg_1786458225
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c20262b5e10so99501166b.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 07:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786458225; x=1787063025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=DxgA4FXTZRgoM3xFPW0GGuTTcHDAm6sr9DaX1M2/VAbAnObMZtN70V6Z6g86Fj0gaO
         AqkNtbZNexMROpxcFmU4sbnMXwqj6xmDcfVOMrbxonkpLAGrMWhrIQE6lpyIEZRQCac/
         U9gjvSmI2K2pqNXuHsNwsaCU40a+TGx0CYS6ZhaRnx4vwU8BHVqJlmeFA44VocNMaPdW
         TvLQXokCDW2G5lc1zjahm+6EUvqAdrChRmaNk/9xGRoVcBveIDnKHeXhnUbUhCBg55J3
         rPKJ3MEAWamvRnFl5LMW6si0916dvjNAYgBvPPibiumMehw6ac2HwMlJV4VOGRbM6i1G
         G39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458225; x=1787063025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=R/mvC92fWpuCY5+0w7kMw3P/QCeiTuK1mTo7xIM0y740JeSyg+P/hYXq4xT2XK9MGu
         7BUJFNV5pjl4B/ee17D5nxvpGgDtRaqaIc/uyXE5GkT3DHD5m0nDWp/eCjOA/qCp4dfj
         Wb5mFIjgOFn17Wqkoj/RcogZYoWwKdqbNt8vt3h0UuxN3mLvCzN+N4frbv87RYSCofJz
         XtCeppMsAhQ3pkpYs0jGAmSNaX4g0mVdZcu1mFW5Qxh9YE91oA79KK21Cqy+TX0UG9vZ
         KYKgAh8BvOSJwza1NRJh8+16SvvsyvluTaP7GrqaI4d3iOqMPXspT/osmFRXPuA6RjPk
         5d/w==
X-Forwarded-Encrypted: i=1; AHgh+RpTVVkYQE1vr6q3O6qe5BTw1OOgVns9EtISqjcFCz7vlPNjFrcbQbBjH6/I/o3eGlM4nBFZPrDbfNdc@vger.kernel.org
X-Gm-Message-State: AOJu0YxsATXSEzyr95HhAk/fgXsxU0kIOmfIa8g8D+WoErUDmeLDEb47
	sz1qOF/KpqPLivi3Ds0VwUwur859aSnP5GurMRkYuNyY5JiFbtUwZdE43tx6xXd5EbSYhtRcP/C
	U2yWi5hkP6nUabst5m9DXqINqCCCbz/KBgsYxAg5kmw2sblCQLBii6g/SxsT7mhI=
X-Gm-Gg: AR+sD12TRaFyALOBR0sbEtkm1/qMqZuYgCO1XI8G/nJaTlIoN+PAFSd6oXZs1yGnkDW
	/LlVLsNCielmR04c04Mrr8XF7EHEcLBFgMJJpwj74BnSBjZO+CIWkQfyZ9DJcw9Eglg025PmIky
	dj7Wm/RRZHkIqFU/MXRAinGPS2iFDoCfbsyUgJJvy5u9TbnnPp+CCaRB6QIL8sD6rYgwDdAdMhW
	Jd7y3UIBgLPEnGu6TwcDLjdFVdN8c4yJjdaW7wY8MF/x/sPRcai+i/NSV4pMblDbo3kLAKMge9P
	vbhkRRTpllsrlPpzNKldASjUa74ZGKX5e6RCBQFLKPzAdfvSdTxwjHOsrEy4AZXQWvf+1ez8M+z
	LPkcQw/FL71s830Y3DKVhU5xmYnUoeNL1Mg==
X-Received: by 2002:a17:907:c1b:b0:c16:6c84:4b8e with SMTP id a640c23a62f3a-c20eca2c6fcmr38538566b.14.1786458224662;
        Tue, 11 Aug 2026 07:23:44 -0700 (PDT)
X-Received: by 2002:a17:907:c1b:b0:c16:6c84:4b8e with SMTP id a640c23a62f3a-c20eca2c6fcmr38535566b.14.1786458224095;
        Tue, 11 Aug 2026 07:23:44 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e43207c8sm60566466b.35.2026.08.11.07.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:23:43 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: fs/ceph/dir: do not repeat ceph_trim_dentries() if no progress possible
Date: Tue, 11 Aug 2026 14:23:42 +0000
Message-Id: <20260811142342.2700795-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707214228.10769-1-max.kellermann@ionos.com>
References: <20260707214228.10769-1-max.kellermann@ionos.com>
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

