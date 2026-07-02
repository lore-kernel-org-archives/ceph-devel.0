Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55446AEF1
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992457; cv=none; b=jEhtGtkQRZR3CcX4NZypGPKpWY/CrxWI7f4fUzss14oKeX3sB74LMRm8MvlOVdt8jdYhXd8C48tcoSZcH3oSjhIfxmcnjBo5cYyrdPSssXy8KKllH5ZMc5O5RalYBpMar8c5ak88BwSlU1mZTovKkOdSycRehm3XisAKOlouEXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992457; c=relaxed/simple;
	bh=zmL5b9iBPm13uBuuCQCSPztw48TTZotBL2IFucbc3tc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wc+udkvIC1xd0vHlAo0+m7mq1eeYiE/uRGoS6NkzBshOT7Lq5nXx0B9/kyVkM1ZTcO8Z5+S+oaIxZXfTW9axjuvI/GxfWJN5gwXsQeTT0fk8esqCvC3Vx+EuZuwxzeK6c76XSvTO1w2fGWQkS3jLcQOssQ9Yb+fIkzzY+GHASgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+TY9xoI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDqfTyQS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+TY9xoI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDqfTyQS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782992455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kSxYelmr9NEfmUXkcJH0DQmCltQUxyg+a6gH5QtM2g=;
	b=g+TY9xoIk77cUL0sXZG1fDb0Nvk4Pd/EHvR3pZuXD9g9G7j85c9WI463UjfNOAbZPEtObv
	ifZjejUokcLyZSSVnETvmfKt6eQeFRHcGrWQT5ilCio0ihdMyqVXjoxdOZ4fH+yJqIFr0n
	IYn41CTwIe7pMhcFXDlXh8kfUkFu0KM=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-YPmOmOm9PU6TFjyfWiTjkw-1; Thu, 02 Jul 2026 07:40:54 -0400
X-MC-Unique: YPmOmOm9PU6TFjyfWiTjkw-1
X-Mimecast-MFC-AGG-ID: YPmOmOm9PU6TFjyfWiTjkw_1782992454
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e9fec69475so2291002a34.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 04:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782992454; x=1783597254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8kSxYelmr9NEfmUXkcJH0DQmCltQUxyg+a6gH5QtM2g=;
        b=HDqfTyQSq7oULMHR4aXEUYYj33DSOhYWi8hc47vqrSNvtyThdokc0kImGyK2rlUUzq
         VNh0FEv1e7R/IL0nHs3b/5ZcEIOiP4p49BaYvDDjItEcvdXdC/+oovMAh/YylQpOGdka
         MUOb6UQWosvjJinKX4gJ0yfeGFa8taN7j3pcfivHGed66YwlFiBdZ73DhAHcdEWLZR6C
         T0AI22G7eSNMMSJB3NTP+BOihQlgKEwm0rO5ULyXc4SxV6mRTmwD3YtSKj2jB0LxP6Jw
         Q+ecvJSucr9yB9oS9w5MSSnd2l+z6xZeWT+GkWcCW5DVAY65WsGC7Qy/0x/4QNz0Pkt8
         rmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992454; x=1783597254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8kSxYelmr9NEfmUXkcJH0DQmCltQUxyg+a6gH5QtM2g=;
        b=ep6pVvW3Xr/vHRWgx8DTamvVZ//5CtUT5pvJN4jRNiA5lJYmD/teTL5mPKGyoyBFLx
         ePKru6MRfBV/+RTdFRobehRKLrrfaeGfpIrqGKtjvn5kjWSNsec/g00wRc4nhFpOKgUS
         /Ipac6wjC8G/cu84JU9ErNYXhMGzTWcCkGgumCh0zX+NxM9r0LlpaQDMZwXUQnTV8tbR
         WbrDBJNQadnzuG7CNhNKA6ZL+8g+tz+m+99Pb6IviZ+Dr27Gtac0eRhKghcE0rB8TlFN
         Z4JK9il8BlJtKSBltmX71qUmMg84ivngDxzdX5f0kSs16hUptW6v1WvPn42aphlY7vuO
         DX2w==
X-Forwarded-Encrypted: i=1; AFNElJ8dgS0RXGM5Bjr1EdkCkCe6a6RQANJ7limMDWqPrkG38qTKOX30FQeXo4uixkYPQQSkxKng20B0ggnm@vger.kernel.org
X-Gm-Message-State: AOJu0YxBCEOkJcP7MPOvEqX3XZOvh/Il+DjKoQnihiu0mHoud6wSAfvz
	zK6irIkpIjN0Bc24FYVbTXQ+NwXBEXrgcb6jZY0oBirJxqXefC+ijYgbtD2/h20m8r5ZtQRiYkp
	3LjzOCRsp5u1T7gpBfYGT+7Y5qcFdYd+CEJQWopBV5J/1o0l2oyo9hsBMrcOVZvM=
X-Gm-Gg: AfdE7cmECNO2AIYlewcvBY0mIMHCNJ5lxeZdhTm/NM+Jryu4Fhk0+9iPWg+aW1QwDW7
	WMRwc1+gk1DY2yZ76sZg29aQekx4sJKP+TIYRTqNWXdSXrEMyJGwAW7kyLtpTI241l6sTmVvbuX
	qLMRinPM4950V88FOxMHTjA0sKkTBWM9HTkkWOWX+tklTcuTzzs0QI4GC8whKrqdqUTKj+7XLGW
	Sdx598AlY8a19MPurWI2h+ntmaeH2wpvUnO2qbmIZLxIPnOPI47YN25NWAd1jU5ZVWOn2ceRkhC
	KbgRE3b2kWlQCeOsWL1+2a229nrQACsbhAu3480pZByhyhdmofPl8Y/zz5YI4idMOQ1b1Y4wdE6
	lR9q3
X-Received: by 2002:a05:6830:3896:b0:7d7:ef0a:1ce5 with SMTP id 46e09a7af769-7eb50375b88mr3645721a34.9.1782992453751;
        Thu, 02 Jul 2026 04:40:53 -0700 (PDT)
X-Received: by 2002:a05:6830:3896:b0:7d7:ef0a:1ce5 with SMTP id 46e09a7af769-7eb50375b88mr3645705a34.9.1782992453361;
        Thu, 02 Jul 2026 04:40:53 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb545515casm2206351a34.27.2026.07.02.04.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:40:52 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: ceph: fix hanging __ceph_get_caps() with stale `mds_wanted`
Date: Thu,  2 Jul 2026 11:40:29 +0000
Message-Id: <20260702114034.917507-8-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427155813.2561935-1-max.kellermann@ionos.com>
References: <20260427155813.2561935-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

NACK for now. Thanks for the patch, but I have some concerns
that need a v2:

  1. [minor] fs/ceph/caps.c:3093: Timeout constant should be a #define
  2. [minor] fs/ceph/caps.c:3144: Unrelated CEPH_FILE_MODE_MASK fix should be split out
  3. [nit] commit message: Missing Fixes: tag


-- 
Alex Markuze

