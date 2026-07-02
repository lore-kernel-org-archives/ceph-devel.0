Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961B147CC91
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992446; cv=none; b=HurT4is1x5KDE+OxK97OuwKWE06KhIdxWqoVb/gxK+V/EU7kAFdb9SS6EGs7WvhK4pnvZsvmzOhZbh5BjlE7lD0uHUnXf0JpUxyg0TCbmTDWnT1g1GiIYAWmx48kcl1AM3kzT8qIGOIi7b/QJLyudpAGEGMBOMxTK2deDfOdDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992446; c=relaxed/simple;
	bh=hLVQ1ftq7EVejCnHot1sW/PcbtMmvC6zm8K/x3ZhQa8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ojbwg+fwBN5wKWPS+2k4Gb+3ZVgKxCFEyEpiEu2kVkx3RXzrLoQDf70WiO2NM9I0VyDwBf6W9g4RUmE/8vGENYS4jBNb9t8wbDL9NmtpDSM/nQbqqxJ4jgynxwDtgvgZEiibJ0nUgTE8kUvEPbuUscTAcuOY3N4Qs9l+dtHI0j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iRqRE0Vp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lJGlGiIl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRqRE0Vp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lJGlGiIl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782992444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=iRqRE0VpwZUgsO9Z+of6MOsplq3oPJ5LHlum9JNdnsXZtjthmlXnVSGnU4kz3lXK/OFQ9V
	O4j+TIphmuD0cDI9fRNg1e5/HpdAMCopQ7aCacLspoEKrRJmmNT9oYwDgWxzFMB09Oz/lA
	rk2hSxtOPUjLMynpJoXnOMabavCt6Cw=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-Y5vVv-DNN2SevM_WMDplGg-1; Thu, 02 Jul 2026 07:40:43 -0400
X-MC-Unique: Y5vVv-DNN2SevM_WMDplGg-1
X-Mimecast-MFC-AGG-ID: Y5vVv-DNN2SevM_WMDplGg_1782992443
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e9fc6dc091so1008604a34.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 04:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782992443; x=1783597243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=lJGlGiIltVH1Y92jLnoDm/OKlj3KpeD1NgyNwBWlNC+ZuKWlJJ5k3qLYDLtYxT7E0z
         XatM5L4vT35aWfNI9FmJRLZYZKKyn6uV851XKibclVY9TAoVt8qS1uEVlco08yZByVe3
         O/5Z6jgFFbbZi4eER8CA9TGOp0s231W099qnwPry3XXFE1eLOFeWksPL4dTKwsPg0FBA
         646zbcBmaN3/k4CsYz+wYNibIJFaglVoTJXJijrM9n0UaW0LDU9qH2oDK1LJuLCTvS/A
         C3avXaGsqBPPKIzpRju8rjn1tMir+9+rzEnswhpTTBHeztluGRjOTiMRqeVhZYB39+aY
         WKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992443; x=1783597243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=b/ZI7w6MSL1EMEw9NahXsNffBPQD3zikbfWj3ZEroGrOeWLAT9bfUi09m4Prz1cKRL
         0x81q4k5jK8cDGmSj+otUWXRDeBR0FBoW9MjineBU1Dju7GDozQdY8ohsqQ1uhrus6OJ
         tfBTiYoq0VqI88IY/8EI5kvlD+YQ8QN839QMkoxefiWpCpslP8TBVIFIjGnrsJF6VfbX
         RgXTXnP46OxVnTp9BmEZ7oxhniEmBd9xvHSnICsNMVoJ/wGRf9yb9qYktNnPSIfV8DpX
         IxV5f2ArnfenvDyEcB73RyNgvGPQJ2mUEYnqq1WNETC+iq6UqEZkrokmrzjT93PL2tNg
         62+Q==
X-Forwarded-Encrypted: i=1; AFNElJ9B/PA8qgk3iV5YJqKTHI/HpnEIxxjvnD8pm/hxo2jev/3Mmckn2VIFNslzFAx9leWJP7/rh7M0bdEd@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7bJWf8MYSTRmZ/YK7Ty3LV5s3MgZojZ97HU/LFKdgqmAtuwW1
	dceC+Cyao0IRTNAk+WZixiRcrwaQpWqN8PDGNuZrQ/Nu1mC7BNTIihcqI4FTBWHrG0SlXZY1nol
	zOJikvfmG2YibJ1tI3U6dVMJxUQehgTK5LKhRwkTB8FwY0cOIptKIRtjQ4yksGbu/WcRe99WZxQ
	==
X-Gm-Gg: AfdE7ckPUMEN7QlP0pwDXnC4CgVIZmpJlOWCXWfLwEf0YwYlnU+5DSkqyC2pSEAdlzs
	aG92h9GInzNgfnX8HXmm7XIgC2YltVaTgpapPUQpWkV9PT2cChn3whQ0/L0TQchAoUZ21dMoZ53
	bGKyi3RcjpXnTKwVVAWISRopFgKGhQKe82DhxamXub9i2saTlfhSSZtmGrhAO2Rnio86mSNwwDV
	G1GizE3B7MQysUwNdwLRRXSa9Eeu3jD+B2yZrBWy0iq1sCSYYz+J1ItMKXD1NGbQPFvRXqOiUHk
	nhjBfYfmKaZFcsG4ytpmnEMYhYUhyML57hAYCSVHfYmPIIE7neA1owPE1877Q8IUHv22+tpY36J
	KCV0O
X-Received: by 2002:a05:6830:2316:b0:7e9:cddb:142a with SMTP id 46e09a7af769-7eb48aaeb77mr3316524a34.7.1782992442716;
        Thu, 02 Jul 2026 04:40:42 -0700 (PDT)
X-Received: by 2002:a05:6830:2316:b0:7e9:cddb:142a with SMTP id 46e09a7af769-7eb48aaeb77mr3316508a34.7.1782992442279;
        Thu, 02 Jul 2026 04:40:42 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb545515casm2206351a34.27.2026.07.02.04.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:40:41 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [v2] ceph: add 'lazyio' mount option to kclient
Date: Thu,  2 Jul 2026 11:40:22 +0000
Message-Id: <20260702114034.917507-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701-lazyio-v2-1-9c667864805b@clyso.com>
References: <20260701-lazyio-v2-1-9c667864805b@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

