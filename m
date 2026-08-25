Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2844038330A
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 12:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660225; cv=none; b=VtasOf85FjJDURV58B1B/87opkSLdIVC2xwJRGi9zC8c2rO3MM9e5k0EuoMuyzIpByC4BhW0AnlAY6iZi8EuJO3KZjbO1CyzHcupt0J25P1v4g+A9+8reXxbuNEQ16yhV1uemsFuvkdYqa15oMvTWJZccvEf3wk6KBtEb+RVey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660225; c=relaxed/simple;
	bh=sa1SToUeInUqwzSKueX6UDBJCQwQzPYV5riUOldNPws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1olOBv2LBAvE3suJNktX9NE8Xq7lyydu13KlsQG7Mq6TX//iLxI98T7CbYTJ2BaTbbUEdL0eTA/ZrsXk9ljuue9cISwf2ACMJO7KY7y646UD/D5ERWBYwwivoo1/TThq3m6s0TdgnB+FGWF5YDo3t1SAmH89QddDgQXsauQ/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXvlFRMe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lsYqNEGr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXvlFRMe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lsYqNEGr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787660223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYgyv6EvLVj1+T9DRpgLD1uZHftGlDTgpmhTHB/3R0U=;
	b=CXvlFRMeWnC36yz8thySspyaJ/WDHgNq8hVaxXA01HhU/PkHifSdDPMJdv1UxoawDliqdr
	QwOv5/mH7+CP4hMhpJKIDGPxHqmlpglLQOsWedEo7uSBnZrg8IZtgLVpanjApfIrAj7Gii
	ZHi+jLZuOom4aJhQqNNpd1yDmRiBTMk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-Ldk0nLqvOAWmQHMDWL8b_g-1; Tue, 25 Aug 2026 08:17:01 -0400
X-MC-Unique: Ldk0nLqvOAWmQHMDWL8b_g-1
X-Mimecast-MFC-AGG-ID: Ldk0nLqvOAWmQHMDWL8b_g_1787660220
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c2192261d79so523552666b.3
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 05:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787660220; x=1788265020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fYgyv6EvLVj1+T9DRpgLD1uZHftGlDTgpmhTHB/3R0U=;
        b=lsYqNEGriSzk4NGbCRzEyCppAR5SmoQygv1jeYc+qbW8/aN62im1DJT2DHDFfgOyZk
         GpSRs7ah0Qjt7pxkaRNtAMsu5bqw+9gj40mB2wTTquvjfm4FPQbLz8nTNOnH8Xj9Opjs
         +CqmHc1arOCPOm4wyeXPrgsIJ5TZI8bzm2Go4GUGuhGghzAmc/QH1ZTv2vsy8OK5L/5a
         X/bL2JXaQ9+y4SDeuAXfy6BKAlZySVmpnCMCtGBP3rjW19UpcS31w+pJkwyGXMmU/nyG
         OEsKOau8YJX3Ji6bTXYjjPKc6pahpmrBqNfbQYQ49zsF5MhnGi21rnbdQDYYjHXEZP+q
         hCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787660220; x=1788265020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fYgyv6EvLVj1+T9DRpgLD1uZHftGlDTgpmhTHB/3R0U=;
        b=s7SEEbhDQ64TAAc/Yc/8I1Fs1BLiKAf+zXgXaaFCLyPyrmQVbnOFKf8wEdHaDDFJ3Q
         Gy97rSU3wjd3gfxTzKfSx2TbueecdQgrL/O3bmstc/+3BWp7Qc8nwFpTDWjjxgXr1v6s
         85RDGtUe10sxI8TDDwMH4mhCyPVtXuc8QLpYuT+ZSRg0OKt0QKQMXyrQG1gGCbWpaMTr
         6WM+AOdLePzsoA1ImhAWVrhBKxFhb4Sn/rJXr1CLquvS3rM1hFWz0my1+aREMblwaBrb
         og7nbLnwFQcbFglhJQb2aoLmsDAwPrCyz2sCvVq8nAzPiC7lURPiLI2gaKOWC9pZtHdy
         bHMQ==
X-Gm-Message-State: AFuF++lvOpm7yxzLY07OT5N2BbtKtgz1zErlWgVsKVVb2kXn+zORN+Gz
	rPAXOkeWiySyJEIrzW+wL1WpWfQV5qv+N2lpvbBPIkRCNLt/Sdea6FJFnyBWgiHaRqkdKmfIL2i
	LeBM3jXNDDJtql+CW1fWz6y6aB7+robJ0aWoJ1Tc2I2p5okYxinIyRg85h5WC6Gc1auv3JBEoKg
	==
X-Gm-Gg: AR+sD111/JrclGbS3n01BnL2FYNCguHI9Jk1i/f+L+B/gzGi8/7grtwZxGjQ7UIhBsH
	k8Uz8g2qr9bm1YyQcfFVHrywc5KdtVVjMMJ7Bwd5nPXxesgv3CE7Ncy4JQubMdN3btkeMmZQx/v
	amJ3ICm3YExmjwbPZdLVL+RYHhCh/m7zDX+hziE5+4oQKpq3JAFDvxuV9iMtEsHly4kBVf9r4tL
	gawdSxQg4tGsC6Z9gRIwuDZ3kQX8sG4JH50B8mROOqL3rpQ3Q+W9WglxZNTlxXfT2q1gVMm/u7u
	XZY4ZJ+LhLkIJhZs/XDGOzioVVXrc6/+UEslh+62kD/43pEzCZoaFq8j9uSrHBX8kSduMrYIiNN
	zKbUtDvcHQb/LmCkN6J9BrIUs578/XJp8qw==
X-Received: by 2002:a17:907:97c9:b0:c20:9447:bd6d with SMTP id a640c23a62f3a-c24e5fc56c2mr639111166b.11.1787660218126;
        Tue, 25 Aug 2026 05:16:58 -0700 (PDT)
X-Received: by 2002:a17:907:97c9:b0:c20:9447:bd6d with SMTP id a640c23a62f3a-c24e5fc56c2mr639088666b.11.1787660216309;
        Tue, 25 Aug 2026 05:16:56 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b683sm1901204166b.5.2026.08.25.05.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 05:16:55 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH v5 00/11] fs/ceph: optimize struct layouts
Date: Tue, 25 Aug 2026 12:16:54 +0000
Message-Id: <20260825121654.2610858-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824184159.240821-1-max.kellermann@ionos.com>
References: <20260824184159.240821-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

Thanks for dropping the pool_id shrink.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

