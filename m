Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633C4749F3
	for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2026 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153643; cv=none; b=ZJ0ljDZvZEUNlGzFz2konpOr3mQU3sh+NkxuN6gk4jnppOKKmLwXe3iVjG4oMTFDiuXH4BgaihXD/9I6GuHnZ4Aw0du4kbQbPjzb09wGPeulL1YESDLAgHh8jAZduF6ua5T4nIKg+HPzs4228IQI8Bl3rgyF+Lu2G7y1UojTnqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153643; c=relaxed/simple;
	bh=FmX/krm3ZxJzVxlvZK909Y74vB0gcWGmPe6CRT3EdVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LqDg0eGaVGYnkkfxLgUwDX/iRA4bQwHQUQUeVTKPnZ5IlMyaDQzXE4s1GZaZnaTwULkF+r7yGcDr6fRKnlH4OlTZvaUs7p+7ZZrlkhLUFM7eyG9R8fatjYbovBrblCLFvV/jEDFEQ2HWcIy5Ly3em3ZQAZgITuYqCEDDC174UWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiHPE+sw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ob79CYcT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiHPE+sw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ob79CYcT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790153631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+AMljX3Rr1ApSBVoa8DYAxeqnDMufje5SScB7xrnN8=;
	b=PiHPE+swf1hBN25VxdlE/qGOjfNjlHwOOs1hkvr9vaeb1qlxtVX+R3exteACGZJGwADvTi
	0uSyBtxLX/RUjjtZix5JARJ86aKp/ajgKPCXQLkxIluAHF9YyO3Kx9Yk9XCN0sVJ3ftXb7
	DXWB1jA0IH9oTjOU03np3GVouGO4C+8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-wYCSiglWO2CA6Qxj_DRUNw-1; Wed, 23 Sep 2026 04:53:50 -0400
X-MC-Unique: wYCSiglWO2CA6Qxj_DRUNw-1
X-Mimecast-MFC-AGG-ID: wYCSiglWO2CA6Qxj_DRUNw_1790153628
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c293e9cd02fso68767066b.3
        for <ceph-devel@vger.kernel.org>; Wed, 23 Sep 2026 01:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790153628; x=1790758428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+AMljX3Rr1ApSBVoa8DYAxeqnDMufje5SScB7xrnN8=;
        b=Ob79CYcT3F/eGWdEKfJLPgv8DO5KSfTFguo6kzuHq31VoCfiaDaKmWR3hO4K3Fvqn+
         Bzgb7aACjdIof1LBG8+SS3vGYBtzJnFClb/ArxYR6XFaZOCs/238W1+XT6WXV23g746b
         8DPyigcf54oLzYRGW+dmBLNujCYj3BlmsgB1ydd1U0mEU0PAMc6QtQ2qHzyamVyqPVo6
         bpimoI0pr+89/CT50XqeDQhUKD89y84iXbJimyo0dm/fIyzaWrZzXvLK/YmQ5EERLyDd
         oDfWGbSWyQwiMAfUVwwqVUmuSychXg+GLKN8NIRdfIqh7cdRE1Q5yAjU0FLY8zQAFncp
         pNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790153628; x=1790758428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N+AMljX3Rr1ApSBVoa8DYAxeqnDMufje5SScB7xrnN8=;
        b=EXSx65c+mYu8RUrMC2RNNF5ACrfKLurUZ5k2Xoh9GuqihKe9jQZqpdWq5jq6MFJQft
         wYZOhFe20t6uBWiXLlWdAiSJtV8+zIIGTIO9K0+hAUOKAg2gklJnVeVsQUa+9NWSDCGv
         1PrddBXmhwAen2Wo3htJG1TDLu38WdMty9YpVpohNpsyBqpbSYc+tTbmBJPb77cyam2C
         iFUIoE3sPy9Wi0ABEfhvIbzKrGoeyps5blX0uxgSRf3ABwRZOFY3iK60pNfG/5f3vHvZ
         AFot8OnSihkufciXXsjd5SCqaMVRzJ1KuMzvImVHHxAIM0PrHqft0MD7hj0vD/XFfNJR
         GRsg==
X-Gm-Message-State: AFuF++mo8mc6pTuZrukQQ1Y0sF1QIwMNhbi49IPGggry6RuQSWR+vPeP
	6SZDeKC/gY1E7ig//7YHL4E7GBnwtxBXTaH01m851phmhN034Z+i3PmLl7BiW2RswOcGLyNi+Y+
	GDCgSaRsUANgY6mel83uXSWblZe+d349hP+1y5XAmSa1r6ruEr7iWsjstkNg0R5mLrF4Puz5fnw
	==
X-Gm-Gg: AYBFou12uVVQe3cqf3F2+b87ljLTKiz07K/FErurnP3nHvTTk6IwzA9czQ3azR3cPqx
	MkA22/5Pm8gYdUQ8SGsCnWoIN5tu3PjR4zjDu/r92nsWTJB7MTx1A5XzeYm2ajIK8LsSWSx3EVy
	OyObazwTYR9kTkL++LY42SJJlHeOHM655IRsKtf8u7P8wa0GavtOAI1LsNXKdCMIykUwpF4JhyD
	qFs7WzVarBZbxF4VgiWLNfZnqi7Gpo+Vrf2aCUYnDN9hY0+ELkFvHP2bDuSXLq+tdNRHUgBlRTa
	YVfGx9qivjb0YTrGSrkB/87l9/zjeaJgUp/4gISo9hY4FNtG0bfzR+4zPKuRiO5Y+qPYkwreysl
	qsBET90u0sqcCM1u754KAMlYLBhZY6Dr2KJxjA8+Fb3+jB8uXT2CxtwRyzmR8mm5WhAltO1/k7e
	mwxnnvfL+t+9QZOg==
X-Received: by 2002:a17:907:1c94:b0:c26:1691:b368 with SMTP id a640c23a62f3a-c2aae0e943cmr145573866b.33.1790153627899;
        Wed, 23 Sep 2026 01:53:47 -0700 (PDT)
X-Received: by 2002:a17:907:1c94:b0:c26:1691:b368 with SMTP id a640c23a62f3a-c2aae0e943cmr145572166b.33.1790153627548;
        Wed, 23 Sep 2026 01:53:47 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6dcf0dsm72422666b.61.2026.09.23.01.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 01:53:47 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: vulab@iscas.ac.cn
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: Fix mds session leak in __open_export_target_session()
Date: Wed, 23 Sep 2026 08:53:46 +0000
Message-Id: <20260923085346.854920-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260917162807.2162279-1-vulab@iscas.ac.cn>
References: <20260917162807.2162279-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Wentao,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

