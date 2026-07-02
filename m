Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B94B4534B7
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992451; cv=none; b=oxzf0nV8Cv/CWdZZA2s/AnQGyVgFJeGyfvb2xuV4uQTEtX7d8eZUGeQefSsCtvaXcPf4GwaPI6SpIqgFPTmvW+3VrSI6UBNZPb6hct6AzMPEX3dv7etImDmRlo5SM3YxGz+gAE0e4B9GX0iqPMU89W3mFUu5aSWvyrkM2BgEV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992451; c=relaxed/simple;
	bh=lCTPtFoxtcyLzZC5JIDhZpR9SAAGT/fE/e8C9bYONAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kIm6/w3e/k0mf6lNMNjHvEHaSHYAYDBT0Pcr8jda7ytPG8+P2qRWmx+x0ovbfAk2qdZ3GPjLpnw/XCLZyF9rSWVaLmRkbEVUIRCbQD9jvlLm6e501TpSht3yVz0NTpMGvogKnwocgFbo9Wp6wu1B828W3VwBfnD1w9y9qP+6Jqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4sa+uFa; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EswVolro; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4sa+uFa";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EswVolro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782992449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
	b=D4sa+uFaDRPZMt4cXtIhxh25pao+/SNpx0tXX+5SowBYu5Xv5rBKLc6sWz73JguTlvG5UI
	cCm2T+uLAq1cM6zIndGaB1Sqxv1fuYKQ0+3I74DA6qZmmK4XDCRWrZlBN8EYDvR/bEK1a0
	Nsz9ETTrZTvBTKff76FHqUJ8NEAX0P4=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-s6G5USRcMz-OQk-jJnRsfQ-1; Thu, 02 Jul 2026 07:40:48 -0400
X-MC-Unique: s6G5USRcMz-OQk-jJnRsfQ-1
X-Mimecast-MFC-AGG-ID: s6G5USRcMz-OQk-jJnRsfQ_1782992447
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7e9f6f0240eso1958126a34.3
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782992447; x=1783597247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=EswVolroDobYNMXVv38DcX6laNlmq15aEgQf2q7qrYUtqgJOdJ9qIITpYw2nDEAW1+
         4bI9ktu/lXGkeOrKAEKU0psq7i4LpWlfpUsLMApAdgt6CNKuBEA3R/jsy56/EDuXuBcr
         eGJBtTUPn1zuLwoA8BOPIeC08BKvcKD+YDc4b6+BA+jc7Dk7gssnHqPZJlT4rUvZQfcB
         YeKmtFzqZCT4XwcGzN3KoTUo/DGXNuY6bt03KTpnvbYEAcNyaFXvTre5DaU4swck5xHE
         NV8i2UAQ5L55IlDBUZNtcXDPeYLEmv3Q7xPOCxQ27nlbpbCHvDqGpWJbv/0kecTYwHVD
         VNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992447; x=1783597247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=GV9PJY76VWe6fGYsGDj0wEk3KatYMDrEA5BIPOrtdRT7slOcO8mcxPUiDVt7h1IJ3H
         ALH2V5y59ipI2IlgwNlRXsdkw/VWFaK+yJNVxJ3trVQ+vJ0Z6i0E3JsqZxyDzNIgINeP
         3YgYeo2YE3VYO/1cvE8PVpc4MT/JujYY4e40z8ya4EKvimMGjrAo32KKW5+491E0OgKw
         W8YZBqLrLt5IOgBeX/Kz+5E2BfYh9sLMLibDPVp6okWISw4VXrzCX3e7yRN61fJ4rMIg
         PfddhijqS9pOCJS+ZPlKQVgkQup5oe+xFICBsx3JRe6wgDDVUJQbskbLP/9ul02Lpsx/
         9C4A==
X-Forwarded-Encrypted: i=1; AFNElJ/CB3jklBUVa7IsCKotk/XDH8LH4f71wTbvufk72ertb8f0vN/5TqZs3UzGpa8Shvscunz5vaCy+jDF@vger.kernel.org
X-Gm-Message-State: AOJu0YwpW18v7OJcT3qIAa/f0SXV0Dd5uwLCowFpwFMUgGW5Lw8wttuG
	IAKWo+GYhbze/4hT4fzB7p5EYmGif0fSfFClz4aiV8xxF7yhVBHl/38SMZgAao9bruiDs7rcrDD
	bAvJcTx3cjLYImQBkF3rmZ+WOSFmrpbHEHwG1WUifx61OVZBb/UzQlCYzmtiyUZQ=
X-Gm-Gg: AfdE7cmS0KvHBzJasuH0FQe4CSyXQo8rC5s5Rxk9y/80qXdVEnqnplU7yqH5C1A0hsh
	Wcojlj1llHT5lQmilwehHGiSJZjD0cvysvck8wzekUCCdeUTsjzQeS0PuLmejSSQ9k7vclXAiqy
	tawCfM0gFFmbN2Urs6PcO6T1K6kDyDHNISzaf/fodYuifM8yCQsiOxGp0F54k3hjcyet7lwP9Ex
	Kyhu+K5CvwMLQoNdV69PBQt2payVajLDT+2BWbZbJ/dOy5bucBeJ+yDfXbYFmBOpMAqVow0jCJp
	0gc3zBNAPnjrQhFzYQne8BDJyP5fcal3FX3bKLqL1R3jq1kYtqy4f/HlOfsWdB1AtIOnQJBIOXc
	hB4Zr
X-Received: by 2002:a05:6830:910:b0:7e6:f2dd:93c3 with SMTP id 46e09a7af769-7eb504b3103mr3454420a34.15.1782992447251;
        Thu, 02 Jul 2026 04:40:47 -0700 (PDT)
X-Received: by 2002:a05:6830:910:b0:7e6:f2dd:93c3 with SMTP id 46e09a7af769-7eb504b3103mr3454407a34.15.1782992446835;
        Thu, 02 Jul 2026 04:40:46 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb545515casm2206351a34.27.2026.07.02.04.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:40:46 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [1/3] fs/ceph/caps: make __ceph_remove_cap() static
Date: Thu,  2 Jul 2026 11:40:25 +0000
Message-Id: <20260702114034.917507-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612170537.92970-1-max.kellermann@ionos.com>
References: <20260612170537.92970-1-max.kellermann@ionos.com>
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

