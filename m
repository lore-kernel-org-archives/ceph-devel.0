Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B52634752F
	for <ceph-devel@vger.kernel.org>; Tue,  6 Oct 2026 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272835; cv=none; b=aBcOvzxQPMfvYb3fgv8P0ALdHcIQBZkMn/LsxkTSNirsAkngS9GAxLLZArZ5rQ2+ETS9vjSyP+DuPWi9+y4aKavSnsoUE9gfd/L41v1x6hwOWa54kYJTNbFLYTO5Gt/7U1seMxszsBAReRj1+ScmCW84nXX0KH8X3Mwegr2nScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272835; c=relaxed/simple;
	bh=RWw/Y+62IDH9kNSGEOXHriUaj36mECYgvej1AEBU2+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WyK+QVu1vnI3arpqcdLFdIrLI3DgzybjzfdQJ8Y1/9bUkrz/OoD5pc2lqxE2ycNlspQ0tCgCdQ4sCW0ORsxKwGsGei69ywkYfBqiL0NupxVw48dciZy+7MwAgyOmaFZv5rB4ycWGL9cr0KycZ1huApOHzqDrD7biu/0ADnWn/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EY8OgS3p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PRn/2Blz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EY8OgS3p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PRn/2Blz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791272833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u5ViZoYu/ANArrj/Mbrv0s22rityo9DQqT7IYflFxs8=;
	b=EY8OgS3pK7rAjJcDvMWKpBVlVYBcCBBRHIdgxZgOzrERCnXiPMRxMSXKKCHfs4YoX66Rj8
	38Tu07pYYPXtf1L+P3X2V6pfrYKuOKo9H10HgaDWvODXzdGeEDqtBsjTzJrMBYv7dHDYlP
	SRAiuK501wZP1pCL6HUXKyAuYgvg3As=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-bCO6j7WDMUiv4uufwNSyug-1; Tue, 06 Oct 2026 03:47:11 -0400
X-MC-Unique: bCO6j7WDMUiv4uufwNSyug-1
X-Mimecast-MFC-AGG-ID: bCO6j7WDMUiv4uufwNSyug_1791272831
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93cc0b31ecaso546298085a.1
        for <ceph-devel@vger.kernel.org>; Tue, 06 Oct 2026 00:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791272831; x=1791877631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u5ViZoYu/ANArrj/Mbrv0s22rityo9DQqT7IYflFxs8=;
        b=PRn/2Blza6H3OiEAtwAaf80hW2B0P7i086CGdKju8NjHyYggQHU1winNYJ3wUFALYL
         +rk5kC0eZonCzIq1VhBZqxHXOaAMk0Z+7EEjo/Qd7nxf9OON+0I0OKzoM5e5nn1MsiY4
         yHuYokY16ayvUFuv2cwGilndFu4wk2REGz1BuXgc8+MZw6/s1Q6njOUM0zTGtN+aHhqH
         CQze2SKhtlrb+3lCmlWklIDOBZ4yXQwYMB7QlRb9rkCDBRwmPa6sWozV6n66feOjkn65
         1oLKFOgZSZ1yEZ7b+SYP2JOlx53fX9wyp7phClrVDapIQuAKQYngyabQixfwD6ReQ7F1
         gC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791272831; x=1791877631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u5ViZoYu/ANArrj/Mbrv0s22rityo9DQqT7IYflFxs8=;
        b=HsguJ0lTjuryQK/jFwunuZUr7zsaIYGkrqUTsQlWkCqHONv62lgoLEFR/C7hfeqSqi
         mbfWDobGNvfwYeHSCurF/kBWu6pTwTibBJNd4JbZHMOpHzssCp2EJweTOXCT8cIRII35
         FP64xYLroN/Skd1Z7pmCWCoZfbJbxmsNs16x10GWPa8eiqtnNaTB/k8tD+LUcL07hje+
         GFYhtPZSukDGDGCmxHic6UrVwOUR3Es6oOi1QcPN8LjlkTVbmV29pPy4E6xNvyLSrG6h
         0uZrz01fw5LLc2YguP54E5qTi9PyorhsEof7RbNvqMZA7Fn8iJR+1uu/LLqoIpaVdfQU
         3hCg==
X-Forwarded-Encrypted: i=1; AKwUvBzTnT+Q/ksuWVX3mf4Dus/rIFzlBr3fpxp/z136jFMrn8pBiPmPN7P98ZWAIGGDxqxYZvGuAXFqH021@vger.kernel.org
X-Gm-Message-State: AFuF++mBw7AO677KQqsob6mJEVFTolZWb9QqYuo5QRK+k/tLa9XtBxWg
	H4HeG/RJNSuLYHolwZsUuDYXqncKUBmDiS/+a7q2PoUWncSgn7gl26AeUBQUL3d+iKVzON97jCU
	0HEV12YerDCrt/nHkIv8bB05RBsFCCCvcOOfkTFTOIiAIJrha2lSkPQsfcOzPwP8=
X-Gm-Gg: AYBFou0fF9TFErGHz3f7KSuf/yAvBiIluKLOJqT/AQ67uPG2YDaZZIQW/ERkUTaD2Zo
	iouzplHimSUmbpCOUaL5IekD9gjGBqGA7nPBL6dfIuwsII/lom9iIq+J77MMoUz07iqAYN/mbd2
	WCUXIwDZCiPbv9X+JSiVrCPiuTfR7olaDZo/lE0xWrHblELyLnWx4RQVpyYU8gnGKVUCa1zVTJF
	8nTkzGj7fp4xTwAzGTaRDUvMnj8EPZv+Cu5b5AgT5AfLseAgPNM4T1fi6ZsEEjULcvjZRtMEn+M
	OGzRC+I4KlLoiLyjeFy1yiVRz7GHdtYMJDvXk3YHwTHrukoiHS7/MuxUMAlV31Vn+uBewaZ9//8
	fvDbffCsx72BFm2XQDo43UCR2YTCtaX+0VJ4prDjEMLoCzCkAZeApFvG4x+yyJOY47ra8SLibM7
	luK9/ftk3Bwynv5Q==
X-Received: by 2002:a05:620a:2715:b0:93c:7486:b4bf with SMTP id af79cd13be357-93e8f08ea47mr103970885a.2.1791272831278;
        Tue, 06 Oct 2026 00:47:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2715:b0:93c:7486:b4bf with SMTP id af79cd13be357-93e8f08ea47mr103968885a.2.1791272830868;
        Tue, 06 Oct 2026 00:47:10 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca03a1bbsm1071507485a.1.2026.10.06.00.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 00:47:10 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: ceph: use a flexible array for monitor addresses
Date: Tue,  6 Oct 2026 07:47:08 +0000
Message-Id: <20261006074708.2082405-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005001955.589395-1-rosenp@gmail.com>
References: <20261005001955.589395-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rosen,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

