Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372991;
	b=WmUqKLFXEcnE/jpCTF6j1BvX+Pwgd5kKzRHfav0YzyBEd9KkE8FScMlNy3Rax3bTkKsj
	 Ng+pDHAnTFbSnRkc6Y8I+3SJvzEHpLo8Qx0c/pUytTtE53jgirDmQizoO3zr0IWODInQ1
	 aKITIHVzeQdFO86QlGdAnwmS07m0jthTJuJwG38AS2iTACFIAB5K/xni/8yCFCwcBUMAR
	 VyvCyzbI+Q6fIe/LeCBeMc0tck7duHyib26ypRrrE8033TE7hdAbmV1QW8MLT1mFMN9LR
	 3x2ol1pg1oyU1ie3YzReFCr/khJYVGei5HNykL41VmwpLPHJCxzLxKJV8TTFve3pX0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372991;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cBcRUPE1iZgUTO5vL9PNhYI1VQ/6dT8/jQCn5srupcA=;
	b=3afqtRZyjZkgsrH9DCPzufSRBadHZNTTD+hGNpWuMUsdr8YDo5ILyuzG+0M91VsxDduO
	 dtVgc0tR5BJJyQiHlbBSZAKwKqhYMSqNXozFRzrY4v60xJ9Cc9oHJFmvvmZmVFNq/KmCb
	 O7snZcbkGZEji39JR9HkEGf99KQc0wRTtT3O3q646JXWj8aPTZ363hhU2m8KszH6i+MIv
	 /W4hci8NYGxbIKDVfplI1IcSEM+ZS9E7YDywcICeic0/tZdGc6RImdhvHgVibWpe4fb9H
	 hB1SZ438e306ytRFL/Sr5Mam7M8sl5PybiBD8oYD5TBaGGRUm5l9LkgZxgRDoW1hn7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="GUvz1/hg";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kA5FPwu7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39023606A32C
	for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 18:43:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39023606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GUvz1/hg;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kA5FPwu7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795372990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cBcRUPE1iZgUTO5vL9PNhYI1VQ/6dT8/jQCn5srupcA=;
	b=GUvz1/hgDWYKSfG7DpRvmwkOrncNOKpEKTrcr6r5w0UWrA51mC9rsOvqfGBhsskFBO/RQ7
	OA+KTVsHgJ2+hJQXc7YuglHGzORrRCI7zFQS6Z8NLo6oVHSvDxjKaUKMeFB2RPXSJH0tRv
	dOXid9y10TdKtOzSReJ2TRrvJfiNmjQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-uxFKEW7sNBiidmx6uy26bQ-1; Sun, 22 Nov 2026 18:43:08 +0000
X-MC-Unique: uxFKEW7sNBiidmx6uy26bQ-1
X-Mimecast-MFC-AGG-ID: uxFKEW7sNBiidmx6uy26bQ_1795372988
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-55d32f54d21so54960901cf.2
        for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 10:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795372988; x=1795977788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cBcRUPE1iZgUTO5vL9PNhYI1VQ/6dT8/jQCn5srupcA=;
        b=kA5FPwu7R6lZ/mBGiPplBrZNrp83YZBkHLHEEtso6d7pPoUds5cD/6OjIJbgIfoZv2
         SjoT18htPH8yAW+aOUs8G+mK9LeYdRFQ/Rzqv71davcXAYdhvr9uYNn92czEqfHGpuOg
         FQcX1bp1YG+rM/X/0/+xYq0FX3cs1ZBO2EvuEDbJLUuKkYGmgGJXUtSWIOq2MV4D39VG
         5Lf/bhYCL2ojZjPWcdjTqEiUANxzQzWcbuvTUcZWz7eXUHnMvRk9Ra+4f3IjFXcoOmX9
         0pqV1SY9fQKI1wCfX34e3xB6a7noQPlz2OGGH+4c1jpKXjEoZTtS8lU4Gzj2CJDZQ7JX
         ipLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795372988; x=1795977788;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cBcRUPE1iZgUTO5vL9PNhYI1VQ/6dT8/jQCn5srupcA=;
        b=QphDk4GAqUcGlBgLqIhxBNyGmXe9orA9BT0KqfzIbvw5p0SnR8jZeAJfQtSasf8K7q
         cOquRLK96+qo1XXMEaTgRhWhqE+i321IeZkeUonvs72wzkHyqPwVAoCr29f2KEOi4eVn
         EQrv/tEW5RGKweRNuQwQkx/rWgTpi+1V5Ae6TMRGNGnkLquELUPCCxvtP2oZQPs1t0h9
         aOPgONDH2iy6bUeWxs2CfjEGRqzpv9qCkY2MJuJq+2TxbE1jiIUUi9aK5YsbAh8YSl2Q
         ORrrfUgRl+o+36fg25pCaT6R9H5YY26Nlaudu+RIFdWv7RHRRdcqSVuUYenuGn01s75J
         gI/w==
