Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6F046AEF1
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992454; cv=none; b=EfeVLFhefMwWVQUSJtyNW6/RUNFsmxgkenYm9nnKxr5S72RPfxbcumsyeRRkRDdx8xmR9VPuTCB/zREpeXefV7+Ci9189oR3xbaNKzhTfjBfkBdZsG/m4Hlsd61jqkOfFO8wpZkuDWho0CEZCKNlqq36awQuNty1lvPHXDFsBCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992454; c=relaxed/simple;
	bh=FF7TC4XN8KRmLfZ/mjA0yMJ1hVLPwJvtjnTU+YgkCIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=acKqFbvi4nA71anCbGkEeEqJdq/8SZ2W4qTlk6oQIW/QpsIWe9amRgcTb5SgXwYnhvKwfh9VZZvgliF4hmA5EfgWMxHGsg8txtzR21VfDShk+CfGmlHV6z3UkxkmzotjGhKJmUt48BYCi5CMoanKj+BxFeLgNAG4c6GNV08fyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KmOXHIB0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=btMj1c79; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KmOXHIB0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="btMj1c79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782992452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oH5eFp6PJAcj/JskxZ8LyapmyPoAQbsXBmEmbh0wWZ0=;
	b=KmOXHIB0cN3e9RjqpCUZviiJ2n/3lIGMBi0A1NPAAkOcucY/7FJblduNzdj48q1CjlOfV9
	Oy5UDnwinmxzoPv7smAsweKY0dL/DwnCamy4AaavRfO0DqPZk6YPIG1qJiYLAzfMoRLGRf
	Fpsqoph8lNs+PNMmwEsDLgcB1i/VzwE=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-5fGGytZ3P1aju87ZTUPJbQ-1; Thu, 02 Jul 2026 07:40:51 -0400
X-MC-Unique: 5fGGytZ3P1aju87ZTUPJbQ-1
X-Mimecast-MFC-AGG-ID: 5fGGytZ3P1aju87ZTUPJbQ_1782992451
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9f1ee3ce4so684063a34.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782992451; x=1783597251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH5eFp6PJAcj/JskxZ8LyapmyPoAQbsXBmEmbh0wWZ0=;
        b=btMj1c79ip7gIE3h9Ihp0bQlm4Q+uzVy9WuW7hHRLABjUmPHU49NPVprpxiyN8WxG3
         7mCyFdqBsuQo5KVkOTCuONT/d/TmOmhaT/dE5V6T8sUomnLCPdf8+2ggxxt9GeRxJ2xy
         coU1bOcHMIQUMcIUQjBb31glsz02Xn9ByQTV4oFkmSeO0G6lVzoDhrq3mKZFsb70BD0l
         tHXbBs/aypJyIse0DTRQzeMH6kepORKYZOsbBRXKEkqjpToitpeLEK8fhASlAaqyIhQk
         3A+wsrvjE+piIhOXtOc5FprtLnOF5pGpAC7xzIeXJr+pHaNQHC+CxTqNaO0gt+8Aaa9m
         s7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992451; x=1783597251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oH5eFp6PJAcj/JskxZ8LyapmyPoAQbsXBmEmbh0wWZ0=;
        b=M7tNhxPLOk7Qo7E6bdDuo9drtikta+HnXXIa600Q2e+GMxOHATHSbGOa19RNBvKsls
         G3IheyMMaIaoC11ROvlTw9W5Q3jF8O2AdWKMlQTPp0OSK2LibLiPHc9Bly0VTnBmpcXk
         34MNE/0F9J+s3MON+WuILZ4KEfI1QBpTFsKtPufYu/cef1AfX6Vq50xjWVcPMmGjyl5M
         TnR6ZJRQGhb3kCuljU1HEOSg587AANAxIbe8Jn2CQ0xrX0XTb7Kcd5rwAnKY8kci+9KY
         QMruWh9xXbVIL4QRXzaDpLPi328EWd5yuns+LvXY5YcDNh5YICC+XyBnmf9a1owiK16C
         weeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+UPtVugTHHqtMuRX+QydpnNxWlNC82fl/YbC4Y2eKCUqiArRJA8v5KX4QzFLYyHPOMMfyIX7ODQBXV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsi6V6iSc/Q0XjjOVQVMO4nrqtVgmcy8M8LuIW+qw21Fa4vLcS
	j5A85sWCpxeBT3DR0x/8V7MIRNk83oDg/GV38QYFohpnCIF9PMZbSNfHfKfBZXdnjZbWLuF3ZCm
	bY1Nb38Ewud8fWlzRba0pk5WqtpJIjPQh9rfo4DHlGcgQ69JLzZfW/nJXN/6Ykck=
X-Gm-Gg: AfdE7ckLNs/40ZKYOxLVOj8IVTR0ZjpCgCgDr0c5+O4fHlZXeqGNz3wnHIu/xh4weeO
	ptpKdHjQv47GLxn0LVpMKfmaz+kpz8/NVaDY90qxIDDubfxVaCQrnMKGam4WvPoF8rcMn4mTfU7
	ZsiUGs3KC/ekymcLMs2e4UbW1Q85h4pfzemOjQQ0KendXc/V+CIOFUpol66swRAFC/aYFsxK7vt
	GUe//fAMM1zyrLNJnv5MVWA9Z5zTsKwU3lxNERo9z8ytkclKtjVYVcqjadtk/jd2e1ziEiEkxWv
	DrE2juIwG9fPxiQMrc0lfNLj8keg+h3NKKXaEu7QFLsGai2HmprPgzXEuGkwpyjhpEc5+JgS7ll
	oS+Jx
X-Received: by 2002:a05:6830:b17:b0:7e6:d003:929b with SMTP id 46e09a7af769-7eb3cd6acd1mr3934189a34.1.1782992450747;
        Thu, 02 Jul 2026 04:40:50 -0700 (PDT)
X-Received: by 2002:a05:6830:b17:b0:7e6:d003:929b with SMTP id 46e09a7af769-7eb3cd6acd1mr3934181a34.1.1782992450253;
        Thu, 02 Jul 2026 04:40:50 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb545515casm2206351a34.27.2026.07.02.04.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:40:49 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Zhenhao Wan <whi4ed0g@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: libceph: fix potential out-of-bounds read in decode_new_up_state_weight()
Date: Thu,  2 Jul 2026 11:40:27 +0000
Message-Id: <20260702114034.917507-6-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260606-ceph-fix-final-v1-1-e19325c14dd6@gmail.com>
References: <20260606-ceph-fix-final-v1-1-e19325c14dd6@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Zhenhao,

NACK for now. Thanks for the patch, but I have some concerns
that need a v2:

  1. [major] (process): Competing patch unresolved on-list
  2. [nit] net/ceph/osdmap.c:1866: Open-coded bounds check deserves a comment


-- 
Alex Markuze

