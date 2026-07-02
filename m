Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8CD4534B7
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 11:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992448; cv=none; b=gZWEphQrVzLY7DMGouwiaFUYGQmNr/hmL+nb2S8ix0HFsMbjEHcCeUDuzM7rMwlUCyI8P06KrWsryHeLTktyc3Z4ENz1dPdAkYroQAf8975ivXlynOE3yxFmeQkhSXGYbut0LvZPAJpbzsLW8s2TVB3bC9pojfYeksVbAHR1Tq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992448; c=relaxed/simple;
	bh=onU/5/kT1hiHwApG8rwpT3PI4XbL2fj4IPsBDnGXyqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PN6t2JhHYfrMQqLTy5vlNjssDbQNnEnnkSqfDKTg+TPZSVkRWwLjHINUQjHQyTQa4aLgbJBpskkz6/XtJF+AVWMN9JYzRpurWnhqCg/CxIW3m3qrGKbD8w7NhIBgISEETh8vFMu9dCjHDYCyBmU9XqOSQVXLv6vtki1ynNt3wbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M2WJs3Yy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQ1nOOzr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M2WJs3Yy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQ1nOOzr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782992446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
	b=M2WJs3YyoIyBTgKqA36juf8sRS23c9ps2T++I2uTAXsq7xW3y4jPzXkgI6AbvgHGZvfhbi
	vWxKTgEMpAwrP1J2udCeAnTFqnao7VdUT4Eiz4o9NjkmTEVId+BcOZPxWkIaxfv86F5ygF
	ES+NW10D6/kqRvVGAeQv3i5qe33JL0c=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-uWICvqbSNiyc1jQqcilOow-1; Thu, 02 Jul 2026 07:40:45 -0400
X-MC-Unique: uWICvqbSNiyc1jQqcilOow-1
X-Mimecast-MFC-AGG-ID: uWICvqbSNiyc1jQqcilOow_1782992444
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7eb60cfd476so227176a34.3
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 04:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782992444; x=1783597244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=iQ1nOOzr9nmR8UHAvtBi5Ing7JpOhobcnFe77ew8HpDC85XWOYsk0YSRBVB5qR+QOP
         ChqM3XMdShtmLVDaSPK8Q+aVxwF2sM8jJ2bHYTyhamD57pv8EnKJl9yDHr58qkoMUmat
         chx4xnaFmtCD0gn2sGO9H2yQCxNiWEdWcF7W9ZVa1hBmYZ+0x/HtpN94vXBdiDvH7m0k
         Whv5GPkqwbG4jkJUsjhLT8L/i85KMITr6oJMe+HzzegIzlxZc20hp7hgpRQdYH8LHSn/
         yLZ+BjoQzfE1myj0xs33PY5rzSpUx1gHeZpqVgja2d6gclRZUVlwC5e0tj7Wwtkj3nGa
         YJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992444; x=1783597244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=obPbTSM7bXYI0zTnyIqgOU0A9yRH+FS2QyoX4xqTTPs=;
        b=Ke5tqiYSHVbfKPXdn72xK4+hmg800iwQIuN2azMC4iA23qZz+6xrqBeRak+ix1jsZA
         DklDDM9iI9Iuh9gJALwygPMh5K1VEmq43XCm2l+B4LfzAwIT2NvwSV3on6WPgVgCe3gL
         ryRIhr4CAOGW53A8aMrbC463aMjDDILJaGfNYpvRLa72tI7rjN/Dng6sDrqIEqiuBgip
         3JUNsr48D3Ek/NJtVKMd1CnAWe8JcpmkU3ZpRTTOP5Icsy1KqZt0Oif/d4xqA/KY/u4Q
         MMWGC3+zxZSruLPKSBnthyXC17TUp3Z3tZpUHnL+Tmwyxv3sRwLIfE8uYbreWqpPHcpG
         3gPg==
X-Forwarded-Encrypted: i=1; AFNElJ8mmw++yZf+QHDr8pTw+A/Xw32GbX8mK9ywv57XThvsc4lLz2Ga3PRh2ki9i02L6+vEkdEM33cG1A1k@vger.kernel.org
X-Gm-Message-State: AOJu0YwtTxq311KPc9fMdVsC4YWwqhseaKEijR+MofVwCAW1SsoQE74V
	lmHqxS9ofK9zeoHGnjhtBOtqoowfIlfSS1U417DrnTFFtOTHXmRcci2iV4bRrVPRUlafdM8E28K
	HLUh6iRuZLoYlyiPnmc4dmN4uiiRETWQ3k/d8apfoRvMtf3zuY/v7zXA4Z5P7TJY=
X-Gm-Gg: AfdE7cnQY1W3iSlUcjveXl6Gha0+AI0c2GlBP7ZsvjNsCPiJWxc4/HhbPdacGBUGuRN
	68OwSrYxtVUw39d5AlPOwjesw38QU36ReoiE+bDq1aUZFJwSbIuHjpp3EtsyRFVHzHKE0qcpm1H
	NcuZVTItEFhKqydtoIRW+DqPrVwU9SXi6HlVJXYdRT2BhBa5+Rzkt87aZH1HKth+0A+aI2MQde2
	BmwWwx2IAMK0V4Y9kSKq4e+ow47L0cJmQqtcvExsHipl52yBEnxWwx2hjgl0FSM3htTxQEAcLsc
	Y4Z78Z+I4VekqbusSrI3BgrzFH72bTcvnoEXxW/q4TVIH5f1ccgqtVv1ORZj58uJLY7rDLEvOnb
	1WVjM
X-Received: by 2002:a05:6830:dc3:b0:7dc:dbe4:3f21 with SMTP id 46e09a7af769-7eb48ab86d7mr3323041a34.1.1782992444189;
        Thu, 02 Jul 2026 04:40:44 -0700 (PDT)
X-Received: by 2002:a05:6830:dc3:b0:7dc:dbe4:3f21 with SMTP id 46e09a7af769-7eb48ab86d7mr3323036a34.1.1782992443728;
        Thu, 02 Jul 2026 04:40:43 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb545515casm2206351a34.27.2026.07.02.04.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:40:43 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [v2] libceph: Assign requests to homeless osd if calculated osd exceeds max_osd
Date: Thu,  2 Jul 2026 11:40:23 +0000
Message-Id: <20260702114034.917507-2-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701155610.3133868-1-raphael.zimmer@tu-ilmenau.de>
References: <20260701155610.3133868-1-raphael.zimmer@tu-ilmenau.de>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Raphael,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