X-Forwarded-Encrypted: i=1; AL+hErERsLJMPSzb/V269Qy559YNi/2DQPT36enfPkRS1VWONkQG/s9/2sAPTbU3GmySmwHfJKTki9vSkqhm@vger.kernel.org
X-Gm-Message-State: APuU4Z8RYWiP4JSiDOMCja1TF1XlMtg2tvtzoYN3oEWwoGKXNvXIrNsz
	zD96eWVvarhHjcS/AbEj6HbsdOnX/FWKf4J/f4gkBetrYUHHSxsbPV5lFE7cId1r38ihxuX7Lvs
	sJpsrYaEC6rfo9LtrpgAiOWidMshxuvX36MEP5xrLDjC6Q+euyjlnJpOlTOn6B8s=
X-Gm-Gg: AZFdTZfhrLmv7a8MjX0tK4+UDysoAxwKnkRj6f1I8CYobH02/qJOPYd5gaToXtl1cJz
	W2BW3erUy9L9K8Di9cIYcNleroRm26IEdm9+2fPfkpbOS2BS1ZRgZ1rf2fbDuyGmfp21oO69uYz
	3t16HFT0IT7AnZcNLFZmrt0/4+o4BSzw8XtdCAxfdLpnVAfAq2ILhOmmh2PIO43hyAArNmCgtS3
	iT0ItmRbXc8uagznhHLuHqqUxF4vfloHx2eGIS2BghLfJK9BL2897zXH+XaeKfZXLbIJY9H4deG
	UFPApPFksnkQhg4vXOLoCgwkiZXM/S3Sp6eVxNOM90DMDUzFiMhfCsyp/7+BN1KwPzTdzy1Klun
	w/Jk5QLPZ7+sRvx/6eI1QcOdx736MRFa6uaaP2iFChP4qb087Fxzdk0qBVg9kimnbAxLCUhYVhJ
	G27ufQvJJAk8cmhSTnPDppIpJ8Ec+9/09HftVrCwcIqFxfWmkBnKcGohjcpbq9RSRtRkX23mq3t
	D8TdS2rP0GIjl29MEak6LwyYWC+lNVifMvg/gJ5S29LEhfEqf0a
X-Received: by 2002:a05:622a:580b:b0:537:a19c:aaad with SMTP id d75a77b69052e-55d76adb4f5mr145678141cf.65.1795372987710;
        Sun, 22 Nov 2026 10:43:07 -0800 (PST)
X-Received: by 2002:a05:622a:580b:b0:537:a19c:aaad with SMTP id d75a77b69052e-55d76adb4f5mr145678041cf.65.1795372987327;
        Sun, 22 Nov 2026 10:43:07 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882c64fsm79845241cf.10.2026.11.22.10.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 10:43:07 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	stable@vger.kernel.org,
	security@kernel.org,
	Quinn Grant <leograntquinn@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: ignore a cap IMPORT peer that names the importing MDS
Date: Sun, 22 Nov 2026 18:43:04 +0000
Message-Id: <20261122184304.1303832-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261121-b4-ceph-cap-import-self-peer-v1-1-9cbc14a6c8b7@clyso.com>
References: <20261121-b4-ceph-cap-import-self-peer-v1-1-9cbc14a6c8b7@clyso.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Thanks for the fix.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

Alex

